module 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::sign {
    struct SignRequested has copy, drop {
        sign_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        signature_algorithm: u32,
        hash_scheme: u32,
    }

    public fun request_future_sign(arg0: &mut 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::Account, arg1: vector<0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::auth::Credential>, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0x2::object::ID, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg5: u32, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap {
        assert!(0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::has_shared_dwallet(arg0, arg3), 1);
        let v0 = future_sign_payload_digest(arg5, &arg6);
        let v1 = 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::stored_shared_uid_bytes(arg0, arg3);
        let v2 = 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::challenges::request_future_sign(&v1, 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::stored_shared_nonce(arg0, arg3), &v0);
        0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::authorize_shared_and_bump_nonce(arg0, arg3, arg1, &v2, arg11);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_future_sign(arg2, arg3, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg2, arg4, arg11), arg6, arg5, arg7, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg2, arg8, arg11), arg9, arg10, arg11)
    }

    public fun verify_partial_user_signature_cap(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap, arg2: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_partial_user_signature_cap(arg0, arg1, arg2)
    }

    public fun complete_future_sign(arg0: &mut 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::Account, arg1: vector<0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::auth::Credential>, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0x2::object::ID, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::has_shared_dwallet(arg0, arg3), 1);
        let v0 = sign_payload_digest(arg5, arg6, &arg7);
        let v1 = 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::stored_shared_uid_bytes(arg0, arg3);
        let v2 = 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::challenges::complete_future_sign(&v1, 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::stored_shared_nonce(arg0, arg3), &v0);
        0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::authorize_shared_and_bump_nonce(arg0, arg3, arg1, &v2, arg11);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_with_partial_user_signature_and_return_id(arg2, arg4, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg2, 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::shared_dwallet_cap(arg0, arg3), arg5, arg6, arg7), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg2, arg8, arg11), arg9, arg10, arg11)
    }

    fun future_sign_payload_digest(arg0: u32, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u32>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(arg1));
        0x1::hash::sha2_256(v0)
    }

    public fun request_sign_shared(arg0: &mut 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::Account, arg1: vector<0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::auth::Credential>, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: 0x2::object::ID, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg11: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::has_shared_dwallet(arg0, arg3), 1);
        let v0 = sign_payload_digest(arg5, arg6, &arg7);
        let v1 = 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::stored_shared_uid_bytes(arg0, arg3);
        let v2 = 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::challenges::request_sign(&v1, 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::stored_shared_nonce(arg0, arg3), &v0);
        0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::authorize_shared_and_bump_nonce(arg0, arg3, arg1, &v2, arg12);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_and_return_id(arg2, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg2, arg4, arg12), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg2, 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::shared_dwallet_cap(arg0, arg3), arg5, arg6, arg7), arg8, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg2, arg9, arg12), arg10, arg11, arg12)
    }

    public fun request_sign_zero_trust(arg0: &mut 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::Account, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg4: u32, arg5: u32, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::has_dwallet(arg0, arg2), 1);
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_and_return_id(arg1, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, arg3, arg11), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::account::dwallet_cap(arg0, arg2), arg4, arg5, arg6), arg7, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg1, arg8, arg11), arg9, arg10, arg11);
        let v1 = SignRequested{
            sign_id             : v0,
            dwallet_id          : arg2,
            signature_algorithm : arg4,
            hash_scheme         : arg5,
        };
        0x2::event::emit<SignRequested>(v1);
        v0
    }

    fun sign_payload_digest(arg0: u32, arg1: u32, arg2: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u32>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u32>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(arg2));
        0x1::hash::sha2_256(v0)
    }

    // decompiled from Move bytecode v6
}

