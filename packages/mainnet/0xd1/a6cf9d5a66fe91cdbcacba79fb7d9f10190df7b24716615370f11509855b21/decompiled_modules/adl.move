module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::adl {
    struct ADLDeactivated has copy, drop {
        is_borrow: bool,
        market: 0x1::type_name::TypeName,
        coin: 0x1::type_name::TypeName,
        emode_group_id: 0x1::option::Option<u8>,
        params: TimeLock<DeleverageParams>,
    }

    struct TimeLock<T0: copy + drop + store> has copy, drop, store {
        inner: T0,
        timestamp: u64,
    }

    struct DeleverageParams has copy, drop, store {
        target_amount: u64,
        liquidation_factor_base: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_factor_hourly_drop: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_incentive_base: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        liquidation_incentive_daily_penalty: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        close_factor: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    struct AutoDeleverageRegistry has store {
        collaterals: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>,
        borrows: 0x2::table::Table<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>,
    }

    public fun close_factor(arg0: &DeleverageParams) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.close_factor
    }

    public(friend) fun enable_collateral_deleverage<T0>(arg0: &mut AutoDeleverageRegistry, arg1: DeleverageParams, arg2: u64) {
        assert!(!0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::supports_type<TimeLock<DeleverageParams>>(&arg0.collaterals, 0x1::type_name::with_defining_ids<T0>()), 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::adl_already_has_coin());
        let v0 = TimeLock<DeleverageParams>{
            inner     : arg1,
            timestamp : arg2,
        };
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::store<TimeLock<DeleverageParams>, T0>(&mut arg0.collaterals, v0);
    }

    public(friend) fun enable_debt_deleverage<T0>(arg0: &mut AutoDeleverageRegistry, arg1: u8, arg2: DeleverageParams, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>(&arg0.borrows, arg1)) {
            0x2::table::add<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>(&mut arg0.borrows, arg1, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::new<TimeLock<DeleverageParams>>(arg4));
        };
        let v0 = 0x2::table::borrow_mut<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>(&mut arg0.borrows, arg1);
        assert!(!0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::supports_type<TimeLock<DeleverageParams>>(v0, 0x1::type_name::with_defining_ids<T0>()), 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::adl_already_has_coin());
        let v1 = TimeLock<DeleverageParams>{
            inner     : arg2,
            timestamp : arg3,
        };
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::store<TimeLock<DeleverageParams>, T0>(v0, v1);
    }

    public(friend) fun ensure_limit_breached(arg0: &DeleverageParams, arg1: u64) {
        assert!(arg0.target_amount < arg1, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::adl_within_limit());
    }

    public(friend) fun get_borrow_deleverage(arg0: &AutoDeleverageRegistry, arg1: 0x1::type_name::TypeName, arg2: u8) : &TimeLock<DeleverageParams> {
        assert!(0x2::table::contains<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>(&arg0.borrows, arg2), 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::adl_emode_group_not_found());
        let v0 = 0x2::table::borrow<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>(&arg0.borrows, arg2);
        assert!(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::supports_type<TimeLock<DeleverageParams>>(v0, arg1), 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::adl_no_coin());
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::load_by_type<TimeLock<DeleverageParams>>(v0, arg1)
    }

    public(friend) fun get_collateral_deleverage(arg0: &AutoDeleverageRegistry, arg1: 0x1::type_name::TypeName) : &TimeLock<DeleverageParams> {
        assert!(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::supports_type<TimeLock<DeleverageParams>>(&arg0.collaterals, arg1), 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::adl_no_coin());
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::load_by_type<TimeLock<DeleverageParams>>(&arg0.collaterals, arg1)
    }

    public(friend) fun get_secs_since_activation<T0: copy + drop + store>(arg0: &TimeLock<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::value::clock_now(arg1);
        assert!(arg0.timestamp <= v0, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::adl_not_activated_by_time());
        v0 - arg0.timestamp
    }

    public(friend) fun inner<T0: copy + drop + store>(arg0: &TimeLock<T0>) : &T0 {
        &arg0.inner
    }

    public fun liquidation_factor_base(arg0: &DeleverageParams) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.liquidation_factor_base
    }

    public fun liquidation_factor_hourly_drop(arg0: &DeleverageParams) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.liquidation_factor_hourly_drop
    }

    public fun liquidation_incentive(arg0: &DeleverageParams, arg1: u64) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(arg0.liquidation_incentive_base, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(arg0.liquidation_incentive_daily_penalty, arg1 / 86400))
    }

    public fun liquidation_incentive_base(arg0: &DeleverageParams) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.liquidation_incentive_base
    }

    public fun liquidation_incentive_daily_penalty(arg0: &DeleverageParams) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.liquidation_incentive_daily_penalty
    }

    public fun liquidation_ltv(arg0: &DeleverageParams, arg1: u64) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::saturating_sub(arg0.liquidation_factor_base, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(arg0.liquidation_factor_hourly_drop, arg1 / 3600))
    }

    public(friend) fun new_auto_deleverage_params(arg0: u64, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg2: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg3: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg4: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg5: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) : DeleverageParams {
        DeleverageParams{
            target_amount                       : arg0,
            liquidation_factor_base             : arg1,
            liquidation_factor_hourly_drop      : arg2,
            liquidation_incentive_base          : arg3,
            liquidation_incentive_daily_penalty : arg4,
            close_factor                        : arg5,
        }
    }

    public(friend) fun new_auto_deleverage_registry(arg0: &mut 0x2::tx_context::TxContext) : AutoDeleverageRegistry {
        AutoDeleverageRegistry{
            collaterals : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::new<TimeLock<DeleverageParams>>(arg0),
            borrows     : 0x2::table::new<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>(arg0),
        }
    }

    public(friend) fun stop_borrow_deleverage<T0>(arg0: &mut AutoDeleverageRegistry, arg1: 0x1::type_name::TypeName, arg2: u8) {
        let v0 = ADLDeactivated{
            is_borrow      : true,
            market         : arg1,
            coin           : 0x1::type_name::with_defining_ids<T0>(),
            emode_group_id : 0x1::option::some<u8>(arg2),
            params         : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::remove<TimeLock<DeleverageParams>, T0>(0x2::table::borrow_mut<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>(&mut arg0.borrows, arg2)),
        };
        0x2::event::emit<ADLDeactivated>(v0);
    }

    public(friend) fun stop_collateral_deleverage<T0>(arg0: &mut AutoDeleverageRegistry, arg1: 0x1::type_name::TypeName) {
        let v0 = ADLDeactivated{
            is_borrow      : false,
            market         : arg1,
            coin           : 0x1::type_name::with_defining_ids<T0>(),
            emode_group_id : 0x1::option::none<u8>(),
            params         : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::remove<TimeLock<DeleverageParams>, T0>(&mut arg0.collaterals),
        };
        0x2::event::emit<ADLDeactivated>(v0);
    }

    public fun target_amount(arg0: &DeleverageParams) : u64 {
        arg0.target_amount
    }

    public(friend) fun try_stop_borrow_deleverage<T0>(arg0: &mut AutoDeleverageRegistry, arg1: 0x1::type_name::TypeName, arg2: u8, arg3: u64) {
        if (!0x2::table::contains<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>(&arg0.borrows, arg2)) {
            return
        };
        let v0 = 0x2::table::borrow<u8, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<TimeLock<DeleverageParams>>>(&arg0.borrows, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (!0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::supports_type<TimeLock<DeleverageParams>>(v0, v1)) {
            return
        };
        if (0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::load_by_type<TimeLock<DeleverageParams>>(v0, v1).inner.target_amount < arg3) {
            return
        };
        stop_borrow_deleverage<T0>(arg0, arg1, arg2);
    }

    public(friend) fun try_stop_collateral_deleverage<T0>(arg0: &mut AutoDeleverageRegistry, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::supports_type<TimeLock<DeleverageParams>>(&arg0.collaterals, v0)) {
            return
        };
        if (0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::load_by_type<TimeLock<DeleverageParams>>(&arg0.collaterals, v0).inner.target_amount < arg2) {
            return
        };
        stop_collateral_deleverage<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

