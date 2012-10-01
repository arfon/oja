class Paper 
  include MongoMapper::Document
  key :title, String
  key :github_address, String
  key :version, String, :default => "1.0"
  key :state, String
  key :category, String
  key :arxiv_id, String
  key :authour_ids, Array


  has_many   :authours, :in => :authour_ids
  has_one    :submitting_authour
  belongs_tp :reviewer

  has_many :tasks

  after_create :pull_arxiv_details
  
  state_machine :initial => :submitted do 
    state :submitted 
    state :accepted
  end
  
  private
  
  def pull_arxiv_details
    # Do something here
    paper = ArxivDownloader.new(self.arxiv_id)
    paper.download
  end
end
