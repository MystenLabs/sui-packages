module 0xc43b48a9d3a1907145731b21da23106496fb2fb24dfecae792177448ef91fd6::swap {
    struct SwapPool has key {
        id: 0x2::object::UID,
        is_active: bool,
        admin: address,
        fee_bps: u64,
        reserve_id: address,
        fee_vault_id: address,
        pyth_price_feed_id: vector<u8>,
        last_gold_price: u64,
        last_exponent: u64,
        last_update_time: u64,
        price_info_object_id: address,
        min_usdc_swap: u64,
        max_usdc_swap: u64,
        min_gldc_swap: u64,
        max_gldc_swap: u64,
        price_deviation_bps: u64,
        weekday_staleness: u64,
        weekend_start_staleness: u64,
        weekend_max_staleness: u64,
        blacklist: 0x2::vec_set::VecSet<address>,
        max_daily_usdc: u64,
        max_daily_gldc: u64,
        daily_usdc_volume: u64,
        daily_gldc_volume: u64,
        last_reset_time: u64,
    }

    struct SwapReserve has key {
        id: 0x2::object::UID,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        gldc_balance: 0x2::balance::Balance<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>,
        admin: address,
        min_liquidity: u64,
    }

    struct FeeVault has key {
        id: 0x2::object::UID,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        gldc_balance: 0x2::balance::Balance<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>,
        admin: address,
    }

    struct SwapEvent has copy, drop {
        user: address,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        direction: vector<u8>,
        rate: u64,
        timestamp: u64,
    }

    struct FeeUpdateEvent has copy, drop {
        admin: address,
        new_fee_bps: u64,
    }

    struct ConfigUpdateEvent has copy, drop {
        admin: address,
        new_feed_id: vector<u8>,
    }

    struct DepositEvent has copy, drop {
        admin: address,
        token: vector<u8>,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        admin: address,
        token: vector<u8>,
        amount: u64,
        recipient: address,
    }

    struct WithdrawFeesEvent has copy, drop {
        admin: address,
        usdc_amount: u64,
        gldc_amount: u64,
        recipient: address,
    }

    struct PoolStatusEvent has copy, drop {
        admin: address,
        is_active: bool,
    }

    struct AdminUpdateEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct PriceResetEvent has copy, drop {
        admin: address,
        new_price: u64,
        new_expo: u64,
        new_time: u64,
    }

    struct PriceInfoSetEvent has copy, drop {
        admin: address,
        new_id: address,
    }

    struct LimitsUpdateEvent has copy, drop {
        admin: address,
        min_usdc_swap: u64,
        max_usdc_swap: u64,
        min_gldc_swap: u64,
        max_gldc_swap: u64,
    }

    struct DeviationUpdateEvent has copy, drop {
        admin: address,
        new_deviation_bps: u64,
    }

    struct StalenessUpdateEvent has copy, drop {
        admin: address,
        weekday_staleness: u64,
        weekend_start_staleness: u64,
        weekend_max_staleness: u64,
    }

    struct MinLiquidityUpdateEvent has copy, drop {
        admin: address,
        new_min_liquidity: u64,
    }

    struct BlacklistUpdateEvent has copy, drop {
        admin: address,
        action: vector<u8>,
        target: address,
    }

    struct FirstPriceSetEvent has copy, drop {
        price: u64,
        exponent: u64,
        timestamp: u64,
    }

    struct DailyLimitsUpdateEvent has copy, drop {
        admin: address,
        new_max_usdc: u64,
        new_max_gldc: u64,
    }

    struct PriceDeviationEvent has copy, drop {
        current_price: u64,
        current_exponent: u64,
        last_price: u64,
        last_exponent: u64,
        timestamp: u64,
    }

    struct SWAP has drop {
        dummy_field: bool,
    }

    public fun add_to_blacklist(arg0: &mut SwapPool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        0x2::vec_set::insert<address>(&mut arg0.blacklist, arg1);
        let v0 = BlacklistUpdateEvent{
            admin  : arg0.admin,
            action : b"add",
            target : arg1,
        };
        0x2::event::emit<BlacklistUpdateEvent>(v0);
    }

    public fun deposit_gldc(arg0: &mut SwapReserve, arg1: 0x2::coin::Coin<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x2::coin::value<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&mut arg0.gldc_balance, 0x2::coin::into_balance<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(arg1));
        let v1 = DepositEvent{
            admin  : arg0.admin,
            token  : b"TESTGLDC",
            amount : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun deposit_usdc(arg0: &mut SwapReserve, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        let v1 = DepositEvent{
            admin  : arg0.admin,
            token  : b"USDC",
            amount : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun get_current_fee(arg0: &SwapPool) : u64 {
        arg0.fee_bps
    }

    public fun get_current_price(arg0: &SwapPool) : u64 {
        arg0.last_gold_price
    }

    fun init(arg0: SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = SwapPool{
            id                      : 0x2::object::new(arg1),
            is_active               : true,
            admin                   : v0,
            fee_bps                 : 125,
            reserve_id              : @0x0,
            fee_vault_id            : @0x0,
            pyth_price_feed_id      : x"765d2ba906dbc32ca17cc11f5310a89e9ee1f6420508c63861f2f8ba4ee34bb2",
            last_gold_price         : 0,
            last_exponent           : 0,
            last_update_time        : 0,
            price_info_object_id    : @0x0,
            min_usdc_swap           : 3000000,
            max_usdc_swap           : 9900000000,
            min_gldc_swap           : 1000000,
            max_gldc_swap           : 2800000000,
            price_deviation_bps     : 500,
            weekday_staleness       : 60,
            weekend_start_staleness : 3600,
            weekend_max_staleness   : 180000,
            blacklist               : 0x2::vec_set::empty<address>(),
            max_daily_usdc          : 300000000000,
            max_daily_gldc          : 100000000000,
            daily_usdc_volume       : 0,
            daily_gldc_volume       : 0,
            last_reset_time         : 0,
        };
        let v2 = SwapReserve{
            id            : 0x2::object::new(arg1),
            usdc_balance  : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            gldc_balance  : 0x2::balance::zero<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(),
            admin         : v0,
            min_liquidity : 1000000,
        };
        let v3 = FeeVault{
            id           : 0x2::object::new(arg1),
            usdc_balance : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            gldc_balance : 0x2::balance::zero<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(),
            admin        : v0,
        };
        v1.reserve_id = 0x2::object::uid_to_address(&v2.id);
        v1.fee_vault_id = 0x2::object::uid_to_address(&v3.id);
        0x2::transfer::share_object<SwapPool>(v1);
        0x2::transfer::share_object<SwapReserve>(v2);
        0x2::transfer::share_object<FeeVault>(v3);
    }

    public fun pause_pool(arg0: &mut SwapPool, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.is_active = false;
        let v0 = PoolStatusEvent{
            admin     : arg0.admin,
            is_active : false,
        };
        0x2::event::emit<PoolStatusEvent>(v0);
    }

    fun pow10(arg0: u64) : u128 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = 1;
        let v1 = 10;
        while (arg0 > 0) {
            if (arg0 % 2 == 1) {
                v0 = v0 * v1;
            };
            v1 = v1 * v1;
            arg0 = arg0 / 2;
        };
        v0
    }

    public fun remove_from_blacklist(arg0: &mut SwapPool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        0x2::vec_set::remove<address>(&mut arg0.blacklist, &arg1);
        let v0 = BlacklistUpdateEvent{
            admin  : arg0.admin,
            action : b"remove",
            target : arg1,
        };
        0x2::event::emit<BlacklistUpdateEvent>(v0);
    }

    public fun reset_price(arg0: &mut SwapPool, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        arg0.last_gold_price = arg1;
        arg0.last_exponent = arg2;
        arg0.last_update_time = arg3;
        arg0.is_active = true;
        let v0 = PriceResetEvent{
            admin     : arg0.admin,
            new_price : arg1,
            new_expo  : arg2,
            new_time  : arg3,
        };
        0x2::event::emit<PriceResetEvent>(v0);
    }

    public fun set_pool_config(arg0: &mut SwapPool, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.pyth_price_feed_id = arg1;
        let v0 = ConfigUpdateEvent{
            admin       : arg0.admin,
            new_feed_id : arg1,
        };
        0x2::event::emit<ConfigUpdateEvent>(v0);
    }

    public fun set_price_info_object_id(arg0: &mut SwapPool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.price_info_object_id = arg1;
        let v0 = PriceInfoSetEvent{
            admin  : arg0.admin,
            new_id : arg1,
        };
        0x2::event::emit<PriceInfoSetEvent>(v0);
    }

    public fun swap_gldc_to_usdc(arg0: &mut SwapPool, arg1: &mut SwapReserve, arg2: &mut FeeVault, arg3: 0x2::coin::Coin<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::vec_set::contains<address>(&arg0.blacklist, &v0), 17);
        assert!(arg0.is_active, 1);
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.reserve_id, 7);
        assert!(0x2::object::uid_to_address(&arg2.id) == arg0.fee_vault_id, 8);
        let v1 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4);
        assert!(0x2::object::id_to_address(&v1) == arg0.price_info_object_id, 12);
        let v2 = 0x2::coin::value<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&arg3);
        assert!(v2 > 0, 3);
        assert!(v2 >= arg0.min_gldc_swap, 13);
        assert!(v2 <= arg0.max_gldc_swap, 14);
        let v3 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v4 = (v3 / 86400 + 4) % 7;
        let v5 = v3 % 86400;
        let v6 = if (v4 == 6) {
            true
        } else if (v4 == 0) {
            true
        } else {
            v4 == 5 && v5 / 3600 >= 21
        };
        let v7 = arg0.weekday_staleness;
        if (v6) {
            let v8 = 0;
            if (v4 == 5) {
                v8 = v5 - 21 * 3600;
            } else if (v4 == 6) {
                v8 = 86400 - 21 * 3600 + v5;
            } else if (v4 == 0) {
                v8 = 86400 - 21 * 3600 + 86400 + v5;
            };
            v7 = arg0.weekend_start_staleness + (arg0.weekend_max_staleness - arg0.weekend_start_staleness) * v8 / 176400;
        };
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg4, arg6, v7);
        let v10 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg4);
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v10);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v11) == arg0.pyth_price_feed_id, 12);
        let v12 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v9);
        let v13 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v9);
        let v14 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v9);
        assert!(v14 >= arg0.last_update_time, 18);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v12) == false, 15);
        let v15 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v12);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v13), 15);
        let v16 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v13);
        assert!(v16 <= 18, 15);
        assert!(v15 > 0, 15);
        let v17 = arg0.last_gold_price == 0;
        if (!v17) {
            if (v16 != arg0.last_exponent) {
                arg0.is_active = false;
                let v18 = PriceDeviationEvent{
                    current_price    : v15,
                    current_exponent : v16,
                    last_price       : arg0.last_gold_price,
                    last_exponent    : arg0.last_exponent,
                    timestamp        : v14,
                };
                0x2::event::emit<PriceDeviationEvent>(v18);
                abort 10
            };
            let v19 = if (v15 > arg0.last_gold_price) {
                v15 - arg0.last_gold_price
            } else {
                arg0.last_gold_price - v15
            };
            if ((v19 as u128) * 10000 > (arg0.last_gold_price as u128) * (arg0.price_deviation_bps as u128)) {
                arg0.is_active = false;
                let v20 = PriceDeviationEvent{
                    current_price    : v15,
                    current_exponent : v16,
                    last_price       : arg0.last_gold_price,
                    last_exponent    : arg0.last_exponent,
                    timestamp        : v14,
                };
                0x2::event::emit<PriceDeviationEvent>(v20);
                abort 10
            };
        };
        if (v3 - arg0.last_reset_time >= 86400) {
            arg0.daily_gldc_volume = 0;
            arg0.daily_usdc_volume = 0;
            arg0.last_reset_time = v3;
        };
        assert!(arg0.daily_gldc_volume + v2 <= arg0.max_daily_gldc, 19);
        arg0.daily_gldc_volume = arg0.daily_gldc_volume + v2;
        let v21 = v2 * arg0.fee_bps / 10000;
        let v22 = ((((v2 - v21) as u128) * (v15 as u128) / (1000 as u128) * pow10(v16)) as u64);
        assert!(v22 >= arg5, 16);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.usdc_balance) >= v22 + arg1.min_liquidity, 2);
        0x2::balance::join<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&mut arg2.gldc_balance, 0x2::coin::into_balance<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(0x2::coin::split<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&mut arg3, v21, arg7)));
        0x2::balance::join<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&mut arg1.gldc_balance, 0x2::coin::into_balance<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.usdc_balance, v22, arg7), v0);
        arg0.last_gold_price = v15;
        arg0.last_exponent = v16;
        arg0.last_update_time = v14;
        let v23 = SwapEvent{
            user       : v0,
            amount_in  : v2,
            amount_out : v22,
            fee_amount : v21,
            direction  : b"gldc_to_usdc",
            rate       : v15,
            timestamp  : v14,
        };
        0x2::event::emit<SwapEvent>(v23);
        if (v17) {
            let v24 = FirstPriceSetEvent{
                price     : v15,
                exponent  : v16,
                timestamp : v14,
            };
            0x2::event::emit<FirstPriceSetEvent>(v24);
        };
    }

    public fun swap_usdc_to_gldc(arg0: &mut SwapPool, arg1: &mut SwapReserve, arg2: &mut FeeVault, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::vec_set::contains<address>(&arg0.blacklist, &v0), 17);
        assert!(arg0.is_active, 1);
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.reserve_id, 7);
        assert!(0x2::object::uid_to_address(&arg2.id) == arg0.fee_vault_id, 8);
        let v1 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4);
        assert!(0x2::object::id_to_address(&v1) == arg0.price_info_object_id, 12);
        let v2 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v2 > 0, 3);
        assert!(v2 >= arg0.min_usdc_swap, 13);
        assert!(v2 <= arg0.max_usdc_swap, 14);
        let v3 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v4 = (v3 / 86400 + 4) % 7;
        let v5 = v3 % 86400;
        let v6 = if (v4 == 6) {
            true
        } else if (v4 == 0) {
            true
        } else {
            v4 == 5 && v5 / 3600 >= 21
        };
        let v7 = arg0.weekday_staleness;
        if (v6) {
            let v8 = 0;
            if (v4 == 5) {
                v8 = v5 - 21 * 3600;
            } else if (v4 == 6) {
                v8 = 86400 - 21 * 3600 + v5;
            } else if (v4 == 0) {
                v8 = 86400 - 21 * 3600 + 86400 + v5;
            };
            v7 = arg0.weekend_start_staleness + (arg0.weekend_max_staleness - arg0.weekend_start_staleness) * v8 / 176400;
        };
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg4, arg6, v7);
        let v10 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg4);
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v10);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v11) == arg0.pyth_price_feed_id, 12);
        let v12 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v9);
        let v13 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v9);
        let v14 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v9);
        assert!(v14 >= arg0.last_update_time, 18);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v12) == false, 15);
        let v15 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v12);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v13), 15);
        let v16 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v13);
        assert!(v16 <= 18, 15);
        assert!(v15 > 0, 15);
        let v17 = arg0.last_gold_price == 0;
        if (!v17) {
            if (v16 != arg0.last_exponent) {
                arg0.is_active = false;
                let v18 = PriceDeviationEvent{
                    current_price    : v15,
                    current_exponent : v16,
                    last_price       : arg0.last_gold_price,
                    last_exponent    : arg0.last_exponent,
                    timestamp        : v14,
                };
                0x2::event::emit<PriceDeviationEvent>(v18);
                abort 10
            };
            let v19 = if (v15 > arg0.last_gold_price) {
                v15 - arg0.last_gold_price
            } else {
                arg0.last_gold_price - v15
            };
            if ((v19 as u128) * 10000 > (arg0.last_gold_price as u128) * (arg0.price_deviation_bps as u128)) {
                arg0.is_active = false;
                let v20 = PriceDeviationEvent{
                    current_price    : v15,
                    current_exponent : v16,
                    last_price       : arg0.last_gold_price,
                    last_exponent    : arg0.last_exponent,
                    timestamp        : v14,
                };
                0x2::event::emit<PriceDeviationEvent>(v20);
                abort 10
            };
        };
        if (v3 - arg0.last_reset_time >= 86400) {
            arg0.daily_usdc_volume = 0;
            arg0.daily_gldc_volume = 0;
            arg0.last_reset_time = v3;
        };
        assert!(arg0.daily_usdc_volume + v2 <= arg0.max_daily_usdc, 19);
        arg0.daily_usdc_volume = arg0.daily_usdc_volume + v2;
        let v21 = v2 * arg0.fee_bps / 10000;
        let v22 = ((((v2 - v21) as u128) * (1000 as u128) * pow10(v16) / (v15 as u128)) as u64);
        assert!(v22 >= arg5, 16);
        assert!(0x2::balance::value<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&arg1.gldc_balance) >= v22 + arg1.min_liquidity, 2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg2.usdc_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg3, v21, arg7)));
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.usdc_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>>(0x2::coin::take<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&mut arg1.gldc_balance, v22, arg7), v0);
        arg0.last_gold_price = v15;
        arg0.last_exponent = v16;
        arg0.last_update_time = v14;
        let v23 = SwapEvent{
            user       : v0,
            amount_in  : v2,
            amount_out : v22,
            fee_amount : v21,
            direction  : b"usdc_to_gldc",
            rate       : v15,
            timestamp  : v14,
        };
        0x2::event::emit<SwapEvent>(v23);
        if (v17) {
            let v24 = FirstPriceSetEvent{
                price     : v15,
                exponent  : v16,
                timestamp : v14,
            };
            0x2::event::emit<FirstPriceSetEvent>(v24);
        };
    }

    public fun unpause_pool(arg0: &mut SwapPool, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.is_active = true;
        let v0 = PoolStatusEvent{
            admin     : arg0.admin,
            is_active : true,
        };
        0x2::event::emit<PoolStatusEvent>(v0);
    }

    public fun update_admin(arg0: &mut SwapPool, arg1: &mut SwapReserve, arg2: &mut FeeVault, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.reserve_id, 7);
        assert!(0x2::object::uid_to_address(&arg2.id) == arg0.fee_vault_id, 8);
        arg0.admin = arg3;
        arg1.admin = arg3;
        arg2.admin = arg3;
        let v0 = AdminUpdateEvent{
            old_admin : arg0.admin,
            new_admin : arg3,
        };
        0x2::event::emit<AdminUpdateEvent>(v0);
    }

    public fun update_daily_limits(arg0: &mut SwapPool, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.max_daily_usdc = arg1;
        arg0.max_daily_gldc = arg2;
        let v0 = DailyLimitsUpdateEvent{
            admin        : arg0.admin,
            new_max_usdc : arg1,
            new_max_gldc : arg2,
        };
        0x2::event::emit<DailyLimitsUpdateEvent>(v0);
    }

    public fun update_deviation_bps(arg0: &mut SwapPool, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.price_deviation_bps = arg1;
        let v0 = DeviationUpdateEvent{
            admin             : arg0.admin,
            new_deviation_bps : arg1,
        };
        0x2::event::emit<DeviationUpdateEvent>(v0);
    }

    public fun update_fee(arg0: &mut SwapPool, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.fee_bps = arg1;
        let v0 = FeeUpdateEvent{
            admin       : arg0.admin,
            new_fee_bps : arg1,
        };
        0x2::event::emit<FeeUpdateEvent>(v0);
    }

    public fun update_limits(arg0: &mut SwapPool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        assert!(arg1 < arg2, 15);
        assert!(arg3 < arg4, 15);
        arg0.min_usdc_swap = arg1;
        arg0.max_usdc_swap = arg2;
        arg0.min_gldc_swap = arg3;
        arg0.max_gldc_swap = arg4;
        let v0 = LimitsUpdateEvent{
            admin         : arg0.admin,
            min_usdc_swap : arg1,
            max_usdc_swap : arg2,
            min_gldc_swap : arg3,
            max_gldc_swap : arg4,
        };
        0x2::event::emit<LimitsUpdateEvent>(v0);
    }

    public fun update_min_liquidity(arg0: &mut SwapReserve, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.min_liquidity = arg1;
        let v0 = MinLiquidityUpdateEvent{
            admin             : arg0.admin,
            new_min_liquidity : arg1,
        };
        0x2::event::emit<MinLiquidityUpdateEvent>(v0);
    }

    public fun update_staleness_thresholds(arg0: &mut SwapPool, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        arg0.weekday_staleness = arg1;
        arg0.weekend_start_staleness = arg2;
        arg0.weekend_max_staleness = arg3;
        let v0 = StalenessUpdateEvent{
            admin                   : arg0.admin,
            weekday_staleness       : arg1,
            weekend_start_staleness : arg2,
            weekend_max_staleness   : arg3,
        };
        0x2::event::emit<StalenessUpdateEvent>(v0);
    }

    public fun withdraw_fees(arg0: &mut FeeVault, arg1: &SwapPool, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.fee_vault_id, 8);
        assert!(arg2 <= 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_balance), 2);
        assert!(arg3 <= 0x2::balance::value<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&arg0.gldc_balance), 2);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, arg2, arg5), arg4);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>>(0x2::coin::take<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&mut arg0.gldc_balance, arg3, arg5), arg4);
        };
        let v0 = WithdrawFeesEvent{
            admin       : arg0.admin,
            usdc_amount : arg2,
            gldc_amount : arg3,
            recipient   : arg4,
        };
        0x2::event::emit<WithdrawFeesEvent>(v0);
    }

    public fun withdraw_gldc(arg0: &mut SwapReserve, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>>(0x2::coin::take<0x9cf55e607b2fc84758decb94c2e98a8ffd3e7fe86820ef8c941c7c5e651e3847::testgldc::TESTGLDC>(&mut arg0.gldc_balance, arg1, arg3), arg2);
        let v0 = WithdrawEvent{
            admin     : arg0.admin,
            token     : b"TESTGLDC",
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public fun withdraw_usdc(arg0: &mut SwapReserve, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, arg1, arg3), arg2);
        let v0 = WithdrawEvent{
            admin     : arg0.admin,
            token     : b"USDC",
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

