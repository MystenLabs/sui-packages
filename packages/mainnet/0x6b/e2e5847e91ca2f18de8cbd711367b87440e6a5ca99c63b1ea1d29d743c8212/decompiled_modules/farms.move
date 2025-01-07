module 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::farms {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CalculatorConfig has drop, store {
        factor_time_booster_numerator: u128,
        factor_time_booster_denominator: u128,
        factor_time_booster_precision: u128,
        factor_xflx_booster: u128,
        factor_xflx_booster_precision: u128,
    }

    struct FarmInfo has key {
        id: 0x2::object::UID,
        epoch: u64,
        flx_per_ms: u64,
        config: CalculatorConfig,
        authorizer: 0x4061a458beb11577e0e7659b0aaecde5ad8088b346809479a203050ff460a36b::access_control::Member<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::minter_role::MINTER_ROLE>,
        pools: 0x2::table_vec::TableVec<Pool>,
        lp_vaults: 0x2::bag::Bag,
        xflx_vaults: 0x2::table::Table<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>>,
        alloc_point_history: vector<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>,
        alloc_point_changes: 0x2::table::Table<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>,
        is_genesis: u8,
        genesis_timestamp: u64,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        lp_name: 0x1::string::String,
        epoch: u64,
        alloc_point_history: vector<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>,
        point_history: vector<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>,
        point_changes: 0x2::table::Table<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>,
        started_at_ms: u64,
        ended_at_ms: u64,
        harvestable: u8,
        is_genesis: u8,
    }

    struct PoolCreated has copy, drop {
        id: 0x2::object::ID,
        lp_name: 0x1::string::String,
        alloc_point: u128,
        started_at_ms: u64,
        ended_at_ms: u64,
        sender: address,
    }

    struct PoolAllocPointChanged has copy, drop {
        id: 0x2::object::ID,
        alloc_point: u128,
        sender: address,
    }

    fun new<T0, T1>(arg0: u64, arg1: u128, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : Pool {
        let v0 = Pool{
            id                  : 0x2::object::new(arg6),
            lp_name             : 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T0, T1>(),
            epoch               : arg0,
            alloc_point_history : 0x1::vector::singleton<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::new(arg0, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_positve(arg1))),
            point_history       : 0x1::vector::singleton<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::new(arg0, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::zero())),
            point_changes       : 0x2::table::new<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(arg6),
            started_at_ms       : arg2,
            ended_at_ms         : arg3,
            harvestable         : arg4,
            is_genesis          : arg5,
        };
        let v1 = PoolCreated{
            id            : 0x2::object::id<Pool>(&v0),
            lp_name       : v0.lp_name,
            alloc_point   : arg1,
            started_at_ms : arg2,
            ended_at_ms   : arg3,
            sender        : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<PoolCreated>(v1);
        v0
    }

    public fun alloc_checkpoint(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo) {
        let v0 = epoch_from_timestamp(0x2::clock::timestamp_ms(arg0), arg1.genesis_timestamp);
        if (v0 > arg1.epoch) {
            arg1.epoch = v0;
            0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::checkpoint(&mut arg1.alloc_point_history, &arg1.alloc_point_changes, v0);
        };
    }

    public fun alloc_point_changes(arg0: &FarmInfo) : &0x2::table::Table<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128> {
        &arg0.alloc_point_changes
    }

    public fun alloc_point_history(arg0: &FarmInfo) : &vector<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point> {
        &arg0.alloc_point_history
    }

    public fun authorizer(arg0: &FarmInfo) : &0x4061a458beb11577e0e7659b0aaecde5ad8088b346809479a203050ff460a36b::access_control::Member<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::minter_role::MINTER_ROLE> {
        &arg0.authorizer
    }

    public entry fun boost_position(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo, arg2: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg3: 0x2::coin::Coin<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_idx(arg2);
        checkpoint(arg0, arg1, v0);
        let v1 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, v0);
        check_depositable(arg0, v1);
        check_boostable(v1);
        let v2 = 0x2::object::id<Pool>(v1);
        assert!(v2 == 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_id(arg2), 11);
        calculate_pending_rewards(&arg1.alloc_point_history, v1, arg2, v1.epoch, arg1.flx_per_ms, arg1.genesis_timestamp);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>>(&mut arg1.xflx_vaults, v2);
        boost_position_internal(v3, arg2, arg3, arg4);
        update_point(v1, arg2, &arg1.config);
    }

    fun boost_position_internal(arg0: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>, arg1: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg2: 0x2::coin::Coin<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::increase_xflx_locked(arg1, 0x2::coin::value<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(&arg2), arg3);
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::deposit<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(arg0, arg2);
    }

    fun calculate_pending_rewards(arg0: &vector<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>, arg1: &Pool, arg2: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0;
        let v1 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::point_history(arg2));
        let v2 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(v1);
        if (arg3 > v2) {
            let v3 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint(&arg1.point_history));
            let v4 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::find_smallest_above_at(&arg1.point_history, v2);
            let v5 = if (arg3 < v3) {
                0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::find_smallest_above_at(&arg1.point_history, arg3)
            } else {
                0x1::vector::length<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(&arg1.point_history) - 1
            };
            let v6 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(v1);
            while (v4 <= v5 && v2 != arg3) {
                let v7 = 0x1::vector::borrow<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(&arg1.point_history, v4 - 1);
                let v8 = 0x1::vector::borrow<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(&arg1.point_history, v4);
                let v9 = if (arg3 > 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(v8)) {
                    0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(v8)
                } else {
                    arg3
                };
                if (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::value(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(v7)) > 0) {
                    v0 = v0 + (((calculate_pool_rewards(arg0, arg1, v2, v9, arg4, arg5) as u128) * 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::value(v6) / 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::value(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(v7))) as u64);
                };
                v2 = v9;
                if (v9 == 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::point_change(arg2)) && v9 != v3) {
                    v6 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::add(v6, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::point_change(arg2)));
                };
                0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::add_point(arg2, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::new(v9, v6));
                v4 = v4 + 1;
            };
        };
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::increase_pending_rewards(arg2, v0);
    }

    public fun calculate_point_boosted_by_time(arg0: &0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg1: &CalculatorConfig) : u128 {
        if (arg1.factor_time_booster_denominator > 0 && arg1.factor_time_booster_precision > 0) {
            (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lp_locked_amount(arg0) as u128) * arg1.factor_time_booster_numerator * (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lock_duration(arg0) as u128) / arg1.factor_time_booster_precision * arg1.factor_time_booster_denominator
        } else {
            0
        }
    }

    public fun calculate_point_boosted_by_xflx(arg0: &0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg1: &CalculatorConfig) : u128 {
        (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lp_locked_amount(arg0) as u128) * arg1.factor_xflx_booster * (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::xflx_locked_amount(arg0) as u128) / arg1.factor_xflx_booster_precision
    }

    public fun calculate_pool_rewards(arg0: &vector<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>, arg1: &Pool, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = 0;
        let v1 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::find_smallest_above_at(arg0, arg2);
        let v2 = if (arg3 < 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint(arg0))) {
            0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::find_smallest_above_at(arg0, arg3)
        } else {
            0x1::vector::length<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(arg0) - 1
        };
        while (v1 <= v2) {
            let v3 = 0x1::vector::borrow<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(arg0, v1 - 1);
            let v4 = 0x1::vector::borrow<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(arg0, v1);
            let v5 = if (arg3 > 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(v4)) {
                get_multiplier(arg1, arg5, arg2, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(v4))
            } else {
                get_multiplier(arg1, arg5, arg2, arg3)
            };
            if (!0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::is_zero(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(v3))) {
                v0 = v0 + ((((v5 * arg4) as u128) * 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::value(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(0x1::vector::borrow<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(&arg1.alloc_point_history, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::find_greatest_under_at(&arg1.alloc_point_history, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(v3))))) / 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::value(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(v3))) as u64);
            };
            arg2 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(v4);
            v1 = v1 + 1;
        };
        v0
    }

    public fun calculator_config(arg0: &FarmInfo) : &CalculatorConfig {
        &arg0.config
    }

    public fun check_active(arg0: &0x2::clock::Clock, arg1: &Pool) {
        assert!(arg1.ended_at_ms == 0 || arg1.ended_at_ms > 0x2::clock::timestamp_ms(arg0), 5);
    }

    public fun check_boostable(arg0: &Pool) {
        assert!(arg0.is_genesis == 0, 8);
    }

    public fun check_depositable(arg0: &0x2::clock::Clock, arg1: &Pool) {
        check_active(arg0, arg1);
        assert!(arg1.started_at_ms > 0x2::clock::timestamp_ms(arg0) || arg1.is_genesis == 0, 6);
    }

    public fun check_harvestable(arg0: &0x2::clock::Clock, arg1: &Pool) {
        assert!(arg1.harvestable == 1 && 0x2::clock::timestamp_ms(arg0) > arg1.started_at_ms, 7);
    }

    public fun check_lock_end(arg0: &0x2::clock::Clock, arg1: &Pool, arg2: &0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position) {
        assert!(arg1.started_at_ms > 0x2::clock::timestamp_ms(arg0) || 0x2::clock::timestamp_ms(arg0) >= 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::ended_at(arg2), 9);
    }

    public entry fun checkpoint(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo, arg2: u64) {
        alloc_checkpoint(arg0, arg1);
        let v0 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, arg2);
        if (arg1.epoch > v0.epoch) {
            v0.epoch = arg1.epoch;
            pool_checkpoint(v0);
        };
    }

    public entry fun create_pool<T0, T1>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut FarmInfo, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = epoch_from_timestamp(0x2::clock::timestamp_ms(arg1), arg2.genesis_timestamp);
        let v1 = round_up_epoch(arg4, arg2.genesis_timestamp);
        assert!(v1 > v0, 0);
        assert!(arg2.is_genesis == 0 && arg5 == 0 || arg5 > arg4, 1);
        mass_checkpoint(arg1, arg2);
        if (arg3 > 0) {
            if (0x2::table::contains<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&arg2.alloc_point_changes, v1)) {
                let v2 = 0x2::table::borrow_mut<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, v1);
                *v2 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::add(*v2, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_positve(arg3));
            } else {
                0x2::table::add<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, v1, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_positve(arg3));
            };
            if (arg5 != 0) {
                let v3 = epoch_from_timestamp(arg5, arg2.genesis_timestamp);
                if (0x2::table::contains<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&arg2.alloc_point_changes, v3)) {
                    let v4 = 0x2::table::borrow_mut<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, v3);
                    *v4 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::add(*v4, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_negative(arg3));
                } else {
                    0x2::table::add<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, v3, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_negative(arg3));
                };
            };
        };
        if (arg5 != 0) {
            let v5 = epoch_from_timestamp(arg5, arg2.genesis_timestamp);
            arg5 = epoch_to_timestamp(v5, arg2.genesis_timestamp);
        };
        let v6 = if (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>()) {
            let v7 = new<T0, T1>(v0, arg3, epoch_to_timestamp(v1, arg2.genesis_timestamp), arg5, arg6, arg2.is_genesis, arg7);
            0x2::bag::add<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(&mut arg2.lp_vaults, 0x2::object::id<Pool>(&v7), 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::new<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg7));
            v7
        } else {
            let v8 = new<T1, T0>(v0, arg3, epoch_to_timestamp(v1, arg2.genesis_timestamp), arg5, arg6, arg2.is_genesis, arg7);
            0x2::bag::add<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T1, T0>>>(&mut arg2.lp_vaults, 0x2::object::id<Pool>(&v8), 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::new<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T1, T0>>(arg7));
            v8
        };
        let v9 = v6;
        0x2::table_vec::push_back<Pool>(&mut arg2.pools, v9);
        0x2::table::add<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>>(&mut arg2.xflx_vaults, 0x2::object::id<Pool>(&v9), 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::new<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(arg7));
    }

    public entry fun decrease_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo, arg2: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_idx(arg2);
        checkpoint(arg0, arg1, v0);
        let v1 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, v0);
        check_lock_end(arg0, v1, arg2);
        let v2 = 0x2::object::id<Pool>(v1);
        assert!(v2 == 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_id(arg2), 11);
        calculate_pending_rewards(&arg1.alloc_point_history, v1, arg2, v1.epoch, arg1.flx_per_ms, arg1.genesis_timestamp);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(&mut arg1.lp_vaults, v2);
        let v4 = decrease_position_internal<T0, T1>(v3, arg2, arg3, arg4);
        if (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::ended_at(arg2) > 0x2::clock::timestamp_ms(arg0)) {
            let v5 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lock_duration(arg2);
            lock_position_internal(arg0, v1, arg2, &arg1.config, arg1.genesis_timestamp, v5, arg4);
        };
        update_point(v1, arg2, &arg1.config);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(v4, 0x2::tx_context::sender(arg4));
    }

    fun decrease_position_internal<T0, T1>(arg0: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg1: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::decrease_lp_locked(arg1, arg2, arg3);
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::withdraw<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg0, arg2, arg3)
    }

    public fun epoch_from_timestamp(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            (arg0 - arg1) / 1800000
        } else {
            0
        }
    }

    public fun epoch_to_timestamp(arg0: u64, arg1: u64) : u64 {
        arg0 * 1800000 + arg1
    }

    public fun flx_per_ms(arg0: &FarmInfo) : u64 {
        arg0.flx_per_ms
    }

    public fun genesis_timestamp(arg0: &FarmInfo) : u64 {
        arg0.genesis_timestamp
    }

    public fun get_multiplier(arg0: &Pool, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = epoch_to_timestamp(arg2, arg1);
        let v1 = v0;
        let v2 = epoch_to_timestamp(arg3, arg1);
        let v3 = v2;
        if (v0 < arg0.started_at_ms) {
            v1 = arg0.started_at_ms;
        };
        if (arg0.ended_at_ms != 0 && v2 > arg0.ended_at_ms) {
            v3 = arg0.ended_at_ms;
        };
        if (v1 < v3) {
            v3 - v1
        } else {
            0
        }
    }

    public fun get_pool(arg0: &FarmInfo, arg1: u64) : &Pool {
        0x2::table_vec::borrow<Pool>(&arg0.pools, arg1)
    }

    public entry fun harvest_position(arg0: &0x2::clock::Clock, arg1: &mut 0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::TreasuryManagement, arg2: &mut 0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::TreasuryManagement, arg3: &0x4061a458beb11577e0e7659b0aaecde5ad8088b346809479a203050ff460a36b::access_control::Role<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::minter_role::MINTER_ROLE>, arg4: &mut FarmInfo, arg5: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_idx(arg5);
        checkpoint(arg0, arg4, v0);
        let v1 = 0x2::table_vec::borrow_mut<Pool>(&mut arg4.pools, v0);
        check_harvestable(arg0, v1);
        assert!(0x2::object::id<Pool>(v1) == 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_id(arg5), 11);
        assert!(arg6 <= v1.epoch, 10);
        calculate_pending_rewards(&arg4.alloc_point_history, v1, arg5, arg6, arg4.flx_per_ms, arg4.genesis_timestamp);
        let v2 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pending_rewards(arg5);
        if (v2 > 0) {
            let v3 = 0x2::tx_context::sender(arg7);
            let v4 = 0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::mint(arg1, arg3, &arg4.authorizer, v2, arg7);
            0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::decrease_pending_rewards(arg5, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(v4, v3);
            0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::mint_and_transfer(arg2, 0x2::coin::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut v4, v2 / 2, arg7), v3, arg7);
        };
    }

    public entry fun increase_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo, arg2: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg3: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_idx(arg2);
        checkpoint(arg0, arg1, v0);
        let v1 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, v0);
        check_depositable(arg0, v1);
        check_lock_end(arg0, v1, arg2);
        let v2 = 0x2::object::id<Pool>(v1);
        assert!(v2 == 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_id(arg2), 11);
        calculate_pending_rewards(&arg1.alloc_point_history, v1, arg2, v1.epoch, arg1.flx_per_ms, arg1.genesis_timestamp);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(&mut arg1.lp_vaults, v2);
        increase_position_internal<T0, T1>(v3, arg2, arg3, arg4);
        if (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::ended_at(arg2) > 0x2::clock::timestamp_ms(arg0)) {
            let v4 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lock_duration(arg2);
            lock_position_internal(arg0, v1, arg2, &arg1.config, arg1.genesis_timestamp, v4, arg4);
        };
        update_point(v1, arg2, &arg1.config);
    }

    fun increase_position_internal<T0, T1>(arg0: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg1: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg2: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg2);
        assert!(v0 > 0, 2);
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::increase_lp_locked(arg1, v0, arg3);
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::deposit<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_farm(arg0: &AdminCap, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = CalculatorConfig{
            factor_time_booster_numerator   : arg2,
            factor_time_booster_denominator : arg3,
            factor_time_booster_precision   : arg4,
            factor_xflx_booster             : arg5,
            factor_xflx_booster_precision   : arg6,
        };
        let v1 = FarmInfo{
            id                  : 0x2::object::new(arg8),
            epoch               : 0,
            flx_per_ms          : arg1,
            config              : v0,
            authorizer          : 0x4061a458beb11577e0e7659b0aaecde5ad8088b346809479a203050ff460a36b::access_control::create_member<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::minter_role::MINTER_ROLE>(arg8),
            pools               : 0x2::table_vec::empty<Pool>(arg8),
            lp_vaults           : 0x2::bag::new(arg8),
            xflx_vaults         : 0x2::table::new<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>>(arg8),
            alloc_point_history : 0x1::vector::singleton<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::new(0, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::zero())),
            alloc_point_changes : 0x2::table::new<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(arg8),
            is_genesis          : arg7,
            genesis_timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        0x2::transfer::share_object<FarmInfo>(v1);
    }

    public entry fun lock_position(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo, arg2: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_idx(arg2);
        checkpoint(arg0, arg1, v0);
        let v1 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, v0);
        check_depositable(arg0, v1);
        check_lock_end(arg0, v1, arg2);
        assert!(0x2::object::id<Pool>(v1) == 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_id(arg2), 11);
        calculate_pending_rewards(&arg1.alloc_point_history, v1, arg2, v1.epoch, arg1.flx_per_ms, arg1.genesis_timestamp);
        lock_position_internal(arg0, v1, arg2, &arg1.config, arg1.genesis_timestamp, arg3, arg4);
        update_point(v1, arg2, &arg1.config);
    }

    fun lock_position_internal(arg0: &0x2::clock::Clock, arg1: &mut Pool, arg2: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg3: &CalculatorConfig, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_genesis == 1 && arg5 == arg1.ended_at_ms - arg1.started_at_ms || arg1.is_genesis == 0 && (arg5 == 0 || arg5 >= 1800000), 3);
        let v0 = if (0x2::clock::timestamp_ms(arg0) < arg1.started_at_ms) {
            arg4
        } else {
            0x2::clock::timestamp_ms(arg0)
        };
        assert!(arg1.is_genesis == 1 || arg1.is_genesis == 0 && arg5 <= 7776000000 && (arg1.ended_at_ms == 0 || arg5 <= arg1.ended_at_ms - v0), 4);
        if (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lock_duration(arg2) > 0) {
            let v1 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::point_change(arg2));
            if (v1 > arg1.epoch) {
                let v2 = 0x2::table::borrow_mut<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg1.point_changes, v1);
                *v2 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::sub(*v2, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::point_change(arg2)));
                0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::set_point_change(arg2, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::new(v1, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::zero()));
            };
        };
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lock(arg0, arg2, arg1.started_at_ms, arg5, arg6);
        if (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lock_duration(arg2) > 0) {
            let v3 = epoch_from_timestamp(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::ended_at(arg2), arg4);
            let v4 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_negative(calculate_point_boosted_by_time(arg2, arg3));
            0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::set_point_change(arg2, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::new(v3, v4));
            if (0x2::table::contains<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&arg1.point_changes, v3)) {
                let v5 = 0x2::table::borrow_mut<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg1.point_changes, v3);
                *v5 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::add(*v5, v4);
            } else {
                0x2::table::add<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg1.point_changes, v3, v4);
            };
        };
    }

    public entry fun mass_checkpoint(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo) {
        let v0 = 0x2::table_vec::length<Pool>(&arg1.pools);
        let v1 = 0;
        alloc_checkpoint(arg0, arg1);
        while (v1 < v0) {
            let v2 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, v1);
            if (arg1.epoch > v2.epoch) {
                v2.epoch = arg1.epoch;
                pool_checkpoint(v2);
            };
            v1 = v1 + 1;
        };
    }

    public entry fun open_and_boost_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo, arg2: u64, arg3: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg4: 0x2::coin::Coin<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        checkpoint(arg0, arg1, arg2);
        let v0 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, arg2);
        check_depositable(arg0, v0);
        check_boostable(v0);
        let v1 = 0x2::object::id<Pool>(v0);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(&mut arg1.lp_vaults, v1);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>>(&mut arg1.xflx_vaults, v1);
        let v4 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::new(arg2, 0x2::object::id<Pool>(v0), v0.epoch, arg6);
        let v5 = &mut v4;
        increase_position_internal<T0, T1>(v2, v5, arg3, arg6);
        let v6 = &mut v4;
        lock_position_internal(arg0, v0, v6, &arg1.config, arg1.genesis_timestamp, arg5, arg6);
        let v7 = &mut v4;
        boost_position_internal(v3, v7, arg4, arg6);
        let v8 = &mut v4;
        update_point(v0, v8, &arg1.config);
        0x2::transfer::public_transfer<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position>(v4, 0x2::tx_context::sender(arg6));
    }

    public entry fun open_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo, arg2: u64, arg3: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        checkpoint(arg0, arg1, arg2);
        let v0 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, arg2);
        check_depositable(arg0, v0);
        let v1 = 0x2::object::id<Pool>(v0);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(&mut arg1.lp_vaults, v1);
        let v3 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::new(arg2, v1, v0.epoch, arg5);
        let v4 = &mut v3;
        increase_position_internal<T0, T1>(v2, v4, arg3, arg5);
        let v5 = &arg1.config;
        let v6 = &mut v3;
        lock_position_internal(arg0, v0, v6, v5, arg1.genesis_timestamp, arg4, arg5);
        let v7 = &mut v3;
        update_point(v0, v7, v5);
        0x2::transfer::public_transfer<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position>(v3, 0x2::tx_context::sender(arg5));
    }

    public fun pool_alloc_point_history(arg0: &Pool) : &vector<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point> {
        &arg0.alloc_point_history
    }

    public fun pool_checkpoint(arg0: &mut Pool) {
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::checkpoint(&mut arg0.point_history, &arg0.point_changes, arg0.epoch);
    }

    public fun pool_ended_at(arg0: &Pool) : u64 {
        arg0.ended_at_ms
    }

    public fun pool_epoch(arg0: &Pool) : u64 {
        arg0.epoch
    }

    public fun pool_id(arg0: &Pool) : 0x2::object::ID {
        0x2::object::id<Pool>(arg0)
    }

    public fun pool_lp_name(arg0: &Pool) : 0x1::string::String {
        arg0.lp_name
    }

    public fun pool_point_changes(arg0: &Pool) : &0x2::table::Table<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128> {
        &arg0.point_changes
    }

    public fun pool_point_history(arg0: &Pool) : &vector<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point> {
        &arg0.point_history
    }

    public fun pool_started_at(arg0: &Pool) : u64 {
        arg0.started_at_ms
    }

    public fun pools(arg0: &FarmInfo) : &0x2::table_vec::TableVec<Pool> {
        &arg0.pools
    }

    public fun round_up_epoch(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 - arg1) / 1800000;
        if (v0 * 1800000 + arg1 < arg0) {
            v0 + 1
        } else {
            v0
        }
    }

    public entry fun set_alloc_point(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut FarmInfo, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        mass_checkpoint(arg1, arg2);
        let v0 = 0x2::table_vec::borrow_mut<Pool>(&mut arg2.pools, arg3);
        check_active(arg1, v0);
        let v1 = v0.epoch;
        let v2 = epoch_from_timestamp(v0.started_at_ms, arg2.genesis_timestamp);
        let v3 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint(&v0.alloc_point_history);
        let v4 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(v3);
        if (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::value(v4) != 0) {
            if (v1 == 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(v3)) {
                0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::decrease(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint_mut(&mut v0.alloc_point_history), v4);
            } else {
                0x1::vector::push_back<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(&mut v0.alloc_point_history, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::new(v1, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::zero()));
            };
            if (v1 > v2) {
                0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::decrease(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint_mut(&mut arg2.alloc_point_history), v4);
            } else {
                let v5 = 0x2::table::borrow_mut<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, v2);
                *v5 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::sub(*v5, v4);
            };
            if (v0.ended_at_ms != 0) {
                let v6 = 0x2::table::borrow_mut<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, epoch_from_timestamp(v0.ended_at_ms, arg2.genesis_timestamp));
                *v6 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::sub(*v6, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::opposite_sign(v4));
            };
        };
        if (arg4 != 0) {
            if (v1 == 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint(&v0.alloc_point_history))) {
                0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::increase(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint_mut(&mut v0.alloc_point_history), 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_positve(arg4));
            } else {
                0x1::vector::push_back<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::Point>(&mut v0.alloc_point_history, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::new(v1, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_positve(arg4)));
            };
            if (v1 > v2) {
                0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::increase(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint_mut(&mut arg2.alloc_point_history), 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_positve(arg4));
            } else if (0x2::table::contains<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&arg2.alloc_point_changes, v2)) {
                let v7 = 0x2::table::borrow_mut<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, v2);
                *v7 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::add(*v7, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_positve(arg4));
            } else {
                0x2::table::add<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, v2, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_positve(arg4));
            };
            if (v0.ended_at_ms != 0) {
                let v8 = epoch_from_timestamp(v0.ended_at_ms, arg2.genesis_timestamp);
                if (0x2::table::contains<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&arg2.alloc_point_changes, v8)) {
                    let v9 = 0x2::table::borrow_mut<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, v8);
                    *v9 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::add(*v9, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_negative(arg4));
                } else {
                    0x2::table::add<u64, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::I128>(&mut arg2.alloc_point_changes, v8, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_negative(arg4));
                };
            };
        };
        let v10 = PoolAllocPointChanged{
            id          : 0x2::object::id<Pool>(v0),
            alloc_point : arg4,
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PoolAllocPointChanged>(v10);
    }

    public entry fun set_harvestable(arg0: &AdminCap, arg1: &mut FarmInfo, arg2: u64, arg3: u8) {
        0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, arg2).harvestable = arg3;
    }

    public entry fun unboost_position(arg0: &0x2::clock::Clock, arg1: &mut FarmInfo, arg2: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_idx(arg2);
        checkpoint(arg0, arg1, v0);
        let v1 = 0x2::table_vec::borrow_mut<Pool>(&mut arg1.pools, v0);
        let v2 = 0x2::object::id<Pool>(v1);
        assert!(v2 == 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pool_id(arg2), 11);
        calculate_pending_rewards(&arg1.alloc_point_history, v1, arg2, v1.epoch, arg1.flx_per_ms, arg1.genesis_timestamp);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>>(&mut arg1.xflx_vaults, v2);
        let v4 = unboost_position_internal(v3, arg2, arg3, arg4);
        update_point(v1, arg2, &arg1.config);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>>(v4, 0x2::tx_context::sender(arg4));
    }

    fun unboost_position_internal(arg0: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::Vault<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>, arg1: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX> {
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::decrease_xflx_locked(arg1, arg2, arg3);
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::vault::withdraw<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(arg0, arg2, arg3)
    }

    public fun update_point(arg0: &mut Pool, arg1: &mut 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg2: &CalculatorConfig) {
        let v0 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint_mut(&mut arg0.point_history);
        let v1 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::value(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::last_checkpoint(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::point_history(arg1)));
        if (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::value(v1) > 0) {
            let v2 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::opposite_sign(v1);
            0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::increase_last_checkpoint(arg1, v2);
            0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::increase(v0, v2);
        };
        let v3 = if (0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lock_duration(arg1) > 0 && arg0.epoch < 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::epoch(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::point_change(arg1))) {
            calculate_point_boosted_by_time(arg1, arg2)
        } else {
            0
        };
        let v4 = 0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::i128::new_positve((0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::lp_locked_amount(arg1) as u128) + v3 + calculate_point_boosted_by_xflx(arg1, arg2));
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::increase_last_checkpoint(arg1, v4);
        0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::point::increase(v0, v4);
    }

    // decompiled from Move bytecode v6
}

