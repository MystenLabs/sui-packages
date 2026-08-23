module 0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::lite {
    public fun create_lite_dwallet(arg0: &mut 0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::LitePaymentPool, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: u32, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg11: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::ensure_lite_account_registered(arg0, &arg2, arg3, arg4, arg11);
        0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::assert_dwallet_creation_allowed(arg0, 0x2::tx_context::sender(arg11), arg6);
        let (v0, v1) = 0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::withdraw_payment_coins(arg0, arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, _) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg_with_public_user_secret_key_share(arg1, arg5, arg6, arg7, arg9, arg8, 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(), arg10, &mut v3, &mut v2, arg11);
        let v6 = v4;
        0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::return_payment_coins(arg0, v3, v2);
        0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::bind_dwallet_cap(arg0, 0x2::tx_context::sender(arg11), arg6, &v6);
        v6
    }

    public fun lite_sign(arg0: &mut 0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::LitePaymentPool, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: u32, arg8: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg9: &mut 0x2::tx_context::TxContext) {
        0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::assert_sign_cap_allowed(arg0, 0x2::tx_context::sender(arg9), arg2);
        0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::do_sign(arg1, arg0, arg2, arg3, arg4, arg5, arg7, arg6, arg8, arg9);
    }

    public fun mint_lite_presign(arg0: &mut 0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::LitePaymentPool, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg6: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap {
        0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::assert_presign_mint_allowed(arg0, 0x2::tx_context::sender(arg6), arg3);
        0xa4b1e3eb90db03507222c3071b375f032c848c3b55f734ec49d67e3df9b0a0b1::core::mint_presign(arg1, arg0, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

