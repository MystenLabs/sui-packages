module 0xdf0ed7f86a6ff414a0a39c6fc140e6d8ebe8da2b7136f33fe6179cefc71abbcc::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1, T2>(arg0: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg3: &mut 0xdf0ed7f86a6ff414a0a39c6fc140e6d8ebe8da2b7136f33fe6179cefc71abbcc::protected::ProtectedLendingMarket<T1>) {
        let v0 = 0xdf0ed7f86a6ff414a0a39c6fc140e6d8ebe8da2b7136f33fe6179cefc71abbcc::state::create_extension_key();
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::cache::account_for_extension_liquidity_of_type<T0, T2, 0xdf0ed7f86a6ff414a0a39c6fc140e6d8ebe8da2b7136f33fe6179cefc71abbcc::state::ExtensionKey>(arg1, arg2, &v0, 0xdf0ed7f86a6ff414a0a39c6fc140e6d8ebe8da2b7136f33fe6179cefc71abbcc::state::total_active_liquidity<T1, T2>(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_extension<T0, 0xdf0ed7f86a6ff414a0a39c6fc140e6d8ebe8da2b7136f33fe6179cefc71abbcc::state::ExtensionKey, 0xdf0ed7f86a6ff414a0a39c6fc140e6d8ebe8da2b7136f33fe6179cefc71abbcc::state::ExtensionStateV1<T1>>(arg0, v0), 0xdf0ed7f86a6ff414a0a39c6fc140e6d8ebe8da2b7136f33fe6179cefc71abbcc::protected::borrow_mut<T1>(arg3)));
    }

    // decompiled from Move bytecode v6
}

