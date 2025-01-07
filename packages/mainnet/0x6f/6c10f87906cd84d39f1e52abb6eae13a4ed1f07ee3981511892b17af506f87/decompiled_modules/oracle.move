module 0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::oracle {
    struct HiveOracle has store, key {
        id: 0x2::object::UID,
        update_cap: 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::TwapUpdateCap,
        sui_hive_pool_addr: 0x1::option::Option<address>,
        usdc_sui_pool_addr: 0x1::option::Option<address>,
        snapshots: 0x2::linked_table::LinkedTable<u64, HiveTwapSnapshot>,
        window_size: u64,
        tolerance: u64,
        module_version: u64,
    }

    struct HiveTwapSnapshot has copy, drop, store {
        timestamp: u64,
        hive_sui_cum_price: u256,
        hive_sui_timestamp: u64,
        sui_usdc_cum_price: u256,
        sui_usdc_timestamp: u64,
    }

    struct HiveOracleUpdated has copy, drop {
        sui_hive_pool_addr: 0x1::option::Option<address>,
        usdc_sui_pool_addr: 0x1::option::Option<address>,
        window_size: u64,
        tolerance: u64,
    }

    struct HiveOracleSnapshotRecorded has copy, drop {
        timestamp: u64,
        hive_sui_cum_price: u256,
        hive_sui_timestamp: u64,
        sui_usdc_cum_price: u256,
        sui_usdc_timestamp: u64,
    }

    fun calculate_twap(arg0: u256, arg1: u256, arg2: u64) : u256 {
        let v0 = if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::overflow_add_u256(arg0, 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::sub_from_max_u256(arg1))
        };
        v0 / (arg2 as u256)
    }

    fun destroy_snapshot(arg0: HiveTwapSnapshot) : (u64, u256, u64, u256, u64) {
        let HiveTwapSnapshot {
            timestamp          : v0,
            hive_sui_cum_price : v1,
            hive_sui_timestamp : v2,
            sui_usdc_cum_price : v3,
            sui_usdc_timestamp : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    public entry fun increment_oracle(arg0: &mut HiveOracle) {
        assert!(arg0.module_version < 0, 1976);
        arg0.module_version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun query_across_all_snapshots(arg0: &HiveOracle, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<u256>, vector<u64>, vector<u256>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u256>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, HiveTwapSnapshot>(&arg0.snapshots)
        };
        let v6 = v5;
        let v7 = 0;
        while (0x1::option::is_some<u64>(&v6) && v7 < arg2) {
            let v8 = *0x1::option::borrow<u64>(&v6);
            let v9 = 0x2::linked_table::borrow<u64, HiveTwapSnapshot>(&arg0.snapshots, v8);
            0x1::vector::push_back<u64>(&mut v0, v9.timestamp);
            0x1::vector::push_back<u256>(&mut v1, v9.hive_sui_cum_price);
            0x1::vector::push_back<u64>(&mut v2, v9.hive_sui_timestamp);
            0x1::vector::push_back<u256>(&mut v3, v9.sui_usdc_cum_price);
            0x1::vector::push_back<u64>(&mut v4, v9.sui_usdc_timestamp);
            v6 = *0x2::linked_table::next<u64, HiveTwapSnapshot>(&arg0.snapshots, v8);
            v7 = v7 + 1;
        };
        (v0, v1, v2, v3, v4, 0x2::linked_table::length<u64, HiveTwapSnapshot>(&arg0.snapshots))
    }

    public fun setup_hive_oracle(arg0: 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::TwapUpdateCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveOracle{
            id                 : 0x2::object::new(arg3),
            update_cap         : arg0,
            sui_hive_pool_addr : 0x1::option::some<address>(arg1),
            usdc_sui_pool_addr : 0x1::option::some<address>(arg2),
            snapshots          : 0x2::linked_table::new<u64, HiveTwapSnapshot>(arg3),
            window_size        : 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::constants::twap_init_window_size(),
            tolerance          : 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::constants::twap_init_tolerance(),
            module_version     : 0,
        };
        0x2::transfer::share_object<HiveOracle>(v0);
    }

    public fun update_hive_oracle(arg0: &0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::yield_flow::DragonDaoCapability, arg1: &mut HiveOracle, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1975);
        if (0x1::option::is_some<address>(&arg2)) {
            arg1.sui_hive_pool_addr = arg2;
        };
        if (0x1::option::is_some<address>(&arg3)) {
            arg1.usdc_sui_pool_addr = arg3;
        };
        if (arg4 > 0) {
            assert!(arg4 <= 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::constants::twap_max_window_size(), 1977);
            arg1.window_size = arg4;
        };
        if (arg5 > 0) {
            assert!(arg5 <= 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::constants::twap_max_tolerance(), 1978);
            arg1.tolerance = arg5;
        };
        let v0 = HiveOracleUpdated{
            sui_hive_pool_addr : arg1.sui_hive_pool_addr,
            usdc_sui_pool_addr : arg1.usdc_sui_pool_addr,
            window_size        : arg1.window_size,
            tolerance          : arg1.tolerance,
        };
        0x2::event::emit<HiveOracleUpdated>(v0);
    }

    public entry fun update_hive_oracle_price<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &mut HiveOracle, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::HiveGraph, arg3: &0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::two_pool::LiquidityPool<T0, T1, T4>, arg4: &0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::two_pool::LiquidityPool<T2, T3, T5>, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg1.module_version == 0, 1975);
        let v1 = *0x2::linked_table::back<u64, HiveTwapSnapshot>(&arg1.snapshots);
        if (0x1::option::is_some<u64>(&v1)) {
            if (v0 - 0x2::linked_table::borrow<u64, HiveTwapSnapshot>(&arg1.snapshots, *0x1::option::borrow<u64>(&v1)).timestamp < arg1.tolerance) {
                return
            };
        };
        let v2 = 0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::two_pool::get_liquidity_pool_id<T2, T3, T5>(arg4);
        assert!(0x2::object::id_to_address(&v2) == *0x1::option::borrow<address>(&arg1.sui_hive_pool_addr), 1974);
        let v3 = 0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::two_pool::get_liquidity_pool_id<T0, T1, T4>(arg3);
        assert!(0x2::object::id_to_address(&v3) == *0x1::option::borrow<address>(&arg1.usdc_sui_pool_addr), 1974);
        let (_, v5, v6) = 0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::two_pool::get_pool_cumulative_prices<T2, T3, T5>(arg4);
        let (_, v8, v9) = 0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::two_pool::get_pool_cumulative_prices<T0, T1, T4>(arg3);
        while (0x2::linked_table::length<u64, HiveTwapSnapshot>(&arg1.snapshots) > 0) {
            let (v10, v11) = 0x2::linked_table::pop_back<u64, HiveTwapSnapshot>(&mut arg1.snapshots);
            let v12 = v11;
            if (v0 - arg1.window_size + arg1.tolerance > v12.timestamp) {
                let (_, _, _, _, _) = destroy_snapshot(v12);
            } else {
                0x2::linked_table::push_back<u64, HiveTwapSnapshot>(&mut arg1.snapshots, v10, v12);
                break
            };
        };
        let v18 = HiveTwapSnapshot{
            timestamp          : v0,
            hive_sui_cum_price : v5,
            hive_sui_timestamp : v6,
            sui_usdc_cum_price : v8,
            sui_usdc_timestamp : v9,
        };
        let v19 = HiveOracleSnapshotRecorded{
            timestamp          : v0,
            hive_sui_cum_price : v5,
            hive_sui_timestamp : v6,
            sui_usdc_cum_price : v8,
            sui_usdc_timestamp : v9,
        };
        0x2::event::emit<HiveOracleSnapshotRecorded>(v19);
        let v20 = 0x1::option::none<HiveTwapSnapshot>();
        let v21 = *0x2::linked_table::back<u64, HiveTwapSnapshot>(&arg1.snapshots);
        while (0x1::option::is_some<u64>(&v21) && 0x2::linked_table::length<u64, HiveTwapSnapshot>(&arg1.snapshots) > 0) {
            let v22 = 0x1::option::borrow<u64>(&v21);
            let v23 = *0x2::linked_table::borrow<u64, HiveTwapSnapshot>(&arg1.snapshots, *v22);
            let v24 = v18.timestamp - v23.timestamp;
            if (arg1.window_size > v24 && arg1.window_size - v24 <= arg1.tolerance) {
                v20 = 0x1::option::some<HiveTwapSnapshot>(v23);
                break
            };
            if (v24 > arg1.window_size && v24 - arg1.window_size <= arg1.tolerance) {
                v20 = 0x1::option::some<HiveTwapSnapshot>(v23);
                break
            };
            v21 = *0x2::linked_table::prev<u64, HiveTwapSnapshot>(&arg1.snapshots, *v22);
        };
        if (0x1::option::is_some<HiveTwapSnapshot>(&v20)) {
            let v25 = *0x1::option::borrow<HiveTwapSnapshot>(&v20);
            let v26 = calculate_twap(v18.hive_sui_cum_price, v25.hive_sui_cum_price, v18.hive_sui_timestamp - v25.hive_sui_timestamp);
            let v27 = calculate_twap(v18.sui_usdc_cum_price, v25.sui_usdc_cum_price, v18.sui_usdc_timestamp - v25.sui_usdc_timestamp);
            let v28 = 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u256(v26, v27, (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::pow(10, (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::constants::twap_precision() as u128)) as u256));
            if (v28 > 0) {
                0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::update_hive_twap_info(&arg1.update_cap, arg0, arg2, v26, v27, v28);
            };
        };
        0x2::linked_table::push_back<u64, HiveTwapSnapshot>(&mut arg1.snapshots, 0x2::linked_table::length<u64, HiveTwapSnapshot>(&arg1.snapshots), v18);
    }

    // decompiled from Move bytecode v6
}

