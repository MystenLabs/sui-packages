module 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::mission {
    struct SprintReward has store, key {
        id: 0x2::object::UID,
        community_id: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        list_missions: vector<address>,
        labels: vector<0x1::string::String>,
        start_time: u64,
        end_time: u64,
        creator: address,
        create_date: u64,
        update_date: u64,
        status: u8,
    }

    struct SprintRewardEvent has copy, drop {
        sprint_reward_id: 0x2::object::ID,
    }

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

    struct MissionReview has store, key {
        id: 0x2::object::UID,
        account: address,
        content: 0x1::string::String,
        feedback: 0x1::string::String,
        create_date: u64,
        update_date: u64,
        status: u8,
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
        missions_review: 0x2::vec_map::VecMap<address, MissionReview>,
        point: u64,
        frequency: u64,
        start_time: u64,
        end_time: u64,
        on_chain: u8,
        is_need_review: u8,
        hashtag: 0x1::string::String,
        is_campigns: u8,
        creator: address,
        create_date: u64,
        update_date: u64,
        status: u8,
    }

    struct MissionCreatedEvent has copy, drop {
        mission_id: 0x2::object::ID,
    }

    public entry fun add_mission(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: u8, arg13: vector<u8>, arg14: u8, arg15: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg15);
        let v0 = Mission{
            id              : 0x2::object::new(arg15),
            community_id    : arg1,
            code            : 0x1::string::utf8(arg2),
            title           : 0x1::string::utf8(arg3),
            description     : 0x1::string::utf8(arg4),
            type            : 0x1::string::utf8(arg5),
            link            : 0x1::string::utf8(arg6),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : arg7,
            frequency       : arg8,
            start_time      : arg9,
            end_time        : arg10,
            on_chain        : arg11,
            is_need_review  : arg12,
            hashtag         : 0x1::string::utf8(arg13),
            is_campigns     : arg14,
            creator         : 0x2::tx_context::sender(arg15),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg15),
            update_date     : 0,
            status          : 1,
        };
        let v1 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v1);
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::update_total_missions(arg0);
        0x2::transfer::public_transfer<Mission>(v0, 0x2::tx_context::sender(arg15));
    }

    public entry fun add_mission_advanced(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: u8, arg13: vector<u8>, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: u8, arg20: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg20);
        let v0 = Mission{
            id              : 0x2::object::new(arg20),
            community_id    : arg1,
            code            : 0x1::string::utf8(arg2),
            title           : 0x1::string::utf8(arg3),
            description     : 0x1::string::utf8(arg4),
            type            : 0x1::string::utf8(arg5),
            link            : 0x1::string::utf8(arg6),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : arg7,
            frequency       : arg8,
            start_time      : arg9,
            end_time        : arg10,
            on_chain        : arg11,
            is_need_review  : arg12,
            hashtag         : 0x1::string::utf8(arg13),
            is_campigns     : arg19,
            creator         : 0x2::tx_context::sender(arg20),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg20),
            update_date     : 0,
            status          : 1,
        };
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::update_total_missions(arg0);
        let v1 = DynamicFields{
            id      : 0x2::object::new(arg20),
            field_0 : arg14,
            field_1 : arg15,
            field_2 : arg16,
            field_3 : arg17,
            field_4 : arg18,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, DynamicFields>(&mut v0.id, 0x2::object::id<DynamicFields>(&v1), v1);
        let v2 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v2);
        0x2::transfer::public_transfer<Mission>(v0, 0x2::tx_context::sender(arg20));
    }

    public entry fun add_mission_with_campaigns_advanced(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: u8, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg14);
        let v0 = Mission{
            id              : 0x2::object::new(arg14),
            community_id    : arg1,
            code            : 0x1::string::utf8(arg2),
            title           : 0x1::string::utf8(arg3),
            description     : 0x1::string::utf8(arg4),
            type            : 0x1::string::utf8(arg5),
            link            : 0x1::string::utf8(arg6),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : 0,
            frequency       : 0,
            start_time      : 0,
            end_time        : 0,
            on_chain        : arg7,
            is_need_review  : arg8,
            hashtag         : 0x1::string::utf8(b""),
            is_campigns     : 1,
            creator         : 0x2::tx_context::sender(arg14),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg14),
            update_date     : 0,
            status          : 1,
        };
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::update_total_missions(arg0);
        let v1 = DynamicFields{
            id      : 0x2::object::new(arg14),
            field_0 : arg9,
            field_1 : arg10,
            field_2 : arg11,
            field_3 : arg12,
            field_4 : arg13,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, DynamicFields>(&mut v0.id, 0x2::object::id<DynamicFields>(&v1), v1);
        let v2 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v2);
        0x2::transfer::public_transfer<Mission>(v0, 0x2::tx_context::sender(arg14));
    }

    public entry fun add_mission_with_campaigns_basic(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg9);
        let v0 = Mission{
            id              : 0x2::object::new(arg9),
            community_id    : arg1,
            code            : 0x1::string::utf8(arg2),
            title           : 0x1::string::utf8(arg3),
            description     : 0x1::string::utf8(arg4),
            type            : 0x1::string::utf8(arg5),
            link            : 0x1::string::utf8(arg6),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : 0,
            frequency       : 0,
            start_time      : 0,
            end_time        : 0,
            on_chain        : arg7,
            is_need_review  : arg8,
            hashtag         : 0x1::string::utf8(b""),
            is_campigns     : 1,
            creator         : 0x2::tx_context::sender(arg9),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg9),
            update_date     : 0,
            status          : 1,
        };
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::update_total_missions(arg0);
        let v1 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v1);
        0x2::transfer::public_transfer<Mission>(v0, 0x2::tx_context::sender(arg9));
    }

    public entry fun add_mission_with_quiz(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: u8, arg13: vector<u8>, arg14: vector<u8>, arg15: vector<0x1::string::String>, arg16: u8, arg17: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg17);
        let v0 = Mission{
            id              : 0x2::object::new(arg17),
            community_id    : arg1,
            code            : 0x1::string::utf8(arg2),
            title           : 0x1::string::utf8(arg3),
            description     : 0x1::string::utf8(arg4),
            type            : 0x1::string::utf8(arg5),
            link            : 0x1::string::utf8(arg6),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : arg7,
            frequency       : arg8,
            start_time      : arg9,
            end_time        : arg10,
            on_chain        : arg11,
            is_need_review  : arg12,
            hashtag         : 0x1::string::utf8(arg13),
            is_campigns     : arg16,
            creator         : 0x2::tx_context::sender(arg17),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg17),
            update_date     : 0,
            status          : 1,
        };
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::update_total_missions(arg0);
        let v1 = MissionQuiz{
            id          : 0x2::object::new(arg17),
            question    : 0x1::string::utf8(arg14),
            list_result : arg15,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, MissionQuiz>(&mut v0.id, 0x2::object::id<MissionQuiz>(&v1), v1);
        let v2 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v2);
        0x2::transfer::public_transfer<Mission>(v0, 0x2::tx_context::sender(arg17));
    }

    public entry fun add_sprint_reward(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<address>, arg5: vector<0x1::string::String>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg8);
        let v0 = SprintReward{
            id            : 0x2::object::new(arg8),
            community_id  : arg1,
            title         : 0x1::string::utf8(arg2),
            description   : 0x1::string::utf8(arg3),
            list_missions : arg4,
            labels        : arg5,
            start_time    : arg6,
            end_time      : arg7,
            creator       : 0x2::tx_context::sender(arg8),
            create_date   : 0x2::tx_context::epoch_timestamp_ms(arg8),
            update_date   : 0,
            status        : 1,
        };
        let v1 = SprintRewardEvent{sprint_reward_id: 0x2::object::id<SprintReward>(&v0)};
        0x2::event::emit<SprintRewardEvent>(v1);
        0x2::transfer::public_transfer<SprintReward>(v0, 0x2::tx_context::sender(arg8));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DROPS{dummy_field: false};
        let v1 = DropsAdmin{
            id     : 0x2::object::new(arg0),
            supply : 0x2::balance::create_supply<DROPS>(v0),
        };
        0x2::transfer::share_object<DropsAdmin>(v1);
    }

    public entry fun resubmit_mission(arg0: &mut MissionReview, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.account, 1);
        arg0.content = 0x1::string::utf8(arg1);
        arg0.status = 0;
    }

    public entry fun review_mision_by_owner_community(arg0: &mut DropsAdmin, arg1: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg2: &mut Mission, arg3: &mut MissionReview, arg4: u8, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg1, arg6);
        0x2::tx_context::sender(arg6);
        arg3.feedback = 0x1::string::utf8(arg5);
        arg3.status = arg4;
        if (arg4 == 1) {
            let v0 = DropsReward{
                id     : 0x2::object::new(arg6),
                reward : 0x2::balance::increase_supply<DROPS>(&mut arg0.supply, arg2.point),
            };
            0x1::vector::push_back<address>(&mut arg2.users_joined, arg3.account);
            0x2::transfer::public_transfer<DropsReward>(v0, arg3.account);
            0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::tracking_users_join(arg1, arg2.point, arg6);
        };
    }

    public entry fun submit_mission(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: &mut Mission, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = MissionReview{
            id          : 0x2::object::new(arg3),
            account     : v0,
            content     : 0x1::string::utf8(arg2),
            feedback    : 0x1::string::utf8(b""),
            create_date : 0x2::tx_context::epoch_timestamp_ms(arg3),
            update_date : 0,
            status      : 0,
        };
        0x2::transfer::public_transfer<MissionReview>(v1, v0);
    }

    public entry fun update_mision(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: &mut Mission, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg7);
        arg1.title = 0x1::string::utf8(arg2);
        arg1.description = 0x1::string::utf8(arg3);
        arg1.link = 0x1::string::utf8(arg4);
        arg1.point = arg5;
        arg1.frequency = arg6;
        arg1.update_date = 0x2::tx_context::epoch_timestamp_ms(arg7);
    }

    public entry fun update_sprint_reward(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: &mut SprintReward, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<address>, arg5: vector<0x1::string::String>, arg6: u64, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg9);
        arg1.title = 0x1::string::utf8(arg2);
        arg1.description = 0x1::string::utf8(arg3);
        arg1.list_missions = arg4;
        arg1.labels = arg5;
        arg1.start_time = arg6;
        arg1.end_time = arg7;
        arg1.status = arg8;
        arg1.update_date = 0x2::tx_context::epoch_timestamp_ms(arg9);
    }

    public entry fun update_status_mision(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: &mut Mission, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg3);
        arg1.status = arg2;
        arg1.update_date = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    public entry fun user_join_and_claim(arg0: &mut DropsAdmin, arg1: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg2: &mut Mission, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg2.users_joined, &v0), 0);
        let v1 = DropsReward{
            id     : 0x2::object::new(arg3),
            reward : 0x2::balance::increase_supply<DROPS>(&mut arg0.supply, arg2.point),
        };
        0x1::vector::push_back<address>(&mut arg2.users_joined, v0);
        0x2::transfer::public_transfer<DropsReward>(v1, v0);
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::tracking_users_join(arg1, arg2.point, arg3);
    }

    // decompiled from Move bytecode v6
}

