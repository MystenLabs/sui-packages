module 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::cetus_adapter {
    public fun swap_exact_in<T0, T1>(arg0: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::VaultOperatorCap<T0>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u64, arg4: u64) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::assert_operator<T0>(arg0, arg1);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::dex_adapter::assert_dex_allowed<T0>(arg0, arg2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::dex_cetus());
        abort 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::adapter_not_implemented()
    }

    // decompiled from Move bytecode v7
}

