module 0xf9956ec46f16511f004189a79f8be54adc85c504b7e68254069b43fb9becb45c::dwallet_factory {
    public fun create_shared_dwallet(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: 0x2::object::ID, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        let (v0, _) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg_with_public_user_secret_key_share(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg0, arg6, arg9), arg7, arg8, arg9);
        v0
    }

    public fun create_shared_dwallet_with_treasury(arg0: &mut 0xf9956ec46f16511f004189a79f8be54adc85c504b7e68254069b43fb9becb45c::treasury::Treasury, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID, arg3: u32, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        let (v0, v1) = 0xf9956ec46f16511f004189a79f8be54adc85c504b7e68254069b43fb9becb45c::treasury::withdraw_coins(arg0, arg8);
        let v2 = v1;
        let v3 = v0;
        let (v4, _) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg_with_public_user_secret_key_share(arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg1, arg7, arg8), &mut v3, &mut v2, arg8);
        0xf9956ec46f16511f004189a79f8be54adc85c504b7e68254069b43fb9becb45c::treasury::return_coins(arg0, v3, v2);
        v4
    }

    // decompiled from Move bytecode v6
}

