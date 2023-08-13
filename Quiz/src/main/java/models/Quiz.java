package Quiz.src.main.java.models;

public class Quiz{
    public    int id;
    public    int creator_id;
    public  String quiz_name;
    public  boolean is_single_page;
    public boolean can_be_practiced;
    public String creatorName;

    public Quiz(int id, int creator_id, String quiz_name, boolean is_single_page, boolean can_be_practiced) {
        this.id = id;
        this.creator_id = creator_id;
        this.quiz_name = quiz_name;
        this.is_single_page = is_single_page;
        this.can_be_practiced = can_be_practiced;
    }
}
