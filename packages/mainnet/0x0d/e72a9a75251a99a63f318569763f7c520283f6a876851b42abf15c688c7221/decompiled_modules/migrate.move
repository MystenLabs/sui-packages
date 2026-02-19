module 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::migrate {
    entry fun migrate<T0>(arg0: &0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::admin::ProtocolAdminCap, arg1: &mut 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::pool::LiquidityPool<T0>, arg2: &mut 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::price_oracle::Oracle, arg3: &mut 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::pool::GlobalConfig, arg4: &0x2::tx_context::TxContext) {
        assert!(0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::pool::get_admin<T0>(arg1) == 0x2::tx_context::sender(arg4), 5000);
        0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::pool::update_module_version(arg3);
        0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::pool::update_pool_version<T0>(arg1);
        0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::price_oracle::update_module_version(arg2);
    }

    // decompiled from Move bytecode v6
}

