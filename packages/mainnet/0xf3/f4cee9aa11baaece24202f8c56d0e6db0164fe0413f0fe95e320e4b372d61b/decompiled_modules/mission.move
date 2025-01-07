module 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::mission {
    struct SprintReward has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
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
        mission_id: 0x2::object::ID,
        account: address,
        content: 0x1::string::String,
        feedback: 0x1::string::String,
        create_date: u64,
        update_date: u64,
        status: u8,
    }

    struct Mission has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
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

    struct MissionReviewCreatedEvent has copy, drop {
        mission_review_id: 0x2::object::ID,
        mission_id: 0x2::object::ID,
    }

    public entry fun add_mission(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: vector<u8>, arg13: u8, arg14: &mut 0x2::tx_context::TxContext) {
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg0, arg14);
        let v0 = Mission{
            id              : 0x2::object::new(arg14),
            community_id    : 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::get_id(arg0),
            code            : 0x1::string::utf8(arg1),
            title           : 0x1::string::utf8(arg2),
            description     : 0x1::string::utf8(arg3),
            type            : 0x1::string::utf8(arg4),
            link            : 0x1::string::utf8(arg5),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : arg6,
            frequency       : arg7,
            start_time      : arg8,
            end_time        : arg9,
            on_chain        : arg10,
            is_need_review  : arg11,
            hashtag         : 0x1::string::utf8(arg12),
            is_campigns     : arg13,
            creator         : 0x2::tx_context::sender(arg14),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg14),
            update_date     : 0,
            status          : 1,
        };
        let v1 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v1);
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::update_total_missions(arg0);
        0x2::transfer::share_object<Mission>(v0);
    }

    public entry fun add_mission_advanced(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: vector<u8>, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: u8, arg19: &mut 0x2::tx_context::TxContext) {
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg0, arg19);
        let v0 = Mission{
            id              : 0x2::object::new(arg19),
            community_id    : 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::get_id(arg0),
            code            : 0x1::string::utf8(arg1),
            title           : 0x1::string::utf8(arg2),
            description     : 0x1::string::utf8(arg3),
            type            : 0x1::string::utf8(arg4),
            link            : 0x1::string::utf8(arg5),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : arg6,
            frequency       : arg7,
            start_time      : arg8,
            end_time        : arg9,
            on_chain        : arg10,
            is_need_review  : arg11,
            hashtag         : 0x1::string::utf8(arg12),
            is_campigns     : arg18,
            creator         : 0x2::tx_context::sender(arg19),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg19),
            update_date     : 0,
            status          : 1,
        };
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::update_total_missions(arg0);
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

    public entry fun add_mission_with_campaigns_advanced(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: u8, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: &mut 0x2::tx_context::TxContext) {
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg0, arg13);
        let v0 = Mission{
            id              : 0x2::object::new(arg13),
            community_id    : 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::get_id(arg0),
            code            : 0x1::string::utf8(arg1),
            title           : 0x1::string::utf8(arg2),
            description     : 0x1::string::utf8(arg3),
            type            : 0x1::string::utf8(arg4),
            link            : 0x1::string::utf8(arg5),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : 0,
            frequency       : 0,
            start_time      : 0,
            end_time        : 0,
            on_chain        : arg6,
            is_need_review  : arg7,
            hashtag         : 0x1::string::utf8(b""),
            is_campigns     : 1,
            creator         : 0x2::tx_context::sender(arg13),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg13),
            update_date     : 0,
            status          : 1,
        };
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::update_total_missions(arg0);
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

    public entry fun add_mission_with_campaigns_basic(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg0, arg8);
        let v0 = Mission{
            id              : 0x2::object::new(arg8),
            community_id    : 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::get_id(arg0),
            code            : 0x1::string::utf8(arg1),
            title           : 0x1::string::utf8(arg2),
            description     : 0x1::string::utf8(arg3),
            type            : 0x1::string::utf8(arg4),
            link            : 0x1::string::utf8(arg5),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : 0,
            frequency       : 0,
            start_time      : 0,
            end_time        : 0,
            on_chain        : arg6,
            is_need_review  : arg7,
            hashtag         : 0x1::string::utf8(b""),
            is_campigns     : 1,
            creator         : 0x2::tx_context::sender(arg8),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg8),
            update_date     : 0,
            status          : 1,
        };
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::update_total_missions(arg0);
        let v1 = MissionCreatedEvent{mission_id: 0x2::object::id<Mission>(&v0)};
        0x2::event::emit<MissionCreatedEvent>(v1);
        0x2::transfer::share_object<Mission>(v0);
    }

    public entry fun add_mission_with_quiz(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<0x1::string::String>, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg0, arg16);
        let v0 = Mission{
            id              : 0x2::object::new(arg16),
            community_id    : 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::get_id(arg0),
            code            : 0x1::string::utf8(arg1),
            title           : 0x1::string::utf8(arg2),
            description     : 0x1::string::utf8(arg3),
            type            : 0x1::string::utf8(arg4),
            link            : 0x1::string::utf8(arg5),
            users_joined    : 0x1::vector::empty<address>(),
            missions_review : 0x2::vec_map::empty<address, MissionReview>(),
            point           : arg6,
            frequency       : arg7,
            start_time      : arg8,
            end_time        : arg9,
            on_chain        : arg10,
            is_need_review  : arg11,
            hashtag         : 0x1::string::utf8(arg12),
            is_campigns     : arg15,
            creator         : 0x2::tx_context::sender(arg16),
            create_date     : 0x2::tx_context::epoch_timestamp_ms(arg16),
            update_date     : 0,
            status          : 1,
        };
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::update_total_missions(arg0);
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

    public entry fun add_sprint_reward(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<address>, arg4: vector<0x1::string::String>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg0, arg7);
        let v0 = SprintReward{
            id            : 0x2::object::new(arg7),
            community_id  : 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::get_id(arg0),
            title         : 0x1::string::utf8(arg1),
            description   : 0x1::string::utf8(arg2),
            list_missions : arg3,
            labels        : arg4,
            start_time    : arg5,
            end_time      : arg6,
            creator       : 0x2::tx_context::sender(arg7),
            create_date   : 0x2::tx_context::epoch_timestamp_ms(arg7),
            update_date   : 0,
            status        : 1,
        };
        let v1 = SprintRewardEvent{sprint_reward_id: 0x2::object::id<SprintReward>(&v0)};
        0x2::event::emit<SprintRewardEvent>(v1);
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::update_sprint_id(arg0, 0x2::object::id<SprintReward>(&v0));
        0x2::transfer::public_transfer<SprintReward>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun check_mission_on_chain(arg0: &mut Mission, arg1: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg2: &mut 0x2::tx_context::TxContext) : bool {
        if (arg0.code == 0x1::string::utf8(b"follow_us_watorFlow")) {
            return 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::get_follower(arg1, arg2)
        };
        if (arg0.code == 0x1::string::utf8(b"rate_us_watorFlow")) {
            return 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::get_rating(arg1, arg2)
        };
        assert!(arg0.code == 0x1::string::utf8(b"ask_us_any_questions_watorFlow"), 2);
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::get_qanda(arg1, arg2)
    }

    public entry fun claim_on_chain_rating(arg0: &mut DropsAdmin, arg1: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg2: &mut Mission, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = check_mission_on_chain(arg2, arg1, arg3);
        assert!(v0 == true, 2);
        user_join_and_claim(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_on_chain_voting(arg0: &mut DropsAdmin, arg1: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg2: &mut Mission, arg3: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::voting::Vote, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::voting::get_votes_by_user(arg3, arg4) == true, 2);
        user_join_and_claim(arg0, arg1, arg2, arg4);
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

    public entry fun review_mision_by_owner_community(arg0: &mut DropsAdmin, arg1: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg2: &mut Mission, arg3: &mut MissionReview, arg4: u8, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 0, 3);
        assert!(!0x1::vector::contains<address>(&arg2.users_joined, &arg3.account), 0);
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg1, arg6);
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
            0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::tracking_users_join(arg1, arg2.point, arg6);
        };
    }

    public entry fun submit_mission(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: &mut Mission, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1.is_need_review == 1) {
            let v0 = MissionReview{
                id          : 0x2::object::new(arg3),
                mission_id  : 0x2::object::id<Mission>(arg1),
                account     : 0x2::tx_context::sender(arg3),
                content     : 0x1::string::utf8(arg2),
                feedback    : 0x1::string::utf8(b""),
                create_date : 0x2::tx_context::epoch_timestamp_ms(arg3),
                update_date : 0,
                status      : 0,
            };
            let v1 = MissionReviewCreatedEvent{
                mission_review_id : 0x2::object::id<MissionReview>(&v0),
                mission_id        : 0x2::object::id<Mission>(arg1),
            };
            0x2::event::emit<MissionReviewCreatedEvent>(v1);
            0x2::transfer::share_object<MissionReview>(v0);
        };
    }

    public entry fun update_mision(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: &mut Mission, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg0, arg7);
        arg1.title = 0x1::string::utf8(arg2);
        arg1.description = 0x1::string::utf8(arg3);
        arg1.link = 0x1::string::utf8(arg4);
        arg1.point = arg5;
        arg1.frequency = arg6;
        arg1.update_date = 0x2::tx_context::epoch_timestamp_ms(arg7);
    }

    public entry fun update_sprint_reward(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: &mut SprintReward, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<address>, arg5: vector<0x1::string::String>, arg6: u64, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg0, arg9);
        arg1.title = 0x1::string::utf8(arg2);
        arg1.description = 0x1::string::utf8(arg3);
        arg1.list_missions = arg4;
        arg1.labels = arg5;
        arg1.start_time = arg6;
        arg1.end_time = arg7;
        arg1.status = arg8;
        arg1.update_date = 0x2::tx_context::epoch_timestamp_ms(arg9);
    }

    public entry fun update_status_mision(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg1: &mut Mission, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::validate_owner_community(arg0, arg3);
        arg1.status = arg2;
        arg1.update_date = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    public entry fun user_join_and_claim(arg0: &mut DropsAdmin, arg1: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::Community, arg2: &mut Mission, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg2.users_joined, &v0), 0);
        let v1 = DropsReward{
            id     : 0x2::object::new(arg3),
            reward : 0x2::balance::increase_supply<DROPS>(&mut arg0.supply, arg2.point),
        };
        0x1::vector::push_back<address>(&mut arg2.users_joined, v0);
        0x2::transfer::public_transfer<DropsReward>(v1, v0);
        0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::community::tracking_users_join(arg1, arg2.point, arg3);
    }

    // decompiled from Move bytecode v6
}

