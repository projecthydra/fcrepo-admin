ActiveFedora::Datastream.class_eval do

  def safe_pid
    pid.sub(/:/, "-")
  end

  def active?
    dsState == 'A'
  end

  def current_version?
    @current_version ||= (new? || versions.empty? || dsVersionID == versions.first.dsVersionID)
  end

  def content_is_url?
    external? || redirect?
  end

  def content_is_downloadable?
    has_content? && (managed? || inline?)
  end

  def modifiable?
    !FcrepoAdmin.read_only && active? && current_version?
  end

  def content_is_uploadable?
    modifiable? && (managed? || inline?)
  end

  def content_is_editable?
    modifiable? && !content_is_url? && content_is_text? && dsSize <= FcrepoAdmin.max_editable_datastream_size
  end

  def content_is_text?
    has_content? && !mimeType.blank? && (mimeType.start_with?('text/') || FcrepoAdmin.extra_text_mime_types.include?(mimeType))
  end

end
