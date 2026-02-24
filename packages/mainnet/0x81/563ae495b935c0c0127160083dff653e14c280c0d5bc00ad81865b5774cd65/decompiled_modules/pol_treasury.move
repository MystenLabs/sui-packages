module 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::pol_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        sui_accum: 0x2::balance::Balance<0x2::sui::SUI>,
        lp_assets: 0x2::bag::Bag,
        is_initialized: bool,
    }

    struct PolVault has key {
        id: 0x2::object::UID,
    }

    struct LiquidityAssetsProvided has copy, drop {
        sui_amount: u64,
        tvyn_minted: u64,
        timestamp_ms: u64,
    }

    struct LpPositionDeposited has copy, drop {
        depositor: address,
        asset_id: 0x2::object::ID,
    }

    fun calculate_tvyn_for_all_sui(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg1 as u256);
        (((arg0 as u256) * 340282366920938463463374607431768211456 / v0 * v0) as u64)
    }

    public fun calculate_tvyn_needed(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 / arg2
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id             : 0x2::object::new(arg0),
            sui_accum      : 0x2::balance::zero<0x2::sui::SUI>(),
            lp_assets      : 0x2::bag::new(arg0),
            is_initialized : false,
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = PolVault{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PolVault>(v1);
    }

    public fun create_liquidity_assets(arg0: &mut Treasury, arg1: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::MintVault, arg2: &0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::Config, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN>) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::dev_addr(arg2) || v0 == 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::lp_operator_addr(arg2), 2);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_accum) < 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::lp_threshold_sui(arg2)) {
            return (0x2::coin::zero<0x2::sui::SUI>(arg3), 0x2::coin::zero<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN>(arg3))
        };
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_accum);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let v3 = v2 * 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::lp_target_ratio_bps(arg2) / 10000;
        let v4 = LiquidityAssetsProvided{
            sui_amount   : v2,
            tvyn_minted  : v3,
            timestamp_ms : 0,
        };
        0x2::event::emit<LiquidityAssetsProvided>(v4);
        (0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::mint_for_protocol(arg1, v3, arg3))
    }

    public fun create_liquidity_assets_v2(arg0: &mut Treasury, arg1: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::MintVault, arg2: &0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::Config, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN>) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::dev_addr(arg2) || v0 == 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::lp_operator_addr(arg2), 2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_accum);
        let v2 = calculate_tvyn_needed(v1, 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::oracle_adapter::read_sui_usd_bps(arg2, arg3, arg4, arg5), 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::lp_target_ratio_bps(arg2));
        let v3 = LiquidityAssetsProvided{
            sui_amount   : v1,
            tvyn_minted  : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<LiquidityAssetsProvided>(v3);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_accum), arg6), 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::mint_for_protocol(arg1, v2, arg6))
    }

    public fun create_liquidity_assets_v3(arg0: &mut Treasury, arg1: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::MintVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN, 0x2::sui::SUI>, arg3: &0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN>) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::dev_addr(arg3) || v0 == 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::lp_operator_addr(arg3), 2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_accum);
        if (v1 == 0) {
            return (0x2::coin::zero<0x2::sui::SUI>(arg5), 0x2::coin::zero<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN>(arg5))
        };
        let v2 = calculate_tvyn_for_all_sui(v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN, 0x2::sui::SUI>(arg2));
        let v3 = LiquidityAssetsProvided{
            sui_amount   : v1,
            tvyn_minted  : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LiquidityAssetsProvided>(v3);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_accum), arg5), 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::mint_for_protocol(arg1, v2, arg5))
    }

    public fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_accum, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun deposit_lp_position<T0: store + key>(arg0: &mut Treasury, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.lp_assets, v0, arg1);
        let v1 = LpPositionDeposited{
            depositor : 0x2::tx_context::sender(arg2),
            asset_id  : v0,
        };
        0x2::event::emit<LpPositionDeposited>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_and_share(arg0);
    }

    public entry fun mint_initial_liquidity_tvyn(arg0: &0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::admin::AdminCap, arg1: &mut Treasury, arg2: &mut 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::MintVault, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == false, 3);
        arg1.is_initialized = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::TVYN>>(0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::tvyn::mint_for_protocol(arg2, 400000000000, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

