module 0xf2d97bf1be1d79d0f068a0cca3297d379d9929c19c33d5ff5698d87b8b9a1ba::validation {
    struct ValidationBoard has key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
        request_count: u64,
        requests: 0x2::table::Table<u64, ValidationRecord>,
    }

    struct ValidationRecord has store {
        validator: address,
        requester: address,
        request_json: 0x1::string::String,
        responses: vector<ValidationResponse>,
        created_at: u64,
    }

    struct ValidationResponse has drop, store {
        score: u8,
        response_json: 0x1::string::String,
        tag: 0x1::string::String,
        timestamp: u64,
    }

    struct ValidationRequested has copy, drop {
        agent_id: 0x2::object::ID,
        board_id: 0x2::object::ID,
        request_index: u64,
        validator: address,
        requester: address,
    }

    struct ValidationResponseSubmitted has copy, drop {
        board_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        request_index: u64,
        validator: address,
        score: u8,
        tag: 0x1::string::String,
    }

    public fun agent_id(arg0: &ValidationBoard) : 0x2::object::ID {
        arg0.agent_id
    }

    public(friend) fun create_and_share<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::derived_object::claim<T0>(arg0, arg1);
        let v1 = ValidationBoard{
            id            : v0,
            agent_id      : arg2,
            request_count : 0,
            requests      : 0x2::table::new<u64, ValidationRecord>(arg3),
        };
        0x2::transfer::share_object<ValidationBoard>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public fun get_validation(arg0: &ValidationBoard, arg1: u64) : &ValidationRecord {
        0x2::table::borrow<u64, ValidationRecord>(&arg0.requests, arg1)
    }

    public fun has_request(arg0: &ValidationBoard, arg1: u64) : bool {
        0x2::table::contains<u64, ValidationRecord>(&arg0.requests, arg1)
    }

    public fun record_created_at(arg0: &ValidationRecord) : u64 {
        arg0.created_at
    }

    public fun record_request_json(arg0: &ValidationRecord) : &0x1::string::String {
        &arg0.request_json
    }

    public fun record_requester(arg0: &ValidationRecord) : address {
        arg0.requester
    }

    public fun record_responses(arg0: &ValidationRecord) : &vector<ValidationResponse> {
        &arg0.responses
    }

    public fun record_validator(arg0: &ValidationRecord) : address {
        arg0.validator
    }

    public fun request_count(arg0: &ValidationBoard) : u64 {
        arg0.request_count
    }

    public fun request_validation(arg0: &mut ValidationBoard, arg1: address, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg0.request_count;
        let v2 = ValidationRecord{
            validator    : arg1,
            requester    : v0,
            request_json : arg2,
            responses    : 0x1::vector::empty<ValidationResponse>(),
            created_at   : 0x2::tx_context::epoch(arg3),
        };
        0x2::table::add<u64, ValidationRecord>(&mut arg0.requests, v1, v2);
        arg0.request_count = v1 + 1;
        let v3 = ValidationRequested{
            agent_id      : arg0.agent_id,
            board_id      : 0x2::object::id<ValidationBoard>(arg0),
            request_index : v1,
            validator     : arg1,
            requester     : v0,
        };
        0x2::event::emit<ValidationRequested>(v3);
    }

    public fun response_json(arg0: &ValidationResponse) : &0x1::string::String {
        &arg0.response_json
    }

    public fun response_score(arg0: &ValidationResponse) : u8 {
        arg0.score
    }

    public fun response_tag(arg0: &ValidationResponse) : &0x1::string::String {
        &arg0.tag
    }

    public fun response_timestamp(arg0: &ValidationResponse) : u64 {
        arg0.timestamp
    }

    public fun submit_response(arg0: &mut ValidationBoard, arg1: u64, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 100, 1);
        assert!(0x2::table::contains<u64, ValidationRecord>(&arg0.requests, arg1), 2);
        let v0 = 0x2::table::borrow_mut<u64, ValidationRecord>(&mut arg0.requests, arg1);
        assert!(v0.validator == 0x2::tx_context::sender(arg5), 0);
        let v1 = ValidationResponse{
            score         : arg2,
            response_json : arg3,
            tag           : arg4,
            timestamp     : 0x2::tx_context::epoch(arg5),
        };
        0x1::vector::push_back<ValidationResponse>(&mut v0.responses, v1);
        let v2 = ValidationResponseSubmitted{
            board_id      : 0x2::object::id<ValidationBoard>(arg0),
            agent_id      : arg0.agent_id,
            request_index : arg1,
            validator     : v0.validator,
            score         : arg2,
            tag           : arg4,
        };
        0x2::event::emit<ValidationResponseSubmitted>(v2);
    }

    // decompiled from Move bytecode v6
}

