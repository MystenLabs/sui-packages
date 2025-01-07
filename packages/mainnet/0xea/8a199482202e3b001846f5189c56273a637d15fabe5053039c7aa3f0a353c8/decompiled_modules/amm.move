module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::amm {
    public fun add_liquidity_1_coins<T0>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_1<T0, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::AddLiquidityEvent>(arg0, arg1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg3);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 0x2::coin::value<T0>(arg1));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_add_liquidity_event(0x2::tx_context::sender(arg3), v0, v1, arg2);
    }

    public fun add_liquidity_2_coins<T0, T1>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_2<T0, T1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::AddLiquidityEvent>(arg0, arg1, arg2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_add_liquidity_event(0x2::tx_context::sender(arg4), v0, v2, arg3);
    }

    public fun add_liquidity_3_coins<T0, T1, T2>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_3<T0, T1, T2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::AddLiquidityEvent>(arg0, arg1, arg2, arg3, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg5);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_add_liquidity_event(0x2::tx_context::sender(arg5), v0, v2, arg4);
    }

    public fun add_liquidity_4_coins<T0, T1, T2, T3>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_4<T0, T1, T2, T3, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::AddLiquidityEvent>(arg0, arg1, arg2, arg3, arg4, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg6);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T3>(arg4));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_add_liquidity_event(0x2::tx_context::sender(arg6), v0, v2, arg5);
    }

    public fun add_liquidity_5_coins<T0, T1, T2, T3, T4>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &mut 0x2::coin::Coin<T4>, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_5<T0, T1, T2, T3, T4, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::AddLiquidityEvent>(arg0, arg1, arg2, arg3, arg4, arg5, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg7);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T3>(arg4));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T4>(arg5));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_add_liquidity_event(0x2::tx_context::sender(arg7), v0, v2, arg6);
    }

    public fun add_liquidity_6_coins<T0, T1, T2, T3, T4, T5>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &mut 0x2::coin::Coin<T4>, arg6: &mut 0x2::coin::Coin<T5>, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_6<T0, T1, T2, T3, T4, T5, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::AddLiquidityEvent>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg8);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T5>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T3>(arg4));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T4>(arg5));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T5>(arg6));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_add_liquidity_event(0x2::tx_context::sender(arg8), v0, v2, arg7);
    }

    public fun add_liquidity_7_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &mut 0x2::coin::Coin<T4>, arg6: &mut 0x2::coin::Coin<T5>, arg7: &mut 0x2::coin::Coin<T6>, arg8: 0x2::object::ID, arg9: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_7<T0, T1, T2, T3, T4, T5, T6, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::AddLiquidityEvent>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg9);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T5>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T6>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T3>(arg4));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T4>(arg5));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T5>(arg6));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T6>(arg7));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_add_liquidity_event(0x2::tx_context::sender(arg9), v0, v2, arg8);
    }

    public fun remove_liquidity_1_coins<T0>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_1<T0, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::RemoveLiquidityEvent>(arg0, arg1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg3);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 0x2::coin::value<T0>(arg1));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_remove_liquidity_event(0x2::tx_context::sender(arg3), v0, v1, arg2);
    }

    public fun remove_liquidity_2_coins<T0, T1>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_2<T0, T1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::RemoveLiquidityEvent>(arg0, arg1, arg2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_remove_liquidity_event(0x2::tx_context::sender(arg4), v0, v2, arg3);
    }

    public fun remove_liquidity_3_coins<T0, T1, T2>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_3<T0, T1, T2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::RemoveLiquidityEvent>(arg0, arg1, arg2, arg3, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg5);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_remove_liquidity_event(0x2::tx_context::sender(arg5), v0, v2, arg4);
    }

    public fun remove_liquidity_4_coins<T0, T1, T2, T3>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_4<T0, T1, T2, T3, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::RemoveLiquidityEvent>(arg0, arg1, arg2, arg3, arg4, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg6);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T3>(arg4));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_remove_liquidity_event(0x2::tx_context::sender(arg6), v0, v2, arg5);
    }

    public fun remove_liquidity_5_coins<T0, T1, T2, T3, T4>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &mut 0x2::coin::Coin<T4>, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_5<T0, T1, T2, T3, T4, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::RemoveLiquidityEvent>(arg0, arg1, arg2, arg3, arg4, arg5, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg7);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T3>(arg4));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T4>(arg5));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_remove_liquidity_event(0x2::tx_context::sender(arg7), v0, v2, arg6);
    }

    public fun remove_liquidity_6_coins<T0, T1, T2, T3, T4, T5>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &mut 0x2::coin::Coin<T4>, arg6: &mut 0x2::coin::Coin<T5>, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_6<T0, T1, T2, T3, T4, T5, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::RemoveLiquidityEvent>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg8);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T5>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T3>(arg4));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T4>(arg5));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T5>(arg6));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_remove_liquidity_event(0x2::tx_context::sender(arg8), v0, v2, arg7);
    }

    public fun remove_liquidity_7_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &mut 0x2::coin::Coin<T4>, arg6: &mut 0x2::coin::Coin<T5>, arg7: &mut 0x2::coin::Coin<T6>, arg8: 0x2::object::ID, arg9: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_7<T0, T1, T2, T3, T4, T5, T6, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::RemoveLiquidityEvent>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::amm_fee_type(), arg9);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T5>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T6>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T2>(arg3));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T3>(arg4));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T4>(arg5));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T5>(arg6));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T6>(arg7));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_amm::emit_remove_liquidity_event(0x2::tx_context::sender(arg9), v0, v2, arg8);
    }

    // decompiled from Move bytecode v6
}

