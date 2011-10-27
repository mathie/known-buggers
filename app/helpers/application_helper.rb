module ApplicationHelper
  def markdown(text)
    RDiscount.new(text, :smart, :filter_html).to_html.html_safe
  end
end
