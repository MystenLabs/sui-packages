module 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity {
    struct AgentIdentity has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        agent_json: 0x1::string::String,
        image_json: 0x1::string::String,
        tags: vector<0x1::string::String>,
        active: bool,
        created_at: u64,
    }

    struct FeedbackKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ValBoardKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AgentRegistered has copy, drop {
        agent_id: 0x2::object::ID,
        feedback_board_id: 0x2::object::ID,
        validation_board_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    struct AgentUpdated has copy, drop {
        agent_id: 0x2::object::ID,
        updated_by: address,
    }

    public fun agent_json(arg0: &AgentIdentity) : &0x1::string::String {
        &arg0.agent_json
    }

    public fun created_at(arg0: &AgentIdentity) : u64 {
        arg0.created_at
    }

    public fun description(arg0: &AgentIdentity) : &0x1::string::String {
        &arg0.description
    }

    public fun feedback_board_address(arg0: 0x2::object::ID) : address {
        let v0 = FeedbackKey{dummy_field: false};
        0x2::derived_object::derive_address<FeedbackKey>(arg0, v0)
    }

    public fun get_metadata<T0: drop + store>(arg0: &AgentIdentity, arg1: 0x1::string::String) : &T0 {
        0x2::dynamic_field::borrow<0x1::string::String, T0>(&arg0.id, arg1)
    }

    public fun has_metadata<T0: drop + store>(arg0: &AgentIdentity, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_with_type<0x1::string::String, T0>(&arg0.id, arg1)
    }

    public fun image_json(arg0: &AgentIdentity) : &0x1::string::String {
        &arg0.image_json
    }

    public fun is_active(arg0: &AgentIdentity) : bool {
        arg0.active
    }

    public fun name(arg0: &AgentIdentity) : &0x1::string::String {
        &arg0.name
    }

    public fun register(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : AgentIdentity {
        let v0 = AgentIdentity{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            agent_json  : arg2,
            image_json  : arg3,
            tags        : arg4,
            active      : true,
            created_at  : 0x2::tx_context::epoch(arg5),
        };
        let v1 = 0x2::object::id<AgentIdentity>(&v0);
        let v2 = FeedbackKey{dummy_field: false};
        let v3 = ValBoardKey{dummy_field: false};
        let v4 = AgentRegistered{
            agent_id            : v1,
            feedback_board_id   : 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::feedback::create_and_share<FeedbackKey>(&mut v0.id, v2, v1, arg5),
            validation_board_id : 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::create_and_share<ValBoardKey>(&mut v0.id, v3, v1, arg5),
            owner               : 0x2::tx_context::sender(arg5),
            name                : v0.name,
        };
        0x2::event::emit<AgentRegistered>(v4);
        v0
    }

    public fun remove_metadata<T0: drop + store>(arg0: &mut AgentIdentity, arg1: 0x1::string::String) : T0 {
        0x2::dynamic_field::remove<0x1::string::String, T0>(&mut arg0.id, arg1)
    }

    public fun review_as_agent(arg0: &mut 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::feedback::FeedbackBoard, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &AgentIdentity, arg3: u8, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::feedback::pay_and_review_as_agent(arg0, arg1, 0x2::object::id<AgentIdentity>(arg2), arg3, arg4, arg5);
    }

    public fun set_active(arg0: &mut AgentIdentity, arg1: bool) {
        arg0.active = arg1;
    }

    public fun set_metadata<T0: drop + store>(arg0: &mut AgentIdentity, arg1: 0x1::string::String, arg2: T0) {
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<0x1::string::String, T0>(&mut arg0.id, arg1);
        };
        0x2::dynamic_field::add<0x1::string::String, T0>(&mut arg0.id, arg1, arg2);
    }

    public fun set_tags(arg0: &mut AgentIdentity, arg1: vector<0x1::string::String>) {
        arg0.tags = arg1;
    }

    public fun tags(arg0: &AgentIdentity) : &vector<0x1::string::String> {
        &arg0.tags
    }

    public fun update_profile(arg0: &mut AgentIdentity, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.agent_json = arg3;
        arg0.image_json = arg4;
        let v0 = AgentUpdated{
            agent_id   : 0x2::object::id<AgentIdentity>(arg0),
            updated_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<AgentUpdated>(v0);
    }

    public fun validation_board_address(arg0: 0x2::object::ID) : address {
        let v0 = ValBoardKey{dummy_field: false};
        0x2::derived_object::derive_address<ValBoardKey>(arg0, v0)
    }

    public fun withdraw(arg0: &mut 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::feedback::FeedbackBoard, arg1: &AgentIdentity, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::feedback::withdraw_balance(arg0, 0x2::object::id<AgentIdentity>(arg1), arg2, arg3)
    }

    public fun withdraw_all(arg0: &mut 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::feedback::FeedbackBoard, arg1: &AgentIdentity, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::feedback::withdraw_all_balance(arg0, 0x2::object::id<AgentIdentity>(arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

