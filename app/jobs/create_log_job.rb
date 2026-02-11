class CreateLogJob < ApplicationJob
  queue_as :default

  def perform
    log = Log.create!

    sleep(5)

    Turbo::StreamsChannel.broadcast_prepend_to(
      "logs",
      target: "logs",
      partial: "logs/log",
      locals: { log: log }
    )
  end
end
