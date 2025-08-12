module 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing {
    struct CreateEvent has copy, drop {
        id: 0x2::object::ID,
        race_event_id: 0x1::string::String,
        bet_end_time: u64,
    }

    struct AddBetEvent has copy, drop {
        player_address: address,
        race_id: 0x2::object::ID,
        race_event_id: 0x1::string::String,
        bet_id: 0x2::object::ID,
        bet_size: u64,
        payout: u64,
        option: vector<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>,
        coin_type: 0x1::type_name::TypeName,
    }

    struct BetCancelEvent has copy, drop {
        race_id: 0x2::object::ID,
        race_event_id: 0x1::string::String,
        cancelled_bets: vector<0x2::object::ID>,
    }

    struct BetResultV2<phantom T0> has copy, drop {
        bet_id: 0x1::option::Option<0x2::object::ID>,
        player: address,
        bet_options: vector<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>,
        bet_size: u64,
        bet_returned: u64,
        outcome: vector<u64>,
    }

    struct BetResultsV2<phantom T0> has copy, drop {
        race_id: 0x1::option::Option<0x2::object::ID>,
        origin: 0x1::option::Option<0x1::string::String>,
        bets: vector<BetResultV2<T0>>,
    }

    struct MarbleRacing has copy, drop, store {
        dummy_field: bool,
    }

    struct RaceConfig has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        managers: 0x2::vec_set::VecSet<address>,
        risk_limits: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>,
        page_size: u64,
        bet_manager: 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::BetManager,
        max_combo: u8,
        current_race: 0x1::option::Option<0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        original_id_cap: 0x2::object::ID,
    }

    struct BetSlip has store, key {
        id: 0x2::object::UID,
        player_address: address,
        bet_size: u64,
        payout: u64,
        option: vector<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>,
        coin_type: 0x1::type_name::TypeName,
    }

    struct Race has store, key {
        id: 0x2::object::UID,
        creator: address,
        race_event_id: 0x1::string::String,
        bet_start_time: u64,
        bet_end_time: u64,
        status: u64,
        risk_manager: 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::risk_manager::RiskManager,
        bet_setting: 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::BetSetting,
        bet_slips: 0x1::option::Option<0x2::linked_table::LinkedTable<address, vector<BetSlip>>>,
    }

    struct PlayerWin<phantom T0> {
        player: address,
        bet_balance: 0x2::balance::Balance<T0>,
        bet_payout: u64,
    }

    fun remove(arg0: &mut RaceConfig, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg2);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 9);
        let Race {
            id             : v0,
            creator        : _,
            race_event_id  : v2,
            bet_start_time : _,
            bet_end_time   : _,
            status         : _,
            risk_manager   : v6,
            bet_setting    : _,
            bet_slips      : v8,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Race>(&mut arg0.id, arg1);
        let v9 = v8;
        let v10 = v2;
        if (0x1::option::is_some<0x2::linked_table::LinkedTable<address, vector<BetSlip>>>(&v9)) {
            let v11 = 0x1::option::extract<0x2::linked_table::LinkedTable<address, vector<BetSlip>>>(&mut v9);
            assert!(0x2::linked_table::length<address, vector<BetSlip>>(&v11) == 0, 11);
            0x2::linked_table::destroy_empty<address, vector<BetSlip>>(v11);
        };
        0x1::option::destroy_none<0x2::linked_table::LinkedTable<address, vector<BetSlip>>>(v9);
        0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::risk_manager::destroy_manager(v6);
        if (0x1::option::is_some<0x1::string::String>(&arg0.current_race)) {
            if (0x1::option::borrow<0x1::string::String>(&arg0.current_race) == &v10) {
                arg0.current_race = 0x1::option::none<0x1::string::String>();
            };
        };
        0x2::object::delete(v0);
    }

    public fun set_house_edge(arg0: &mut RaceConfig, arg1: &AdminCap, arg2: u64) {
        if (arg2 > 500000 || arg2 < 100000) {
            abort 2
        };
        0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::set_house_edge(&mut arg0.bet_manager, arg2);
    }

    public fun add_bet<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut RaceConfig, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: vector<u64>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_package_version(arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Race>(&mut arg1.id, arg2);
        assert!(0x2::clock::timestamp_ms(arg6) > v0.bet_start_time, 17);
        assert!(0x2::clock::timestamp_ms(arg6) < v0.bet_end_time, 1);
        assert_no_duplicates_u64(&arg4);
        assert_no_duplicates_u8(&arg5);
        let v1 = create_option(arg4, arg5);
        assert!(0x1::vector::length<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>(&v1) <= (arg1.max_combo as u64), 6);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0x2::coin::into_balance<T0>(arg3);
        let v4 = 0x2::balance::value<T0>(&v3);
        let (v5, v6) = 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::get_bet_payout(&arg1.bet_manager, &v0.bet_setting, v4, v1, 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::risk_manager::marble_ids(&v0.risk_manager));
        let v7 = 0x1::type_name::get<T0>();
        0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::risk_manager::add_risk(&mut v0.risk_manager, 0x1::type_name::get<T0>(), v1, v6);
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, u64>(&arg1.risk_limits, v7)) {
            abort 15
        };
        let v8 = 0x2::linked_table::borrow<0x1::type_name::TypeName, u64>(&arg1.risk_limits, v7);
        let v9 = if (v5 > *v8) {
            *v8
        } else {
            v5
        };
        let v10 = BetSlip{
            id             : 0x2::object::new(arg7),
            player_address : v2,
            bet_size       : v4,
            payout         : v9,
            option         : v1,
            coin_type      : v7,
        };
        let v11 = 0x2::object::id<BetSlip>(&v10);
        let v12 = 0x1::option::borrow_mut<0x2::linked_table::LinkedTable<address, vector<BetSlip>>>(&mut v0.bet_slips);
        if (0x2::linked_table::contains<address, vector<BetSlip>>(v12, v2)) {
            0x1::vector::push_back<BetSlip>(0x2::linked_table::borrow_mut<address, vector<BetSlip>>(v12, v2), v10);
        } else {
            let v13 = 0x1::vector::empty<BetSlip>();
            0x1::vector::push_back<BetSlip>(&mut v13, v10);
            0x2::linked_table::push_back<address, vector<BetSlip>>(v12, v2, v13);
        };
        0x2::dynamic_field::add<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut v0.id, v11, v3);
        let v14 = AddBetEvent{
            player_address : v2,
            race_id        : arg2,
            race_event_id  : *0x1::option::borrow<0x1::string::String>(&arg1.current_race),
            bet_id         : v11,
            bet_size       : v4,
            payout         : v5,
            option         : v1,
            coin_type      : v7,
        };
        0x2::event::emit<AddBetEvent>(v14);
        v11
    }

    public fun add_manager(arg0: &mut RaceConfig, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_risk_limit<T0>(arg0: &mut RaceConfig, arg1: &AdminCap, arg2: u64) {
        0x2::linked_table::push_back<0x1::type_name::TypeName, u64>(&mut arg0.risk_limits, 0x1::type_name::get<T0>(), arg2);
    }

    public fun add_version(arg0: &mut RaceConfig, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.version_set, arg2);
    }

    fun assert_no_duplicates_u64(arg0: &vector<u64>) {
        let v0 = 0x2::vec_set::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            assert!(!0x2::vec_set::contains<u64>(&v0, 0x1::vector::borrow<u64>(arg0, v1)), 18);
            0x2::vec_set::insert<u64>(&mut v0, *0x1::vector::borrow<u64>(arg0, v1));
            v1 = v1 + 1;
        };
    }

    fun assert_no_duplicates_u8(arg0: &vector<u8>) {
        let v0 = 0x2::vec_set::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            assert!(!0x2::vec_set::contains<u8>(&v0, 0x1::vector::borrow<u8>(arg0, v1)), 19);
            0x2::vec_set::insert<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
    }

    fun assert_sender_is_manager(arg0: &RaceConfig, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(managers(arg0), &v0)) {
            abort 8
        };
    }

    fun assert_valid_package_version(arg0: &RaceConfig) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(versions(arg0), &v0)) {
            abort 7
        };
    }

    public fun burn_admin_cap(arg0: AdminCap) {
        let AdminCap {
            id              : v0,
            original_id_cap : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun cancel_race_bets<T0>(arg0: 0x2::object::ID, arg1: &mut RaceConfig, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg1);
        assert_sender_is_manager(arg1, arg3);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg1.id, arg0), 9);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Race>(&mut arg1.id, arg0);
        let v1 = v0.race_event_id;
        assert!(v0.status == 2, 5);
        let v2 = 0x1::option::borrow_mut<0x2::linked_table::LinkedTable<address, vector<BetSlip>>>(&mut v0.bet_slips);
        if (0x2::linked_table::length<address, vector<BetSlip>>(v2) == 0) {
            let v3 = BetCancelEvent{
                race_id        : arg0,
                race_event_id  : v1,
                cancelled_bets : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::event::emit<BetCancelEvent>(v3);
            remove(arg1, arg0, arg3);
            return
        };
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        let v5 = arg1.page_size;
        if (0x1::option::is_some<u64>(&arg2)) {
            v5 = *0x1::option::borrow<u64>(&arg2);
        };
        let v6 = 0;
        while (v6 < v5 && 0x2::linked_table::length<address, vector<BetSlip>>(v2) > 0) {
            let (v7, v8) = 0x2::linked_table::pop_back<address, vector<BetSlip>>(v2);
            let v9 = v8;
            while (v6 < v5 && 0x1::vector::length<BetSlip>(&v9) != 0) {
                let v10 = 0x1::vector::pop_back<BetSlip>(&mut v9);
                let v11 = 0x2::object::id<BetSlip>(&v10);
                if (v10.coin_type == 0x1::type_name::get<T0>()) {
                    let BetSlip {
                        id             : v12,
                        player_address : _,
                        bet_size       : _,
                        payout         : _,
                        option         : _,
                        coin_type      : _,
                    } = v10;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut v0.id, v11), arg3), v7);
                    0x1::vector::push_back<0x2::object::ID>(&mut v4, v11);
                    0x2::object::delete(v12);
                } else {
                    0x1::vector::push_back<BetSlip>(&mut v9, v10);
                };
                v6 = v6 + 1;
            };
            if (!0x1::vector::is_empty<BetSlip>(&v9)) {
                0x2::linked_table::push_back<address, vector<BetSlip>>(v2, v7, v9);
                continue
            };
            0x1::vector::destroy_empty<BetSlip>(v9);
        };
        let v18 = BetCancelEvent{
            race_id        : arg0,
            race_event_id  : v1,
            cancelled_bets : v4,
        };
        0x2::event::emit<BetCancelEvent>(v18);
        if (0x2::linked_table::length<address, vector<BetSlip>>(v2) == 0) {
            remove(arg1, arg0, arg3);
        };
    }

    public fun create(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: &mut RaceConfig, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_package_version(arg3);
        assert_sender_is_manager(arg3, arg6);
        assert!(0x1::option::is_none<0x1::string::String>(&arg3.current_race), 16);
        assert!(0x2::clock::timestamp_ms(arg5) < arg2, 1);
        let v0 = Race{
            id             : 0x2::object::new(arg6),
            creator        : 0x2::tx_context::sender(arg6),
            race_event_id  : arg0,
            bet_start_time : arg1,
            bet_end_time   : arg2,
            status         : 0,
            risk_manager   : 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::risk_manager::new_manager(arg4, arg6),
            bet_setting    : 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::new_bet_setting(arg4),
            bet_slips      : 0x1::option::some<0x2::linked_table::LinkedTable<address, vector<BetSlip>>>(0x2::linked_table::new<address, vector<BetSlip>>(arg6)),
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x2::dynamic_object_field::add<0x2::object::ID, Race>(&mut arg3.id, v1, v0);
        arg3.current_race = 0x1::option::some<0x1::string::String>(arg0);
        let v2 = CreateEvent{
            id            : v1,
            race_event_id : arg0,
            bet_end_time  : arg2,
        };
        0x2::event::emit<CreateEvent>(v2);
        v1
    }

    public fun create_bank<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing_bank::new_bank<T0>(arg1);
    }

    fun create_option(arg0: vector<u64>, arg1: vector<u8>) : vector<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement> {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u8>(&arg1), 10);
        let v0 = 0x1::vector::empty<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>(&mut v0, 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::new_placement(*0x1::vector::borrow<u64>(&arg0, v1), *0x1::vector::borrow<u8>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = AdminCap{
            id              : v0,
            original_id_cap : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = RaceConfig{
            id           : 0x2::object::new(arg0),
            version_set  : 0x2::vec_set::singleton<u64>(1),
            managers     : 0x2::vec_set::empty<address>(),
            risk_limits  : 0x2::linked_table::new<0x1::type_name::TypeName, u64>(arg0),
            page_size    : 200,
            bet_manager  : 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::new_bet_manager(),
            max_combo    : 3,
            current_race : 0x1::option::none<0x1::string::String>(),
        };
        0x2::transfer::share_object<RaceConfig>(v2);
    }

    public fun managers(arg0: &RaceConfig) : &0x2::vec_set::VecSet<address> {
        &arg0.managers
    }

    public fun mint_child_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg0.original_id_cap, 0);
        AdminCap{
            id              : 0x2::object::new(arg1),
            original_id_cap : 0x2::object::uid_to_inner(&arg0.id),
        }
    }

    public fun package_version() : u64 {
        1
    }

    public fun put_to_bank<T0>(arg0: &AdminCap, arg1: &mut 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing_bank::MarbleRacingBank<T0>, arg2: 0x2::coin::Coin<T0>) {
        0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing_bank::put_to_bank<T0>(arg1, arg2);
    }

    public fun race_status(arg0: 0x2::object::ID, arg1: &RaceConfig) : u64 {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Race>(&arg1.id, arg0).status
    }

    public fun remove_manager(arg0: &mut RaceConfig, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_risk_limit<T0>(arg0: &mut RaceConfig, arg1: &AdminCap) {
        0x2::linked_table::remove<0x1::type_name::TypeName, u64>(&mut arg0.risk_limits, 0x1::type_name::get<T0>());
    }

    public fun remove_version(arg0: &mut RaceConfig, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg2);
    }

    public fun resolve<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::object::ID, arg2: vector<u64>, arg3: &mut RaceConfig, arg4: 0x1::option::Option<u64>, arg5: &mut 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing_bank::MarbleRacingBank<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg3);
        assert_sender_is_manager(arg3, arg6);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg3.id, arg1), 9);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Race>(&mut arg3.id, arg1);
        assert!(v0.status == 1, 4);
        let v1 = 0x1::option::borrow_mut<0x2::linked_table::LinkedTable<address, vector<BetSlip>>>(&mut v0.bet_slips);
        if (0x2::linked_table::length<address, vector<BetSlip>>(v1) == 0) {
            let v2 = BetResultsV2<T0>{
                race_id : 0x1::option::some<0x2::object::ID>(arg1),
                origin  : 0x1::option::none<0x1::string::String>(),
                bets    : 0x1::vector::empty<BetResultV2<T0>>(),
            };
            0x2::event::emit<BetResultsV2<T0>>(v2);
            remove(arg3, arg1, arg6);
            return
        };
        let v3 = 0x1::vector::empty<PlayerWin<T0>>();
        let v4 = 0;
        let v5 = 0x2::balance::zero<T0>();
        let v6 = 0x1::vector::empty<BetResultV2<T0>>();
        let v7 = arg3.page_size;
        if (0x1::option::is_some<u64>(&arg4)) {
            v7 = *0x1::option::borrow<u64>(&arg4);
        };
        let v8 = 0;
        while (v8 < v7 && 0x2::linked_table::length<address, vector<BetSlip>>(v1) > 0) {
            let (v9, v10) = 0x2::linked_table::pop_back<address, vector<BetSlip>>(v1);
            let v11 = v10;
            while (v8 < v7 && 0x1::vector::length<BetSlip>(&v11) != 0) {
                let v12 = 0x1::vector::pop_back<BetSlip>(&mut v11);
                let v13 = 0;
                if (v12.coin_type == 0x1::type_name::get<T0>()) {
                    let BetSlip {
                        id             : v14,
                        player_address : _,
                        bet_size       : v16,
                        payout         : v17,
                        option         : v18,
                        coin_type      : _,
                    } = v12;
                    let v20 = v18;
                    if (0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::won_bet(v12.option, arg2)) {
                        v4 = v4 + v17;
                        let v21 = PlayerWin<T0>{
                            player      : v9,
                            bet_balance : 0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut v0.id, 0x2::object::id<BetSlip>(&v12)),
                            bet_payout  : v17,
                        };
                        0x1::vector::push_back<PlayerWin<T0>>(&mut v3, v21);
                        v13 = v17 + v16;
                    } else {
                        0x2::balance::join<T0>(&mut v5, 0x2::dynamic_field::remove<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut v0.id, 0x2::object::id<BetSlip>(&v12)));
                    };
                    let v22 = 0;
                    let v23 = 0x1::vector::empty<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>();
                    while (v22 < 0x1::vector::length<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>(&v20)) {
                        0x1::vector::push_back<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>(&mut v23, *0x1::vector::borrow<0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::bet_manager::Placement>(&v20, v22));
                        v22 = v22 + 1;
                    };
                    let v24 = BetResultV2<T0>{
                        bet_id       : 0x1::option::some<0x2::object::ID>(0x2::object::id<BetSlip>(&v12)),
                        player       : v9,
                        bet_options  : v23,
                        bet_size     : v16,
                        bet_returned : v13,
                        outcome      : arg2,
                    };
                    0x1::vector::push_back<BetResultV2<T0>>(&mut v6, v24);
                    0x2::object::delete(v14);
                } else {
                    0x1::vector::push_back<BetSlip>(&mut v11, v12);
                };
                v8 = v8 + 1;
            };
            if (!0x1::vector::is_empty<BetSlip>(&v11)) {
                0x2::linked_table::push_back<address, vector<BetSlip>>(v1, v9, v11);
                continue
            };
            0x1::vector::destroy_empty<BetSlip>(v11);
        };
        if (!0x1::vector::is_empty<PlayerWin<T0>>(&v3)) {
            while (!0x1::vector::is_empty<PlayerWin<T0>>(&v3)) {
                let PlayerWin {
                    player      : v25,
                    bet_balance : v26,
                    bet_payout  : v27,
                } = 0x1::vector::pop_back<PlayerWin<T0>>(&mut v3);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing_bank::get_from_bank<T0>(arg5, v27), arg6), v25);
                0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing_bank::put_to_bank<T0>(arg5, 0x2::coin::from_balance<T0>(v26, arg6));
            };
        };
        0x1::vector::destroy_empty<PlayerWin<T0>>(v3);
        if (0x2::balance::value<T0>(&v5) != 0) {
            0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing_bank::put_to_bank<T0>(arg5, 0x2::coin::from_balance<T0>(v5, arg6));
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        let v28 = BetResultsV2<T0>{
            race_id : 0x1::option::some<0x2::object::ID>(arg1),
            origin  : 0x1::option::none<0x1::string::String>(),
            bets    : v6,
        };
        0x2::event::emit<BetResultsV2<T0>>(v28);
        if (0x2::linked_table::length<address, vector<BetSlip>>(v1) == 0) {
            remove(arg3, arg1, arg6);
        };
    }

    public fun risk_limit<T0>(arg0: &RaceConfig) : u64 {
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, u64>(&arg0.risk_limits, 0x1::type_name::get<T0>())) {
            abort 15
        };
        *0x2::linked_table::borrow<0x1::type_name::TypeName, u64>(&arg0.risk_limits, 0x1::type_name::get<T0>())
    }

    public fun update_status(arg0: 0x2::object::ID, arg1: u64, arg2: &mut RaceConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg2);
        assert_sender_is_manager(arg2, arg4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Race>(&mut arg2.id, arg0);
        assert!(v0.status < arg1 && arg1 <= 2, 14);
        assert!(v0.status < 1, 3);
        if (arg1 == 1) {
            assert!(0x2::clock::timestamp_ms(arg3) > v0.bet_end_time, 16);
        };
        v0.status = arg1;
    }

    public fun versions(arg0: &RaceConfig) : &0x2::vec_set::VecSet<u64> {
        &arg0.version_set
    }

    public fun withdraw_from_bank<T0>(arg0: &AdminCap, arg1: address, arg2: &mut 0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing_bank::MarbleRacingBank<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xfbae234b46acc5aff0d63a79ce5f1db9b34643743232e43b8d98fd76277b7ede::marble_racing_bank::withdraw_from_bank<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

