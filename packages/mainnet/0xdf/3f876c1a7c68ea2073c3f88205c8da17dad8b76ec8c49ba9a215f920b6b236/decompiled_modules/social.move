module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::social {
    struct IdentKey has copy, drop, store {
        phase: u64,
        ident: vector<u8>,
    }

    fun check_v2(arg0: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg1: u64, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg3: &vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg4) == 32, 6);
        assert!(0x2::clock::timestamp_ms(arg6) < arg5, 2);
        let v0 = ticket_message(0x2::object::id<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop>(arg0), arg1, 0x2::tx_context::sender(arg7), arg4, arg5);
        assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::verify_sig(arg2, &v0, arg3), 1);
        let v1 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::phase_per_wallet(arg0, arg1);
        if (v1 > 0) {
            let v2 = IdentKey{
                phase : arg1,
                ident : arg4,
            };
            let v3 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::uid_mut(arg0);
            if (0x2::dynamic_field::exists<IdentKey>(v3, v2)) {
                let v4 = 0x2::dynamic_field::borrow_mut<IdentKey, u64>(v3, v2);
                assert!(*v4 < v1, 5);
                *v4 = *v4 + 1;
            } else {
                0x2::dynamic_field::add<IdentKey, u64>(v3, v2, 1);
            };
        };
    }

    public fun ident_minted(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg1: u64, arg2: vector<u8>) : u64 {
        let v0 = IdentKey{
            phase : arg1,
            ident : arg2,
        };
        if (0x2::dynamic_field::exists<IdentKey>(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::uid(arg0), v0)) {
            *0x2::dynamic_field::borrow<IdentKey, u64>(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::uid(arg0), v0)
        } else {
            0
        }
    }

    entry fun mint(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg2: u64, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: vector<u8>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 4
    }

    entry fun mint_kiosk(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg2: u64, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::transfer_policy::TransferPolicy<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: address, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        abort 4
    }

    entry fun mint_kiosk_v2(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg2: u64, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &0x2::transfer_policy::TransferPolicy<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: address, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::assert_version(arg0);
        check_v2(arg1, arg2, arg3, &arg4, arg5, arg6, arg13, arg14);
        0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::lock_into_kiosk(arg7, arg8, arg9, 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::social_mint(arg0, arg1, arg2, arg10, arg11, arg12, arg13, arg14));
    }

    entry fun mint_v2(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg2: u64, arg3: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::gift::GiftAuthority, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::assert_version(arg0);
        assert!(!0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::is_kiosk_only(arg1), 3);
        check_v2(arg1, arg2, arg3, &arg4, arg5, arg6, arg10, arg11);
        0x2::transfer::public_transfer<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::social_mint(arg0, arg1, arg2, arg7, arg8, arg9, arg10, arg11), 0x2::tx_context::sender(arg11));
    }

    public fun ticket_message(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: vector<u8>, arg4: u64) : vector<u8> {
        let v0 = b"tapdrop:mint:v2";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        v0
    }

    // decompiled from Move bytecode v7
}

