module 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::feedback {
    struct FeedbackBoard has key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        feedback_count: u64,
        feedback: 0x2::table::Table<u64, FeedbackRecord>,
    }

    struct FeedbackRecord has store {
        reviewer: address,
        reviewer_agent_id: 0x1::option::Option<0x2::object::ID>,
        score: u8,
        payment_amount: u64,
        feedback_json: 0x1::string::String,
        is_revoked: bool,
        timestamp: u64,
        response_count: u64,
        responses: 0x2::table::Table<address, ResponseRecord>,
    }

    struct ResponseRecord has drop, store {
        response_json: 0x1::string::String,
        timestamp: u64,
    }

    struct FeedbackSubmitted has copy, drop {
        agent_id: 0x2::object::ID,
        board_id: 0x2::object::ID,
        feedback_index: u64,
        reviewer: address,
        reviewer_agent_id: 0x1::option::Option<0x2::object::ID>,
        score: u8,
        payment_amount: u64,
    }

    struct FeedbackRevoked has copy, drop {
        agent_id: 0x2::object::ID,
        board_id: 0x2::object::ID,
        feedback_index: u64,
        reviewer: address,
    }

    struct ResponseAppended has copy, drop {
        board_id: 0x2::object::ID,
        feedback_index: u64,
        responder: address,
    }

    public fun agent_id(arg0: &FeedbackBoard) : 0x2::object::ID {
        arg0.agent_id
    }

    public fun append_response(arg0: &mut FeedbackBoard, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, FeedbackRecord>(&arg0.feedback, arg1), 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<u64, FeedbackRecord>(&mut arg0.feedback, arg1);
        let v2 = ResponseRecord{
            response_json : arg2,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::table::add<address, ResponseRecord>(&mut v1.responses, v0, v2);
        v1.response_count = v1.response_count + 1;
        let v3 = ResponseAppended{
            board_id       : 0x2::object::id<FeedbackBoard>(arg0),
            feedback_index : arg1,
            responder      : v0,
        };
        0x2::event::emit<ResponseAppended>(v3);
    }

    public fun balance_value(arg0: &FeedbackBoard) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public(friend) fun create_and_share<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::derived_object::claim<T0>(arg0, arg1);
        let v1 = FeedbackBoard{
            id             : v0,
            agent_id       : arg2,
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            feedback_count : 0,
            feedback       : 0x2::table::new<u64, FeedbackRecord>(arg3),
        };
        0x2::transfer::share_object<FeedbackBoard>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public fun feedback_count(arg0: &FeedbackBoard) : u64 {
        arg0.feedback_count
    }

    public fun feedback_is_revoked(arg0: &FeedbackRecord) : bool {
        arg0.is_revoked
    }

    public fun feedback_json(arg0: &FeedbackRecord) : &0x1::string::String {
        &arg0.feedback_json
    }

    public fun feedback_payment_amount(arg0: &FeedbackRecord) : u64 {
        arg0.payment_amount
    }

    public fun feedback_response_count(arg0: &FeedbackRecord) : u64 {
        arg0.response_count
    }

    public fun feedback_reviewer(arg0: &FeedbackRecord) : address {
        arg0.reviewer
    }

    public fun feedback_reviewer_agent_id(arg0: &FeedbackRecord) : &0x1::option::Option<0x2::object::ID> {
        &arg0.reviewer_agent_id
    }

    public fun feedback_score(arg0: &FeedbackRecord) : u8 {
        arg0.score
    }

    public fun feedback_timestamp(arg0: &FeedbackRecord) : u64 {
        arg0.timestamp
    }

    public fun has_feedback(arg0: &FeedbackBoard, arg1: u64) : bool {
        0x2::table::contains<u64, FeedbackRecord>(&arg0.feedback, arg1)
    }

    public fun has_response(arg0: &FeedbackBoard, arg1: u64, arg2: address) : bool {
        if (!0x2::table::contains<u64, FeedbackRecord>(&arg0.feedback, arg1)) {
            return false
        };
        0x2::table::contains<address, ResponseRecord>(&0x2::table::borrow<u64, FeedbackRecord>(&arg0.feedback, arg1).responses, arg2)
    }

    public fun pay(arg0: &mut FeedbackBoard, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun pay_and_review(arg0: &mut FeedbackBoard, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        submit_feedback(arg0, arg1, 0x1::option::none<0x2::object::ID>(), arg2, arg3, arg4);
    }

    public(friend) fun pay_and_review_as_agent(arg0: &mut FeedbackBoard, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: u8, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        submit_feedback(arg0, arg1, 0x1::option::some<0x2::object::ID>(arg2), arg3, arg4, arg5);
    }

    public fun read_feedback(arg0: &FeedbackBoard, arg1: u64) : &FeedbackRecord {
        0x2::table::borrow<u64, FeedbackRecord>(&arg0.feedback, arg1)
    }

    public fun read_response(arg0: &FeedbackBoard, arg1: u64, arg2: address) : &ResponseRecord {
        0x2::table::borrow<address, ResponseRecord>(&0x2::table::borrow<u64, FeedbackRecord>(&arg0.feedback, arg1).responses, arg2)
    }

    public fun response_json(arg0: &ResponseRecord) : &0x1::string::String {
        &arg0.response_json
    }

    public fun response_timestamp(arg0: &ResponseRecord) : u64 {
        arg0.timestamp
    }

    public fun revoke_feedback(arg0: &mut FeedbackBoard, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, FeedbackRecord>(&arg0.feedback, arg1), 4);
        let v0 = 0x2::table::borrow_mut<u64, FeedbackRecord>(&mut arg0.feedback, arg1);
        assert!(v0.reviewer == 0x2::tx_context::sender(arg2), 2);
        assert!(!v0.is_revoked, 3);
        v0.is_revoked = true;
        let v1 = FeedbackRevoked{
            agent_id       : arg0.agent_id,
            board_id       : 0x2::object::id<FeedbackBoard>(arg0),
            feedback_index : arg1,
            reviewer       : v0.reviewer,
        };
        0x2::event::emit<FeedbackRevoked>(v1);
    }

    fun submit_feedback(arg0: &mut FeedbackBoard, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u8, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 200, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = arg0.feedback_count;
        let v3 = FeedbackRecord{
            reviewer          : v1,
            reviewer_agent_id : arg2,
            score             : arg3,
            payment_amount    : v0,
            feedback_json     : arg4,
            is_revoked        : false,
            timestamp         : 0x2::tx_context::epoch(arg5),
            response_count    : 0,
            responses         : 0x2::table::new<address, ResponseRecord>(arg5),
        };
        0x2::table::add<u64, FeedbackRecord>(&mut arg0.feedback, v2, v3);
        arg0.feedback_count = v2 + 1;
        let v4 = FeedbackSubmitted{
            agent_id          : arg0.agent_id,
            board_id          : 0x2::object::id<FeedbackBoard>(arg0),
            feedback_index    : v2,
            reviewer          : v1,
            reviewer_agent_id : arg2,
            score             : arg3,
            payment_amount    : v0,
        };
        0x2::event::emit<FeedbackSubmitted>(v4);
    }

    public(friend) fun withdraw_all_balance(arg0: &mut FeedbackBoard, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.agent_id == arg1, 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg2)
    }

    public(friend) fun withdraw_balance(arg0: &mut FeedbackBoard, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.agent_id == arg1, 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

