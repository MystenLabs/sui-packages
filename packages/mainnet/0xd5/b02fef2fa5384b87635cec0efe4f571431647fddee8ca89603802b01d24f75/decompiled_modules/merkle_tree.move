module 0xd5b02fef2fa5384b87635cec0efe4f571431647fddee8ca89603802b01d24f75::merkle_tree {
    struct MerkleTree has store, key {
        id: 0x2::object::UID,
        root: vector<u8>,
        next_index: u64,
        filled_subtrees: vector<vector<u8>>,
        zeros: vector<vector<u8>>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : MerkleTree {
        let v0 = compute_zeros();
        MerkleTree{
            id              : 0x2::object::new(arg0),
            root            : *0x1::vector::borrow<vector<u8>>(&v0, 16),
            next_index      : 0,
            filled_subtrees : 0x1::vector::empty<vector<u8>>(),
            zeros           : v0,
        }
    }

    fun bytes_to_u256(arg0: vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 2);
        let v0 = 0;
        let v1 = 32;
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(&arg0, v1) as u256);
        };
        v0 % 21888242871839275222246405745257275088548364400416034343698204186575808495617
    }

    fun compute_zeros() : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v2 = v2 + 1;
        };
        0x1::vector::push_back<vector<u8>>(&mut v0, v1);
        let v3 = 0;
        while (v3 < 16) {
            let v4 = *0x1::vector::borrow<vector<u8>>(&v0, v3);
            0x1::vector::push_back<vector<u8>>(&mut v0, hash_pair(v4, v4));
            v3 = v3 + 1;
        };
        v0
    }

    public fun get_next_index(arg0: &MerkleTree) : u64 {
        arg0.next_index
    }

    public fun get_root(arg0: &MerkleTree) : vector<u8> {
        arg0.root
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, bytes_to_u256(arg0));
        0x1::vector::push_back<u256>(v1, bytes_to_u256(arg1));
        u256_to_bytes(0x2::poseidon::poseidon_bn254(&v0))
    }

    public fun insert(arg0: &mut MerkleTree, arg1: vector<u8>) {
        assert!(arg0.next_index < 1 << 16, 0);
        let v0 = arg0.next_index;
        let v1 = arg1;
        let v2 = 0;
        while (v2 < 16) {
            if (v0 % 2 == 0) {
                if (0x1::vector::length<vector<u8>>(&arg0.filled_subtrees) <= v2) {
                    0x1::vector::push_back<vector<u8>>(&mut arg0.filled_subtrees, v1);
                } else {
                    *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.filled_subtrees, v2) = v1;
                };
                v1 = hash_pair(v1, *0x1::vector::borrow<vector<u8>>(&arg0.zeros, v2));
            } else {
                v1 = hash_pair(*0x1::vector::borrow<vector<u8>>(&arg0.filled_subtrees, v2), v1);
            };
            v0 = v0 / 2;
            v2 = v2 + 1;
        };
        arg0.root = v1;
        arg0.next_index = arg0.next_index + 1;
    }

    fun u256_to_bytes(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify_proof(arg0: &MerkleTree, arg1: vector<u8>, arg2: u64, arg3: vector<vector<u8>>) : bool {
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 16, 1);
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 16) {
            if (arg2 % 2 == 0) {
                v0 = hash_pair(v0, *0x1::vector::borrow<vector<u8>>(&arg3, v1));
            } else {
                v0 = hash_pair(*0x1::vector::borrow<vector<u8>>(&arg3, v1), v0);
            };
            arg2 = arg2 / 2;
            v1 = v1 + 1;
        };
        v0 == arg0.root
    }

    // decompiled from Move bytecode v6
}

