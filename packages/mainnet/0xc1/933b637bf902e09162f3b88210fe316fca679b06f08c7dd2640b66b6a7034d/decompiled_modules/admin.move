module 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::AdminCap, arg1: &mut 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::Vault<T0, T1, T2, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::set_slippage<T0, T1, T2, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::AdminCap, arg1: &mut 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::Vault<T0, T1, T2, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::error::upper_lower_trigger_price_incompatible());
        0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::config::set_trigger_price_scalling(0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::borrow_mut_config<T0, T1, T2, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

