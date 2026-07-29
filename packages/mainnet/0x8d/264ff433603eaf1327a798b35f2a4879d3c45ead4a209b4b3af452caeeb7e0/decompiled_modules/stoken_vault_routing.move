module 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_vault_routing {
    public fun process_deposits<T0, T1>(arg0: &mut 0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>, arg1: &0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::ProcessorCap, arg2: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_proxy_is_current_am<T0, T1>(arg0, arg2);
        0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::process_deposits<T0, T1>(arg0, arg1, arg3, arg5);
    }

    public fun process_deposits_manager<T0, T1>(arg0: &mut 0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>, arg1: &0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::ManagerCap, arg2: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_proxy_is_current_am<T0, T1>(arg0, arg2);
        0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::process_deposits_manager<T0, T1>(arg0, arg1, arg3, arg5);
    }

    fun assert_proxy_can_return<T0, T1>(arg0: &0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>, arg1: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>) {
        assert_proxy_registered_for_vault<T0, T1>(arg0, arg1);
        let v0 = 0x2::object::id<0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        assert!(0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::asset_manager_return_allowed<T0, T1>(arg0, 0x2::object::id_to_address(&v0)), 1);
    }

    fun assert_proxy_is_current_am<T0, T1>(arg0: &0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>, arg1: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>) {
        assert_proxy_registered_for_vault<T0, T1>(arg0, arg1);
        let v0 = 0x2::object::id<0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == 0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::get_asset_manager<T0, T1>(arg0), 1);
    }

    fun assert_proxy_registered_for_vault<T0, T1>(arg0: &0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>, arg1: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>) {
        assert!(0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::is_vault_registered<T0>(arg1, 0x2::object::id<0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>>(arg0)), 1);
    }

    public fun attach_proxy_asset_manager<T0, T1>(arg0: &mut 0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>, arg1: &0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::AdminCap, arg2: &mut 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>, arg3: 0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::AssetManagerCap, arg4: &0x2::tx_context::TxContext) {
        assert!(0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::is_vault_registered<T0>(arg2, 0x2::object::id<0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>>(arg0)), 1);
        assert!(0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::asset_manager_cap_vault_id(&arg3) == 0x2::object::id<0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>>(arg2);
        0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::attach_asset_manager_role<T0, T1>(arg0, arg1, 0x2::object::id_to_address(&v0), arg4);
        0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::store_asset_manager_cap<T0>(arg2, arg3);
    }

    public fun claim_deployed_funds<T0>(arg0: &mut 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::clock::Clock) {
        0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::claim_received<T0>(arg0, arg1, arg2);
    }

    public fun emergency_sweep_to_vault<T0, T1>(arg0: &mut 0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>, arg1: &mut 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>, arg2: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyManagerCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_proxy_can_return<T0, T1>(arg0, arg1);
        let v0 = 0x2::object::id<0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::credit_returned_underlying<T0, T1>(arg0, 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::borrow_asset_manager_cap<T0>(arg1, 0x2::object::id<0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>>(arg0)), 0x2::object::id_to_address(&v0), 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::emergency_sweep<T0>(arg1, arg2, arg3, arg4, arg5));
    }

    public fun return_funds_from_proxy<T0, T1>(arg0: &mut 0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>, arg1: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>, arg2: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyProcessorCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::get_processor_cap_proxy_id(arg2) == 0x2::object::id<0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>>(arg1), 1);
        assert_proxy_can_return<T0, T1>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg5) == 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::get_processor<T0>(arg1), 1);
        let v0 = 0x2::object::id<0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::credit_returned_underlying<T0, T1>(arg0, 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::borrow_asset_manager_cap<T0>(arg1, 0x2::object::id<0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>>(arg0)), 0x2::object::id_to_address(&v0), arg3);
    }

    public fun return_funds_from_proxy_manager<T0, T1>(arg0: &mut 0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>, arg1: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>, arg2: &0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyManagerCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::get_manager_cap_proxy_id(arg2) == 0x2::object::id<0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>>(arg1), 1);
        assert_proxy_can_return<T0, T1>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg5) == 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::get_manager<T0>(arg1), 1);
        let v0 = 0x2::object::id<0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::credit_returned_underlying<T0, T1>(arg0, 0x8d264ff433603eaf1327a798b35f2a4879d3c45ead4a209b4b3af452caeeb7e0::stoken_proxy::borrow_asset_manager_cap<T0>(arg1, 0x2::object::id<0x6281b88894ed290cdf01ad718c3b29663d3ac11843ffcf431d7e5c66e707eea::stoken_vault::Vault<T0, T1>>(arg0)), 0x2::object::id_to_address(&v0), arg3);
    }

    // decompiled from Move bytecode v7
}

