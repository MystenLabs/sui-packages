module 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        sui_accum: 0x2::balance::Balance<0x2::sui::SUI>,
        buyback_accum: 0x2::balance::Balance<0x2::sui::SUI>,
        keeper_reward_accum: 0x2::balance::Balance<0x2::sui::SUI>,
        lp_assets: 0x2::bag::Bag,
        is_initialized: bool,
        last_buyback_ms: u64,
        buyback_spent_today: u64,
        last_buyback_day_utc: u64,
    }

    struct PolVault has key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCapCreated has copy, drop {
        operator_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct LiquidityAssetsProvided has copy, drop {
        sui_amount: u64,
        tvyn_minted: u64,
        timestamp_ms: u64,
    }

    struct LpPositionDeposited has copy, drop {
        depositor: address,
        asset_id: 0x2::object::ID,
        keeper_reward_paid: u64,
    }

    struct BuybackStarted has copy, drop {
        sui_amount: u64,
        min_tvyn_to_burn: u64,
        price_mist_per_tvyn: u64,
        timestamp_ms: u64,
    }

    struct BuybackBurned has copy, drop {
        sui_amount: u64,
        tvyn_burned: u64,
        keeper_reward_paid: u64,
    }

    struct OfficialPoolRegistered has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct BuybackReceipt {
        sui_amount: u64,
        min_tvyn_to_burn: u64,
    }

    struct LpReceipt {
        sui_amount: u64,
        tvyn_amount: u64,
    }

    fun assert_mint_vault(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault, arg1: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config) {
        assert!(0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault>(arg0) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::mint_vault_id(arg1), 13);
    }

    fun assert_registered_pool(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg1: address) {
        assert!(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::pool_registered(arg0), 5);
        assert!(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::registered_pool_id(arg0) == 0x2::object::id_from_address(arg1), 4);
    }

    fun assert_treasury(arg0: &Treasury, arg1: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config) {
        assert!(0x2::object::id<Treasury>(arg0) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::treasury_id(arg1), 12);
    }

    public fun begin_buyback_and_burn(arg0: &mut Treasury, arg1: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BuybackReceipt) {
        begin_buyback_and_burn_internal(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun begin_buyback_and_burn_for_operator(arg0: &OperatorCap, arg1: &mut Treasury, arg2: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BuybackReceipt) {
        begin_buyback_and_burn_internal(arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun begin_buyback_and_burn_internal(arg0: &mut Treasury, arg1: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BuybackReceipt) {
        assert_treasury(arg0, arg1);
        assert_registered_pool(arg1, arg2);
        reset_buyback_day_if_needed(arg0, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.last_buyback_ms + 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::buyback_cooldown_ms(arg1), 7);
        assert!(arg3 < 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::buyback_floor_price_mist(arg1), 6);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_accum);
        assert!(v1 > 0, 8);
        let v2 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::buyback_daily_cap_sui(arg1);
        assert!(arg0.buyback_spent_today < v2, 8);
        let v3 = v2 - arg0.buyback_spent_today;
        assert!(v3 > 0, 8);
        let v4 = min_u64(min_u64(v1, v3), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::buyback_max_per_run_sui(arg1));
        let v5 = min_tvyn_for_buyback(v4, 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::buyback_floor_price_mist(arg1), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::buyback_min_burn_bps(arg1));
        arg0.last_buyback_ms = v0;
        arg0.buyback_spent_today = arg0.buyback_spent_today + v4;
        let v6 = BuybackStarted{
            sui_amount          : v4,
            min_tvyn_to_burn    : v5,
            price_mist_per_tvyn : arg3,
            timestamp_ms        : v0,
        };
        0x2::event::emit<BuybackStarted>(v6);
        let v7 = BuybackReceipt{
            sui_amount       : v4,
            min_tvyn_to_burn : v5,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.buyback_accum, v4), arg5), v7)
    }

    public fun buyback_accum_value(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_accum)
    }

    fun calculate_tvyn_for_all_sui(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg1 as u256);
        (((arg0 as u256) * 340282366920938463463374607431768211456 / v0 * v0) as u64)
    }

    public fun complete_buyback_and_burn(arg0: &mut Treasury, arg1: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault, arg2: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg3: BuybackReceipt, arg4: 0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_treasury(arg0, arg2);
        assert_mint_vault(arg1, arg2);
        let BuybackReceipt {
            sui_amount       : v0,
            min_tvyn_to_burn : v1,
        } = arg3;
        let v2 = 0x2::coin::value<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>(&arg4);
        assert!(v2 >= v1, 9);
        0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::burn_for_protocol(arg1, arg4);
        let v3 = BuybackBurned{
            sui_amount         : v0,
            tvyn_burned        : v2,
            keeper_reward_paid : pay_keeper_reward(arg0, arg2, arg5),
        };
        0x2::event::emit<BuybackBurned>(v3);
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                   : 0x2::object::new(arg0),
            sui_accum            : 0x2::balance::zero<0x2::sui::SUI>(),
            buyback_accum        : 0x2::balance::zero<0x2::sui::SUI>(),
            keeper_reward_accum  : 0x2::balance::zero<0x2::sui::SUI>(),
            lp_assets            : 0x2::bag::new(arg0),
            is_initialized       : false,
            last_buyback_ms      : 0,
            buyback_spent_today  : 0,
            last_buyback_day_utc : 0,
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = PolVault{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PolVault>(v1);
    }

    public fun create_liquidity_assets(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut Treasury, arg2: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault, arg3: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg4: address, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>, LpReceipt) {
        create_liquidity_assets_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun create_liquidity_assets_for_operator(arg0: &OperatorCap, arg1: &mut Treasury, arg2: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault, arg3: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg4: address, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>, LpReceipt) {
        create_liquidity_assets_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun create_liquidity_assets_internal(arg0: &mut Treasury, arg1: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault, arg2: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg3: address, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>, LpReceipt) {
        assert_treasury(arg0, arg2);
        assert_mint_vault(arg1, arg2);
        assert_registered_pool(arg2, arg3);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_accum);
        assert!(v0 >= 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::lp_threshold_sui(arg2), 11);
        let v1 = calculate_tvyn_for_all_sui(v0, arg4);
        let v2 = LiquidityAssetsProvided{
            sui_amount   : v0,
            tvyn_minted  : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<LiquidityAssetsProvided>(v2);
        let v3 = LpReceipt{
            sui_amount  : v0,
            tvyn_amount : v1,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_accum), arg6), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::mint_for_protocol(arg1, v1, arg6), v3)
    }

    public entry fun create_operator_cap(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<OperatorCap>(v0, arg1);
        let v1 = OperatorCapCreated{
            operator_cap_id : 0x2::object::id<OperatorCap>(&v0),
            recipient       : arg1,
        };
        0x2::event::emit<OperatorCapCreated>(v1);
    }

    public fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_accum, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun deposit_buyback(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_accum, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun deposit_keeper_rewards(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.keeper_reward_accum, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun deposit_lp_position<T0: store + key>(arg0: &mut Treasury, arg1: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg2: address, arg3: T0, arg4: LpReceipt, arg5: &mut 0x2::tx_context::TxContext) {
        assert_treasury(arg0, arg1);
        let LpReceipt {
            sui_amount  : _,
            tvyn_amount : _,
        } = arg4;
        assert_registered_pool(arg1, arg2);
        let v2 = 0x2::object::id<T0>(&arg3);
        let v3 = 0x2::tx_context::sender(arg5);
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.lp_assets, v2, arg3);
        let v4 = LpPositionDeposited{
            depositor          : v3,
            asset_id           : v2,
            keeper_reward_paid : pay_keeper_reward(arg0, arg1, arg5),
        };
        0x2::event::emit<LpPositionDeposited>(v4);
    }

    public fun is_buyback_reserve_ready(arg0: &Treasury, arg1: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_accum) >= 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::buyback_max_per_run_sui(arg1)
    }

    public fun is_lp_ready(arg0: &Treasury, arg1: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_accum) >= 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::lp_threshold_sui(arg1)
    }

    fun min_tvyn_for_buyback(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u256) * 1000000000 * (arg2 as u256) / (arg1 as u256) * 10000) as u64)
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public entry fun mint_initial_liquidity_tvyn(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut Treasury, arg2: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == false, 3);
        assert!(arg3 <= 10000000000, 10);
        arg1.is_initialized = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::mint_for_protocol(arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    fun pay_keeper_reward(arg0: &mut Treasury, arg1: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = min_u64(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::keeper_reward_sui(arg1), 0x2::balance::value<0x2::sui::SUI>(&arg0.keeper_reward_accum));
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.keeper_reward_accum, v0), arg2), 0x2::tx_context::sender(arg2));
        };
        v0
    }

    public entry fun register_cetus_pool(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg2: address) {
        let v0 = 0x2::object::id_from_address(arg2);
        0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::set_registered_pool_id(arg1, v0);
        let v1 = OfficialPoolRegistered{pool_id: v0};
        0x2::event::emit<OfficialPoolRegistered>(v1);
    }

    fun reset_buyback_day_if_needed(arg0: &mut Treasury, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 86400000;
        if (v0 > arg0.last_buyback_day_utc) {
            arg0.buyback_spent_today = 0;
            arg0.last_buyback_day_utc = v0;
        };
    }

    public fun sui_accum_value(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_accum)
    }

    // decompiled from Move bytecode v7
}

