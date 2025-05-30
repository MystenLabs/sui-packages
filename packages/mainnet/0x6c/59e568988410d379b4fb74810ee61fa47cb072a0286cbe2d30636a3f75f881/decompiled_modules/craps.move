module 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::craps {
    struct Craps has copy, drop, store {
        dummy_field: bool,
    }

    struct CrapsTag<phantom T0> has copy, drop, store {
        creator: address,
    }

    struct CrapsConfig has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        bet_referral_rate: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CrapsTable<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<T0>,
        bets: 0x1::option::Option<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>,
        settled_bets: 0x1::option::Option<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>,
        numbers_rolled_set: 0x2::vec_set::VecSet<u64>,
        numbers_rolled: vector<u64>,
        target_roll_sum: u64,
        status: u8,
        rounds_settled: 0x2::table::Table<u64, u64>,
        round_number: u64,
        current_risk: u64,
    }

    fun add_bet_to_player_bets(arg0: &mut vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0;
        loop {
            if (v0 >= 0x1::vector::length<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(arg0)) {
                break
            };
            let v1 = 0x1::vector::borrow_mut<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(arg0, v0);
            let (v2, v3, v4, _) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::bet_metadata(v1);
            v0 = v0 + 1;
            if (v2 == arg1 && v4 == arg2) {
                if (v2 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::come_bet() || v2 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::come_odds_bet() || v2 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::dont_come_bet() || v2 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::dont_come_odds_bet()) {
                    abort 15
                };
                0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::update_bet_size(v1, v3 + arg3);
                return 0x2::object::id<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(v1)
            };
        };
        let v6 = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::new_bet(arg1, arg3, arg2, arg4, arg5);
        0x1::vector::push_back<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(arg0, v6);
        0x2::object::id<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v6)
    }

    fun assert_table_has_bets<T0>(arg0: &mut CrapsTable<T0>) : bool {
        0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(0x1::option::borrow_mut<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut arg0.bets)) > 0
    }

    fun assert_valid_version(arg0: &CrapsConfig) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 3);
    }

    public fun borrow_craps_table<T0>(arg0: &CrapsConfig, arg1: address) : &CrapsTable<T0> {
        let v0 = CrapsTag<T0>{creator: arg1};
        0x2::dynamic_object_field::borrow<CrapsTag<T0>, CrapsTable<T0>>(&arg0.id, v0)
    }

    fun borrow_table_mut<T0>(arg0: &mut CrapsConfig, arg1: address) : &mut CrapsTable<T0> {
        let v0 = CrapsTag<T0>{creator: arg1};
        0x2::dynamic_object_field::borrow_mut<CrapsTag<T0>, CrapsTable<T0>>(&mut arg0.id, v0)
    }

    public fun create_craps_table<T0>(arg0: &mut CrapsConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!table_exists<T0>(arg0, v0), 4);
        let v1 = 0x2::object::new(arg1);
        let v2 = CrapsTable<T0>{
            id                 : v1,
            creator            : v0,
            balance            : 0x2::balance::zero<T0>(),
            bets               : 0x1::option::some<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(0x2::linked_table::new<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg1)),
            settled_bets       : 0x1::option::some<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(0x2::linked_table::new<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg1)),
            numbers_rolled_set : 0x2::vec_set::empty<u64>(),
            numbers_rolled     : 0x1::vector::empty<u64>(),
            target_roll_sum    : 0,
            status             : 0,
            rounds_settled     : 0x2::table::new<u64, u64>(arg1),
            round_number       : 0,
            current_risk       : 0,
        };
        let v3 = CrapsTag<T0>{creator: v0};
        0x2::dynamic_object_field::add<CrapsTag<T0>, CrapsTable<T0>>(&mut arg0.id, v3, v2);
        0x2::object::uid_to_inner(&v1)
    }

    public fun get_bets_length_from_table<T0>(arg0: &CrapsConfig, arg1: address) : u64 {
        let v0 = CrapsTag<T0>{creator: arg1};
        0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(0x1::option::borrow<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&0x2::dynamic_object_field::borrow<CrapsTag<T0>, CrapsTable<T0>>(&arg0.id, v0).bets))
    }

    public fun get_crapstable_metadata<T0>(arg0: &CrapsConfig, arg1: address) : (vector<u64>, 0x2::vec_set::VecSet<u64>, u64, u8, u64, u64) {
        let v0 = CrapsTag<T0>{creator: arg1};
        let v1 = 0x2::dynamic_object_field::borrow<CrapsTag<T0>, CrapsTable<T0>>(&arg0.id, v0);
        (v1.numbers_rolled, v1.numbers_rolled_set, v1.target_roll_sum, v1.status, v1.round_number, v1.current_risk)
    }

    public fun get_settled_bets_length_from_table<T0>(arg0: &CrapsConfig, arg1: address) : u64 {
        let v0 = CrapsTag<T0>{creator: arg1};
        0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(0x1::option::borrow<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&0x2::dynamic_object_field::borrow<CrapsTag<T0>, CrapsTable<T0>>(&arg0.id, v0).settled_bets))
    }

    fun handle_bets<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: u64, arg2: &mut 0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>, arg3: &mut 0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>, arg4: &mut CrapsTable<T0>, arg5: address, arg6: &mut bool, arg7: &mut u64, arg8: &mut u64, arg9: &mut vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Craps>>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : bool {
        let (v0, v1) = 0x2::linked_table::pop_back<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg2);
        let v2 = v1;
        if (v0 != arg5) {
            *arg6 = true;
        };
        while (*arg8 < arg10 && 0x1::vector::length<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v2) != 0) {
            let v3 = 0x1::vector::pop_back<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&mut v2);
            let v4 = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::dice_interpreter::get_dice_sum(arg1);
            let (v5, v6, v7, _) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::bet_metadata(&v3);
            let v9 = v7;
            let (v10, v11, v12) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::get_bet_result_and_payout(v5, v9, v6, &arg4.numbers_rolled_set, arg1, v4, arg4.target_roll_sum);
            if (v0 != arg5) {
                *arg7 = *arg7 + v6;
            };
            if (v11) {
                assert!(!v10, 15);
                let v13 = if (v5 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::come_bet() || v5 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::dont_come_bet()) {
                    let v14 = vector[7, 11, 2, 3, 12];
                    !0x1::vector::contains<u64>(&v14, &v4)
                } else {
                    false
                };
                if (v13 && 0x1::option::is_none<u64>(&v9)) {
                    0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::fill_bet_number(&mut v3, v4);
                };
                if (0x2::linked_table::contains<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg3, v0)) {
                    0x1::vector::push_back<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(0x2::linked_table::borrow_mut<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg3, v0), v3);
                } else {
                    let v15 = 0x1::vector::empty<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>();
                    0x1::vector::push_back<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&mut v15, v3);
                    0x2::linked_table::push_back<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg3, v0, v15);
                };
            } else {
                let v16 = Craps{dummy_field: false};
                0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::join_with_fee<T0, Craps>(arg0, v16, 0x2::balance::split<T0>(&mut arg4.balance, v6));
                if (v10) {
                    let v17 = Craps{dummy_field: false};
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take_with_fee_reimbursement<T0, Craps>(arg0, v17, v12 + v6, arg11), v0);
                    0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Craps>>(arg9, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::bet_result<T0, Craps>(0x1::option::some<0x2::object::ID>(0x2::object::id<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v3)), v0, v5, v9, v6, v12 + v6, arg1));
                } else {
                    0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Craps>>(arg9, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::bet_result<T0, Craps>(0x1::option::some<0x2::object::ID>(0x2::object::id<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v3)), v0, v5, v9, v6, v12, arg1));
                };
                arg4.current_risk = arg4.current_risk - 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::get_bet_max_payout(v6, v5, v9);
                let (_, _, _, _) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::destroy_bet(v3);
            };
            *arg8 = *arg8 + 1;
        };
        if (*arg8 >= arg10 && !0x1::vector::is_empty<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v2)) {
            0x2::linked_table::push_back<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg2, v0, v2);
            return true
        };
        0x1::vector::destroy_empty<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(v2);
        false
    }

    fun handle_bets_0<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: u64, arg2: &mut 0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>, arg3: &mut 0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>, arg4: &mut CrapsTable<T0>, arg5: address, arg6: &mut bool, arg7: &mut u64, arg8: &mut u64, arg9: &mut vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Craps>>, arg10: u64, arg11: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg12: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg13: &0x2::clock::Clock, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::pipe_exists<T0, 0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SUILEND_POND>(arg0)) {
            return handle_bets<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg16)
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg12, arg15, arg13, arg14);
        let (v0, v1) = 0x2::linked_table::pop_back<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg2);
        let v2 = v1;
        if (v0 != arg5) {
            *arg6 = true;
        };
        let v3 = Craps{dummy_field: false};
        while (*arg8 < arg10 && 0x1::vector::length<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v2) != 0) {
            let v4 = 0x1::vector::pop_back<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&mut v2);
            let v5 = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::dice_interpreter::get_dice_sum(arg1);
            let (v6, v7, v8, _) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::bet_metadata(&v4);
            let v10 = v8;
            let (v11, v12, v13) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::get_bet_result_and_payout(v6, v10, v7, &arg4.numbers_rolled_set, arg1, v5, arg4.target_roll_sum);
            if (v0 != arg5) {
                *arg7 = *arg7 + v7;
            };
            if (v12) {
                assert!(!v11, 15);
                let v14 = if (v6 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::come_bet() || v6 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::dont_come_bet()) {
                    let v15 = vector[7, 11, 2, 3, 12];
                    !0x1::vector::contains<u64>(&v15, &v5)
                } else {
                    false
                };
                if (v14 && 0x1::option::is_none<u64>(&v10)) {
                    0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::fill_bet_number(&mut v4, v5);
                };
                if (0x2::linked_table::contains<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg3, v0)) {
                    0x1::vector::push_back<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(0x2::linked_table::borrow_mut<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg3, v0), v4);
                } else {
                    let v16 = 0x1::vector::empty<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>();
                    0x1::vector::push_back<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&mut v16, v4);
                    0x2::linked_table::push_back<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg3, v0, v16);
                };
            } else {
                let v17 = Craps{dummy_field: false};
                0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::join_with_fee<T0, Craps>(arg0, v17, 0x2::balance::split<T0>(&mut arg4.balance, v7));
                if (v11) {
                    let (v18, v19) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_changes(v13);
                    let v20 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_house<T0>(arg0));
                    if (v18 > v20) {
                        0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Craps>(arg11, arg0, v18 - v20, false, v3, arg12, arg13, arg15, arg16);
                    };
                    let v21 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::house_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_house<T0>(arg0));
                    if (v19 > v21) {
                        0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Craps>(arg11, arg0, v19 - v21, true, v3, arg12, arg13, arg15, arg16);
                    };
                    let v22 = Craps{dummy_field: false};
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take_with_fee_reimbursement<T0, Craps>(arg0, v22, v13 + v7, arg16), v0);
                    0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Craps>>(arg9, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::bet_result<T0, Craps>(0x1::option::some<0x2::object::ID>(0x2::object::id<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v4)), v0, v6, v10, v7, v13 + v7, arg1));
                } else {
                    let (v23, v24) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_changes(v7);
                    0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Craps>(arg11, arg0, v23, false, v3, arg12, arg13, arg15, arg16);
                    0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Craps>(arg11, arg0, v24, true, v3, arg12, arg13, arg15, arg16);
                    0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Craps>>(arg9, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::bet_result<T0, Craps>(0x1::option::some<0x2::object::ID>(0x2::object::id<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v4)), v0, v6, v10, v7, v13, arg1));
                };
                arg4.current_risk = arg4.current_risk - 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::get_bet_max_payout(v7, v6, v10);
                let (_, _, _, _) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::destroy_bet(v4);
            };
            *arg8 = *arg8 + 1;
        };
        if (*arg8 >= arg10 && !0x1::vector::is_empty<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v2)) {
            0x2::linked_table::push_back<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg2, v0, v2);
            return true
        };
        0x1::vector::destroy_empty<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(v2);
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CrapsConfig{
            id                : 0x2::object::new(arg0),
            version_set       : 0x2::vec_set::singleton<u64>(1),
            bet_referral_rate : 5000,
        };
        0x2::transfer::share_object<CrapsConfig>(v1);
    }

    public fun package_version() : u64 {
        1
    }

    public fun place_bet<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &mut CrapsConfig, arg2: address, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg1);
        assert!(table_exists<T0>(arg1, arg2), 5);
        let v0 = borrow_table_mut<T0>(arg1, arg2);
        let v1 = 0x2::coin::value<T0>(&arg5);
        let v2 = v1;
        if (arg3 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::buy_bet() || arg3 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::lay_bet()) {
            let v3 = v1 / 21;
            v2 = v1 - v3;
            let v4 = Craps{dummy_field: false};
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::put_with_fee<T0, Craps>(arg0, v4, 0x2::coin::split<T0>(&mut arg5, v3, arg6));
        };
        v0.current_risk = v0.current_risk + 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::get_bet_max_payout(v2, arg3, arg4);
        assert!(v0.current_risk < 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::max_risk<T0>(arg0), 6);
        let v5 = 0x1::option::borrow_mut<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v0.bets);
        let v6 = 0x2::tx_context::sender(arg6);
        0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(arg5));
        let v7 = if (0x2::linked_table::contains<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v5, v6)) {
            let v8 = 0x2::linked_table::borrow_mut<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v5, v6);
            add_bet_to_player_bets(v8, arg3, arg4, v2, v6, arg6)
        } else {
            let v9 = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::new_bet(arg3, v2, arg4, v6, arg6);
            let v10 = 0x1::vector::empty<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>();
            0x1::vector::push_back<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&mut v10, v9);
            0x2::linked_table::push_back<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v5, v6, v10);
            0x2::object::id<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(&v9)
        };
        0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::is_valid_bet(arg3, v2, arg4, v0.target_roll_sum, v0.numbers_rolled, 0x2::linked_table::borrow<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v5, v6));
        v7
    }

    public fun remove_bet<T0>(arg0: &mut CrapsConfig, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        assert!(table_exists<T0>(arg0, arg1), 5);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = borrow_table_mut<T0>(arg0, arg1);
        let v2 = 0x1::option::borrow_mut<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.bets);
        assert!(0x2::linked_table::contains<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v2, v0), 7);
        let v3 = 0x2::linked_table::borrow_mut<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v2, v0);
        0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::is_valid_remove(arg2, arg3, v1.target_roll_sum, v1.status, v1.numbers_rolled, v3);
        let (v4, v5, v6, _) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::destroy_bet(remove_bet_from_player_bets(v3, arg2, arg3));
        v1.current_risk = v1.current_risk - 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::get_bet_max_payout(v5, v4, v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, v5), arg4)
    }

    fun remove_bet_from_player_bets(arg0: &mut vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>, arg1: u64, arg2: 0x1::option::Option<u64>) : 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet {
        let v0 = 0;
        loop {
            if (v0 >= 0x1::vector::length<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(arg0)) {
                break
            };
            let (v1, _, v3, _) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::bet_metadata(0x1::vector::borrow<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(arg0, v0));
            if (v1 == arg1 && v3 == arg2) {
                break
            };
            v0 = v0 + 1;
        };
        assert!(v0 < 0x1::vector::length<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(arg0), 8);
        0x1::vector::remove<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(arg0, v0)
    }

    public fun settle_or_continue<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &mut CrapsConfig, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        assert!(table_exists<T0>(arg1, arg2), 5);
        let v0 = arg1.bet_referral_rate;
        let v1 = borrow_table_mut<T0>(arg1, arg2);
        let v2 = 0x2::object::id<CrapsTable<T0>>(v1);
        let v3 = 0x1::option::extract<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.bets);
        let v4 = 0x1::option::extract<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.settled_bets);
        assert!(0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(&v3) != 0, 12);
        let v5 = *0x2::table::borrow<u64, u64>(&v1.rounds_settled, v1.round_number);
        let v6 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Craps>>();
        let v7 = 0;
        let v8 = 10000;
        if (0x1::option::is_some<u64>(&arg3)) {
            v8 = *0x1::option::borrow<u64>(&arg3);
        };
        let v9 = 0;
        let v10 = false;
        while (v9 < v8 && 0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(&v3) > 0) {
            let v11 = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::dice_interpreter::get_dice_sum(v5);
            if (!0x2::vec_set::contains<u64>(&v1.numbers_rolled_set, &v11)) {
                0x2::vec_set::insert<u64>(&mut v1.numbers_rolled_set, v11);
            };
            0x1::vector::push_back<u64>(&mut v1.numbers_rolled, v11);
            let v12 = &mut v3;
            let v13 = &mut v4;
            let v14 = &mut v10;
            let v15 = &mut v7;
            let v16 = &mut v9;
            let v17 = &mut v6;
            if (handle_bets<T0>(arg0, v5, v12, v13, v1, arg2, v14, v15, v16, v17, v8, arg5)) {
                break
            };
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Craps>(arg0, 0x1::option::some<0x2::object::ID>(v2), 0x1::option::some<u64>(v1.round_number), 0x1::option::some<0x1::string::String>(arg4), v6);
        if (v10) {
            let v18 = Craps{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take<T0, Craps>(arg0, v18, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::math::mul_rate(v7, v0), arg5), arg2);
        };
        if (0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(&v3) == 0) {
            v1.status = 0;
            v1.round_number = v1.round_number + 1;
            0x1::option::fill<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.settled_bets, 0x2::linked_table::new<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg5));
            0x1::option::fill<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.bets, v4);
            0x2::linked_table::destroy_empty<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v3);
            let v19 = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::dice_interpreter::get_dice_sum(v5);
            if (0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::dice_interpreter::get_dice_sum(v5) == 7) {
                let v20 = 0x1::option::borrow<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&v1.settled_bets);
                assert!(0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(0x1::option::borrow<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&v1.bets)) == 0, 13);
                assert!(0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v20) == 0, 14);
                assert!(0x2::balance::value<T0>(&v1.balance) == 0, 15);
                v1.numbers_rolled_set = 0x2::vec_set::empty<u64>();
                v1.numbers_rolled = 0x1::vector::empty<u64>();
                v1.target_roll_sum = 0;
                v1.current_risk = 0;
            } else if (v19 == v1.target_roll_sum) {
                v1.target_roll_sum = 0;
            } else {
                let v21 = if (v1.target_roll_sum == 0) {
                    let v22 = v19 == 11 || v19 == 2 || v19 == 3 || v19 == 12;
                    !v22
                } else {
                    false
                };
                if (v21) {
                    v1.target_roll_sum = v19;
                };
            };
        } else {
            0x1::option::fill<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.bets, v3);
            0x1::option::fill<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.settled_bets, v4);
        };
    }

    public fun settle_or_continue_0<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &mut CrapsConfig, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::string::String, arg5: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg7: &0x2::clock::Clock, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        assert!(table_exists<T0>(arg1, arg2), 5);
        let v0 = arg1.bet_referral_rate;
        let v1 = borrow_table_mut<T0>(arg1, arg2);
        let v2 = 0x2::object::id<CrapsTable<T0>>(v1);
        let v3 = 0x1::option::extract<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.bets);
        let v4 = 0x1::option::extract<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.settled_bets);
        assert!(0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(&v3) != 0, 12);
        let v5 = *0x2::table::borrow<u64, u64>(&v1.rounds_settled, v1.round_number);
        let v6 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Craps>>();
        let v7 = 0;
        let v8 = 10000;
        if (0x1::option::is_some<u64>(&arg3)) {
            v8 = *0x1::option::borrow<u64>(&arg3);
        };
        let v9 = 0;
        let v10 = false;
        while (v9 < v8 && 0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(&v3) > 0) {
            let v11 = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::dice_interpreter::get_dice_sum(v5);
            if (!0x2::vec_set::contains<u64>(&v1.numbers_rolled_set, &v11)) {
                0x2::vec_set::insert<u64>(&mut v1.numbers_rolled_set, v11);
            };
            0x1::vector::push_back<u64>(&mut v1.numbers_rolled, v11);
            let v12 = &mut v3;
            let v13 = &mut v4;
            let v14 = &mut v10;
            let v15 = &mut v7;
            let v16 = &mut v9;
            let v17 = &mut v6;
            if (handle_bets_0<T0>(arg0, v5, v12, v13, v1, arg2, v14, v15, v16, v17, v8, arg5, arg6, arg7, arg8, arg9, arg10)) {
                break
            };
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Craps>(arg0, 0x1::option::some<0x2::object::ID>(v2), 0x1::option::some<u64>(v1.round_number), 0x1::option::some<0x1::string::String>(arg4), v6);
        if (v10) {
            let v18 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::math::mul_rate(v7, v0);
            let v19 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_house<T0>(arg0));
            if (v18 > v19) {
                let v20 = Craps{dummy_field: false};
                0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Craps>(arg5, arg0, v18 - v19, false, v20, arg6, arg7, arg9, arg10);
            };
            let v21 = Craps{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take<T0, Craps>(arg0, v21, v18, arg10), arg2);
        };
        if (0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(&v3) == 0) {
            v1.status = 0;
            v1.round_number = v1.round_number + 1;
            0x1::option::fill<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.settled_bets, 0x2::linked_table::new<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(arg10));
            0x1::option::fill<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.bets, v4);
            0x2::linked_table::destroy_empty<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v3);
            let v22 = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::dice_interpreter::get_dice_sum(v5);
            if (0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::dice_interpreter::get_dice_sum(v5) == 7) {
                let v23 = 0x1::option::borrow<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&v1.settled_bets);
                assert!(0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(0x1::option::borrow<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&v1.bets)) == 0, 13);
                assert!(0x2::linked_table::length<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(v23) == 0, 14);
                assert!(0x2::balance::value<T0>(&v1.balance) == 0, 15);
                v1.numbers_rolled_set = 0x2::vec_set::empty<u64>();
                v1.numbers_rolled = 0x1::vector::empty<u64>();
                v1.target_roll_sum = 0;
                v1.current_risk = 0;
            } else if (v22 == v1.target_roll_sum) {
                v1.target_roll_sum = 0;
            } else {
                let v24 = if (v1.target_roll_sum == 0) {
                    let v25 = v22 == 11 || v22 == 2 || v22 == 3 || v22 == 12;
                    !v25
                } else {
                    false
                };
                if (v24) {
                    v1.target_roll_sum = v22;
                };
            };
        } else {
            0x1::option::fill<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.bets, v3);
            0x1::option::fill<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&mut v1.settled_bets, v4);
        };
    }

    entry fun start_roll<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: &mut CrapsConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(table_exists<T0>(arg2, v0), 5);
        let v1 = borrow_table_mut<T0>(arg2, v0);
        assert!(v1.status == 0, 11);
        let v2 = Craps{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_within_risk<T0, Craps>(arg0, v2, v1.current_risk, arg3);
        v1.status = 1;
        assert!(assert_table_has_bets<T0>(v1), 10);
        if (v1.target_roll_sum == 0) {
            let v3 = 0x2::linked_table::borrow<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>(0x1::option::borrow<0x2::linked_table::LinkedTable<address, vector<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>>>(&v1.bets), v0);
            let v4 = 0;
            let v5 = false;
            while (v4 < 0x1::vector::length<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(v3)) {
                let (v6, _, _, _) = 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::bet_metadata(0x1::vector::borrow<0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::Bet>(v3, v4));
                if (v6 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::pass_line_bet() || v6 == 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::bet_manager::dont_pass_line_bet()) {
                    v5 = true;
                    break
                };
                v4 = v4 + 1;
            };
            assert!(v5, 0);
        };
        let v10 = 0x2::random::new_generator(arg1, arg3);
        assert!(!0x2::table::contains<u64, u64>(&v1.rounds_settled, v1.round_number), 9);
        0x2::table::add<u64, u64>(&mut v1.rounds_settled, v1.round_number, 0x2::random::generate_u64_in_range(&mut v10, 1, 36));
    }

    public fun table_exists<T0>(arg0: &CrapsConfig, arg1: address) : bool {
        let v0 = CrapsTag<T0>{creator: arg1};
        0x2::dynamic_object_field::exists_<CrapsTag<T0>>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

