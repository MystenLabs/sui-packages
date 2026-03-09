module 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1>(arg0: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg3: &mut 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::protected::ProtectedStorage) {
        let v0 = 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::state::create_extension_key();
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::cache::account_for_extension_liquidity_of_type<T0, T1, 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::state::ExtensionKey>(arg1, arg2, &v0, 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::state::total_active_liquidity<T1>(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_extension<T0, 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::state::ExtensionKey, 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::state::ExtensionStateV1>(arg0, v0), 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::protected::borrow_mut(arg3)));
    }

    // decompiled from Move bytecode v6
}

