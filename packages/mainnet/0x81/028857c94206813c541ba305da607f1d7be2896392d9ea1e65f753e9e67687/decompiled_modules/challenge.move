module 0x81028857c94206813c541ba305da607f1d7be2896392d9ea1e65f753e9e67687::challenge {
    struct Global has key {
        id: 0x2::object::UID,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        rank_20: vector<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>,
        reward_20: 0x2::table::Table<u64, u64>,
        publish_time: u64,
        duration_hours: u64,
        lock: bool,
        version: u64,
        manager: address,
    }

    public fun calculate_score(arg0: &Global, arg1: u64) : u64 {
        assert!(0x1::vector::length<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20) > arg1 - 1, 5);
        0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_gold_cost(0x1::vector::borrow<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20, arg1 - 1)) / 1000000000 * get_base_weight_by_rank(arg1 - 1)
    }

    public fun calculate_scores(arg0: &Global) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 20) {
            assert!(0x1::vector::length<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20) > v0, 5);
            v1 = 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_gold_cost(0x1::vector::borrow<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20, v0)) / 1000000000 * get_base_weight_by_rank(v0) + v1;
            v0 = v0 + 1;
        };
        v1
    }

    public fun change_manager(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 2);
        arg0.manager = arg1;
    }

    public fun change_season_duration(arg0: &mut Global, arg1: u64) {
        arg0.duration_hours = arg1;
    }

    fun check_lineup_equality(arg0: &0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp, arg1: &0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp) : bool {
        0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_hash(arg0) == 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_hash(arg1) && 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_name(arg0) == 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_name(arg1) && 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_creator(arg0) == 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_creator(arg1)
    }

    public fun find_rank(arg0: &Global, arg1: &0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp) : u64 {
        let v0 = 0;
        while (v0 < 20) {
            assert!(0x1::vector::length<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20) > v0, 5);
            if (check_lineup_equality(0x1::vector::borrow<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20, v0), arg1)) {
                return v0 + 1
            };
            v0 = v0 + 1;
        };
        21
    }

    public entry fun generate_rank_20_description(arg0: &Global) : 0x1::string::String {
        let v0 = 0x1::ascii::byte(0x1::ascii::char(44));
        let v1 = 0;
        let v2 = 0x1::vector::empty<u8>();
        while (v1 < 0x1::vector::length<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20)) {
            assert!(0x1::vector::length<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20) > v1, 5);
            let v3 = 0x1::vector::borrow<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20, v1);
            let v4 = 0x2::address::to_string(0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_creator(v3));
            let v5 = 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_name(v3);
            let v6 = 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_roles(v3);
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v4));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v5));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::numbers_to_ascii_vector(v1 + 1));
            0x1::vector::push_back<u8>(&mut v2, v0);
            let v7 = 0;
            while (v7 < 6) {
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(v6) > v7, 5);
                let v8 = 0x1::vector::borrow<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(v6, v7);
                let v9 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(v8);
                0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v9));
                0x1::vector::push_back<u8>(&mut v2, 0x1::ascii::byte(0x1::ascii::char(95)));
                0x1::vector::append<u8>(&mut v2, 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::numbers_to_ascii_vector((0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_level(v8) as u64)));
                0x1::vector::push_back<u8>(&mut v2, v0);
                v7 = v7 + 1;
            };
            0x1::vector::append<u8>(&mut v2, 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::numbers_to_ascii_vector(calculate_score(arg0, v1 + 1)));
            0x1::vector::push_back<u8>(&mut v2, 0x1::ascii::byte(0x1::ascii::char(59)));
            v1 = v1 + 1;
        };
        0x1::string::utf8(v2)
    }

    fun get_base_weight_by_rank(arg0: u64) : u64 {
        20 - arg0 / 2
    }

    public fun get_estimate_reward_20_amounts(arg0: &Global) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u8>();
        while (v0 < 0x2::table::length<u64, u64>(&arg0.reward_20)) {
            0x1::vector::append<u8>(&mut v1, 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::numbers_to_ascii_vector(*0x2::table::borrow<u64, u64>(&arg0.reward_20, v0)));
            0x1::vector::push_back<u8>(&mut v1, 0x1::ascii::byte(0x1::ascii::char(44)));
            v0 = v0 + 1;
        };
        0x1::string::utf8(v1)
    }

    public fun get_lineup_by_rank(arg0: &Global, arg1: u8) : &0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp {
        assert!(0x1::vector::length<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20) > (arg1 as u64), 5);
        0x1::vector::borrow<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20, (arg1 as u64))
    }

    public fun get_reward_amount_by_rank(arg0: &Global, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(0x1::vector::length<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20) > arg3, 5);
        let v0 = 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_gold_cost(0x1::vector::borrow<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20, arg3)) / 1000000000 * get_base_weight_by_rank(arg3) / arg2;
        if (arg1 * v0 > 100000000) {
            arg1 * v0 - 100000000
        } else {
            arg1 * v0
        }
    }

    public fun get_rewards_balance(arg0: &Global) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id             : 0x2::object::new(arg0),
            balance_SUI    : 0x2::balance::zero<0x2::sui::SUI>(),
            rank_20        : 0x1::vector::empty<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(),
            reward_20      : 0x2::table::new<u64, u64>(arg0),
            publish_time   : 0,
            duration_hours : 336,
            lock           : false,
            version        : 1,
            manager        : @0xb2a79beac8a092b336f560ba27f278382bcab2da831c64e546d7e0e087acc4fe,
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun init_rank_20(arg0: &mut Global, arg1: &0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Global, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 80;
        let v2 = 1;
        arg0.publish_time = 0x2::clock::timestamp_ms(arg2);
        assert!(0x1::vector::length<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20) == 0, 4);
        while (v0 < 20) {
            0x1::vector::push_back<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&mut arg0.rank_20, 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::generate_lineup_by_power(arg1, v1, v2, arg3));
            v1 = v1 - 3;
            v2 = v2 + 1;
            v0 = v0 + 1;
        };
    }

    public fun lock_pool(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.manager, 2);
        arg0.lock = true;
    }

    fun push_reward_amount(arg0: &mut Global, arg1: u64, arg2: u64) {
        assert!(!arg0.lock, 3);
        if (0x2::table::contains<u64, u64>(&arg0.reward_20, arg2)) {
            0x2::table::remove<u64, u64>(&mut arg0.reward_20, arg2);
            0x2::table::add<u64, u64>(&mut arg0.reward_20, arg2, arg1);
        } else {
            0x2::table::add<u64, u64>(&mut arg0.reward_20, arg2, arg1);
        };
    }

    public entry fun query_left_challenge_time(arg0: &Global, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.duration_hours * 3600000;
        if (v0 - arg0.publish_time >= v1) {
            0
        } else {
            v1 - v0 - arg0.publish_time
        }
    }

    public fun rank_forward(arg0: &mut Global, arg1: 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp, arg2: &mut 0x81028857c94206813c541ba305da607f1d7be2896392d9ea1e65f753e9e67687::metaIdentity::MetaIdentity) {
        assert!(!arg0.lock, 3);
        let v0 = find_rank(arg0, &arg1);
        if (v0 == 21) {
            0x1::vector::pop_back<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&mut arg0.rank_20);
            0x1::vector::insert<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&mut arg0.rank_20, arg1, 19);
            0x81028857c94206813c541ba305da607f1d7be2896392d9ea1e65f753e9e67687::metaIdentity::record_update_best_rank(arg2, 19);
        } else if (v0 == 1) {
            0x81028857c94206813c541ba305da607f1d7be2896392d9ea1e65f753e9e67687::metaIdentity::record_update_best_rank(arg2, 1);
        } else {
            let v1 = v0 - 1;
            0x1::vector::remove<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&mut arg0.rank_20, v1);
            0x1::vector::insert<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&mut arg0.rank_20, arg1, v1 - 1);
            0x81028857c94206813c541ba305da607f1d7be2896392d9ea1e65f753e9e67687::metaIdentity::record_update_best_rank(arg2, v1 - 1);
        };
    }

    public(friend) fun send_reward_by_rank(arg0: &mut Global, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp>(&arg0.rank_20) > (arg1 as u64), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, *0x2::table::borrow<u64, u64>(&arg0.reward_20, (arg1 as u64))), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun top_up_challenge_pool(arg0: &mut Global, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1);
        let v0 = 0;
        while (v0 < 20) {
            let v1 = get_reward_amount_by_rank(arg0, get_rewards_balance(arg0), calculate_scores(arg0), v0);
            push_reward_amount(arg0, v1, v0);
            v0 = v0 + 1;
        };
    }

    public fun unlock_pool(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.manager, 2);
        arg0.lock = false;
    }

    public fun upgradeVersion(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 2);
        arg0.version = arg1;
    }

    public fun withdraw_left_amount(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 2);
        assert!(query_left_challenge_time(arg0, arg1) == 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

