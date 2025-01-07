module 0xbd1746e73f3af781571f57f496a38031297cea2151ba8e3b1785d15c29e1eda9::quest {
    struct QUEST has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VerifierCap has store, key {
        id: 0x2::object::UID,
    }

    struct SpaceHub has key {
        id: 0x2::object::UID,
        version: u64,
        fee_for_creating_journey: u64,
        fee_for_start_quest: u64,
        verifier_address: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        space_creators_allowlist: 0x2::table::Table<address, u64>,
        spaces: 0x2::table_vec::TableVec<0x2::object::ID>,
    }

    struct Space has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        website_url: 0x2::url::Url,
        twitter_url: 0x2::url::Url,
        journeys: 0x2::object_table::ObjectTable<0x2::object::ID, Journey>,
        points: 0x2::table::Table<address, u64>,
    }

    struct SpaceAdminCap has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        space_id: 0x2::object::ID,
    }

    struct Journey has store, key {
        id: 0x2::object::UID,
        reward_type: u64,
        reward_required_points: u64,
        reward_image_url: 0x2::url::Url,
        name: 0x1::string::String,
        description: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        total_completed: u64,
        quests: 0x2::object_table::ObjectTable<0x2::object::ID, Quest>,
        completed_users: 0x2::table::Table<address, bool>,
        users_points: 0x2::table::Table<address, u64>,
        users_completed_quests: 0x2::table::Table<address, u64>,
    }

    struct Quest has store, key {
        id: 0x2::object::UID,
        points_amount: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        call_to_action_url: 0x2::url::Url,
        package_id: 0x2::object::ID,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        arguments: vector<0x1::string::String>,
        total_completed: u64,
        completed_users: 0x2::table::Table<address, bool>,
    }

    struct NftReward has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        space_id: 0x2::object::ID,
        journey_id: 0x2::object::ID,
        claimer: address,
    }

    struct SoulboundReward has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        space_id: 0x2::object::ID,
        journey_id: 0x2::object::ID,
        claimer: address,
    }

    struct SpaceCreated has copy, drop {
        space_id: 0x2::object::ID,
    }

    struct JourneyCreated has copy, drop {
        space_id: 0x2::object::ID,
        journey_id: 0x2::object::ID,
    }

    struct JourneyRemoved has copy, drop {
        space_id: 0x2::object::ID,
        journey_id: 0x2::object::ID,
    }

    struct JourneyCompleted has copy, drop {
        space_id: 0x2::object::ID,
        journey_id: 0x2::object::ID,
        user: address,
    }

    struct QuestCreated has copy, drop {
        space_id: 0x2::object::ID,
        journey_id: 0x2::object::ID,
        quest_id: 0x2::object::ID,
    }

    struct QuestRemoved has copy, drop {
        space_id: 0x2::object::ID,
        journey_id: 0x2::object::ID,
        quest_id: 0x2::object::ID,
    }

    struct QuestCompleted has copy, drop {
        space_id: 0x2::object::ID,
        journey_id: 0x2::object::ID,
        quest_id: 0x2::object::ID,
        user: address,
    }

    public fun quest(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : &Quest {
        0x2::object_table::borrow<0x2::object::ID, Quest>(&0x2::object_table::borrow<0x2::object::ID, Journey>(&arg0.journeys, arg1).quests, arg2)
    }

    public entry fun add_space_creator(arg0: &AdminCap, arg1: &mut SpaceHub, arg2: address, arg3: u64) {
        check_hub_version(arg1);
        if (!0x2::table::contains<address, u64>(&arg1.space_creators_allowlist, arg2)) {
            0x2::table::add<address, u64>(&mut arg1.space_creators_allowlist, arg2, arg3);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.space_creators_allowlist, arg2);
            *v0 = *v0 + arg3;
        };
    }

    public fun available_spaces_to_create(arg0: &SpaceHub, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.space_creators_allowlist, arg1)) {
            return *0x2::table::borrow<address, u64>(&arg0.space_creators_allowlist, arg1)
        };
        0
    }

    fun check_hub_version(arg0: &SpaceHub) {
        assert!(arg0.version == 0, 0);
    }

    fun check_space_admin(arg0: &SpaceAdminCap, arg1: &Space) {
        assert!(arg0.space_id == 0x2::object::id<Space>(arg1), 3);
    }

    fun check_space_version(arg0: &Space) {
        assert!(arg0.version == 0, 0);
    }

    public fun complete_journey(arg0: &mut Space, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        check_space_version(arg0);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg0.journeys, arg1);
        assert!(!0x2::table::contains<address, bool>(&v0.completed_users, 0x2::tx_context::sender(arg2)), 8);
        assert!(0x2::table::contains<address, u64>(&v0.users_points, 0x2::tx_context::sender(arg2)), 9);
        assert!(*0x2::table::borrow<address, u64>(&v0.users_points, 0x2::tx_context::sender(arg2)) >= v0.reward_required_points, 9);
        let v1 = JourneyCompleted{
            space_id   : 0x2::object::uid_to_inner(&arg0.id),
            journey_id : arg1,
            user       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<JourneyCompleted>(v1);
        v0.total_completed = v0.total_completed + 1;
        0x2::table::add<address, bool>(&mut v0.completed_users, 0x2::tx_context::sender(arg2), true);
        if (v0.reward_type == 0) {
            let v2 = NftReward{
                id          : 0x2::object::new(arg2),
                name        : v0.name,
                description : v0.description,
                image_url   : v0.reward_image_url,
                space_id    : 0x2::object::id<Space>(arg0),
                journey_id  : arg1,
                claimer     : 0x2::tx_context::sender(arg2),
            };
            0x2::transfer::transfer<NftReward>(v2, 0x2::tx_context::sender(arg2));
        } else if (v0.reward_type == 1) {
            let v3 = SoulboundReward{
                id          : 0x2::object::new(arg2),
                name        : v0.name,
                description : v0.description,
                image_url   : v0.reward_image_url,
                space_id    : 0x2::object::id<Space>(arg0),
                journey_id  : arg1,
                claimer     : 0x2::tx_context::sender(arg2),
            };
            0x2::transfer::transfer<SoulboundReward>(v3, 0x2::tx_context::sender(arg2));
        };
    }

    public fun complete_quest(arg0: &VerifierCap, arg1: &mut Space, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: &0x2::clock::Clock) {
        check_space_version(arg1);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg1.journeys, arg2);
        assert!(0x2::clock::timestamp_ms(arg5) >= v0.start_time && 0x2::clock::timestamp_ms(arg5) <= v0.end_time, 4);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Quest>(&mut v0.quests, arg3);
        assert!(0x2::table::contains<address, bool>(&v1.completed_users, arg4), 6);
        assert!(*0x2::table::borrow<address, bool>(&v1.completed_users, arg4) == false, 5);
        let v2 = QuestCompleted{
            space_id   : 0x2::object::uid_to_inner(&arg1.id),
            journey_id : arg2,
            quest_id   : arg3,
            user       : arg4,
        };
        0x2::event::emit<QuestCompleted>(v2);
        v1.total_completed = v1.total_completed + 1;
        *0x2::table::borrow_mut<address, bool>(&mut v1.completed_users, arg4) = true;
        let v3 = &mut v0.users_points;
        update_address_to_u64_table(v3, arg4, v1.points_amount);
        let v4 = &mut v0.users_completed_quests;
        update_address_to_u64_table(v4, arg4, 1);
        let v5 = &mut arg1.points;
        update_address_to_u64_table(v5, arg4, v1.points_amount);
    }

    public fun create_journey(arg0: &mut SpaceHub, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &SpaceAdminCap, arg3: &mut Space, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_space_version(arg3);
        check_space_admin(arg2, arg3);
        assert!(arg4 == 0 || arg4 == 1, 10);
        0xbd1746e73f3af781571f57f496a38031297cea2151ba8e3b1785d15c29e1eda9::utils::handle_payment<0x2::sui::SUI>(&mut arg0.balance, arg1, arg0.fee_for_creating_journey, arg11);
        let v0 = Journey{
            id                     : 0x2::object::new(arg11),
            reward_type            : arg4,
            reward_required_points : arg6,
            reward_image_url       : 0x2::url::new_unsafe(0x1::string::to_ascii(arg5)),
            name                   : arg7,
            description            : arg8,
            start_time             : arg9,
            end_time               : arg10,
            total_completed        : 0,
            quests                 : 0x2::object_table::new<0x2::object::ID, Quest>(arg11),
            completed_users        : 0x2::table::new<address, bool>(arg11),
            users_points           : 0x2::table::new<address, u64>(arg11),
            users_completed_quests : 0x2::table::new<address, u64>(arg11),
        };
        let v1 = JourneyCreated{
            space_id   : 0x2::object::uid_to_inner(&arg3.id),
            journey_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<JourneyCreated>(v1);
        let v2 = 0x2::object::id<Journey>(&v0);
        0x2::object_table::add<0x2::object::ID, Journey>(&mut arg3.journeys, v2, v0);
        v2
    }

    public fun create_quest(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::object::ID, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        let v0 = Quest{
            id                 : 0x2::object::new(arg11),
            points_amount      : arg3,
            name               : arg4,
            description        : arg5,
            call_to_action_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg6)),
            package_id         : arg7,
            module_name        : arg8,
            function_name      : arg9,
            arguments          : arg10,
            total_completed    : 0,
            completed_users    : 0x2::table::new<address, bool>(arg11),
        };
        let v1 = QuestCreated{
            space_id   : 0x2::object::uid_to_inner(&arg1.id),
            journey_id : arg2,
            quest_id   : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<QuestCreated>(v1);
        let v2 = 0x2::object::id<Quest>(&v0);
        0x2::object_table::add<0x2::object::ID, Quest>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg1.journeys, arg2).quests, v2, v0);
        v2
    }

    public fun create_space(arg0: &mut SpaceHub, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        check_hub_version(arg0);
        assert!(0x2::table::contains<address, u64>(&arg0.space_creators_allowlist, 0x2::tx_context::sender(arg6)) && *0x2::table::borrow<address, u64>(&arg0.space_creators_allowlist, 0x2::tx_context::sender(arg6)) > 0, 2);
        let v0 = Space{
            id          : 0x2::object::new(arg6),
            version     : 0,
            name        : arg1,
            description : arg2,
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(arg3)),
            website_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg4)),
            twitter_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg5)),
            journeys    : 0x2::object_table::new<0x2::object::ID, Journey>(arg6),
            points      : 0x2::table::new<address, u64>(arg6),
        };
        let v1 = SpaceAdminCap{
            id       : 0x2::object::new(arg6),
            name     : v0.name,
            space_id : 0x2::object::id<Space>(&v0),
        };
        let v2 = SpaceCreated{space_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<SpaceCreated>(v2);
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.space_creators_allowlist, 0x2::tx_context::sender(arg6));
        *v3 = *v3 - 1;
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.spaces, 0x2::object::id<Space>(&v0));
        0x2::transfer::share_object<Space>(v0);
        0x2::transfer::public_transfer<SpaceAdminCap>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun fee_for_creating_journey(arg0: &SpaceHub) : u64 {
        arg0.fee_for_creating_journey
    }

    public fun fee_for_starting_quest(arg0: &SpaceHub) : u64 {
        arg0.fee_for_start_quest
    }

    fun init(arg0: QUEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<QUEST>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.holasui.app"));
        let v5 = 0x2::display::new_with_fields<NftReward>(&v0, v1, v3, arg1);
        0x2::display::update_version<NftReward>(&mut v5);
        let v6 = 0x2::display::new_with_fields<SoulboundReward>(&v0, v1, v3, arg1);
        0x2::display::update_version<SoulboundReward>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NftReward>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SoulboundReward>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
        let v8 = VerifierCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<VerifierCap>(v8, 0x2::tx_context::sender(arg1));
        let v9 = SpaceHub{
            id                       : 0x2::object::new(arg1),
            version                  : 0,
            fee_for_creating_journey : 1000000000,
            fee_for_start_quest      : 10000000,
            verifier_address         : @0xfa40dda8beaf0bee40130a32df04bc74bb8a4bc85b2d27c54289fe8676d5f977,
            balance                  : 0x2::balance::zero<0x2::sui::SUI>(),
            space_creators_allowlist : 0x2::table::new<address, u64>(arg1),
            spaces                   : 0x2::table_vec::empty<0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<SpaceHub>(v9);
    }

    public fun journey(arg0: &Space, arg1: 0x2::object::ID) : &Journey {
        0x2::object_table::borrow<0x2::object::ID, Journey>(&arg0.journeys, arg1)
    }

    public fun journey_completed_user(arg0: &Space, arg1: 0x2::object::ID, arg2: address) : bool {
        let v0 = journey_completed_users(arg0, arg1);
        if (0x2::table::contains<address, bool>(v0, arg2)) {
            return *0x2::table::borrow<address, bool>(v0, arg2)
        };
        false
    }

    public fun journey_completed_users(arg0: &Space, arg1: 0x2::object::ID) : &0x2::table::Table<address, bool> {
        &journey(arg0, arg1).completed_users
    }

    public fun journey_description(arg0: &Space, arg1: 0x2::object::ID) : 0x1::string::String {
        journey(arg0, arg1).description
    }

    public fun journey_end_time(arg0: &Space, arg1: 0x2::object::ID) : u64 {
        journey(arg0, arg1).end_time
    }

    public fun journey_name(arg0: &Space, arg1: 0x2::object::ID) : 0x1::string::String {
        journey(arg0, arg1).name
    }

    public fun journey_quests(arg0: &Space, arg1: 0x2::object::ID) : &0x2::object_table::ObjectTable<0x2::object::ID, Quest> {
        &journey(arg0, arg1).quests
    }

    public fun journey_reward_image_url(arg0: &Space, arg1: 0x2::object::ID) : 0x2::url::Url {
        journey(arg0, arg1).reward_image_url
    }

    public fun journey_reward_required_points(arg0: &Space, arg1: 0x2::object::ID) : u64 {
        journey(arg0, arg1).reward_required_points
    }

    public fun journey_reward_type(arg0: &Space, arg1: 0x2::object::ID) : u64 {
        journey(arg0, arg1).reward_type
    }

    public fun journey_start_time(arg0: &Space, arg1: 0x2::object::ID) : u64 {
        journey(arg0, arg1).start_time
    }

    public fun journey_total_completed(arg0: &Space, arg1: 0x2::object::ID) : u64 {
        journey(arg0, arg1).total_completed
    }

    public fun journey_user_completed_quests(arg0: &Space, arg1: 0x2::object::ID, arg2: address) : u64 {
        let v0 = journey_users_completed_quests(arg0, arg1);
        if (0x2::table::contains<address, u64>(v0, arg2)) {
            return *0x2::table::borrow<address, u64>(v0, arg2)
        };
        0
    }

    public fun journey_user_points(arg0: &Space, arg1: 0x2::object::ID, arg2: address) : u64 {
        let v0 = journey_users_points(arg0, arg1);
        if (0x2::table::contains<address, u64>(v0, arg2)) {
            return *0x2::table::borrow<address, u64>(v0, arg2)
        };
        0
    }

    public fun journey_users_completed_quests(arg0: &Space, arg1: 0x2::object::ID) : &0x2::table::Table<address, u64> {
        &journey(arg0, arg1).users_completed_quests
    }

    public fun journey_users_points(arg0: &Space, arg1: 0x2::object::ID) : &0x2::table::Table<address, u64> {
        &journey(arg0, arg1).users_points
    }

    entry fun migrate_hub(arg0: &AdminCap, arg1: &mut SpaceHub) {
        assert!(arg1.version < 0, 1);
        arg1.version = 0;
    }

    entry fun migrate_space(arg0: &AdminCap, arg1: &mut Space) {
        assert!(arg1.version < 0, 1);
        arg1.version = 0;
    }

    public fun quest_arguments(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : &vector<0x1::string::String> {
        &quest(arg0, arg1, arg2).arguments
    }

    public fun quest_call_to_action_url(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : 0x2::url::Url {
        quest(arg0, arg1, arg2).call_to_action_url
    }

    public fun quest_completed_user(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) : bool {
        let v0 = quest_completed_users(arg0, arg1, arg2);
        if (0x2::table::contains<address, bool>(v0, arg3)) {
            return *0x2::table::borrow<address, bool>(v0, arg3)
        };
        false
    }

    public fun quest_completed_users(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : &0x2::table::Table<address, bool> {
        &quest(arg0, arg1, arg2).completed_users
    }

    public fun quest_description(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : 0x1::string::String {
        quest(arg0, arg1, arg2).description
    }

    public fun quest_function_name(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : 0x1::string::String {
        quest(arg0, arg1, arg2).function_name
    }

    public fun quest_module_name(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : 0x1::string::String {
        quest(arg0, arg1, arg2).module_name
    }

    public fun quest_name(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : 0x1::string::String {
        quest(arg0, arg1, arg2).name
    }

    public fun quest_package_id(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : 0x2::object::ID {
        quest(arg0, arg1, arg2).package_id
    }

    public fun quest_points_amount(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : u64 {
        quest(arg0, arg1, arg2).points_amount
    }

    public fun quest_started_user(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) : bool {
        0x2::table::contains<address, bool>(quest_completed_users(arg0, arg1, arg2), arg3)
    }

    public fun quest_total_completed(arg0: &Space, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : u64 {
        quest(arg0, arg1, arg2).total_completed
    }

    public fun remove_journey(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x2::object::ID) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        let Journey {
            id                     : v0,
            reward_type            : _,
            reward_required_points : _,
            reward_image_url       : _,
            name                   : _,
            description            : _,
            start_time             : _,
            end_time               : _,
            total_completed        : _,
            quests                 : v9,
            completed_users        : v10,
            users_points           : v11,
            users_completed_quests : v12,
        } = 0x2::object_table::remove<0x2::object::ID, Journey>(&mut arg1.journeys, arg2);
        let v13 = v0;
        let v14 = JourneyRemoved{
            space_id   : 0x2::object::uid_to_inner(&arg1.id),
            journey_id : 0x2::object::uid_to_inner(&v13),
        };
        0x2::event::emit<JourneyRemoved>(v14);
        0x2::object_table::destroy_empty<0x2::object::ID, Quest>(v9);
        0x2::table::drop<address, bool>(v10);
        0x2::table::drop<address, u64>(v11);
        0x2::table::drop<address, u64>(v12);
        0x2::object::delete(v13);
    }

    public fun remove_quest(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        let Quest {
            id                 : v0,
            points_amount      : _,
            name               : _,
            description        : _,
            call_to_action_url : _,
            package_id         : _,
            module_name        : _,
            function_name      : _,
            arguments          : _,
            total_completed    : _,
            completed_users    : v10,
        } = 0x2::object_table::remove<0x2::object::ID, Quest>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg1.journeys, arg2).quests, arg3);
        let v11 = v0;
        let v12 = QuestRemoved{
            space_id   : 0x2::object::uid_to_inner(&arg1.id),
            journey_id : arg2,
            quest_id   : 0x2::object::uid_to_inner(&v11),
        };
        0x2::event::emit<QuestRemoved>(v12);
        0x2::object::delete(v11);
        0x2::table::drop<address, bool>(v10);
    }

    public fun space(arg0: &Space) : &Space {
        arg0
    }

    public fun space_description(arg0: &Space) : 0x1::string::String {
        arg0.description
    }

    public fun space_image_url(arg0: &Space) : 0x2::url::Url {
        arg0.image_url
    }

    public fun space_journeys(arg0: &Space) : &0x2::object_table::ObjectTable<0x2::object::ID, Journey> {
        &arg0.journeys
    }

    public fun space_name(arg0: &Space) : 0x1::string::String {
        arg0.name
    }

    public fun space_points(arg0: &Space) : &0x2::table::Table<address, u64> {
        &arg0.points
    }

    public fun space_twitter_url(arg0: &Space) : 0x2::url::Url {
        arg0.twitter_url
    }

    public fun space_user_points(arg0: &Space, arg1: address) : u64 {
        let v0 = space_points(arg0);
        if (0x2::table::contains<address, u64>(v0, arg1)) {
            return *0x2::table::borrow<address, u64>(v0, arg1)
        };
        0
    }

    public fun space_website_url(arg0: &Space) : 0x2::url::Url {
        arg0.website_url
    }

    public fun spaces(arg0: &SpaceHub) : &0x2::table_vec::TableVec<0x2::object::ID> {
        &arg0.spaces
    }

    public fun start_quest(arg0: &mut SpaceHub, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Space, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_space_version(arg2);
        0xbd1746e73f3af781571f57f496a38031297cea2151ba8e3b1785d15c29e1eda9::utils::handle_transfer<0x2::sui::SUI>(@0xfa40dda8beaf0bee40130a32df04bc74bb8a4bc85b2d27c54289fe8676d5f977, arg1, arg0.fee_for_start_quest, arg6);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg2.journeys, arg3);
        assert!(0x2::clock::timestamp_ms(arg5) >= v0.start_time && 0x2::clock::timestamp_ms(arg5) <= v0.end_time, 4);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Quest>(&mut v0.quests, arg4);
        assert!(!0x2::table::contains<address, bool>(&v1.completed_users, 0x2::tx_context::sender(arg6)), 7);
        0x2::table::add<address, bool>(&mut v1.completed_users, 0x2::tx_context::sender(arg6), false);
    }

    fun update_address_to_u64_table(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, u64>(arg0, arg1)) {
            0x2::table::add<address, u64>(arg0, arg1, arg2);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
            *v0 = *v0 + arg2;
        };
    }

    entry fun update_fee_for_creating_journey(arg0: &AdminCap, arg1: &mut SpaceHub, arg2: u64) {
        check_hub_version(arg1);
        arg1.fee_for_creating_journey = arg2;
    }

    entry fun update_fee_for_start_quest(arg0: &AdminCap, arg1: &mut SpaceHub, arg2: u64) {
        check_hub_version(arg1);
        arg1.fee_for_start_quest = arg2;
    }

    entry fun update_journey_description(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x2::object::ID, arg3: 0x1::string::String) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg1.journeys, arg2).description = arg3;
    }

    entry fun update_journey_end_time(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x2::object::ID, arg3: u64) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg1.journeys, arg2).end_time = arg3;
    }

    entry fun update_journey_name(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x2::object::ID, arg3: 0x1::string::String) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg1.journeys, arg2).name = arg3;
    }

    entry fun update_journey_reward_image_url(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x2::object::ID, arg3: 0x1::string::String) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg1.journeys, arg2).reward_image_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg3));
    }

    entry fun update_journey_start_time(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x2::object::ID, arg3: u64) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        0x2::object_table::borrow_mut<0x2::object::ID, Journey>(&mut arg1.journeys, arg2).start_time = arg3;
    }

    entry fun update_space_description(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x1::string::String) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        arg1.description = arg2;
    }

    entry fun update_space_image_url(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x1::string::String) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        arg1.image_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg2));
    }

    entry fun update_space_name(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x1::string::String) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        arg1.name = arg2;
    }

    entry fun update_space_twitter_url(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x1::string::String) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        arg1.twitter_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg2));
    }

    entry fun update_space_website_url(arg0: &SpaceAdminCap, arg1: &mut Space, arg2: 0x1::string::String) {
        check_space_version(arg1);
        check_space_admin(arg0, arg1);
        arg1.website_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg2));
    }

    entry fun update_verifier_address(arg0: &AdminCap, arg1: &mut SpaceHub, arg2: address) {
        check_hub_version(arg1);
        arg1.verifier_address = arg2;
    }

    public fun verifier_address(arg0: &SpaceHub) : address {
        arg0.verifier_address
    }

    entry fun withdraw(arg0: &AdminCap, arg1: &mut SpaceHub, arg2: &mut 0x2::tx_context::TxContext) {
        check_hub_version(arg1);
        0xbd1746e73f3af781571f57f496a38031297cea2151ba8e3b1785d15c29e1eda9::utils::withdraw_balance<0x2::sui::SUI>(&mut arg1.balance, arg2);
    }

    // decompiled from Move bytecode v6
}

