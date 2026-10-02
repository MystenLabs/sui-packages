module 0xb03c997dc08e3dae8b172678a2467095a2bc74a9af7a2f00cba04d876cb95120::escrow {
    struct Escrow has key {
        id: 0x2::object::UID,
        coordinator_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        source_share_id: 0x2::object::ID,
        seller: address,
        recipient: address,
        recipient_encryption_address: address,
        recipient_signing_public_key: vector<u8>,
        curve: u32,
        public_output_hash: vector<u8>,
        request_id: vector<u8>,
        ownership_request: vector<u8>,
        price_mist: u64,
        deadline_ms: u64,
        state: u8,
        cap: 0x1::option::Option<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>,
        destination_share_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ClaimReceipt has copy, drop, store {
        escrow_id: 0x2::object::ID,
        request_id: vector<u8>,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        destination_share_id: 0x2::object::ID,
        seller: address,
        recipient: address,
        price_mist: u64,
        deadline_ms: u64,
        coordinator_id: 0x2::object::ID,
    }

    struct Prepared has copy, drop {
        escrow_id: 0x2::object::ID,
        request_id: vector<u8>,
        seller: address,
        recipient: address,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        price_mist: u64,
        deadline_ms: u64,
    }

    struct Locked has copy, drop {
        escrow_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        source_share_id: 0x2::object::ID,
        recipient_encryption_address: address,
    }

    struct Claimed has copy, drop {
        escrow_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        destination_share_id: 0x2::object::ID,
        seller: address,
        recipient: address,
        price_mist: u64,
    }

    struct Cancelled has copy, drop {
        escrow_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        seller: address,
        was_locked: bool,
    }

    public fun cancel(arg0: &mut Escrow, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        cancel_at(arg0, 0x2::clock::timestamp_ms(arg1), 0x2::tx_context::sender(arg2));
    }

    fun cancel_at(arg0: &mut Escrow, arg1: u64, arg2: address) {
        assert!(arg2 == arg0.seller, 0);
        assert!(arg0.state == 0 || arg0.state == 1, 1);
        assert!(arg1 >= arg0.deadline_ms, 4);
        let v0 = arg0.state == 1;
        if (v0) {
            0x2::transfer::public_transfer<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(0x1::option::extract<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.cap), arg0.seller);
        };
        arg0.state = 3;
        let v1 = Cancelled{
            escrow_id  : 0x2::object::id<Escrow>(arg0),
            cap_id     : arg0.cap_id,
            seller     : arg0.seller,
            was_locked : v0,
        };
        0x2::event::emit<Cancelled>(v1);
    }

    public fun cap_id(arg0: &Escrow) : 0x2::object::ID {
        arg0.cap_id
    }

    fun check_wallet(arg0: &Escrow, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator) {
        assert!(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator>(arg1) == arg0.coordinator_id, 2);
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::get_dwallet(arg1, arg0.dwallet_id);
        assert!(!0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::is_imported_key_dwallet(v0), 8);
        assert!(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::curve(v0) == arg0.curve && 0x2::hash::blake2b256(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::validate_active_and_get_public_output(v0)) == arg0.public_output_hash, 2);
    }

    public fun claim(arg0: &mut Escrow, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        check_wallet(arg0, arg1);
        claim_verified(arg0, 0x2::clock::timestamp_ms(arg2), arg3, arg4, arg5, 0x2::tx_context::sender(arg6));
    }

    public fun claim_receipt_bytes(arg0: &Escrow, arg1: 0x2::object::ID) : vector<u8> {
        let v0 = ClaimReceipt{
            escrow_id            : 0x2::object::id<Escrow>(arg0),
            request_id           : arg0.request_id,
            dwallet_id           : arg0.dwallet_id,
            cap_id               : arg0.cap_id,
            destination_share_id : arg1,
            seller               : arg0.seller,
            recipient            : arg0.recipient,
            price_mist           : arg0.price_mist,
            deadline_ms          : arg0.deadline_ms,
            coordinator_id       : arg0.coordinator_id,
        };
        let v1 = b"m1k4.ownership.escrow.claim.v1";
        0x1::vector::push_back<u8>(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<ClaimReceipt>(&v0));
        v1
    }

    fun claim_verified(arg0: &mut Escrow, arg1: u64, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address) {
        assert!(arg5 == arg0.recipient, 0);
        assert!(arg0.state == 1 && 0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.cap), 1);
        assert!(arg1 < arg0.deadline_ms, 3);
        assert!(0x2::object::id_to_address(&arg2) != @0x0 && arg2 != arg0.source_share_id, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg0.price_mist, 6);
        let v0 = if (0x1::vector::length<u8>(&arg3) == 64) {
            let v1 = claim_receipt_bytes(arg0, arg2);
            0x2::ed25519::ed25519_verify(&arg3, &arg0.recipient_signing_public_key, &v1)
        } else {
            false
        };
        assert!(v0, 7);
        arg0.state = 2;
        arg0.destination_share_id = 0x1::option::some<0x2::object::ID>(arg2);
        if (arg0.price_mist == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.seller);
        };
        0x2::transfer::public_transfer<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(0x1::option::extract<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.cap), arg0.recipient);
        let v2 = Claimed{
            escrow_id            : 0x2::object::id<Escrow>(arg0),
            dwallet_id           : arg0.dwallet_id,
            cap_id               : arg0.cap_id,
            destination_share_id : arg2,
            seller               : arg0.seller,
            recipient            : arg0.recipient,
            price_mist           : arg0.price_mist,
        };
        0x2::event::emit<Claimed>(v2);
    }

    public fun close_expired_request(arg0: &mut Escrow, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.recipient, 0);
        assert!(arg0.state == 0 && 0x1::option::is_none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.cap), 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms, 4);
        arg0.state = 3;
        let v0 = Cancelled{
            escrow_id  : 0x2::object::id<Escrow>(arg0),
            cap_id     : arg0.cap_id,
            seller     : arg0.seller,
            was_locked : false,
        };
        0x2::event::emit<Cancelled>(v0);
    }

    public fun dwallet_id(arg0: &Escrow) : 0x2::object::ID {
        arg0.dwallet_id
    }

    public fun lock_and_reencrypt(arg0: &mut Escrow, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &0x2::clock::Clock, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg4: vector<u8>, arg5: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg6: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        check_wallet(arg0, arg1);
        lock_cap(arg0, arg3, 0x2::clock::timestamp_ms(arg2), 0x2::tx_context::sender(arg8));
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_re_encrypt_user_share_for(arg1, arg0.dwallet_id, arg0.recipient_encryption_address, arg4, arg0.source_share_id, arg5, arg6, arg7, arg8);
        let v0 = Locked{
            escrow_id                    : 0x2::object::id<Escrow>(arg0),
            dwallet_id                   : arg0.dwallet_id,
            cap_id                       : arg0.cap_id,
            source_share_id              : arg0.source_share_id,
            recipient_encryption_address : arg0.recipient_encryption_address,
        };
        0x2::event::emit<Locked>(v0);
    }

    fun lock_cap(arg0: &mut Escrow, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg2: u64, arg3: address) {
        assert!(arg3 == arg0.seller, 0);
        assert!(arg0.state == 0 && 0x1::option::is_none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.cap), 1);
        assert!(arg2 < arg0.deadline_ms, 3);
        assert!(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg1) == arg0.cap_id && 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg1) == arg0.dwallet_id, 2);
        0x1::option::fill<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.cap, arg1);
        arg0.state = 1;
    }

    fun new_request(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: address, arg6: vector<u8>, arg7: u32, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : Escrow {
        let v0 = if (arg4 != @0x0) {
            if (arg4 != 0x2::tx_context::sender(arg14)) {
                0x2::tx_context::sender(arg14) != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = if (0x1::vector::length<u8>(&arg9) == 32) {
            if (0x1::vector::length<u8>(&arg6) == 32) {
                0x1::vector::length<u8>(&arg8) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 5);
        let v2 = if (!0x1::vector::is_empty<u8>(&arg10)) {
            if (0x1::vector::length<u8>(&arg10) <= 200000) {
                0x1::hash::sha2_256(arg10) == arg9
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 5);
        let v3 = if (arg12 > arg13) {
            if (arg12 - arg13 >= 60000) {
                arg12 - arg13 <= 604800000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 5);
        let v4 = if (0x2::object::id_to_address(&arg1) != @0x0) {
            if (0x2::object::id_to_address(&arg2) != @0x0) {
                0x2::object::id_to_address(&arg3) != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 5);
        let v5 = x"00";
        0x1::vector::append<u8>(&mut v5, arg6);
        assert!(0x2::address::from_bytes(0x2::hash::blake2b256(&v5)) == arg5, 5);
        Escrow{
            id                           : 0x2::object::new(arg14),
            coordinator_id               : arg0,
            dwallet_id                   : arg1,
            cap_id                       : arg2,
            source_share_id              : arg3,
            seller                       : arg4,
            recipient                    : 0x2::tx_context::sender(arg14),
            recipient_encryption_address : arg5,
            recipient_signing_public_key : arg6,
            curve                        : arg7,
            public_output_hash           : arg8,
            request_id                   : arg9,
            ownership_request            : arg10,
            price_mist                   : arg11,
            deadline_ms                  : arg12,
            state                        : 0,
            cap                          : 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(),
            destination_share_id         : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun prepare(arg0: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: &0x2::clock::Clock, arg2: address, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: address, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::get_dwallet(arg0, arg3);
        assert!(!0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::is_imported_key_dwallet(v0), 8);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::get_active_encryption_key(arg0, arg6);
        let v1 = new_request(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator>(arg0), arg3, arg4, arg5, arg2, arg6, arg7, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::curve(v0), 0x2::hash::blake2b256(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::validate_active_and_get_public_output(v0)), arg8, arg9, arg10, arg11, 0x2::clock::timestamp_ms(arg1), arg12);
        let v2 = Prepared{
            escrow_id   : 0x2::object::id<Escrow>(&v1),
            request_id  : arg8,
            seller      : arg2,
            recipient   : 0x2::tx_context::sender(arg12),
            dwallet_id  : arg3,
            cap_id      : arg4,
            price_mist  : arg10,
            deadline_ms : arg11,
        };
        0x2::event::emit<Prepared>(v2);
        0x2::transfer::share_object<Escrow>(v1);
    }

    public fun state(arg0: &Escrow) : u8 {
        arg0.state
    }

    // decompiled from Move bytecode v7
}

