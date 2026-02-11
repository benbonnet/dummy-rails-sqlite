class LogsController < ApplicationController
  def index
    @logs = Log.order(id: :desc)

    CreateLogJob.perform_later

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
