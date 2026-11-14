module 0x334445cd0c4bf0237846ddb45a3bac17ac9a848feb1a81590c989ec6b361370f::dlmm_vault {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        vaults: 0x2::table::Table<VaultKey, 0x2::object::ID>,
        pool_configs: vector<PoolConfig>,
    }

    struct VaultKey has copy, drop, store {
        token: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
    }

    struct PoolConfig has copy, drop, store {
        bin_step: u16,
        base_factor: u16,
    }

    struct Depth has copy, drop, store {
        ms: u64,
        liquidity: u128,
    }

    struct DlmmVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        main_pool_id: 0x2::object::ID,
        main_shape: u8,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        bin_step: u16,
        limits: 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Limits,
        perf_fee_bps: u64,
        max_pool_share_bps: u64,
        max_deposit_dev_bps: u64,
        daily_deposit_bps: u64,
        min_hold_ms: u64,
        idle_t: 0x2::balance::Balance<T0>,
        idle_q: 0x2::balance::Balance<T1>,
        ranges: vector<0x2::object::ID>,
        retired: vector<0x2::object::ID>,
        observations: 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::Observations,
        turnover: 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::Turnover,
        last_rebalance_ms: u64,
        spot_sqrt: u128,
        spot_ms: u64,
        rebalance_paused: bool,
        total_shares: u64,
        depth: vector<Depth>,
        depth_next: u64,
        deposits: 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::Turnover,
        opened_ms: u64,
        totals: Totals,
    }

    struct Totals has copy, drop, store {
        deposited_t: u64,
        withdrawn_t: u64,
        withdrawn_q: u64,
        fees_t: u64,
        fees_q: u64,
        perf_t: u64,
        perf_q: u64,
    }

    struct RangeKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct RetiredKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Deposit<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
        deposited_ms: u64,
    }

    struct Ticket {
        version: u64,
        owner: 0x2::object::ID,
        ref_sqrt: u128,
        value: u64,
        t_value: u64,
        q_value: u64,
        added: u64,
        now: u64,
    }

    struct VaultOpened has copy, drop {
        vault_id: 0x2::object::ID,
        main_pool_id: 0x2::object::ID,
        main_shape: u8,
        token: 0x1::ascii::String,
        quote: 0x1::ascii::String,
        perf_fee_bps: u64,
        max_pool_share_bps: u64,
        min_hold_ms: u64,
    }

    struct PoolAdopted has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        bin_step: u16,
        active_id: u32,
        ref_sqrt_price: u128,
    }

    struct PoolCreated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        bin_step: u16,
        base_factor: u16,
        active_id: u32,
        ref_sqrt_price: u128,
    }

    struct Observed has copy, drop {
        vault_id: 0x2::object::ID,
        sqrt_price: u128,
        liquidity: u128,
        timestamp_ms: u64,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_id: 0x2::object::ID,
        owner: address,
        tokens: u64,
        value: u64,
        vault_value: u64,
        sqrt_price: u128,
        shares: u64,
        total_shares: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        tokens: u64,
        quote: u64,
        total_shares: u64,
    }

    struct DepositSplit has copy, drop {
        vault_id: 0x2::object::ID,
        from_id: 0x2::object::ID,
        new_id: 0x2::object::ID,
        shares: u64,
    }

    struct DepositsMerged has copy, drop {
        vault_id: 0x2::object::ID,
        into_id: 0x2::object::ID,
        from_id: 0x2::object::ID,
        shares: u64,
        deposited_ms: u64,
    }

    struct FeesCollected has copy, drop {
        vault_id: 0x2::object::ID,
        fee_t: u64,
        fee_q: u64,
        perf_t: u64,
        perf_q: u64,
    }

    struct RangeAdded has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lower_bin: u32,
        upper_bin: u32,
        tokens: u64,
        quote: u64,
    }

    struct RangeRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        numerator: u128,
        denominator: u128,
        tokens: u64,
        quote: u64,
        retired: bool,
    }

    struct Rebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        ref_sqrt_price: u128,
        value: u64,
        added_quote: u64,
        turnover_24h: u64,
        ranges: u64,
        timestamp_ms: u64,
    }

    struct RangeClosed has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct RewardCollected has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        amount: u64,
        to: address,
    }

    struct RebalancePauseChanged has copy, drop {
        vault_id: 0x2::object::ID,
        paused: bool,
    }

    struct PoolConfigSet has copy, drop {
        bin_step: u16,
        base_factor: u16,
        allowed: bool,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    public fun remove<T0, T1>(arg0: &mut Ticket, arg1: &mut DlmmVault<T0, T1>, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: 0x2::object::ID, arg7: u128, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_pool<T0, T1>(arg1, arg3);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.ranges, &arg6), 849);
        let (v0, v1, v2, v3) = take_position<T0, T1>(arg1, arg3, arg4, arg5, arg6, arg7, arg8, true, arg9, arg10);
        keep<T0, T1>(arg1, arg2, v0, v1, v2, v3, arg10);
    }

    public fun split<T0, T1>(arg0: &mut Deposit<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Deposit<T0, T1> {
        assert!(arg1 > 0 && arg1 < arg0.shares, 827);
        arg0.shares = arg0.shares - arg1;
        let v0 = Deposit<T0, T1>{
            id           : 0x2::object::new(arg2),
            vault_id     : arg0.vault_id,
            shares       : arg1,
            deposited_ms : arg0.deposited_ms,
        };
        let v1 = DepositSplit{
            vault_id : arg0.vault_id,
            from_id  : 0x2::object::id<Deposit<T0, T1>>(arg0),
            new_id   : 0x2::object::id<Deposit<T0, T1>>(&v0),
            shares   : arg1,
        };
        0x2::event::emit<DepositSplit>(v1);
        v0
    }

    public fun add<T0, T1>(arg0: &mut Ticket, arg1: &mut DlmmVault<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: vector<u32>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_pool<T0, T1>(arg1, arg2);
        let (v0, v1) = 0x334445cd0c4bf0237846ddb45a3bac17ac9a848feb1a81590c989ec6b361370f::bins::span(&arg5);
        assert!(0x1::vector::length<u64>(&arg6) == 0x1::vector::length<u32>(&arg5), 848);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.retired) < 16, 855);
        let v2 = 0;
        assert!(!0x1::vector::contains<u64>(&arg6, &v2), 856);
        let v3 = sum(&arg6);
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg2);
        let (v5, v6) = 0x334445cd0c4bf0237846ddb45a3bac17ac9a848feb1a81590c989ec6b361370f::bins::side(v4, v0, v1);
        check_add<T0, T1>(arg0, arg1, v4, v0, v1, v5, v6, v3);
        let (v7, v8) = if (v5) {
            (arg6, zeros(0x1::vector::length<u32>(&arg5)))
        } else {
            (zeros(0x1::vector::length<u32>(&arg5)), arg6)
        };
        let (v9, v10) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg2, arg5, v7, v8, arg3, arg4, arg7, arg8);
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v11);
        assert!(v5 && v14 == 0 && v13 <= v3 || v13 == 0 && v14 <= v3, 848);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg2, &mut v12, v11, 0x2::balance::split<T0>(&mut arg1.idle_t, v13), 0x2::balance::split<T1>(&mut arg1.idle_q, v14), arg4);
        arg0.added = arg0.added + v14;
        let v15 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v12);
        let v16 = RangeKey{id: v15};
        0x2::dynamic_object_field::add<RangeKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg1.id, v16, v12);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.ranges, v15);
        let v17 = RangeAdded{
            vault_id    : 0x2::object::id<DlmmVault<T0, T1>>(arg1),
            position_id : v15,
            lower_bin   : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0),
            upper_bin   : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1),
            tokens      : v13,
            quote       : v14,
        };
        0x2::event::emit<RangeAdded>(v17);
    }

    public fun adopt_pool<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg2, arg5);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pool_id), 837);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg3);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg3);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg3);
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(v2);
        arg0.bin_step = v0;
        let v3 = PoolAdopted{
            vault_id       : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            pool_id        : v2,
            bin_step       : v0,
            active_id      : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1),
            ref_sqrt_price : check_adopt<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg4)),
        };
        0x2::event::emit<PoolAdopted>(v3);
    }

    fun amounts<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.idle_t);
        let v1 = 0x2::balance::value<T1>(&arg0.idle_q);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg0.ranges)) {
            let (v3, v4) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::get_position_amounts<T0, T1>(arg1, *0x1::vector::borrow<0x2::object::ID>(&arg0.ranges, v2));
            v0 = v0 + v3;
            v1 = v1 + v4;
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun assert_can_deposit<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config) {
        assert_version(arg1);
        assert!(!0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::paused(arg2), 825);
        let v0 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::open_params<T0, T1>(arg2);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::open_enabled(&v0), 823);
        assert!(!arg0.rebalance_paused, 825);
    }

    fun assert_main<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: 0x2::object::ID, arg2: u8) {
        assert!(arg1 == arg0.main_pool_id && arg2 == arg0.main_shape, 824);
    }

    fun assert_pool<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pool_id), 836);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.pool_id), 824);
    }

    fun assert_ticket<T0, T1>(arg0: &Ticket, arg1: &DlmmVault<T0, T1>) {
        assert!(arg0.version == 1, 851);
        assert!(arg0.owner == 0x2::object::id<DlmmVault<T0, T1>>(arg1), 835);
    }

    fun assert_version(arg0: &Registry) {
        assert!(arg0.version == 1, 820);
    }

    public fun begin<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : Ticket {
        assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg2, arg5);
        assert_pool<T0, T1>(arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = prepare_ticket<T0, T1>(arg0, v0);
        let (v2, v3) = amounts<T0, T1>(arg0, arg3);
        make_ticket<T0, T1>(arg0, v1, v2, v3, v0)
    }

    public fun bin_step<T0, T1>(arg0: &DlmmVault<T0, T1>) : u16 {
        arg0.bin_step
    }

    fun check_add<T0, T1>(arg0: &Ticket, arg1: &DlmmVault<T0, T1>, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: bool, arg6: bool, arg7: u64) {
        let (v0, v1) = 0x334445cd0c4bf0237846ddb45a3bac17ac9a848feb1a81590c989ec6b361370f::bins::edges(arg3, arg4, arg1.bin_step);
        check_add_at<T0, T1>(arg0, arg1, v0, v1, arg5, arg6, arg7);
    }

    fun check_add_at<T0, T1>(arg0: &Ticket, arg1: &DlmmVault<T0, T1>, arg2: u128, arg3: u128, arg4: bool, arg5: bool, arg6: u64) {
        let v0 = &arg1.limits;
        let v1 = arg1.spot_sqrt;
        assert!(arg1.spot_ms > 0 && arg0.now <= arg1.spot_ms + 120000, 854);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::within_deviation(v1, arg0.ref_sqrt, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_dev_bps(v0)), 829);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.ranges) < 8, 842);
        assert!(arg6 > 0, 826);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::within_band(arg2, arg3, arg0.ref_sqrt, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::band_low_bps(v0), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::band_high_bps(v0)), 843);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::side_ok(arg2, arg3, arg0.ref_sqrt, arg4, arg5), 844);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::side_ok(arg2, arg3, v1, arg4, arg5), 844);
        if (arg4) {
            assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::above_premium(arg2, arg0.ref_sqrt, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::min_ask_premium_bps(v0)), 847);
            assert!(arg6 <= 0x2::balance::value<T0>(&arg1.idle_t), 848);
        } else {
            assert!(!0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::token_heavy(arg0.t_value, arg0.q_value, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_token_value_bps(v0)), 845);
            assert!(arg6 <= 0x2::balance::value<T1>(&arg1.idle_q), 848);
        };
    }

    fun check_adopt<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: &Registry, arg2: u16, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: u64) : u128 {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PoolConfig>(&arg1.pool_configs)) {
            if (0x1::vector::borrow<PoolConfig>(&arg1.pool_configs, v1).bin_step == arg2) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 838);
        let v2 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::reference(&arg0.observations, arg4);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::within_deviation(0x334445cd0c4bf0237846ddb45a3bac17ac9a848feb1a81590c989ec6b361370f::bins::sqrt_price(arg3, arg2), v2, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_dev_bps(&arg0.limits)), 829);
        v2
    }

    fun check_new_pool<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: &Registry, arg2: u16, arg3: u16, arg4: u32, arg5: u64) : u128 {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pool_id), 837);
        let v0 = PoolConfig{
            bin_step    : arg2,
            base_factor : arg3,
        };
        assert!(0x1::vector::contains<PoolConfig>(&arg1.pool_configs, &v0), 838);
        let v1 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::reference(&arg0.observations, arg5);
        0x334445cd0c4bf0237846ddb45a3bac17ac9a848feb1a81590c989ec6b361370f::bins::assert_bin_of(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4), arg2, v1);
        v1
    }

    fun check_withdraw<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: &Deposit<T0, T1>, arg2: u64) {
        assert!(arg1.vault_id == 0x2::object::id<DlmmVault<T0, T1>>(arg0), 835);
        assert!(arg2 >= arg1.deposited_ms + arg0.min_hold_ms, 828);
    }

    public fun close_retired<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_pool<T0, T1>(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.retired, &arg5);
        assert!(v0, 849);
        let v2 = &mut arg0.id;
        let (v3, v4) = position_fees<T0, T1>(v2, arg5, true, arg2, arg3, arg4, arg6, arg7);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.retired, v1);
        let v5 = RetiredKey{id: arg5};
        let v6 = 0x2::dynamic_object_field::remove<RetiredKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.id, v5);
        assert!(is_empty(&v6), 853);
        let (v7, v8, v9) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::close_position<T0, T1>(arg2, v6, arg3, arg4, arg6, arg7);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::destroy_close_position_cert(v7, arg4);
        keep<T0, T1>(arg0, arg1, v8, v9, v3, v4, arg7);
        let v10 = RangeClosed{
            vault_id    : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            position_id : arg5,
        };
        0x2::event::emit<RangeClosed>(v10);
    }

    public fun collect<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_pool<T0, T1>(arg0, arg2);
        collect_all<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun collect_all<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0.ranges);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = &mut arg0.id;
            let (v5, v6) = position_fees<T0, T1>(v4, *0x1::vector::borrow<0x2::object::ID>(&arg0.ranges, v3), false, arg2, arg3, arg4, arg5, arg6);
            0x2::balance::join<T0>(&mut v1, v5);
            0x2::balance::join<T1>(&mut v2, v6);
            v3 = v3 + 1;
        };
        let (v7, v8) = take_fees<T0, T1>(arg0, v1, v2);
        pay_fees<T0, T1>(v7, v8, arg1, arg6);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut DlmmVault<T0, T1>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_pool<T0, T1>(arg0, arg2);
        let v0 = 0x1::vector::contains<0x2::object::ID>(&arg0.retired, &arg5);
        assert!(v0 || 0x1::vector::contains<0x2::object::ID>(&arg0.ranges, &arg5), 849);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg5, arg4, arg6);
        let v1 = if (v0) {
            let v2 = RetiredKey{id: arg5};
            0x2::dynamic_object_field::borrow_mut<RetiredKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.id, v2)
        } else {
            let v3 = RangeKey{id: arg5};
            0x2::dynamic_object_field::borrow_mut<RangeKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.id, v3)
        };
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, v1, arg3, arg4, arg7);
        let v5 = 0x2::balance::value<T2>(&v4);
        if (v5 == 0) {
            0x2::balance::destroy_zero<T2>(v4);
            return
        };
        let v6 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::fee_recipient(arg1);
        let v7 = RewardCollected{
            vault_id    : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            position_id : arg5,
            coin        : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T2>()),
            amount      : v5,
            to          : v6,
        };
        0x2::event::emit<RewardCollected>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg7), v6);
    }

    public fun create_pool<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::registry::Registry, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: u16, arg7: u16, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg2, arg10);
        let v0 = check_new_pool<T0, T1>(arg0, arg1, arg6, arg7, arg8, 0x2::clock::timestamp_ms(arg9));
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::registry::create_pool_v2<T0, T1>(arg3, arg6, arg7, arg8, 0x1::string::utf8(b""), arg4, arg5, arg9, arg10);
        let v3 = v2;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::registry::destroy_receipt<T0, T1>(v1, v3, arg5);
        record_pool<T0, T1>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(&v3), arg6, arg7, arg8, v0);
    }

    fun deposit_at<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Deposit<T0, T1> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 826);
        let v1 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::reference(&arg0.observations, arg6);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::within_deviation(arg2, v1, arg0.max_deposit_dev_bps), 829);
        let v2 = if (arg2 < v1) {
            arg2
        } else {
            v1
        };
        let v3 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::token_value(v0, v2);
        assert!(v3 > 0, 833);
        assert!(v3 >= 10000, 834);
        let v4 = (0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::token_value(arg4, v2) as u128) + (arg5 as u128);
        let v5 = if (v4 == 0) {
            0
        } else {
            (((v3 as u128) * (arg5 as u128) / v4 * (arg3 as u128) / 1000000) as u64)
        };
        let v6 = if (arg0.total_shares == 0 || v4 == 0) {
            v3
        } else {
            ((((v3 - v5) as u128) * (arg0.total_shares as u128) / v4) as u64)
        };
        assert!(v6 > 0, 826);
        let v7 = max_size<T0, T1>(arg0, arg6);
        assert!(v4 + (v3 as u128) <= v7, 830);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::add_turnover(&mut arg0.deposits, arg6, v3);
        assert!((0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::turnover(&arg0.deposits, arg6) as u256) * (10000 as u256) <= (v7 as u256) * (arg0.daily_deposit_bps as u256), 831);
        0x2::balance::join<T0>(&mut arg0.idle_t, arg1);
        arg0.total_shares = arg0.total_shares + v6;
        arg0.totals.deposited_t = arg0.totals.deposited_t + v0;
        let v8 = Deposit<T0, T1>{
            id           : 0x2::object::new(arg7),
            vault_id     : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            shares       : v6,
            deposited_ms : arg6,
        };
        let v9 = if (v4 > 18446744073709551615) {
            18446744073709551615
        } else {
            v4
        };
        let v10 = Deposited{
            vault_id     : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            deposit_id   : 0x2::object::id<Deposit<T0, T1>>(&v8),
            owner        : 0x2::tx_context::sender(arg7),
            tokens       : v0,
            value        : v3,
            vault_value  : (v9 as u64),
            sqrt_price   : v2,
            shares       : v6,
            total_shares : arg0.total_shares,
        };
        0x2::event::emit<Deposited>(v10);
        v8
    }

    public fun deposit_bluefin<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Deposit<T0, T1> {
        let (v0, _, _, v3) = read_bluefin<T0, T1>(arg0, arg3);
        deposit_on<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, v0, v3, arg8, arg9)
    }

    public fun deposit_cetus<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Deposit<T0, T1> {
        let (v0, _, _, v3) = read_cetus<T0, T1>(arg0, arg3);
        deposit_on<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, v0, v3, arg8, arg9)
    }

    public fun deposit_cetus_qf<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Deposit<T0, T1> {
        let (v0, _, _, v3) = read_cetus_qf<T0, T1>(arg0, arg3);
        deposit_on<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, v0, v3, arg8, arg9)
    }

    fun deposit_on<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: 0x2::coin::Coin<T0>, arg7: u128, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Deposit<T0, T1> {
        assert_pool<T0, T1>(arg0, arg3);
        assert_can_deposit<T0, T1>(arg0, arg1, arg2);
        collect_all<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg9, arg10);
        let (v0, v1) = amounts<T0, T1>(arg0, arg3);
        deposit_at<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg6), arg7, arg8, v0, v1, 0x2::clock::timestamp_ms(arg9), arg10)
    }

    public fun deposit_shares<T0, T1>(arg0: &Deposit<T0, T1>) : u64 {
        arg0.shares
    }

    public fun deposit_vault_id<T0, T1>(arg0: &Deposit<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun deposited_ms<T0, T1>(arg0: &Deposit<T0, T1>) : u64 {
        arg0.deposited_ms
    }

    public fun deposits_24h<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: u64) : u64 {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::turnover(&arg0.deposits, arg1)
    }

    public fun finish<T0, T1>(arg0: Ticket, arg1: &mut DlmmVault<T0, T1>) {
        assert_ticket<T0, T1>(&arg0, arg1);
        let Ticket {
            version  : _,
            owner    : _,
            ref_sqrt : v2,
            value    : v3,
            t_value  : _,
            q_value  : _,
            added    : v6,
            now      : v7,
        } = arg0;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::add_turnover(&mut arg1.turnover, v7, v6);
        let v8 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::turnover(&arg1.turnover, v7);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::turnover_ok(v8, v3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_turnover_bps(&arg1.limits)), 846);
        let v9 = Rebalanced{
            vault_id       : 0x2::object::id<DlmmVault<T0, T1>>(arg1),
            ref_sqrt_price : v2,
            value          : v3,
            added_quote    : v6,
            turnover_24h   : v8,
            ranges         : 0x1::vector::length<0x2::object::ID>(&arg1.ranges),
            timestamp_ms   : v7,
        };
        0x2::event::emit<Rebalanced>(v9);
    }

    fun finish_withdraw<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg2 == arg3) {
            0x2::balance::join<T0>(&mut arg4, 0x2::balance::withdraw_all<T0>(&mut arg0.idle_t));
            0x2::balance::join<T1>(&mut arg5, 0x2::balance::withdraw_all<T1>(&mut arg0.idle_q));
        };
        arg0.total_shares = arg3 - arg2;
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = 0x2::balance::value<T1>(&arg5);
        arg0.totals.withdrawn_t = arg0.totals.withdrawn_t + v0;
        arg0.totals.withdrawn_q = arg0.totals.withdrawn_q + v1;
        let v2 = Withdrawn{
            vault_id     : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            deposit_id   : arg1,
            owner        : 0x2::tx_context::sender(arg6),
            shares       : arg2,
            tokens       : v0,
            quote        : v1,
            total_shares : arg0.total_shares,
        };
        0x2::event::emit<Withdrawn>(v2);
        (0x2::coin::from_balance<T0>(arg4, arg6), 0x2::coin::from_balance<T1>(arg5, arg6))
    }

    public fun idle<T0, T1>(arg0: &DlmmVault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.idle_t), 0x2::balance::value<T1>(&arg0.idle_q))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id           : 0x2::object::new(arg0),
            version      : 1,
            vaults       : 0x2::table::new<VaultKey, 0x2::object::ID>(arg0),
            pool_configs : 0x1::vector::empty<PoolConfig>(),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    fun is_empty(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position) : bool {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::liquidity_shares(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&v0)) {
            if (*0x1::vector::borrow<u128>(&v0, v1) > 0) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun keep<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.idle_t, arg2);
        0x2::balance::join<T1>(&mut arg0.idle_q, arg3);
        let (v0, v1) = take_fees<T0, T1>(arg0, arg4, arg5);
        pay_fees<T0, T1>(v0, v1, arg1, arg6);
    }

    public fun last_rebalance_ms<T0, T1>(arg0: &DlmmVault<T0, T1>) : u64 {
        arg0.last_rebalance_ms
    }

    public fun limits<T0, T1>(arg0: &DlmmVault<T0, T1>) : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Limits {
        arg0.limits
    }

    public fun main_pool<T0, T1>(arg0: &DlmmVault<T0, T1>) : (0x2::object::ID, u8) {
        (arg0.main_pool_id, arg0.main_shape)
    }

    fun make_ticket<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: u128, arg2: u64, arg3: u64, arg4: u64) : Ticket {
        let v0 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::token_value(arg2, arg1);
        Ticket{
            version  : 1,
            owner    : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            ref_sqrt : arg1,
            value    : v0 + arg3,
            t_value  : v0,
            q_value  : arg3,
            added    : 0,
            now      : arg4,
        }
    }

    public fun max_ranges() : u64 {
        8
    }

    public fun max_retired() : u64 {
        16
    }

    fun max_size<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: u64) : u128 {
        let v0 = (median_depth<T0, T1>(arg0, arg1) as u256) * (arg0.max_pool_share_bps as u256) / (10000 as u256);
        let v1 = 340282366920938463463374607431768211455;
        if (v0 > (v1 as u256)) {
            v1
        } else {
            (v0 as u128)
        }
    }

    public fun max_size_at<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: u64) : u128 {
        max_size<T0, T1>(arg0, arg1)
    }

    fun median_depth<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: u64) : u128 {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Depth>(&arg0.depth)) {
            let v2 = 0x1::vector::borrow<Depth>(&arg0.depth, v1);
            if (v2.ms + 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::ref_window_ms() >= arg1 && v2.ms <= arg1) {
                0x1::vector::push_back<u128>(&mut v0, v2.liquidity);
                let v3 = 0x1::vector::length<u128>(&v0) - 1;
                while (v3 > 0 && *0x1::vector::borrow<u128>(&v0, v3 - 1) > v2.liquidity) {
                    0x1::vector::swap<u128>(&mut v0, v3 - 1, v3);
                    v3 = v3 - 1;
                };
            };
            v1 = v1 + 1;
        };
        let v4 = 0x1::vector::length<u128>(&v0);
        assert!(v4 >= 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::min_observations(), 832);
        if (v4 % 2 == 1) {
            *0x1::vector::borrow<u128>(&v0, v4 / 2)
        } else {
            *0x1::vector::borrow<u128>(&v0, v4 / 2 - 1) / 2 + *0x1::vector::borrow<u128>(&v0, v4 / 2) / 2
        }
    }

    public fun merge<T0, T1>(arg0: &mut Deposit<T0, T1>, arg1: Deposit<T0, T1>) {
        let Deposit {
            id           : v0,
            vault_id     : v1,
            shares       : v2,
            deposited_ms : v3,
        } = arg1;
        let v4 = v0;
        assert!(v1 == arg0.vault_id, 835);
        arg0.shares = arg0.shares + v2;
        if (v3 > arg0.deposited_ms) {
            arg0.deposited_ms = v3;
        };
        let v5 = DepositsMerged{
            vault_id     : v1,
            into_id      : 0x2::object::id<Deposit<T0, T1>>(arg0),
            from_id      : 0x2::object::uid_to_inner(&v4),
            shares       : v2,
            deposited_ms : arg0.deposited_ms,
        };
        0x2::event::emit<DepositsMerged>(v5);
        0x2::object::delete(v4);
    }

    public fun migrate(arg0: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::AdminCap, arg1: &mut Registry) {
        assert!(arg1.version < 1, 821);
        arg1.version = 1;
        let v0 = Migrated{
            from : arg1.version,
            to   : 1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun min_deposit_value() : u64 {
        10000
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun observations<T0, T1>(arg0: &DlmmVault<T0, T1>) : &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::Observations {
        &arg0.observations
    }

    entry fun observe_bluefin<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg2, arg5);
        let (v0, v1, v2, _) = read_bluefin<T0, T1>(arg0, arg3);
        observe_reserves<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg4), v0, v1, v2);
    }

    entry fun observe_cetus<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg2, arg5);
        let (v0, v1, v2, _) = read_cetus<T0, T1>(arg0, arg3);
        observe_reserves<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg4), v0, v1, v2);
    }

    entry fun observe_cetus_qf<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg2, arg5);
        let (v0, v1, v2, _) = read_cetus_qf<T0, T1>(arg0, arg3);
        observe_reserves<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg4), v0, v1, v2);
    }

    fun observe_reserves<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: u64, arg2: u128, arg3: u64, arg4: u64) {
        let v0 = (arg4 as u128) + (0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::token_value(arg3, arg2) as u128);
        arg0.spot_sqrt = arg2;
        arg0.spot_ms = arg1;
        let v1 = Depth{
            ms        : arg1,
            liquidity : v0,
        };
        if (0x1::vector::length<Depth>(&arg0.depth) < 32) {
            0x1::vector::push_back<Depth>(&mut arg0.depth, v1);
        } else {
            *0x1::vector::borrow_mut<Depth>(&mut arg0.depth, arg0.depth_next) = v1;
        };
        arg0.depth_next = (arg0.depth_next + 1) % 32;
        let v2 = Observed{
            vault_id     : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            sqrt_price   : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::observe(&mut arg0.observations, arg1, arg2),
            liquidity    : v0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<Observed>(v2);
    }

    public fun open_bluefin<T0, T1>(arg0: &mut Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        open_on<T0, T1>(arg0, arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0, arg3, arg4);
    }

    public fun open_cetus<T0, T1>(arg0: &mut Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        open_on<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 1, arg3, arg4);
    }

    public fun open_cetus_qf<T0, T1>(arg0: &mut Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        open_on<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2), 2, arg3, arg4);
    }

    fun open_on<T0, T1>(arg0: &mut Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: 0x2::object::ID, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg1, arg5);
        assert!(!0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::paused(arg1), 825);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::registry::is_right_order<T0, T1>(), 839);
        0x2::transfer::share_object<DlmmVault<T0, T1>>(register<T0, T1>(arg0, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4), arg5));
    }

    public fun opened_ms<T0, T1>(arg0: &DlmmVault<T0, T1>) : u64 {
        arg0.opened_ms
    }

    fun pay_fees<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::fee_recipient(arg2);
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg3), v0);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
        if (0x2::balance::value<T1>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg1, arg3), v0);
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
    }

    public fun pool_config_fields(arg0: &PoolConfig) : (u16, u16) {
        (arg0.bin_step, arg0.base_factor)
    }

    public fun pool_configs(arg0: &Registry) : vector<PoolConfig> {
        arg0.pool_configs
    }

    public fun pool_id<T0, T1>(arg0: &DlmmVault<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    fun position_fees<T0, T1>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg3, arg1, arg5, arg6);
        let v0 = if (arg2) {
            let v1 = RetiredKey{id: arg1};
            0x2::dynamic_object_field::borrow_mut<RetiredKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg0, v1)
        } else {
            let v2 = RangeKey{id: arg1};
            0x2::dynamic_object_field::borrow_mut<RangeKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(arg0, v2)
        };
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg3, v0, arg4, arg5, arg7)
    }

    fun prepare_ticket<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: u64) : u128 {
        assert!(!arg0.rebalance_paused, 840);
        assert!(arg0.last_rebalance_ms == 0 || arg1 >= arg0.last_rebalance_ms + 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::min_interval_ms(&arg0.limits), 841);
        arg0.last_rebalance_ms = arg1;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::reference(&arg0.observations, arg1)
    }

    public fun ranges<T0, T1>(arg0: &DlmmVault<T0, T1>) : vector<0x2::object::ID> {
        arg0.ranges
    }

    fun read_bluefin<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u64, u64, u64) {
        assert_main<T0, T1>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0);
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg1);
        (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), v0, v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg1))
    }

    fun read_cetus<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u128, u64, u64, u64) {
        assert_main<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg1);
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x2::balance::value<T0>(v0), 0x2::balance::value<T1>(v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1))
    }

    fun read_cetus_qf<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>) : (u128, u64, u64, u64) {
        assert_main<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1), 2);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T1, T0>(arg1);
        (0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), true), 0x2::balance::value<T0>(v1), 0x2::balance::value<T1>(v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T0>(arg1))
    }

    public fun rebalance_paused<T0, T1>(arg0: &DlmmVault<T0, T1>) : bool {
        arg0.rebalance_paused
    }

    public fun reclaim_crossed<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_pool<T0, T1>(arg0, arg2);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.ranges, &arg5), 849);
        let v0 = RangeKey{id: arg5};
        assert!(0x334445cd0c4bf0237846ddb45a3bac17ac9a848feb1a81590c989ec6b361370f::bins::crossed(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg2), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(0x2::dynamic_object_field::borrow<RangeKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.id, v0))), 850);
        let (v1, v2, v3, v4) = take_position<T0, T1>(arg0, arg2, arg3, arg4, arg5, 1, 1, true, arg6, arg7);
        keep<T0, T1>(arg0, arg1, v1, v2, v3, v4, arg7);
    }

    fun record_pool<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: 0x2::object::ID, arg2: u16, arg3: u16, arg4: u32, arg5: u128) {
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.bin_step = arg2;
        let v0 = PoolCreated{
            vault_id       : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            pool_id        : arg1,
            bin_step       : arg2,
            base_factor    : arg3,
            active_id      : arg4,
            ref_sqrt_price : arg5,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    fun register<T0, T1>(arg0: &mut Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : DlmmVault<T0, T1> {
        let v0 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::open_params<T0, T1>(arg1);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::open_enabled(&v0), 823);
        assert!(arg2 == 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::open_pool_id(&v0), 824);
        let v1 = VaultKey{
            token : 0x1::type_name::with_original_ids<T0>(),
            quote : 0x1::type_name::with_original_ids<T1>(),
        };
        assert!(!0x2::table::contains<VaultKey, 0x2::object::ID>(&arg0.vaults, v1), 822);
        let v2 = Totals{
            deposited_t : 0,
            withdrawn_t : 0,
            withdrawn_q : 0,
            fees_t      : 0,
            fees_q      : 0,
            perf_t      : 0,
            perf_q      : 0,
        };
        let v3 = DlmmVault<T0, T1>{
            id                  : 0x2::object::new(arg5),
            main_pool_id        : arg2,
            main_shape          : arg3,
            pool_id             : 0x1::option::none<0x2::object::ID>(),
            bin_step            : 0,
            limits              : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::open_limits(&v0),
            perf_fee_bps        : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::perf_fee_bps(&v0),
            max_pool_share_bps  : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_pool_share_bps(&v0),
            max_deposit_dev_bps : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_deposit_dev_bps(&v0),
            daily_deposit_bps   : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::daily_deposit_bps(&v0),
            min_hold_ms         : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::min_hold_ms(&v0),
            idle_t              : 0x2::balance::zero<T0>(),
            idle_q              : 0x2::balance::zero<T1>(),
            ranges              : 0x1::vector::empty<0x2::object::ID>(),
            retired             : 0x1::vector::empty<0x2::object::ID>(),
            observations        : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::new_observations(),
            turnover            : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::new_turnover(),
            last_rebalance_ms   : 0,
            spot_sqrt           : 0,
            spot_ms             : 0,
            rebalance_paused    : false,
            total_shares        : 0,
            depth               : 0x1::vector::empty<Depth>(),
            depth_next          : 0,
            deposits            : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::new_turnover(),
            opened_ms           : arg4,
            totals              : v2,
        };
        0x2::table::add<VaultKey, 0x2::object::ID>(&mut arg0.vaults, v1, 0x2::object::id<DlmmVault<T0, T1>>(&v3));
        let v4 = VaultOpened{
            vault_id           : 0x2::object::id<DlmmVault<T0, T1>>(&v3),
            main_pool_id       : arg2,
            main_shape         : arg3,
            token              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            quote              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            perf_fee_bps       : v3.perf_fee_bps,
            max_pool_share_bps : v3.max_pool_share_bps,
            min_hold_ms        : v3.min_hold_ms,
        };
        0x2::event::emit<VaultOpened>(v4);
        v3
    }

    public fun retired<T0, T1>(arg0: &DlmmVault<T0, T1>) : vector<0x2::object::ID> {
        arg0.retired
    }

    public fun set_pool_config(arg0: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::AdminCap, arg1: &mut Registry, arg2: u16, arg3: u16, arg4: bool) {
        let v0 = PoolConfig{
            bin_step    : arg2,
            base_factor : arg3,
        };
        let (v1, v2) = 0x1::vector::index_of<PoolConfig>(&arg1.pool_configs, &v0);
        if (arg4 && !v1) {
            0x1::vector::push_back<PoolConfig>(&mut arg1.pool_configs, v0);
        };
        if (!arg4 && v1) {
            0x1::vector::remove<PoolConfig>(&mut arg1.pool_configs, v2);
        };
        let v3 = PoolConfigSet{
            bin_step    : arg2,
            base_factor : arg3,
            allowed     : arg4,
        };
        0x2::event::emit<PoolConfigSet>(v3);
    }

    public fun set_rebalance_paused<T0, T1>(arg0: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::AdminCap, arg1: &mut DlmmVault<T0, T1>, arg2: bool) {
        arg1.rebalance_paused = arg2;
        let v0 = RebalancePauseChanged{
            vault_id : 0x2::object::id<DlmmVault<T0, T1>>(arg1),
            paused   : arg2,
        };
        0x2::event::emit<RebalancePauseChanged>(v0);
    }

    public fun spot<T0, T1>(arg0: &DlmmVault<T0, T1>) : (u128, u64) {
        (arg0.spot_sqrt, arg0.spot_ms)
    }

    fun sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + (*0x1::vector::borrow<u64>(arg0, v1) as u128);
            v1 = v1 + 1;
        };
        assert!(v0 <= 18446744073709551615, 848);
        (v0 as u64)
    }

    fun take_fees<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::balance::value<T1>(&arg2);
        let (v2, v3) = if (arg0.total_shares == 0) {
            (v0, v1)
        } else {
            (mul_div(v0, arg0.perf_fee_bps, 10000), mul_div(v1, arg0.perf_fee_bps, 10000))
        };
        0x2::balance::join<T0>(&mut arg0.idle_t, arg1);
        0x2::balance::join<T1>(&mut arg0.idle_q, arg2);
        arg0.totals.fees_t = arg0.totals.fees_t + v0;
        arg0.totals.fees_q = arg0.totals.fees_q + v1;
        arg0.totals.perf_t = arg0.totals.perf_t + v2;
        arg0.totals.perf_q = arg0.totals.perf_q + v3;
        if (v0 > 0 || v1 > 0) {
            let v4 = FeesCollected{
                vault_id : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
                fee_t    : v0,
                fee_q    : v1,
                perf_t   : v2,
                perf_q   : v3,
            };
            0x2::event::emit<FeesCollected>(v4);
        };
        (0x2::balance::split<T0>(&mut arg1, v2), 0x2::balance::split<T1>(&mut arg2, v3))
    }

    fun take_idle<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: Deposit<T0, T1>) : (0x2::object::ID, u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let Deposit {
            id           : v0,
            vault_id     : _,
            shares       : v2,
            deposited_ms : _,
        } = arg1;
        let v4 = v0;
        0x2::object::delete(v4);
        let v5 = arg0.total_shares;
        assert!(v2 > 0 && v2 <= v5, 827);
        (0x2::object::uid_to_inner(&v4), v2, v5, 0x2::balance::split<T0>(&mut arg0.idle_t, mul_div(0x2::balance::value<T0>(&arg0.idle_t), v2, v5)), 0x2::balance::split<T1>(&mut arg0.idle_q, mul_div(0x2::balance::value<T1>(&arg0.idle_q), v2, v5)))
    }

    fun take_position<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: 0x2::object::ID, arg5: u128, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg6 > 0 && arg5 <= arg6, 852);
        let (v0, v1) = if (arg7) {
            let v2 = &mut arg0.id;
            position_fees<T0, T1>(v2, arg4, false, arg1, arg2, arg3, arg8, arg9)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v3, v4) = if (arg5 > 0) {
            let v5 = RangeKey{id: arg4};
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_full_range_liquidity_by_percent<T0, T1>(arg1, 0x2::dynamic_object_field::borrow_mut<RangeKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.id, v5), arg5, arg6, arg2, arg3, arg8, arg9)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v6 = v4;
        let v7 = v3;
        let v8 = RangeKey{id: arg4};
        let v9 = is_empty(0x2::dynamic_object_field::borrow<RangeKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.id, v8));
        if (v9) {
            let (_, v11) = 0x1::vector::index_of<0x2::object::ID>(&arg0.ranges, &arg4);
            0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.ranges, v11);
            let v12 = RangeKey{id: arg4};
            let v13 = RetiredKey{id: arg4};
            0x2::dynamic_object_field::add<RetiredKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.id, v13, 0x2::dynamic_object_field::remove<RangeKey, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.id, v12));
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.retired, arg4);
        };
        let v14 = RangeRemoved{
            vault_id    : 0x2::object::id<DlmmVault<T0, T1>>(arg0),
            position_id : arg4,
            numerator   : arg5,
            denominator : arg6,
            tokens      : 0x2::balance::value<T0>(&v7),
            quote       : 0x2::balance::value<T1>(&v6),
            retired     : v9,
        };
        0x2::event::emit<RangeRemoved>(v14);
        (v7, v6, v0, v1)
    }

    public fun terms<T0, T1>(arg0: &DlmmVault<T0, T1>) : (u64, u64, u64, u64, u64) {
        (arg0.perf_fee_bps, arg0.max_pool_share_bps, arg0.max_deposit_dev_bps, arg0.daily_deposit_bps, arg0.min_hold_ms)
    }

    public fun ticket_ref(arg0: &Ticket) : u128 {
        arg0.ref_sqrt
    }

    public fun total_shares<T0, T1>(arg0: &DlmmVault<T0, T1>) : u64 {
        arg0.total_shares
    }

    public fun totals<T0, T1>(arg0: &DlmmVault<T0, T1>) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.totals.deposited_t, arg0.totals.withdrawn_t, arg0.totals.withdrawn_q, arg0.totals.fees_t, arg0.totals.fees_q, arg0.totals.perf_t, arg0.totals.perf_q)
    }

    public fun turnover_24h<T0, T1>(arg0: &DlmmVault<T0, T1>, arg1: u64) : u64 {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::turnover(&arg0.turnover, arg1)
    }

    public fun vault_of<T0, T1>(arg0: &Registry) : 0x1::option::Option<0x2::object::ID> {
        let v0 = VaultKey{
            token : 0x1::type_name::with_original_ids<T0>(),
            quote : 0x1::type_name::with_original_ids<T1>(),
        };
        if (0x2::table::contains<VaultKey, 0x2::object::ID>(&arg0.vaults, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<VaultKey, 0x2::object::ID>(&arg0.vaults, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    public fun withdraw<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: Deposit<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_pool<T0, T1>(arg0, arg2);
        check_withdraw<T0, T1>(arg0, &arg5, 0x2::clock::timestamp_ms(arg6));
        collect_all<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        let (v0, v1, v2, v3, v4) = take_idle<T0, T1>(arg0, arg5);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x1::vector::length<0x2::object::ID>(&arg0.ranges);
        while (v7 > 0) {
            v7 = v7 - 1;
            let v8 = *0x1::vector::borrow<0x2::object::ID>(&arg0.ranges, v7);
            let (v9, v10, v11, v12) = take_position<T0, T1>(arg0, arg2, arg3, arg4, v8, (v1 as u128), (v2 as u128), false, arg6, arg7);
            0x2::balance::join<T0>(&mut v6, v9);
            0x2::balance::join<T1>(&mut v5, v10);
            0x2::balance::destroy_zero<T0>(v11);
            0x2::balance::destroy_zero<T1>(v12);
        };
        finish_withdraw<T0, T1>(arg0, v0, v1, v2, v6, v5, arg7)
    }

    public fun withdraw_idle<T0, T1>(arg0: &mut DlmmVault<T0, T1>, arg1: Deposit<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pool_id), 837);
        check_withdraw<T0, T1>(arg0, &arg1, 0x2::clock::timestamp_ms(arg2));
        let (v0, v1, v2, v3, v4) = take_idle<T0, T1>(arg0, arg1);
        finish_withdraw<T0, T1>(arg0, v0, v1, v2, v3, v4, arg3)
    }

    fun zeros(arg0: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

