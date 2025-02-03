module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer {
    struct WeightedSigner has copy, drop, store {
        pub_key: vector<u8>,
        weight: u128,
    }

    public(friend) fun default() : WeightedSigner {
        let v0 = 0x2::address::to_bytes(@0x0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        WeightedSigner{
            pub_key : v0,
            weight  : 0,
        }
    }

    public(friend) fun lt(arg0: &WeightedSigner, arg1: &WeightedSigner) : bool {
        let v0 = 0;
        while (v0 < 33) {
            if (*0x1::vector::borrow<u8>(&arg0.pub_key, v0) < *0x1::vector::borrow<u8>(&arg1.pub_key, v0)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(&arg0.pub_key, v0) > *0x1::vector::borrow<u8>(&arg1.pub_key, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun new(arg0: vector<u8>, arg1: u128) : WeightedSigner {
        assert!(0x1::vector::length<u8>(&arg0) == 33, 9223372243013271554);
        WeightedSigner{
            pub_key : arg0,
            weight  : arg1,
        }
    }

    public(friend) fun peel(arg0: &mut 0x2::bcs::BCS) : WeightedSigner {
        new(0x2::bcs::peel_vec_u8(arg0), 0x2::bcs::peel_u128(arg0))
    }

    public(friend) fun pub_key(arg0: &WeightedSigner) : vector<u8> {
        arg0.pub_key
    }

    public(friend) fun validate(arg0: &WeightedSigner) {
        assert!(arg0.weight != 0, 9223372346092617732);
    }

    public(friend) fun weight(arg0: &WeightedSigner) : u128 {
        arg0.weight
    }

    // decompiled from Move bytecode v6
}

