module 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1>(arg0: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg3: &mut 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::protected::ProtectedMarket, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock) {
        let v0 = 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::state::create_extension_key();
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::cache::account_for_extension_liquidity_of_type<T0, T1, 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::state::ExtensionKey>(arg1, arg2, &v0, 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::state::total_active_liquidity<T1>(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_extension<T0, 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::state::ExtensionKey, 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::state::ExtensionStateV1>(arg0, v0), 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::protected::borrow_mut(arg3), arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

