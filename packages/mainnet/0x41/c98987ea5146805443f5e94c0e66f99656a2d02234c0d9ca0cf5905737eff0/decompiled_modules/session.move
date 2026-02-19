module 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::session {
    public fun deposit_into_extension<T0, T1, T2>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::SessionCap<T0>, arg1: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::SessionCap<T1>, arg2: &0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<0x2::coin::Coin<T0>> {
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::assert_package_version(arg2);
        let v0 = 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key();
        let v1 = 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::deposit<T1, T2>(arg1, arg3, arg4, arg5, arg6);
        let v2 = 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::borrow_mut_extension<T0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, v0);
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::crank_unlocks<T1>(v2, arg5);
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::join<T1>(v2, v1, 0x2::coin::value<T1>(0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::borrow<0x2::coin::Coin<T1>>(&v1)), arg5);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::deposit_into_extension<T0, T2, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey>(arg0, arg3, &v0, &arg4, arg5, arg6)
    }

    public fun crank_unlocks<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::SessionCap<T0>, arg1: &0x2::clock::Clock) {
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::crank_unlocks<T1>(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::borrow_mut_extension<T0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key()), arg1);
    }

    public fun withdraw_from_extension<T0, T1, T2>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::SessionCap<T0>, arg1: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::ForceWithdrawCap<T0, T2>, arg2: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::SessionCap<T1>, arg3: &0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::Config, arg4: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::assert_package_version(arg3);
        let v0 = 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key();
        let v1 = 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::borrow_mut_extension<T0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, v0);
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::crank_unlocks<T1>(v1, arg5);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::force_withdraw_from_extension<T0, T2, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey>(arg0, arg1, arg4, v0, 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::withdraw<T1, T2>(arg2, arg4, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::split<T1>(v1, 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::remaining_amount<T0, T2>(arg1), arg6), arg5, arg6));
    }

    // decompiled from Move bytecode v6
}

