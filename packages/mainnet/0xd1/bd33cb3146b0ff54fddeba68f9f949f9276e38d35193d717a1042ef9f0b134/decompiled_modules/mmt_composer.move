module 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_composer {
    struct SwapRecordEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        key_storage: vector<u8>,
        input_amount: u64,
        swap_input_amount: u64,
        swap_output_amount: u64,
        amount_in_vault: u64,
    }

    struct SwapFromRecordEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        key_storage: vector<u8>,
        restore: bool,
        amount_in_vault_before: u64,
        swap_input_amount: u64,
        swap_output_amount: u64,
        amount_in_vault_after: u64,
    }

    struct AddLiquidityRecordEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        key_storage: vector<u8>,
        amount_in_vault: u64,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    public entry fun add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let (v0, v1, v2, v3) = get_coin_amount_for_add_liquidity<T2, T3, T0, T1>(arg1, arg3, arg5, arg6, arg7, arg8);
        let (_, _) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v1 as u64), (v2 as u64), 0, 0, arg9, arg10);
        0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::borrow_access_cap(arg0, arg10)), arg3, arg7);
        let v6 = AddLiquidityRecordEvent<T2, T3>{
            vault_id        : 0x2::object::id<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>>(arg3),
            pool_id         : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T3>(arg1),
            tick_lower      : arg5,
            tick_upper      : arg6,
            key_storage     : arg7,
            amount_in_vault : v3,
            liquidity       : v0,
            amount_a        : (v1 as u64),
            amount_b        : (v2 as u64),
        };
        0x2::event::emit<AddLiquidityRecordEvent<T2, T3>>(v6);
    }

    public entry fun add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let (v0, v1, v2, v3) = get_coin_amount_for_add_liquidity<T0, T2, T0, T1>(arg1, arg3, arg5, arg6, arg7, arg8);
        let (_, _) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v1 as u64), (v2 as u64), 0, 0, arg9, arg10);
        0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::borrow_access_cap(arg0, arg10)), arg3, arg7);
        let v6 = AddLiquidityRecordEvent<T0, T2>{
            vault_id        : 0x2::object::id<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>>(arg3),
            pool_id         : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T0, T2>(arg1),
            tick_lower      : arg5,
            tick_upper      : arg6,
            key_storage     : arg7,
            amount_in_vault : v3,
            liquidity       : v0,
            amount_a        : (v1 as u64),
            amount_b        : (v2 as u64),
        };
        0x2::event::emit<AddLiquidityRecordEvent<T0, T2>>(v6);
    }

    public entry fun add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let (v0, v1, v2, v3) = get_coin_amount_for_add_liquidity<T2, T0, T0, T1>(arg1, arg3, arg5, arg6, arg7, arg8);
        let (_, _) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v1 as u64), (v2 as u64), 0, 0, arg9, arg10);
        0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::borrow_access_cap(arg0, arg10)), arg3, arg7);
        let v6 = AddLiquidityRecordEvent<T2, T0>{
            vault_id        : 0x2::object::id<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>>(arg3),
            pool_id         : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T0>(arg1),
            tick_lower      : arg5,
            tick_upper      : arg6,
            key_storage     : arg7,
            amount_in_vault : v3,
            liquidity       : v0,
            amount_a        : (v1 as u64),
            amount_b        : (v2 as u64),
        };
        0x2::event::emit<AddLiquidityRecordEvent<T2, T0>>(v6);
    }

    fun get_coin_amount_for_add_liquidity<T0, T1, T2, T3>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T2, T3>, arg2: u32, arg3: u32, arg4: vector<u8>, arg5: bool) : (u128, u128, u128, u64) {
        let v0 = 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T2, T3, u64>(arg1, arg4);
        let (v1, v2, v3) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg2, arg3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), (v0 as u128), arg5);
        (v1, v2, v3, v0)
    }

    public entry fun swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg8, arg9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T2, T3>(arg1), (v1 as u128), v2);
        let (_, _) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (v5 as u64), 0, 0, arg10, arg11);
    }

    public entry fun swap_from_record<T0, T1, T2, T3>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::borrow_access_cap(arg0, arg10);
        0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        let v5 = SwapFromRecordEvent<T2, T3>{
            vault_id               : 0x2::object::id<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>>(arg3),
            pool_id                : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1),
            direction              : arg6,
            key_storage            : arg7,
            restore                : arg8,
            amount_in_vault_before : v0,
            swap_input_amount      : v1,
            swap_output_amount     : v2,
            amount_in_vault_after  : v4,
        };
        0x2::event::emit<SwapFromRecordEvent<T2, T3>>(v5);
    }

    public entry fun swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg8, arg9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T2>(arg1), (v1 as u128), v2);
        let (_, _) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (v5 as u64), 0, 0, arg10, arg11);
    }

    public entry fun swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::borrow_access_cap(arg0, arg10);
        0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        let v5 = SwapFromRecordEvent<T0, T2>{
            vault_id               : 0x2::object::id<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>>(arg3),
            pool_id                : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1),
            direction              : arg6,
            key_storage            : arg7,
            restore                : arg8,
            amount_in_vault_before : v0,
            swap_input_amount      : v1,
            swap_output_amount     : v2,
            amount_in_vault_after  : v4,
        };
        0x2::event::emit<SwapFromRecordEvent<T0, T2>>(v5);
    }

    public entry fun swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg8, arg9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T2, T0>(arg1), (v1 as u128), v2);
        let (_, _) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (v5 as u64), 0, 0, arg10, arg11);
    }

    public entry fun swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::borrow_access_cap(arg0, arg10);
        0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        let v5 = SwapFromRecordEvent<T2, T0>{
            vault_id               : 0x2::object::id<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>>(arg3),
            pool_id                : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1),
            direction              : arg6,
            key_storage            : arg7,
            restore                : arg8,
            amount_in_vault_before : v0,
            swap_input_amount      : v1,
            swap_output_amount     : v2,
            amount_in_vault_after  : v4,
        };
        0x2::event::emit<SwapFromRecordEvent<T2, T0>>(v5);
    }

    public entry fun swap_record<T0, T1, T2, T3>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        let v2 = SwapRecordEvent<T2, T3>{
            vault_id           : 0x2::object::id<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>>(arg3),
            pool_id            : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1),
            direction          : arg7,
            key_storage        : arg8,
            input_amount       : arg5,
            swap_input_amount  : v0,
            swap_output_amount : v1,
            amount_in_vault    : 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8),
        };
        0x2::event::emit<SwapRecordEvent<T2, T3>>(v2);
    }

    public entry fun swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        let v2 = SwapRecordEvent<T0, T2>{
            vault_id           : 0x2::object::id<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>>(arg3),
            pool_id            : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1),
            direction          : arg7,
            key_storage        : arg8,
            input_amount       : arg5,
            swap_input_amount  : v0,
            swap_output_amount : v1,
            amount_in_vault    : 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8),
        };
        0x2::event::emit<SwapRecordEvent<T0, T2>>(v2);
    }

    public entry fun swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>, arg4: &mut 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::AccessCap>(0xfb292d8afc3d6e4fca4e735e34b9c6c27c7fc74e20bee025920820c690c22b34::mmt_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        let v2 = SwapRecordEvent<T2, T0>{
            vault_id           : 0x2::object::id<0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::Vault<T0, T1>>(arg3),
            pool_id            : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1),
            direction          : arg7,
            key_storage        : arg8,
            input_amount       : arg5,
            swap_input_amount  : v0,
            swap_output_amount : v1,
            amount_in_vault    : 0x49099704c85d20c73f73234c5349b257ad9664ef21ca562b0ca1574f31be427b::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8),
        };
        0x2::event::emit<SwapRecordEvent<T2, T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

