module 0x14deadc7b4b49527adfd12ad08443bb6379afe05b154d938d3f752ee6ee61f5::certifier {
    struct BlobCertifier has store, key {
        id: 0x2::object::UID,
        dwallet_cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap,
        presigns: vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>,
        ika_balance: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        dwallet_network_encryption_key_id: 0x2::object::ID,
        first_epoch_start_ms: u64,
        epoch_duration_ms: u64,
    }

    struct AttestationRequested has copy, drop {
        sign_request_id: 0x2::object::ID,
        blob_id: u256,
        registered_epoch: u32,
        start_epoch: u32,
        end_epoch: u32,
        end_timestamp_ms: u64,
        extra_data: vector<u8>,
        requester: address,
    }

    fun abi_encode_u256(arg0: u256) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun abi_encode_u32(arg0: u32) : vector<u8> {
        abi_encode_u256((arg0 as u256))
    }

    fun abi_encode_u64(arg0: u64) : vector<u8> {
        abi_encode_u256((arg0 as u256))
    }

    public fun add_presigns(arg0: &mut BlobCertifier, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns) + arg2 <= 10, 4);
        let v0 = 0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::split<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.ika_balance)), arg3);
        let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)), arg3);
        let v2 = 0;
        while (v2 < arg2) {
            0x1::vector::push_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut arg0.presigns, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_global_presign(arg1, arg0.dwallet_network_encryption_key_id, 0, 0, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg1, 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg3)), arg3), &mut v0, &mut v1, arg3));
            v2 = v2 + 1;
        };
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(v0));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
    }

    public fun attest_blob(arg0: &mut BlobCertifier, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg6));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg7));
        assert!(0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(arg2)), 0);
        assert!(!0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(arg2), 1);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 5);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(arg2);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::registered_epoch(arg2);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(arg2));
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(arg2);
        let v4 = arg0.first_epoch_start_ms + ((v3 as u64) - 1) * arg0.epoch_duration_ms;
        assert!(arg3 < 0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns), 6);
        let v5 = 0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::split<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.ika_balance)), arg8);
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)), arg8);
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(v5));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v6));
        let v7 = AttestationRequested{
            sign_request_id  : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_and_return_id(arg1, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, 0x1::vector::swap_remove<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut arg0.presigns, arg3), arg8), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, &arg0.dwallet_cap, 0, 1, build_eip712_digest(v0, v1, v2, v3, v4, arg4)), arg5, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg1, 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg8)), arg8), &mut v5, &mut v6, arg8),
            blob_id          : v0,
            registered_epoch : v1,
            start_epoch      : v2,
            end_epoch        : v3,
            end_timestamp_ms : v4,
            extra_data       : arg4,
            requester        : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<AttestationRequested>(v7);
    }

    fun build_eip712_digest(arg0: u256, arg1: u32, arg2: u32, arg3: u32, arg4: u64, arg5: vector<u8>) : vector<u8> {
        let v0 = x"050886ae044ecb4b90c6a98a23a5957269bc629907e0dc999d053d3aa78ad025";
        0x1::vector::append<u8>(&mut v0, abi_encode_u256(arg0));
        0x1::vector::append<u8>(&mut v0, abi_encode_u32(arg1));
        0x1::vector::append<u8>(&mut v0, abi_encode_u32(arg2));
        0x1::vector::append<u8>(&mut v0, abi_encode_u32(arg3));
        0x1::vector::append<u8>(&mut v0, abi_encode_u64(arg4));
        0x1::vector::append<u8>(&mut v0, arg5);
        let v1 = x"1901";
        0x1::vector::append<u8>(&mut v1, x"fb895d9b22beb4592dec4f8eee6d3e8af154763e6844d18328ec403a56e8a08f");
        0x1::vector::append<u8>(&mut v1, 0x2::hash::keccak256(&v0));
        0x2::hash::keccak256(&v1)
    }

    public fun create_certifier(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg_with_public_user_secret_key_share(arg0, arg3, 0, arg4, arg5, arg6, 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg0, arg7, arg10), &mut arg1, &mut arg2, arg10);
        let v2 = BlobCertifier{
            id                                : 0x2::object::new(arg10),
            dwallet_cap                       : v0,
            presigns                          : 0x1::vector::empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(),
            ika_balance                       : 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1),
            sui_balance                       : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            dwallet_network_encryption_key_id : arg3,
            first_epoch_start_ms              : arg8,
            epoch_duration_ms                 : arg9,
        };
        0x2::transfer::public_share_object<BlobCertifier>(v2);
    }

    public fun fund(arg0: &mut BlobCertifier, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun ika_balance_value(arg0: &BlobCertifier) : u64 {
        0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.ika_balance)
    }

    public fun presign_count(arg0: &BlobCertifier) : u64 {
        0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns)
    }

    public fun sui_balance_value(arg0: &BlobCertifier) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    // decompiled from Move bytecode v6
}

