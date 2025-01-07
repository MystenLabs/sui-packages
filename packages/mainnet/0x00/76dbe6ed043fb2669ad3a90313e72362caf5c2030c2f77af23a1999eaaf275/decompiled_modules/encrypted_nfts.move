module 0x76dbe6ed043fb2669ad3a90313e72362caf5c2030c2f77af23a1999eaaf275::encrypted_nfts {
    struct ENCRYPTED_NFTS has drop {
        dummy_field: bool,
    }

    struct TimeCapsule has store, key {
        id: 0x2::object::UID,
        encrypted_data: vector<u8>,
        round: u64,
    }

    struct LuckyCard has store, key {
        id: 0x2::object::UID,
        prize: 0x1::string::String,
    }

    public fun decrypt(arg0: TimeCapsule, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : LuckyCard {
        let TimeCapsule {
            id             : v0,
            encrypted_data : v1,
            round          : v2,
        } = arg0;
        let v3 = v1;
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= 1692803367 + 3 * (v2 - 1), 1);
        0x76dbe6ed043fb2669ad3a90313e72362caf5c2030c2f77af23a1999eaaf275::drand_lib::verify_drand_signature(arg2, v2);
        let v4 = 0x2::bls12381::g1_from_bytes(&arg2);
        let v5 = 0x76dbe6ed043fb2669ad3a90313e72362caf5c2030c2f77af23a1999eaaf275::ec_ops::ibe_decrypt(0x76dbe6ed043fb2669ad3a90313e72362caf5c2030c2f77af23a1999eaaf275::ec_ops::ibe_encryption_from_bytes(&v3), &v4);
        let v6 = if (0x1::option::is_some<vector<u8>>(&v5)) {
            0x1::option::destroy_some<vector<u8>>(v5)
        } else {
            0x1::vector::empty<u8>()
        };
        let v7 = v6;
        assert!(!0x1::vector::is_empty<u8>(&v7), 0);
        0x2::object::delete(v0);
        LuckyCard{
            id    : 0x2::object::new(arg3),
            prize : 0x1::string::utf8(remove_padding(&v7)),
        }
    }

    fun init(arg0: ENCRYPTED_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ENCRYPTED_NFTS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Enoki Time Capsule NFT"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://storage.googleapis.com/basecamp-images/locked.gif"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"This NFT will reveal itself during the Enoki launch announcement at Sui Basecamp, April 10 @ 16:00 CET"));
        let v5 = 0x2::display::new_with_fields<TimeCapsule>(&v0, v1, v3, arg1);
        0x2::display::update_version<TimeCapsule>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Enoki Launch NFT"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://storage.googleapis.com/basecamp-images/{prize}.gif"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"The countdown is over and the Enoki NFT has been revealed."));
        let v10 = 0x2::display::new_with_fields<LuckyCard>(&v0, v6, v8, arg1);
        0x2::display::update_version<LuckyCard>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TimeCapsule>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<LuckyCard>>(v10, 0x2::tx_context::sender(arg1));
    }

    public fun mint_encrypted(arg0: &0x76dbe6ed043fb2669ad3a90313e72362caf5c2030c2f77af23a1999eaaf275::access::AdminCap, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : TimeCapsule {
        TimeCapsule{
            id             : 0x2::object::new(arg3),
            encrypted_data : arg1,
            round          : arg2,
        }
    }

    fun remove_padding(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = 0x1::vector::borrow<u8>(arg0, v1);
            if (*v2 != 0) {
                0x1::vector::push_back<u8>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

