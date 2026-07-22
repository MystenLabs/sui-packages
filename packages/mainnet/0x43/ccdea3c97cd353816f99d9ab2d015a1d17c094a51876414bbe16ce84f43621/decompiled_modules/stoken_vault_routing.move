module 0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_vault_routing {
    public fun attach_proxy_asset_manager<T0, T1>(arg0: &mut 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>, arg1: &0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::AdminCap, arg2: &0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_vault_id<T0>(arg2) == 0x2::object::id<0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>>(arg2);
        0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::attach_asset_manager_role<T0, T1>(arg0, arg1, 0x2::object::id_to_address(&v0), arg3);
    }

    public fun emergency_sweep_to_vault<T0, T1>(arg0: &mut 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>, arg1: &mut 0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>, arg2: &0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyManagerCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_vault_id<T0>(arg1) == 0x2::object::id<0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>>(arg0), 1);
        0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::credit_returned_underlying<T0, T1>(arg0, 0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::emergency_sweep<T0>(arg1, arg2, arg3, arg4, arg5));
    }

    public fun process_deposits<T0, T1>(arg0: &mut 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>, arg1: &0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::ProcessorCap, arg2: &mut 0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_vault_id<T0>(arg2) == 0x2::object::id<0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>>(arg2);
        assert!(0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::asset_manager_return_allowed<T0, T1>(arg0, 0x2::object::id_to_address(&v0)), 1);
        0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::accept_underlying<T0>(arg2, 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::withdraw_idle_to_coin<T0, T1>(arg0, arg1, arg3, arg5));
    }

    public fun process_deposits_manager<T0, T1>(arg0: &mut 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>, arg1: &0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::ManagerCap, arg2: &mut 0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_vault_id<T0>(arg2) == 0x2::object::id<0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>>(arg2);
        assert!(0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::asset_manager_return_allowed<T0, T1>(arg0, 0x2::object::id_to_address(&v0)), 1);
        0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::accept_underlying<T0>(arg2, 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::withdraw_idle_to_coin_manager<T0, T1>(arg0, arg1, arg3, arg5));
    }

    public fun return_funds_from_proxy<T0, T1>(arg0: &mut 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>, arg1: &0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>, arg2: &0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyProcessorCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_processor_cap_proxy_id(arg2) == 0x2::object::id<0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>>(arg1), 1);
        assert!(0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_vault_id<T0>(arg1) == 0x2::object::id<0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::get_asset_manager<T0, T1>(arg0), 1);
        assert!(0x2::tx_context::sender(arg5) == 0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_processor<T0>(arg1), 1);
        0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::credit_returned_underlying<T0, T1>(arg0, arg3);
    }

    public fun return_funds_from_proxy_manager<T0, T1>(arg0: &mut 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>, arg1: &0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>, arg2: &0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyManagerCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_manager_cap_proxy_id(arg2) == 0x2::object::id<0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>>(arg1), 1);
        assert!(0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_vault_id<T0>(arg1) == 0x2::object::id<0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == 0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::get_asset_manager<T0, T1>(arg0), 1);
        assert!(0x2::tx_context::sender(arg5) == 0x43ccdea3c97cd353816f99d9ab2d015a1d17c094a51876414bbe16ce84f43621::stoken_proxy::get_manager<T0>(arg1), 1);
        0xdc5204320d39d5a74e47f00d2c669b188ec32575bd0654565dcb13119e83415::stoken_vault::credit_returned_underlying<T0, T1>(arg0, arg3);
    }

    // decompiled from Move bytecode v7
}

