module 0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::mission {
    struct UsersJoin has drop, store {
        account: address,
        totalDrops: u64,
        join_date: u64,
    }

    struct DROPS has drop {
        dummy_field: bool,
    }

    struct DropsAdmin has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<DROPS>,
    }

    struct DropsReward has store, key {
        id: 0x2::object::UID,
        reward: 0x2::balance::Balance<DROPS>,
    }

    struct DynamicFields has store, key {
        id: 0x2::object::UID,
        field_0: 0x1::string::String,
        field_1: 0x1::string::String,
        field_2: 0x1::string::String,
        field_3: 0x1::string::String,
        field_4: 0x1::string::String,
    }

    struct MissionQuiz has store, key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        list_result: vector<0x1::string::String>,
    }

    struct Follow has drop, store {
        account: address,
    }

    struct Task has drop, store {
        idTemplate: address,
        url: 0x1::string::String,
        status: u8,
    }

    struct User has drop, store {
        account: address,
        taskId: u8,
    }

    struct Mission has store, key {
        id: 0x2::object::UID,
        community_id: address,
        code: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        type: 0x1::string::String,
        link: 0x1::string::String,
        users_joined: vector<address>,
        point: u64,
        frequency: u64,
        start_time: u64,
        end_time: u64,
        on_chain: u8,
        hashtag: 0x1::string::String,
        is_campigns: u8,
        creator: address,
        create_date: u64,
    }

    struct MissionCreatedEvent has copy, drop {
        mission_id: 0x2::object::ID,
    }

    public entry fun add_mission(arg0: &mut 0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: vector<u8>, arg13: u8, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = Mission{
            id           : 0x2::object::new(arg14),
            community_id : arg1,
            code         : 0x1::string::utf8(arg2),
            title        : 0x1::string::utf8(arg3),
            description  : 0x1::string::utf8(arg4),
            type         : 0x1::string::utf8(arg5),
            link         : 0x1::string::utf8(arg6),
            users_joined : 0x1::vector::empty<address>(),
            point        : arg7,
            frequency    : arg8,
            start_time   : arg9,
            end_time     : arg10,
            on_chain     : arg11,
            hashtag      : 0x1::string::utf8(arg12),
            is_campigns  : arg13,
            creator      : 0x2::tx_context::sender(arg14),
            create_date  : 0x2::tx_context::epoch_timestamp_ms(arg14),
        };
        let v1 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v1);
        0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::update_total_missions(arg0);
        0x2::transfer::share_object<Mission>(v0);
    }

    public entry fun add_mission_advanced(arg0: &mut 0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: vector<u8>, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: u8, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = Mission{
            id           : 0x2::object::new(arg19),
            community_id : arg1,
            code         : 0x1::string::utf8(arg2),
            title        : 0x1::string::utf8(arg3),
            description  : 0x1::string::utf8(arg4),
            type         : 0x1::string::utf8(arg5),
            link         : 0x1::string::utf8(arg6),
            users_joined : 0x1::vector::empty<address>(),
            point        : arg7,
            frequency    : arg8,
            start_time   : arg9,
            end_time     : arg10,
            on_chain     : arg11,
            hashtag      : 0x1::string::utf8(arg12),
            is_campigns  : arg18,
            creator      : 0x2::tx_context::sender(arg19),
            create_date  : 0x2::tx_context::epoch_timestamp_ms(arg19),
        };
        0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::update_total_missions(arg0);
        let v1 = DynamicFields{
            id      : 0x2::object::new(arg19),
            field_0 : arg13,
            field_1 : arg14,
            field_2 : arg15,
            field_3 : arg16,
            field_4 : arg17,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, DynamicFields>(&mut v0.id, 0x2::object::id<DynamicFields>(&v1), v1);
        let v2 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v2);
        0x2::transfer::share_object<Mission>(v0);
    }

    public entry fun add_mission_with_campaigns_advanced(arg0: &mut 0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = Mission{
            id           : 0x2::object::new(arg13),
            community_id : arg1,
            code         : 0x1::string::utf8(arg2),
            title        : 0x1::string::utf8(arg3),
            description  : 0x1::string::utf8(arg4),
            type         : 0x1::string::utf8(arg5),
            link         : 0x1::string::utf8(arg6),
            users_joined : 0x1::vector::empty<address>(),
            point        : 0,
            frequency    : 0,
            start_time   : 0,
            end_time     : 0,
            on_chain     : arg7,
            hashtag      : 0x1::string::utf8(b""),
            is_campigns  : 1,
            creator      : 0x2::tx_context::sender(arg13),
            create_date  : 0x2::tx_context::epoch_timestamp_ms(arg13),
        };
        0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::update_total_missions(arg0);
        let v1 = DynamicFields{
            id      : 0x2::object::new(arg13),
            field_0 : arg8,
            field_1 : arg9,
            field_2 : arg10,
            field_3 : arg11,
            field_4 : arg12,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, DynamicFields>(&mut v0.id, 0x2::object::id<DynamicFields>(&v1), v1);
        let v2 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v2);
        0x2::transfer::share_object<Mission>(v0);
    }

    public entry fun add_mission_with_campaigns_basic(arg0: &mut 0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Mission{
            id           : 0x2::object::new(arg8),
            community_id : arg1,
            code         : 0x1::string::utf8(arg2),
            title        : 0x1::string::utf8(arg3),
            description  : 0x1::string::utf8(arg4),
            type         : 0x1::string::utf8(arg5),
            link         : 0x1::string::utf8(arg6),
            users_joined : 0x1::vector::empty<address>(),
            point        : 0,
            frequency    : 0,
            start_time   : 0,
            end_time     : 0,
            on_chain     : arg7,
            hashtag      : 0x1::string::utf8(b""),
            is_campigns  : 1,
            creator      : 0x2::tx_context::sender(arg8),
            create_date  : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::update_total_missions(arg0);
        let v1 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v1);
        0x2::transfer::share_object<Mission>(v0);
    }

    public entry fun add_mission_with_quiz(arg0: &mut 0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<0x1::string::String>, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = Mission{
            id           : 0x2::object::new(arg16),
            community_id : arg1,
            code         : 0x1::string::utf8(arg2),
            title        : 0x1::string::utf8(arg3),
            description  : 0x1::string::utf8(arg4),
            type         : 0x1::string::utf8(arg5),
            link         : 0x1::string::utf8(arg6),
            users_joined : 0x1::vector::empty<address>(),
            point        : arg7,
            frequency    : arg8,
            start_time   : arg9,
            end_time     : arg10,
            on_chain     : arg11,
            hashtag      : 0x1::string::utf8(arg12),
            is_campigns  : arg15,
            creator      : 0x2::tx_context::sender(arg16),
            create_date  : 0x2::tx_context::epoch_timestamp_ms(arg16),
        };
        0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::update_total_missions(arg0);
        let v1 = MissionQuiz{
            id          : 0x2::object::new(arg16),
            question    : 0x1::string::utf8(arg13),
            list_result : arg14,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, MissionQuiz>(&mut v0.id, 0x2::object::id<MissionQuiz>(&v1), v1);
        let v2 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v2);
        0x2::transfer::share_object<Mission>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DROPS{dummy_field: false};
        let v1 = DropsAdmin{
            id     : 0x2::object::new(arg0),
            supply : 0x2::balance::create_supply<DROPS>(v0),
        };
        0x2::transfer::share_object<DropsAdmin>(v1);
    }

    public entry fun user_join_and_claim(arg0: &mut DropsAdmin, arg1: &mut 0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::Community, arg2: &mut Mission, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg2.users_joined, &v0), 1);
        let v1 = DropsReward{
            id     : 0x2::object::new(arg3),
            reward : 0x2::balance::increase_supply<DROPS>(&mut arg0.supply, arg2.point),
        };
        0x1::vector::push_back<address>(&mut arg2.users_joined, v0);
        0x2::transfer::public_transfer<DropsReward>(v1, v0);
        0xf73cf3e4f19e5135e47bcf35157b8671d132473f71b209fd5fa297785297b53b::community::tracking_users_join(arg1, arg2.point, arg3);
    }

    // decompiled from Move bytecode v6
}

