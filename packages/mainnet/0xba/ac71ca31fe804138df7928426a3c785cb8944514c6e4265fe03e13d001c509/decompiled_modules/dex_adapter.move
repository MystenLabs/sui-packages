module 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::dex_adapter {
    public fun assert_dex_allowed<T0>(arg0: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T0>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: u8) {
        assert!(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::is_dex_allowed(arg1, arg2), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::dex_not_allowed());
        assert!(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::is_dex_allowed<T0>(arg0, arg2), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::dex_not_allowed());
    }

    public fun assert_pool_allowed<T0>(arg0: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T0>, arg1: 0x2::object::ID) {
        assert!(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::is_pool_allowed<T0>(arg0, arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::pool_not_allowed());
    }

    // decompiled from Move bytecode v7
}

