module 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::dkg {
    public fun accept_user_share(arg0: &mut 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::account::Account, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: vector<u8>) {
        assert!(0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::account::has_dwallet(arg0, arg2), 1);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::accept_encrypted_user_share(arg1, arg2, arg3, arg4);
    }

    public fun request_dkg_shared(arg0: &0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::acl::OperatorCap, arg1: &mut 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::account::Account, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0x2::object::ID, arg4: u32, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::NewCredential>, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg12: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg_with_public_user_secret_key_share(arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg2, arg10, arg13), arg11, arg12, arg13);
        let v2 = v0;
        0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::account::store_shared_dwallet_cap(arg1, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&v2), v2, arg8, arg9, arg13);
    }

    public fun request_dkg_zero_trust(arg0: &0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::acl::OperatorCap, arg1: &mut 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::account::Account, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0x2::object::ID, arg4: u32, arg5: vector<u8>, arg6: vector<u8>, arg7: address, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg12: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg2, arg10, arg13), arg11, arg12, arg13);
        let v2 = v0;
        0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::account::store_dwallet_cap(arg1, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&v2), v2, arg13);
    }

    // decompiled from Move bytecode v6
}

