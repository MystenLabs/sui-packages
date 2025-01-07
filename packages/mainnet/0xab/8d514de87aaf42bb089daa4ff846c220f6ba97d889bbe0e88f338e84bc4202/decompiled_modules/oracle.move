module 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::oracle {
    struct HiveOracle has store, key {
        id: 0x2::object::UID,
        update_cap: 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::TwapUpdateCap,
        sui_hive_pool_addr: 0x1::option::Option<address>,
        usdc_sui_pool_addr: 0x1::option::Option<address>,
        snapshots: 0x2::linked_table::LinkedTable<u64, HiveTwapSnapshot>,
        window_size: u64,
        tolerance: u64,
    }

    struct HiveTwapSnapshot has copy, drop, store {
        timestamp: u64,
        hive_sui_cum_price: u256,
        sui_usdc_cum_price: u256,
    }

    struct HiveOracleUpdated has copy, drop {
        sui_hive_pool_addr: 0x1::option::Option<address>,
        usdc_sui_pool_addr: 0x1::option::Option<address>,
    }

    struct HiveOracleSnapshotRecorded has copy, drop {
        timestamp: u64,
        hive_sui_cum_price: u256,
        sui_usdc_cum_price: u256,
    }

    fun calculate_twap(arg0: u256, arg1: u256, arg2: u64) : u256 {
        let v0 = if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::math::overflow_add_u256(arg0, 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::math::sub_from_max_u256(arg1))
        };
        v0 / (arg2 as u256)
    }

    fun destroy_snapshot(arg0: HiveTwapSnapshot) : (u64, u256, u256) {
        let HiveTwapSnapshot {
            timestamp          : v0,
            hive_sui_cum_price : v1,
            sui_usdc_cum_price : v2,
        } = arg0;
        (v0, v1, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun query_across_all_snapshots(arg0: &HiveOracle, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<u256>, vector<u256>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0x1::vector::empty<u256>();
        let v3 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, HiveTwapSnapshot>(&arg0.snapshots)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<u64>(&v4) && v5 < arg2) {
            let v6 = *0x1::option::borrow<u64>(&v4);
            let v7 = 0x2::linked_table::borrow<u64, HiveTwapSnapshot>(&arg0.snapshots, v6);
            0x1::vector::push_back<u64>(&mut v0, v7.timestamp);
            0x1::vector::push_back<u256>(&mut v1, v7.hive_sui_cum_price);
            0x1::vector::push_back<u256>(&mut v2, v7.sui_usdc_cum_price);
            v4 = *0x2::linked_table::next<u64, HiveTwapSnapshot>(&arg0.snapshots, v6);
            v5 = v5 + 1;
        };
        (v0, v1, v2, 0x2::linked_table::length<u64, HiveTwapSnapshot>(&arg0.snapshots))
    }

    public fun setup_hive_oracle(arg0: 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::TwapUpdateCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveOracle{
            id                 : 0x2::object::new(arg3),
            update_cap         : arg0,
            sui_hive_pool_addr : 0x1::option::some<address>(arg1),
            usdc_sui_pool_addr : 0x1::option::some<address>(arg2),
            snapshots          : 0x2::linked_table::new<u64, HiveTwapSnapshot>(arg3),
            window_size        : 300000,
            tolerance          : 60000,
        };
        0x2::transfer::share_object<HiveOracle>(v0);
    }

    public fun update_hive_oracle(arg0: &0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::HiveDaoCapability, arg1: &mut HiveOracle, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<address>(&arg2)) {
            arg1.sui_hive_pool_addr = arg2;
        };
        if (0x1::option::is_some<address>(&arg3)) {
            arg1.usdc_sui_pool_addr = arg3;
        };
        let v0 = HiveOracleUpdated{
            sui_hive_pool_addr : arg2,
            usdc_sui_pool_addr : arg3,
        };
        0x2::event::emit<HiveOracleUpdated>(v0);
    }

    public entry fun update_hive_oracle_price<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &mut HiveOracle, arg2: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HiveManager, arg3: &0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T4>, arg4: &0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T2, T3, T5>, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = *0x2::linked_table::back<u64, HiveTwapSnapshot>(&arg1.snapshots);
        if (0x1::option::is_some<u64>(&v1)) {
            if (v0 - 0x2::linked_table::borrow<u64, HiveTwapSnapshot>(&arg1.snapshots, *0x1::option::borrow<u64>(&v1)).timestamp < arg1.tolerance) {
                return
            };
        };
        let v2 = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::get_liquidity_pool_id<T2, T3, T5>(arg4);
        assert!(0x2::object::id_to_address(&v2) == *0x1::option::borrow<address>(&arg1.sui_hive_pool_addr), 1974);
        let v3 = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::get_liquidity_pool_id<T0, T1, T4>(arg3);
        assert!(0x2::object::id_to_address(&v3) == *0x1::option::borrow<address>(&arg1.usdc_sui_pool_addr), 1974);
        let (_, v5, _) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::get_pool_cumulative_prices<T2, T3, T5>(arg4);
        let (_, v8, _) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::get_pool_cumulative_prices<T0, T1, T4>(arg3);
        while (0x2::linked_table::length<u64, HiveTwapSnapshot>(&arg1.snapshots) > 0) {
            let (v10, v11) = 0x2::linked_table::pop_back<u64, HiveTwapSnapshot>(&mut arg1.snapshots);
            let v12 = v11;
            if (v0 - arg1.window_size + arg1.tolerance > v12.timestamp) {
                let (_, _, _) = destroy_snapshot(v12);
            } else {
                0x2::linked_table::push_back<u64, HiveTwapSnapshot>(&mut arg1.snapshots, v10, v12);
                break
            };
        };
        let v16 = HiveTwapSnapshot{
            timestamp          : v0,
            hive_sui_cum_price : v5,
            sui_usdc_cum_price : v8,
        };
        let v17 = 0x1::option::none<HiveTwapSnapshot>();
        let v18 = *0x2::linked_table::back<u64, HiveTwapSnapshot>(&arg1.snapshots);
        while (0x1::option::is_some<u64>(&v18) && 0x2::linked_table::length<u64, HiveTwapSnapshot>(&arg1.snapshots) > 0) {
            let v19 = 0x1::option::borrow<u64>(&v18);
            let v20 = *0x2::linked_table::borrow<u64, HiveTwapSnapshot>(&arg1.snapshots, *v19);
            let v21 = v16.timestamp - v20.timestamp;
            if (arg1.window_size > v21 && arg1.window_size - v21 <= arg1.tolerance) {
                v17 = 0x1::option::some<HiveTwapSnapshot>(v20);
                break
            };
            if (v21 > arg1.window_size && v21 - arg1.window_size <= arg1.tolerance) {
                v17 = 0x1::option::some<HiveTwapSnapshot>(v20);
                break
            };
            v18 = *0x2::linked_table::prev<u64, HiveTwapSnapshot>(&arg1.snapshots, *v19);
        };
        assert!(0x1::option::is_some<HiveTwapSnapshot>(&v17), 1976);
        let v22 = *0x1::option::borrow<HiveTwapSnapshot>(&v17);
        let v23 = v16.timestamp - v22.timestamp;
        let v24 = calculate_twap(v16.hive_sui_cum_price, v22.hive_sui_cum_price, v23);
        let v25 = calculate_twap(v16.sui_usdc_cum_price, v22.sui_usdc_cum_price, v23);
        assert!(v25 > 0, 1975);
        0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::update_hive_twap_info(&arg1.update_cap, arg0, arg2, v24, v25, 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::math::mul_div_u256(v24, v25, (1000000000000000000 as u256)));
        0x2::linked_table::push_back<u64, HiveTwapSnapshot>(&mut arg1.snapshots, 0x2::linked_table::length<u64, HiveTwapSnapshot>(&arg1.snapshots), v16);
        let v26 = HiveOracleSnapshotRecorded{
            timestamp          : v0,
            hive_sui_cum_price : v5,
            sui_usdc_cum_price : v8,
        };
        0x2::event::emit<HiveOracleSnapshotRecorded>(v26);
    }

    // decompiled from Move bytecode v6
}

