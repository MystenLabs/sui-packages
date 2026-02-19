module 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::session {
    public fun deposit_into_extension<T0>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::SessionCap<T0>, arg1: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x9775782a66473e9d441e5d16ef77fc36a9dd7e061d84565f3120fb2d4d9e25c::locked::Locked<0x2::coin::Coin<T0>> {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg1);
        let v0 = 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key();
        let v1 = 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, v0);
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::deposit_into_extension(v1, arg3, arg4, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::deposit_into_extension_validator_preference(v1), arg6);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::deposit_into_extension<T0, 0x2::sui::SUI, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey>(arg0, arg2, &v0, &arg4, arg5, arg6)
    }

    public fun withdraw_from_extension<T0>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::SessionCap<T0>, arg1: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::ForceWithdrawCap<T0, 0x2::sui::SUI>, arg2: &0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::config::assert_package_version(arg2);
        let v0 = 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::create_extension_key();
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::force_withdraw_from_extension<T0, 0x2::sui::SUI, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey>(arg0, arg1, arg3, v0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::withdraw_from_extension(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::borrow_mut_extension<T0, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionKey, 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state::ExtensionStateV1>(arg0, v0), arg4, 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::remaining_amount<T0, 0x2::sui::SUI>(arg1), arg5));
    }

    // decompiled from Move bytecode v6
}

