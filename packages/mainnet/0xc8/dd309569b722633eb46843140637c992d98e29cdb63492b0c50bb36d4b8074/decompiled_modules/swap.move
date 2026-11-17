module 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::swap {
    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun calculate_swap_result<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) : (u64, u64, u64, bool, u128) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3);
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v0))
    }

    public fun current_sqrt_price<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)
    }

    public fun fee_rate<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0)
    }

    fun assert_amounts(arg0: u64, arg1: u64) {
        assert!(arg0 > 0, 100);
        assert!(arg1 > 0, 102);
    }

    fun assert_recorded_partner(arg0: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner) {
        assert!(0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::cetus_partner_id(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg1)), 104);
    }

    fun close_swap<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg2: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket, arg3: 0x2::object::ID, arg4: 0x2::balance::Balance<T1>, arg5: 0x2::balance::Balance<T2>) {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, &mut arg2, arg4);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::put<T0, T2, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, &mut arg2, arg5);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::settle<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg0, arg1, arg2, 0x1::option::some<0x2::object::ID>(arg3));
    }

    fun emit_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &0x2::tx_context::TxContext) {
        let v0 = SwapEvent{
            pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            sender     : 0x2::tx_context::sender(arg5),
            amount_in  : arg1,
            amount_out : arg2,
            a2b        : arg3,
            partner_id : arg4,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    fun fill_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        assert!(arg3 < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 103);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, arg3, arg5);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) >= arg4, 101);
        0x2::balance::join<T0>(&mut arg2, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        emit_swap<T0, T1>(arg1, v0 - 0x2::balance::value<T0>(&arg2), 0x2::balance::value<T1>(&v5), true, 0x1::option::none<0x2::object::ID>(), arg6);
        (v5, arg2)
    }

    fun fill_a2b_partner<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        assert!(arg4 < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 103);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, true, true, v0, arg4, arg6);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) >= arg5, 101);
        0x2::balance::join<T0>(&mut arg3, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        emit_swap<T0, T1>(arg1, v0 - 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&v5), true, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg2)), arg7);
        (v5, arg3)
    }

    fun fill_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg3 > 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 103);
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, arg3, arg5);
        let v4 = v3;
        let v5 = v1;
        assert!(0x2::balance::value<T0>(&v5) >= arg4, 101);
        0x2::balance::join<T1>(&mut arg2, v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        emit_swap<T0, T1>(arg1, v0 - 0x2::balance::value<T1>(&arg2), 0x2::balance::value<T0>(&v5), false, 0x1::option::none<0x2::object::ID>(), arg6);
        (v5, arg2)
    }

    fun fill_b2a_partner<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::balance::Balance<T1>, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg4 > 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 103);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, false, true, v0, arg4, arg6);
        let v4 = v3;
        let v5 = v1;
        assert!(0x2::balance::value<T0>(&v5) >= arg5, 101);
        0x2::balance::join<T1>(&mut arg3, v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        emit_swap<T0, T1>(arg1, v0 - 0x2::balance::value<T1>(&arg3), 0x2::balance::value<T0>(&v5), false, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg2)), arg7);
        (v5, arg3)
    }

    fun open_swap<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg3: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg4: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry) : 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Ticket {
        let v0 = if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<T0>()) {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_exit()
        } else {
            0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::move_enter()
        };
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::open_ticket<T0, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, arg2, arg3, arg4, v0, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::role_flag_swap())
    }

    public fun pool_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0)
    }

    public fun quote_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : (u64, u64) {
        assert!(arg1 > 0, 100);
        let (_, v1, v2, _, _) = calculate_swap_result<T0, T1>(arg0, arg2, true, arg1);
        (v1, v2)
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_amounts(arg7, arg9);
        let v0 = open_swap<T0, T2>(arg0, arg1, arg4, arg2, arg3);
        let (v1, v2) = fill_a2b<T1, T2>(arg5, arg6, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, &mut v0, arg7), arg8, arg9, arg10, arg11);
        close_swap<T0, T1, T2>(arg1, arg3, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6), v2, v1);
    }

    public fun swap_a2b_with_partner<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_recorded_partner(arg4, arg7);
        assert_amounts(arg8, arg10);
        let v0 = open_swap<T0, T2>(arg0, arg1, arg4, arg2, arg3);
        let (v1, v2) = fill_a2b_partner<T1, T2>(arg5, arg6, arg7, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, &mut v0, arg8), arg9, arg10, arg11, arg12);
        close_swap<T0, T1, T2>(arg1, arg3, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6), v2, v1);
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_amounts(arg7, arg9);
        let v0 = open_swap<T0, T1>(arg0, arg1, arg4, arg2, arg3);
        let (v1, v2) = fill_b2a<T1, T2>(arg5, arg6, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T2, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, &mut v0, arg7), arg8, arg9, arg10, arg11);
        close_swap<T0, T2, T1>(arg1, arg3, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6), v2, v1);
    }

    public fun swap_b2a_with_partner<T0, T1, T2>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ManagerCap, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_recorded_partner(arg4, arg7);
        assert_amounts(arg8, arg10);
        let v0 = open_swap<T0, T1>(arg0, arg1, arg4, arg2, arg3);
        let (v1, v2) = fill_b2a_partner<T1, T2>(arg5, arg6, arg7, 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take<T0, T2, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), arg1, &mut v0, arg8), arg9, arg10, arg11, arg12);
        close_swap<T0, T2, T1>(arg1, arg3, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg6), v2, v1);
    }

    public fun swap_pocket_a2b<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg3: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: u64, arg7: u128, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_amounts(arg6, arg8);
        let (v0, v1) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take_escrow_for_swap<T0, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, arg2, arg6);
        let (v2, v3) = fill_a2b<T1, T2>(arg4, arg5, v0, arg7, arg8, arg9, arg10);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_swap_to_escrow<T0, T1, T2, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, arg2, arg3, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg5), v2, v3);
    }

    public fun swap_pocket_b2a<T0, T1, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Pocket<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::AdapterInfo, arg2: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg3: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: u64, arg7: u128, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_amounts(arg6, arg8);
        let (v0, v1) = 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::take_escrow_for_swap<T0, T2, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, arg2, arg6);
        let (v2, v3) = fill_b2a<T1, T2>(arg4, arg5, v0, arg7, arg8, arg9, arg10);
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::return_swap_to_escrow<T0, T2, T1, 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::CetusWitness>(0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::witness::new(), 0xc8dd309569b722633eb46843140637c992d98e29cdb63492b0c50bb36d4b8074::version::current_version(), arg0, arg1, arg2, arg3, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg5), v2, v3);
    }

    // decompiled from Move bytecode v7
}

