module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer {
    public fun parse_and_verify_le_ecdsa_update(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x2::clock::Clock, arg2: vector<u8>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update {
        let v0 = 0x2::bcs::new(arg2);
        assert!(0x2::bcs::peel_u32(&mut v0) == 1296547300, 13906834548005994504);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 65) {
            0x1::vector::push_back<u8>(&mut v1, 0x2::bcs::peel_u8(&mut v0));
            v2 = v2 + 1;
        };
        let v3 = 0x2::bcs::into_remainder_bytes(v0);
        assert!((0x2::bcs::peel_u16(&mut v0) as u64) == 0x1::vector::length<u8>(&v3), 13906834612430766092);
        let v4 = 0x2::bcs::new(v3);
        assert!(0x2::bcs::peel_u32(&mut v4) == 2479346549, 13906834633905471498);
        verify_le_ecdsa_message(arg0, arg1, &v1, &v3);
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::parse_from_cursor(v4)
    }

    public(friend) fun verify_le_ecdsa_message(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x2::clock::Clock, arg2: &vector<u8>, arg3: &vector<u8>) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::current_cap(arg0);
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg2, arg3, 0);
        let v2 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::trusted_signers(arg0, &v0);
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::TrustedSignerInfo>(v2)) {
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::public_key(0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::TrustedSignerInfo>(v2, v3)) == &v1) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 4 */
                assert!(0x1::option::is_some<u64>(&v4), 13906834436336582660);
                assert!(0x2::clock::timestamp_ms(arg1) < 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::expires_at_ms(0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::TrustedSignerInfo>(v2, 0x1::option::extract<u64>(&mut v4))), 13906834449221615622);
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    // decompiled from Move bytecode v6
}

