module 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten {
    struct BTEN has drop {
        dummy_field: bool,
    }

    struct RouterCap has store, key {
        id: 0x2::object::UID,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperConfig has key {
        id: 0x2::object::UID,
        keeper: address,
        paused: bool,
        daily_staking_cap: u64,
        accounting_day: u64,
        spent_today: u64,
    }

    struct LpProgramCap has store, key {
        id: 0x2::object::UID,
    }

    struct LpProgramState has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, u64>,
        weight_total: u64,
        finalized: bool,
        paused: bool,
        protocol_liquidity: 0x2::balance::Balance<BTEN>,
    }

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, u8>,
        finalized: bool,
    }

    struct FeeSubsidyState has key {
        id: 0x2::object::UID,
        sponsor: address,
        sui_pool: address,
        per_refill_cap_mist: u64,
        daily_cap_mist: u64,
        accounting_day: u64,
        spent_today_mist: u64,
    }

    struct DistributionState has key {
        id: 0x2::object::UID,
        next_height: u64,
        enabled: 0x2::table::Table<u8, bool>,
        destinations: 0x2::table::Table<u8, address>,
    }

    struct RouteTreasuryState has key {
        id: 0x2::object::UID,
        next_height: u64,
        sponsor_accrued: u64,
        pol_accrued: u64,
        rebate_accrued: u64,
        lp_support_accrued: u64,
        safety_accrued: u64,
        paused: bool,
    }

    struct PointKey has copy, drop, store {
        round: u64,
        trader: address,
    }

    struct TraderRound has copy, drop, store {
        total_points: u64,
        reward_total: u64,
        reward_paid: u64,
    }

    struct EmissionState has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BTEN>,
        total_minted: u64,
        block_height: u64,
        last_slot_ts: u64,
        pending_blocks: u64,
        batch_trades: u64,
        batch_fee_points: u64,
        current_round: u64,
        trader_points: 0x2::table::Table<PointKey, u64>,
        trader_rounds: 0x2::table::Table<u64, TraderRound>,
        route_fee_vault: 0x2::balance::Balance<BTEN>,
        trader_vault: 0x2::balance::Balance<BTEN>,
        bten_lp_vault: 0x2::balance::Balance<BTEN>,
        staking_vault: 0x2::balance::Balance<BTEN>,
        cetus_vault: 0x2::balance::Balance<BTEN>,
        haedal_vault: 0x2::balance::Balance<BTEN>,
        blue_vault: 0x2::balance::Balance<BTEN>,
        magma_vault: 0x2::balance::Balance<BTEN>,
        sui_gas_vault: 0x2::balance::Balance<BTEN>,
    }

    struct RouteRecorded has copy, drop {
        trader: address,
        fee_points: u64,
        batch_trades: u64,
    }

    struct BlocksReleased has copy, drop {
        blocks: u64,
        emission: u64,
        remaining_pending: u64,
    }

    struct TraderPaid has copy, drop {
        round: u64,
        trader: address,
        amount: u64,
    }

    struct SponsorRefilled has copy, drop {
        sponsor: address,
        bten_in: u64,
        sui_out_mist: u64,
        spent_today_mist: u64,
    }

    struct AllocationDelivered has copy, drop {
        height: u64,
        bucket: u8,
        recipient: address,
        amount: u64,
    }

    struct DistributionDestinationConfigured has copy, drop {
        bucket: u8,
        recipient: address,
        enabled: bool,
    }

    struct RouteTreasuryAccrued has copy, drop {
        height: u64,
        sponsor: u64,
        protocol_liquidity: u64,
        rebates: u64,
        lp_support: u64,
        safety: u64,
    }

    struct LpProgrammeAccrued has copy, drop {
        total: u64,
        protocol_liquidity: u64,
        cetus_rewards: u64,
    }

    struct LpProgrammeReleased has copy, drop {
        pool_id: address,
        category: u8,
        amount: u64,
    }

    public entry fun accrue_lp_program(arg0: &mut EmissionState, arg1: &mut LpProgramState) {
        assert!(arg1.finalized, 25);
        let v0 = &mut arg0.bten_lp_vault;
        let v1 = drain_bten(v0);
        let v2 = &mut arg0.cetus_vault;
        0x2::balance::join<BTEN>(&mut v1, drain_bten(v2));
        let v3 = &mut arg0.haedal_vault;
        0x2::balance::join<BTEN>(&mut v1, drain_bten(v3));
        let v4 = &mut arg0.blue_vault;
        0x2::balance::join<BTEN>(&mut v1, drain_bten(v4));
        let v5 = &mut arg0.magma_vault;
        0x2::balance::join<BTEN>(&mut v1, drain_bten(v5));
        let v6 = &mut arg0.sui_gas_vault;
        0x2::balance::join<BTEN>(&mut v1, drain_bten(v6));
        let v7 = 0x2::balance::value<BTEN>(&v1);
        assert!(10000 == 10000, 26);
        0x2::balance::join<BTEN>(&mut arg1.protocol_liquidity, v1);
        let v8 = LpProgrammeAccrued{
            total              : v7,
            protocol_liquidity : v7 * 10000 / 10000,
            cetus_rewards      : 0,
        };
        0x2::event::emit<LpProgrammeAccrued>(v8);
    }

    public fun accrue_route_lp_support_to_program(arg0: &mut EmissionState, arg1: &mut RouteTreasuryState, arg2: &mut LpProgramState, arg3: &LpProgramCap, arg4: u64) {
        assert!(!arg2.paused && arg2.finalized, 23);
        assert!(arg4 > 0 && arg4 <= arg1.lp_support_accrued, 0);
        arg1.lp_support_accrued = arg1.lp_support_accrued - arg4;
        0x2::balance::join<BTEN>(&mut arg2.protocol_liquidity, 0x2::balance::split<BTEN>(&mut arg0.route_fee_vault, arg4));
        let v0 = LpProgrammeAccrued{
            total              : arg4,
            protocol_liquidity : arg4,
            cetus_rewards      : 0,
        };
        0x2::event::emit<LpProgrammeAccrued>(v0);
    }

    fun advance_slots(arg0: &mut EmissionState, arg1: u64) {
        if (arg0.last_slot_ts == 0) {
            arg0.last_slot_ts = arg1;
            return
        };
        if (arg1 <= arg0.last_slot_ts) {
            return
        };
        let v0 = (arg1 - arg0.last_slot_ts) / 600;
        if (v0 > 0) {
            arg0.pending_blocks = arg0.pending_blocks + v0;
            arg0.last_slot_ts = arg0.last_slot_ts + v0 * 600;
        };
    }

    fun allocate(arg0: &mut EmissionState, arg1: 0x2::balance::Balance<BTEN>, arg2: u64) {
        0x2::balance::join<BTEN>(&mut arg0.route_fee_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 5000 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.trader_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 1000 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.bten_lp_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 2500 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.staking_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 1000 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.cetus_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.haedal_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.blue_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.magma_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.sui_gas_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.haedal_vault, arg1);
    }

    public fun auto_pay_trader(arg0: &mut EmissionState, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, TraderRound>(&arg0.trader_rounds, arg1), 6);
        let v0 = PointKey{
            round  : arg1,
            trader : arg2,
        };
        assert!(0x2::table::contains<PointKey, u64>(&arg0.trader_points, v0), 7);
        let v1 = 0x2::table::borrow_mut<u64, TraderRound>(&mut arg0.trader_rounds, arg1);
        let v2 = 0x2::table::remove<PointKey, u64>(&mut arg0.trader_points, v0) * v1.reward_total / v1.total_points;
        assert!(v2 > 0, 7);
        v1.reward_paid = v1.reward_paid + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(&mut arg0.trader_vault, v2), arg3), arg2);
        let v3 = TraderPaid{
            round  : arg1,
            trader : arg2,
            amount : v2,
        };
        0x2::event::emit<TraderPaid>(v3);
    }

    public entry fun auto_pay_trader_entry(arg0: &mut EmissionState, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        auto_pay_trader(arg0, arg1, arg2, arg3);
    }

    public fun batch_trades(arg0: &EmissionState) : u64 {
        arg0.batch_trades
    }

    public fun block_height(arg0: &EmissionState) : u64 {
        arg0.block_height
    }

    public fun block_time_secs() : u64 {
        600
    }

    public fun blue_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.blue_vault)
    }

    public fun bten_lp_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.bten_lp_vault)
    }

    public fun cetus_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.cetus_vault)
    }

    public entry fun cetus_swap_from_bten<T0>(arg0: &mut EmissionState, arg1: &PoolRegistry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, BTEN>, arg4: 0x2::coin::Coin<BTEN>, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, BTEN>>(arg3);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x2::table::contains<address, u8>(&arg1.pools, v1), 12);
        assert!(*0x2::table::borrow<address, u8>(&arg1.pools, v1) == 1, 12);
        let v2 = 0x2::coin::value<BTEN>(&arg4);
        assert!(v2 > 0, 14);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, BTEN>(arg2, arg3, false, true, v2, arg6, arg7);
        let v6 = v5;
        let v7 = v3;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, BTEN>(&v6);
        assert!(0x2::balance::value<T0>(&v7) >= arg5, 13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, BTEN>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<BTEN>(0x2::coin::split<BTEN>(&mut arg4, v8, arg8)), v6);
        0x2::coin::join<BTEN>(&mut arg4, 0x2::coin::from_balance<BTEN>(v4, arg8));
        record_atomic_route(arg0, v8, arg7, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(arg4, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg8), 0x2::tx_context::sender(arg8));
    }

    public entry fun cetus_swap_from_bten_a2b<T0>(arg0: &mut EmissionState, arg1: &PoolRegistry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<BTEN, T0>, arg4: 0x2::coin::Coin<BTEN>, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<BTEN, T0>>(arg3);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x2::table::contains<address, u8>(&arg1.pools, v1), 12);
        assert!(*0x2::table::borrow<address, u8>(&arg1.pools, v1) == 1, 12);
        let v2 = 0x2::coin::value<BTEN>(&arg4);
        assert!(v2 > 0, 14);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<BTEN, T0>(arg2, arg3, true, true, v2, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<BTEN, T0>(&v6);
        assert!(0x2::balance::value<T0>(&v7) >= arg5, 13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<BTEN, T0>(arg2, arg3, 0x2::coin::into_balance<BTEN>(0x2::coin::split<BTEN>(&mut arg4, v8, arg8)), 0x2::balance::zero<T0>(), v6);
        0x2::coin::join<BTEN>(&mut arg4, 0x2::coin::from_balance<BTEN>(v3, arg8));
        record_atomic_route(arg0, v8, arg7, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(arg4, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg8), 0x2::tx_context::sender(arg8));
    }

    public entry fun cetus_swap_to_bten<T0>(arg0: &mut EmissionState, arg1: &PoolRegistry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, BTEN>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, BTEN>>(arg3);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x2::table::contains<address, u8>(&arg1.pools, v1), 12);
        assert!(*0x2::table::borrow<address, u8>(&arg1.pools, v1) == 1, 12);
        let v2 = 0x2::coin::value<T0>(&arg4);
        assert!(v2 > 0, 14);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, BTEN>(arg2, arg3, true, true, v2, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, BTEN>(&v6);
        assert!(0x2::balance::value<BTEN>(&v7) >= arg5, 13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, BTEN>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v8, arg8)), 0x2::balance::zero<BTEN>(), v6);
        0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v3, arg8));
        record_atomic_route(arg0, v8, arg7, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(0x2::coin::from_balance<BTEN>(v7, arg8), 0x2::tx_context::sender(arg8));
    }

    public entry fun cetus_swap_to_bten_b2a<T0>(arg0: &mut EmissionState, arg1: &PoolRegistry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<BTEN, T0>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<BTEN, T0>>(arg3);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x2::table::contains<address, u8>(&arg1.pools, v1), 12);
        assert!(*0x2::table::borrow<address, u8>(&arg1.pools, v1) == 1, 12);
        let v2 = 0x2::coin::value<T0>(&arg4);
        assert!(v2 > 0, 14);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<BTEN, T0>(arg2, arg3, false, true, v2, arg6, arg7);
        let v6 = v5;
        let v7 = v3;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<BTEN, T0>(&v6);
        assert!(0x2::balance::value<BTEN>(&v7) >= arg5, 13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<BTEN, T0>(arg2, arg3, 0x2::balance::zero<BTEN>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v8, arg8)), v6);
        0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v4, arg8));
        record_atomic_route(arg0, v8, arg7, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(0x2::coin::from_balance<BTEN>(v7, arg8), 0x2::tx_context::sender(arg8));
    }

    public fun configure_distribution_destination(arg0: &mut DistributionState, arg1: &RegistryAdminCap, arg2: u8, arg3: address, arg4: bool) {
        assert!(arg2 <= 6, 3);
        assert!(arg2 == 6, 27);
        assert!(arg2 != 0 || arg3 != @0x0, 18);
        assert!(arg2 != 1 || arg3 != @0x0, 18);
        assert!(arg2 != 2 || arg3 != @0x0, 18);
        assert!(arg2 != 3 || arg3 != @0x0, 18);
        assert!(arg2 != 4 || arg3 != @0x0, 18);
        assert!(arg2 != 5 || arg3 != @0x0, 18);
        assert!(arg2 != 6 || arg3 != @0x0, 18);
        if (0x2::table::contains<u8, address>(&arg0.destinations, arg2)) {
            *0x2::table::borrow_mut<u8, address>(&mut arg0.destinations, arg2) = arg3;
            *0x2::table::borrow_mut<u8, bool>(&mut arg0.enabled, arg2) = arg4;
        } else {
            0x2::table::add<u8, address>(&mut arg0.destinations, arg2, arg3);
            0x2::table::add<u8, bool>(&mut arg0.enabled, arg2, arg4);
        };
        let v0 = DistributionDestinationConfigured{
            bucket    : arg2,
            recipient : arg3,
            enabled   : arg4,
        };
        0x2::event::emit<DistributionDestinationConfigured>(v0);
    }

    public entry fun create_distribution_state(arg0: &EmissionState, arg1: &RegistryAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DistributionState{
            id           : 0x2::object::new(arg2),
            next_height  : arg0.block_height,
            enabled      : 0x2::table::new<u8, bool>(arg2),
            destinations : 0x2::table::new<u8, address>(arg2),
        };
        0x2::transfer::share_object<DistributionState>(v0);
    }

    public entry fun create_fee_subsidy_state(arg0: &PoolRegistry, arg1: &RegistryAdminCap, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u8>(&arg0.pools, arg3), 17);
        assert!(*0x2::table::borrow<address, u8>(&arg0.pools, arg3) == 1, 17);
        assert!(arg4 > 0 && arg4 <= 5000000, 15);
        assert!(arg5 >= arg4 && arg5 <= 250000000, 15);
        let v0 = FeeSubsidyState{
            id                  : 0x2::object::new(arg7),
            sponsor             : arg2,
            sui_pool            : arg3,
            per_refill_cap_mist : arg4,
            daily_cap_mist      : arg5,
            accounting_day      : 0x2::clock::timestamp_ms(arg6) / 86400000,
            spent_today_mist    : 0,
        };
        0x2::transfer::share_object<FeeSubsidyState>(v0);
    }

    public entry fun create_keeper_config(arg0: &RegistryAdminCap, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 21);
        assert!(arg2 > 0 && arg2 <= 5 * 100000000, 22);
        let v0 = KeeperCap{id: 0x2::object::new(arg4)};
        0x2::transfer::public_transfer<KeeperCap>(v0, arg1);
        let v1 = KeeperConfig{
            id                : 0x2::object::new(arg4),
            keeper            : arg1,
            paused            : true,
            daily_staking_cap : arg2,
            accounting_day    : 0x2::clock::timestamp_ms(arg3) / 86400000,
            spent_today       : 0,
        };
        0x2::transfer::share_object<KeeperConfig>(v1);
    }

    public entry fun create_lp_program(arg0: &RegistryAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 21);
        let v0 = LpProgramCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<LpProgramCap>(v0, arg1);
        let v1 = LpProgramState{
            id                 : 0x2::object::new(arg2),
            pools              : 0x2::table::new<address, u64>(arg2),
            weight_total       : 0,
            finalized          : false,
            paused             : false,
            protocol_liquidity : 0x2::balance::zero<BTEN>(),
        };
        0x2::transfer::share_object<LpProgramState>(v1);
    }

    public entry fun create_route_treasury_state(arg0: &EmissionState, arg1: &RegistryAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RouteTreasuryState{
            id                 : 0x2::object::new(arg2),
            next_height        : arg0.block_height,
            sponsor_accrued    : 0,
            pol_accrued        : 0,
            rebate_accrued     : 0,
            lp_support_accrued : 0,
            safety_accrued     : 0,
            paused             : false,
        };
        0x2::transfer::share_object<RouteTreasuryState>(v0);
    }

    public fun current_round(arg0: &EmissionState) : u64 {
        arg0.current_round
    }

    public fun decimals() : u8 {
        8
    }

    fun deliver_if_enabled(arg0: &mut 0x2::balance::Balance<BTEN>, arg1: &DistributionState, arg2: u8, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 0) {
            true
        } else if (!0x2::table::contains<u8, bool>(&arg1.enabled, arg2)) {
            true
        } else {
            !*0x2::table::borrow<u8, bool>(&arg1.enabled, arg2)
        };
        if (v0) {
            return
        };
        let v1 = *0x2::table::borrow<u8, address>(&arg1.destinations, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(arg0, arg3), arg5), v1);
        let v2 = AllocationDelivered{
            height    : arg4,
            bucket    : arg2,
            recipient : v1,
            amount    : arg3,
        };
        0x2::event::emit<AllocationDelivered>(v2);
    }

    fun distribute_fixed_allocations(arg0: &mut EmissionState, arg1: &DistributionState, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.bten_lp_vault;
        deliver_if_enabled(v0, arg1, 0, arg3 * 2500 / 10000, arg2, arg4);
        let v1 = &mut arg0.staking_vault;
        deliver_if_enabled(v1, arg1, 6, arg3 * 1000 / 10000, arg2, arg4);
        let v2 = &mut arg0.cetus_vault;
        deliver_if_enabled(v2, arg1, 1, arg3 * 100 / 10000, arg2, arg4);
        let v3 = &mut arg0.haedal_vault;
        deliver_if_enabled(v3, arg1, 5, arg3 * 100 / 10000, arg2, arg4);
        let v4 = &mut arg0.blue_vault;
        deliver_if_enabled(v4, arg1, 2, arg3 * 100 / 10000, arg2, arg4);
        let v5 = &mut arg0.magma_vault;
        deliver_if_enabled(v5, arg1, 3, arg3 * 100 / 10000, arg2, arg4);
        let v6 = &mut arg0.sui_gas_vault;
        deliver_if_enabled(v6, arg1, 4, arg3 * 100 / 10000, arg2, arg4);
    }

    public entry fun distribute_released_blocks(arg0: &mut EmissionState, arg1: &mut DistributionState, arg2: &mut 0x2::tx_context::TxContext) {
        while (arg1.next_height < arg0.block_height) {
            let v0 = arg1.next_height;
            distribute_fixed_allocations(arg0, arg1, v0, subsidy_at_height(v0), arg2);
            arg1.next_height = v0 + 1;
        };
    }

    public fun distribution_destination(arg0: &DistributionState, arg1: u8) : 0x1::option::Option<address> {
        if (!0x2::table::contains<u8, address>(&arg0.destinations, arg1)) {
            return 0x1::option::none<address>()
        };
        0x1::option::some<address>(*0x2::table::borrow<u8, address>(&arg0.destinations, arg1))
    }

    public fun distribution_is_enabled(arg0: &DistributionState, arg1: u8) : bool {
        if (!0x2::table::contains<u8, bool>(&arg0.enabled, arg1)) {
            return false
        };
        *0x2::table::borrow<u8, bool>(&arg0.enabled, arg1)
    }

    public fun distribution_next_height(arg0: &DistributionState) : u64 {
        arg0.next_height
    }

    fun drain_bten(arg0: &mut 0x2::balance::Balance<BTEN>) : 0x2::balance::Balance<BTEN> {
        0x2::balance::split<BTEN>(arg0, 0x2::balance::value<BTEN>(arg0))
    }

    fun emission_between(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v0 < arg1) {
            let v2 = (v0 / 210000 + 1) * 210000;
            let v3 = if (arg1 < v2) {
                arg1
            } else {
                v2
            };
            v1 = v1 + (v3 - arg0) * subsidy_at_height(arg0);
            v0 = v3;
        };
        v1
    }

    public fun finalize_lp_program(arg0: &mut LpProgramState, arg1: &RegistryAdminCap) {
        assert!(arg0.weight_total == 10000, 26);
        arg0.finalized = true;
    }

    public fun finalize_pool_registry(arg0: &mut PoolRegistry, arg1: &RegistryAdminCap) {
        arg0.finalized = true;
    }

    public fun haedal_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.haedal_vault)
    }

    fun init(arg0: BTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BTEN>(arg0, 8, b"BTEN", b"BlockTen", b"Trade-gated, fixed-cap routing token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTEN>>(v2, v0);
        let v3 = RouterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<RouterCap>(v3, v0);
        let v4 = RegistryAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<RegistryAdminCap>(v4, v0);
        let v5 = PoolRegistry{
            id        : 0x2::object::new(arg1),
            pools     : 0x2::table::new<address, u8>(arg1),
            finalized : false,
        };
        0x2::transfer::share_object<PoolRegistry>(v5);
        let v6 = EmissionState{
            id               : 0x2::object::new(arg1),
            cap              : v1,
            total_minted     : 0,
            block_height     : 0,
            last_slot_ts     : 0,
            pending_blocks   : 0,
            batch_trades     : 0,
            batch_fee_points : 0,
            current_round    : 0,
            trader_points    : 0x2::table::new<PointKey, u64>(arg1),
            trader_rounds    : 0x2::table::new<u64, TraderRound>(arg1),
            route_fee_vault  : 0x2::balance::zero<BTEN>(),
            trader_vault     : 0x2::balance::zero<BTEN>(),
            bten_lp_vault    : 0x2::balance::zero<BTEN>(),
            staking_vault    : 0x2::balance::zero<BTEN>(),
            cetus_vault      : 0x2::balance::zero<BTEN>(),
            haedal_vault     : 0x2::balance::zero<BTEN>(),
            blue_vault       : 0x2::balance::zero<BTEN>(),
            magma_vault      : 0x2::balance::zero<BTEN>(),
            sui_gas_vault    : 0x2::balance::zero<BTEN>(),
        };
        0x2::transfer::share_object<EmissionState>(v6);
    }

    public fun initial_subsidy() : u64 {
        5000000000
    }

    public fun keeper_address(arg0: &KeeperConfig) : address {
        arg0.keeper
    }

    public fun keeper_daily_staking_cap(arg0: &KeeperConfig) : u64 {
        arg0.daily_staking_cap
    }

    public fun keeper_is_paused(arg0: &KeeperConfig) : bool {
        arg0.paused
    }

    public fun keeper_staking_spent_today(arg0: &KeeperConfig) : u64 {
        arg0.spent_today
    }

    public fun lp_program_is_finalized(arg0: &LpProgramState) : bool {
        arg0.finalized
    }

    public fun lp_program_is_paused(arg0: &LpProgramState) : bool {
        arg0.paused
    }

    public fun lp_program_protocol_balance(arg0: &LpProgramState) : u64 {
        0x2::balance::value<BTEN>(&arg0.protocol_liquidity)
    }

    public fun lp_program_weight(arg0: &LpProgramState, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.pools, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.pools, arg1)
    }

    public fun magma_balance(arg0: &EmissionState) : u64 {
        turbos_balance(arg0)
    }

    public fun max_supply() : u64 {
        2100000000000000
    }

    public fun min_trades_per_block() : u64 {
        10
    }

    public fun pending_blocks(arg0: &EmissionState) : u64 {
        arg0.pending_blocks
    }

    public fun pool_bucket(arg0: &PoolRegistry, arg1: address) : u8 {
        if (!0x2::table::contains<address, u8>(&arg0.pools, arg1)) {
            return 255
        };
        *0x2::table::borrow<address, u8>(&arg0.pools, arg1)
    }

    fun record_atomic_route(arg0: &mut EmissionState, arg1: u64, arg2: &0x2::clock::Clock, arg3: address) {
        assert!(arg1 > 0, 0);
        advance_slots(arg0, 0x2::clock::timestamp_ms(arg2) / 1000);
        arg0.batch_trades = arg0.batch_trades + 1;
        arg0.batch_fee_points = arg0.batch_fee_points + arg1;
        let v0 = PointKey{
            round  : arg0.current_round,
            trader : arg3,
        };
        if (0x2::table::contains<PointKey, u64>(&arg0.trader_points, v0)) {
            *0x2::table::borrow_mut<PointKey, u64>(&mut arg0.trader_points, v0) = *0x2::table::borrow<PointKey, u64>(&arg0.trader_points, v0) + arg1;
        } else {
            0x2::table::add<PointKey, u64>(&mut arg0.trader_points, v0, arg1);
        };
        let v1 = RouteRecorded{
            trader       : arg3,
            fee_points   : arg1,
            batch_trades : arg0.batch_trades,
        };
        0x2::event::emit<RouteRecorded>(v1);
    }

    public fun record_qualified_route(arg0: &mut EmissionState, arg1: &RouterCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 11
    }

    public fun refill_sponsor_from_route_reserve(arg0: &mut EmissionState, arg1: &mut FeeSubsidyState, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<BTEN, 0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<BTEN, 0x2::sui::SUI>>(arg3);
        assert!(0x2::object::id_to_address(&v0) == arg1.sui_pool, 17);
        let v1 = 0x2::clock::timestamp_ms(arg7) / 86400000;
        if (v1 > arg1.accounting_day) {
            arg1.accounting_day = v1;
            arg1.spent_today_mist = 0;
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<BTEN, 0x2::sui::SUI>(arg2, arg3, true, true, arg4, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<BTEN, 0x2::sui::SUI>(&v5);
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        assert!(v8 >= arg5, 13);
        assert!(v8 <= arg1.per_refill_cap_mist, 16);
        assert!(arg1.spent_today_mist + v8 <= arg1.daily_cap_mist, 16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<BTEN, 0x2::sui::SUI>(arg2, arg3, 0x2::balance::split<BTEN>(&mut arg0.route_fee_vault, v7), 0x2::balance::zero<0x2::sui::SUI>(), v5);
        0x2::balance::join<BTEN>(&mut arg0.route_fee_vault, v2);
        arg1.spent_today_mist = arg1.spent_today_mist + v8;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg8), arg1.sponsor);
        let v9 = SponsorRefilled{
            sponsor          : arg1.sponsor,
            bten_in          : v7,
            sui_out_mist     : v8,
            spent_today_mist : arg1.spent_today_mist,
        };
        0x2::event::emit<SponsorRefilled>(v9);
    }

    public fun register_lp_program_pool(arg0: &mut LpProgramState, arg1: &PoolRegistry, arg2: &RegistryAdminCap, arg3: address, arg4: u64) {
        assert!(!arg0.finalized, 25);
        assert!(arg4 > 0 && arg0.weight_total + arg4 <= 10000, 26);
        assert!(0x2::table::contains<address, u8>(&arg1.pools, arg3), 24);
        assert!(!0x2::table::contains<address, u64>(&arg0.pools, arg3), 4);
        0x2::table::add<address, u64>(&mut arg0.pools, arg3, arg4);
        arg0.weight_total = arg0.weight_total + arg4;
    }

    public fun register_pool(arg0: &mut PoolRegistry, arg1: &RegistryAdminCap, arg2: address, arg3: u8) {
        assert!(!arg0.finalized, 5);
        assert!(arg3 <= 6, 3);
        assert!(!0x2::table::contains<address, u8>(&arg0.pools, arg2), 4);
        0x2::table::add<address, u8>(&mut arg0.pools, arg2, arg3);
    }

    public fun registry_is_finalized(arg0: &PoolRegistry) : bool {
        arg0.finalized
    }

    public fun release_genesis(arg0: &mut EmissionState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_minted == 0 && arg0.block_height == 0, 10);
        let v0 = subsidy_at_height(0);
        arg0.total_minted = v0;
        let v1 = 0x2::coin::into_balance<BTEN>(0x2::coin::mint<BTEN>(&mut arg0.cap, v0, arg1));
        allocate(arg0, v1, v0);
        arg0.block_height = 1;
        let v2 = BlocksReleased{
            blocks            : 1,
            emission          : v0,
            remaining_pending : arg0.pending_blocks,
        };
        0x2::event::emit<BlocksReleased>(v2);
    }

    public fun rotate_keeper(arg0: &mut KeeperConfig, arg1: &RegistryAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 21);
        arg0.keeper = arg2;
        arg0.paused = true;
        let v0 = KeeperCap{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<KeeperCap>(v0, arg2);
    }

    public fun route_fee_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.route_fee_vault)
    }

    public fun route_treasury_is_paused(arg0: &RouteTreasuryState) : bool {
        arg0.paused
    }

    public fun route_treasury_lp_support(arg0: &RouteTreasuryState) : u64 {
        arg0.lp_support_accrued
    }

    public fun route_treasury_next_height(arg0: &RouteTreasuryState) : u64 {
        arg0.next_height
    }

    public fun route_treasury_pol(arg0: &RouteTreasuryState) : u64 {
        arg0.pol_accrued
    }

    public fun route_treasury_rebates(arg0: &RouteTreasuryState) : u64 {
        arg0.rebate_accrued
    }

    public fun route_treasury_safety(arg0: &RouteTreasuryState) : u64 {
        arg0.safety_accrued
    }

    public fun route_treasury_sponsor(arg0: &RouteTreasuryState) : u64 {
        arg0.sponsor_accrued
    }

    public fun set_keeper_paused(arg0: &mut KeeperConfig, arg1: &RegistryAdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun set_lp_program_paused(arg0: &mut LpProgramState, arg1: &RegistryAdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun set_route_treasury_paused(arg0: &mut RouteTreasuryState, arg1: &RegistryAdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun settle(arg0: &mut EmissionState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        advance_slots(arg0, 0x2::clock::timestamp_ms(arg1) / 1000);
        let v0 = arg0.batch_trades / 10;
        let v1 = if (arg0.pending_blocks < v0) {
            arg0.pending_blocks
        } else {
            v0
        };
        let v2 = v1;
        if (v1 > 100) {
            v2 = 100;
        };
        assert!(v2 > 0, 1);
        let v3 = emission_between(arg0.block_height, arg0.block_height + v2);
        if (v3 > 0) {
            assert!(arg0.total_minted + v3 <= 2100000000000000, 2);
            arg0.total_minted = arg0.total_minted + v3;
            let v4 = 0x2::coin::into_balance<BTEN>(0x2::coin::mint<BTEN>(&mut arg0.cap, v3, arg2));
            allocate(arg0, v4, v3);
            let v5 = TraderRound{
                total_points : arg0.batch_fee_points,
                reward_total : v3 * 1000 / 10000,
                reward_paid  : 0,
            };
            0x2::table::add<u64, TraderRound>(&mut arg0.trader_rounds, arg0.current_round, v5);
        };
        arg0.block_height = arg0.block_height + v2;
        arg0.pending_blocks = arg0.pending_blocks - v2;
        arg0.batch_trades = 0;
        arg0.batch_fee_points = 0;
        arg0.current_round = arg0.current_round + 1;
        let v6 = BlocksReleased{
            blocks            : v2,
            emission          : v3,
            remaining_pending : arg0.pending_blocks,
        };
        0x2::event::emit<BlocksReleased>(v6);
    }

    public entry fun settle_and_distribute(arg0: &mut EmissionState, arg1: &mut DistributionState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        settle(arg0, arg2, arg3);
        distribute_released_blocks(arg0, arg1, arg3);
    }

    public fun staking_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.staking_vault)
    }

    public fun subsidy_at_height(arg0: u64) : u64 {
        let v0 = arg0 / 210000;
        if (v0 >= 64) {
            return 0
        };
        let v1 = 1;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 * 2;
            v2 = v2 + 1;
        };
        5000000000 / v1
    }

    public fun sui_gas_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.sui_gas_vault)
    }

    public entry fun sync_route_treasury(arg0: &EmissionState, arg1: &mut RouteTreasuryState) {
        assert!(!arg1.paused, 19);
        while (arg1.next_height < arg0.block_height) {
            let v0 = arg1.next_height;
            let v1 = subsidy_at_height(v0) * 5000 / 10000;
            let v2 = v1 * 3000 / 10000;
            let v3 = v1 * 3000 / 10000;
            let v4 = v1 * 2000 / 10000;
            let v5 = v1 * 1000 / 10000;
            let v6 = v1 * 1000 / 10000;
            let v7 = v6 + v1 - v2 - v3 - v4 - v5 - v6;
            arg1.sponsor_accrued = arg1.sponsor_accrued + v2;
            arg1.pol_accrued = arg1.pol_accrued + v3;
            arg1.rebate_accrued = arg1.rebate_accrued + v4;
            arg1.lp_support_accrued = arg1.lp_support_accrued + v5;
            arg1.safety_accrued = arg1.safety_accrued + v7;
            arg1.next_height = v0 + 1;
            let v8 = RouteTreasuryAccrued{
                height             : v0,
                sponsor            : v2,
                protocol_liquidity : v3,
                rebates            : v4,
                lp_support         : v5,
                safety             : v7,
            };
            0x2::event::emit<RouteTreasuryAccrued>(v8);
        };
    }

    public fun take_protocol_liquidity(arg0: &mut LpProgramState, arg1: &LpProgramCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BTEN> {
        assert!(!arg0.paused, 23);
        assert!(arg0.finalized && 0x2::table::contains<address, u64>(&arg0.pools, arg2), 24);
        assert!(arg3 > 0 && arg3 <= 5000000000, 0);
        let v0 = LpProgrammeReleased{
            pool_id  : arg2,
            category : 0,
            amount   : arg3,
        };
        0x2::event::emit<LpProgrammeReleased>(v0);
        0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(&mut arg0.protocol_liquidity, arg3), arg4)
    }

    public fun total_minted(arg0: &EmissionState) : u64 {
        arg0.total_minted
    }

    public fun trader_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.trader_vault)
    }

    public fun turbos_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.magma_vault)
    }

    public fun unit() : u64 {
        100000000
    }

    public fun update_coin_metadata(arg0: &EmissionState, arg1: &RegistryAdminCap, arg2: &mut 0x2::coin::CoinMetadata<BTEN>, arg3: 0x1::ascii::String, arg4: 0x1::string::String) {
        0x2::coin::update_icon_url<BTEN>(&arg0.cap, arg2, arg3);
        0x2::coin::update_description<BTEN>(&arg0.cap, arg2, arg4);
    }

    public fun withdraw_bootstrap_bten_lp(arg0: &mut EmissionState, arg1: &RegistryAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BTEN> {
        assert!(arg2 > 0, 0);
        0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(&mut arg0.bten_lp_vault, arg2), arg3)
    }

    public entry fun withdraw_bootstrap_bten_lp_to_sender(arg0: &mut EmissionState, arg1: &RegistryAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_bootstrap_bten_lp(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_registered_pool_funding(arg0: &mut EmissionState, arg1: &PoolRegistry, arg2: &RegistryAdminCap, arg3: address, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BTEN> {
        assert!(arg5 > 0, 0);
        assert!(0x2::table::contains<address, u8>(&arg1.pools, arg3), 8);
        assert!(*0x2::table::borrow<address, u8>(&arg1.pools, arg3) == arg4, 3);
        let v0 = if (arg4 == 0) {
            true
        } else if (arg4 == 1) {
            true
        } else {
            arg4 == 3
        };
        assert!(v0, 9);
        let v1 = if (arg4 == 0) {
            &mut arg0.bten_lp_vault
        } else if (arg4 == 1) {
            &mut arg0.cetus_vault
        } else {
            &mut arg0.magma_vault
        };
        0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(v1, arg5), arg6)
    }

    public entry fun withdraw_staking_rewards_to_sender(arg0: &mut EmissionState, arg1: &RegistryAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(&mut arg0.staking_vault, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_staking_tranche_to_keeper(arg0: &mut EmissionState, arg1: &mut KeeperConfig, arg2: &KeeperCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 20);
        assert!(0x2::tx_context::sender(arg5) == arg1.keeper, 21);
        assert!(arg3 > 0 && arg3 <= arg1.daily_staking_cap, 22);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 86400000;
        if (v0 > arg1.accounting_day) {
            arg1.accounting_day = v0;
            arg1.spent_today = 0;
        };
        assert!(arg1.spent_today + arg3 <= arg1.daily_staking_cap, 22);
        arg1.spent_today = arg1.spent_today + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(&mut arg0.staking_vault, arg3), arg5), arg1.keeper);
    }

    // decompiled from Move bytecode v7
}

