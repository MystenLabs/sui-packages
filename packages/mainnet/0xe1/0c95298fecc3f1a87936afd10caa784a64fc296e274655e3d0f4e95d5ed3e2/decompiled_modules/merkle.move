module 0xe10c95298fecc3f1a87936afd10caa784a64fc296e274655e3d0f4e95d5ed3e2::merkle {
    struct MerkleStep has copy, drop, store {
        on_left: bool,
        sibling: vector<u8>,
    }

    public fun fold_sha_root(arg0: vector<u8>, arg1: vector<MerkleStep>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<MerkleStep>(&arg1)) {
            let v2 = 0x1::vector::borrow<MerkleStep>(&arg1, v1);
            if (0x1::vector::length<u8>(&v2.sibling) != 0) {
                assert!(0x1::vector::length<u8>(&v2.sibling) == 32, 1);
                let v3 = 0x1::vector::empty<u8>();
                if (v2.on_left) {
                    0x1::vector::append<u8>(&mut v3, v2.sibling);
                    0x1::vector::append<u8>(&mut v3, v0);
                } else {
                    0x1::vector::append<u8>(&mut v3, v0);
                    0x1::vector::append<u8>(&mut v3, v2.sibling);
                };
                v0 = 0x1::hash::sha2_256(v3);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun step(arg0: bool, arg1: vector<u8>) : MerkleStep {
        MerkleStep{
            on_left : arg0,
            sibling : arg1,
        }
    }

    public fun verify_inclusion(arg0: vector<u8>, arg1: vector<MerkleStep>, arg2: vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(&arg2) == 20, 1);
        0xe10c95298fecc3f1a87936afd10caa784a64fc296e274655e3d0f4e95d5ed3e2::ripemd160::hash(fold_sha_root(arg0, arg1)) == arg2
    }

    // decompiled from Move bytecode v7
}

