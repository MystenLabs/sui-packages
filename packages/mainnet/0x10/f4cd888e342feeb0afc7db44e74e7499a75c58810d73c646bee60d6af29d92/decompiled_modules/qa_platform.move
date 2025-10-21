module 0x10f4cd888e342feeb0afc7db44e74e7499a75c58810d73c646bee60d6af29d92::qa_platform {
    struct Platform has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
        question_counter: u64,
        questions: 0x2::table::Table<u64, Question>,
        questions_by_month: 0x2::table::Table<0x1::string::String, vector<u64>>,
    }

    struct Question has store {
        id: u64,
        author: address,
        question_blob_id: 0x1::string::String,
        month: 0x1::string::String,
        created_at: u64,
        voters: 0x2::vec_set::VecSet<address>,
        vote_count: u64,
        is_answered: bool,
        answer_blob_id: 0x1::string::String,
        answered_at: u64,
        answered_by: address,
    }

    struct QuestionSubmitted has copy, drop {
        question_id: u64,
        author: address,
        question_blob_id: 0x1::string::String,
        month: 0x1::string::String,
        created_at: u64,
    }

    struct QuestionVoted has copy, drop {
        question_id: u64,
        voter: address,
        new_vote_count: u64,
    }

    struct QuestionAnswered has copy, drop {
        question_id: u64,
        answer_blob_id: 0x1::string::String,
        answered_by: address,
        answered_at: u64,
    }

    public entry fun add_admin(arg0: &mut Platform, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
    }

    public entry fun answer_question(arg0: &mut Platform, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        assert!(0x2::table::contains<u64, Question>(&arg0.questions, arg1), 3);
        let v1 = 0x2::table::borrow_mut<u64, Question>(&mut arg0.questions, arg1);
        assert!(!v1.is_answered, 4);
        v1.is_answered = true;
        v1.answer_blob_id = arg2;
        v1.answered_at = 0x2::clock::timestamp_ms(arg3);
        v1.answered_by = 0x2::tx_context::sender(arg4);
        let v2 = QuestionAnswered{
            question_id    : arg1,
            answer_blob_id : v1.answer_blob_id,
            answered_by    : v1.answered_by,
            answered_at    : v1.answered_at,
        };
        0x2::event::emit<QuestionAnswered>(v2);
    }

    public entry fun delete_answer(arg0: &mut Platform, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        assert!(0x2::table::contains<u64, Question>(&arg0.questions, arg1), 3);
        let v1 = 0x2::table::borrow_mut<u64, Question>(&mut arg0.questions, arg1);
        v1.is_answered = false;
        v1.answer_blob_id = 0x1::string::utf8(b"");
        v1.answered_at = 0;
        v1.answered_by = @0x0;
    }

    public fun get_answer_blob_id(arg0: &Platform, arg1: u64) : 0x1::string::String {
        if (!0x2::table::contains<u64, Question>(&arg0.questions, arg1)) {
            return 0x1::string::utf8(b"")
        };
        0x2::table::borrow<u64, Question>(&arg0.questions, arg1).answer_blob_id
    }

    public fun get_question(arg0: &Platform, arg1: u64) : (u64, address, 0x1::string::String, 0x1::string::String, u64, u64, bool, 0x1::string::String, u64, address) {
        assert!(0x2::table::contains<u64, Question>(&arg0.questions, arg1), 3);
        let v0 = 0x2::table::borrow<u64, Question>(&arg0.questions, arg1);
        (v0.id, v0.author, v0.question_blob_id, v0.month, v0.created_at, v0.vote_count, v0.is_answered, v0.answer_blob_id, v0.answered_at, v0.answered_by)
    }

    public fun get_question_count(arg0: &Platform) : u64 {
        arg0.question_counter
    }

    public fun get_vote_count(arg0: &Platform, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, Question>(&arg0.questions, arg1)) {
            return 0
        };
        0x2::table::borrow<u64, Question>(&arg0.questions, arg1).vote_count
    }

    public fun has_voted(arg0: &Platform, arg1: u64, arg2: address) : bool {
        if (!0x2::table::contains<u64, Question>(&arg0.questions, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(&0x2::table::borrow<u64, Question>(&arg0.questions, arg1).voters, &arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, @0x8460005b0378efac468a1704d353afb8fa7e3d6743536d197c9d59f86809961e);
        let v1 = Platform{
            id                 : 0x2::object::new(arg0),
            admins             : v0,
            question_counter   : 0,
            questions          : 0x2::table::new<u64, Question>(arg0),
            questions_by_month : 0x2::table::new<0x1::string::String, vector<u64>>(arg0),
        };
        0x2::transfer::share_object<Platform>(v1);
    }

    public fun is_admin(arg0: &Platform, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_question_answered(arg0: &Platform, arg1: u64) : bool {
        if (!0x2::table::contains<u64, Question>(&arg0.questions, arg1)) {
            return false
        };
        0x2::table::borrow<u64, Question>(&arg0.questions, arg1).is_answered
    }

    public entry fun remove_admin(arg0: &mut Platform, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
    }

    public entry fun submit_question(arg0: &mut Platform, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.question_counter = arg0.question_counter + 1;
        let v0 = arg0.question_counter;
        let v1 = Question{
            id               : v0,
            author           : 0x2::tx_context::sender(arg4),
            question_blob_id : arg1,
            month            : arg2,
            created_at       : 0x2::clock::timestamp_ms(arg3),
            voters           : 0x2::vec_set::empty<address>(),
            vote_count       : 0,
            is_answered      : false,
            answer_blob_id   : 0x1::string::utf8(b""),
            answered_at      : 0,
            answered_by      : @0x0,
        };
        0x2::table::add<u64, Question>(&mut arg0.questions, v0, v1);
        if (!0x2::table::contains<0x1::string::String, vector<u64>>(&arg0.questions_by_month, arg2)) {
            0x2::table::add<0x1::string::String, vector<u64>>(&mut arg0.questions_by_month, arg2, 0x1::vector::empty<u64>());
        };
        0x1::vector::push_back<u64>(0x2::table::borrow_mut<0x1::string::String, vector<u64>>(&mut arg0.questions_by_month, arg2), v0);
        let v2 = 0x2::table::borrow<u64, Question>(&arg0.questions, v0);
        let v3 = QuestionSubmitted{
            question_id      : v0,
            author           : v2.author,
            question_blob_id : v2.question_blob_id,
            month            : v2.month,
            created_at       : v2.created_at,
        };
        0x2::event::emit<QuestionSubmitted>(v3);
    }

    public entry fun update_answer(arg0: &mut Platform, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        assert!(0x2::table::contains<u64, Question>(&arg0.questions, arg1), 3);
        let v1 = 0x2::table::borrow_mut<u64, Question>(&mut arg0.questions, arg1);
        v1.answer_blob_id = arg2;
        v1.answered_at = 0x2::clock::timestamp_ms(arg3);
        v1.answered_by = 0x2::tx_context::sender(arg4);
        let v2 = QuestionAnswered{
            question_id    : arg1,
            answer_blob_id : v1.answer_blob_id,
            answered_by    : v1.answered_by,
            answered_at    : v1.answered_at,
        };
        0x2::event::emit<QuestionAnswered>(v2);
    }

    public entry fun vote_question(arg0: &mut Platform, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Question>(&arg0.questions, arg1), 3);
        let v0 = 0x2::table::borrow_mut<u64, Question>(&mut arg0.questions, arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::vec_set::contains<address>(&v0.voters, &v1), 2);
        0x2::vec_set::insert<address>(&mut v0.voters, 0x2::tx_context::sender(arg2));
        v0.vote_count = v0.vote_count + 1;
        let v2 = QuestionVoted{
            question_id    : arg1,
            voter          : 0x2::tx_context::sender(arg2),
            new_vote_count : v0.vote_count,
        };
        0x2::event::emit<QuestionVoted>(v2);
    }

    // decompiled from Move bytecode v6
}

