module 0xe37b0c54c07dab743a7663118315e80a26c1bd3edd3f43769a1f2ddd243b04d::merkle_tree_v3 {
    struct MerkleTreeV3 has store, key {
        id: 0x2::object::UID,
        height: u8,
        next_index: u64,
        root_index: u64,
        filled_subtrees: vector<vector<u8>>,
        roots: vector<vector<u8>>,
    }

    public fun append(arg0: &mut MerkleTreeV3, arg1: vector<u8>) : (u64, vector<vector<u8>>) {
        assert!(arg0.next_index < 1 << (arg0.height as u8), 0);
        let v0 = arg0.next_index;
        let v1 = arg1;
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = 0;
        while (v3 < arg0.height) {
            let v4 = if (v0 % 2 == 0) {
                *0x1::vector::borrow<vector<u8>>(&arg0.filled_subtrees, (v3 as u64))
            } else {
                let v5 = v0 - 1;
                if (0x2::dynamic_field::exists_<u64>(&arg0.id, v5)) {
                    *0x2::dynamic_field::borrow<u64, vector<u8>>(&arg0.id, v5)
                } else {
                    *0x1::vector::borrow<vector<u8>>(&arg0.filled_subtrees, (v3 as u64))
                }
            };
            0x1::vector::push_back<vector<u8>>(&mut v2, v4);
            let v6 = if (v0 % 2 == 0) {
                hash_pair_poseidon(v1, v4)
            } else {
                hash_pair_poseidon(v4, v1)
            };
            v1 = v6;
            if (v0 % 2 == 0 && v0 > 0) {
                0x2::dynamic_field::add<u64, vector<u8>>(&mut arg0.id, v0, v6);
            };
            v0 = v0 / 2;
            v3 = v3 + 1;
        };
        let v7 = arg0.next_index;
        update_filled_subtrees(arg0, v7, arg1);
        arg0.root_index = (arg0.root_index + 1) % 30;
        if (0x1::vector::length<vector<u8>>(&arg0.roots) < 30) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.roots, v1);
        } else {
            *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.roots, arg0.root_index) = v1;
        };
        arg0.next_index = arg0.next_index + 1;
        (arg0.next_index, v2)
    }

    fun bytes_to_u256(arg0: vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(&arg0);
        let v3 = if (v2 > 32) {
            32
        } else {
            v2
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(&arg0, v1) as u256) << ((v1 * 8) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_root(arg0: &MerkleTreeV3) : vector<u8> {
        *0x1::vector::borrow<vector<u8>>(&arg0.roots, arg0.root_index)
    }

    public fun get_stats(arg0: &MerkleTreeV3) : (u64, u8, u64) {
        (arg0.next_index, arg0.height, 0x1::vector::length<vector<u8>>(&arg0.roots))
    }

    fun hash_pair_poseidon(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, bytes_to_u256(arg0));
        0x1::vector::push_back<u256>(v1, bytes_to_u256(arg1));
        poseidon_hash_to_bytes(&v0)
    }

    public fun initialize(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : MerkleTreeV3 {
        assert!(arg0 > 0 && arg0 <= 26, 1);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = vector[0];
        let v2 = poseidon_hash_to_bytes(&v1);
        let v3 = 0;
        while (v3 < arg0) {
            0x1::vector::push_back<vector<u8>>(&mut v0, v2);
            v2 = hash_pair_poseidon(v2, v2);
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v4, v2);
        MerkleTreeV3{
            id              : 0x2::object::new(arg1),
            height          : arg0,
            next_index      : 0,
            root_index      : 0,
            filled_subtrees : v0,
            roots           : v4,
        }
    }

    public fun is_valid_root(arg0: &MerkleTreeV3, arg1: vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.roots)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg0.roots, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun poseidon_hash_to_bytes(arg0: &vector<u256>) : vector<u8> {
        u256_to_bytes(0x2::poseidon::poseidon_bn254(arg0))
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

    fun update_filled_subtrees(arg0: &mut MerkleTreeV3, arg1: u64, arg2: vector<u8>) {
        let v0 = 0;
        while (v0 < arg0.height) {
            if (arg1 % 2 == 0 && arg1 + 1 == arg0.next_index) {
                *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.filled_subtrees, (v0 as u64)) = arg2;
            };
            let v1 = if (arg1 % 2 == 0) {
                hash_pair_poseidon(arg2, *0x1::vector::borrow<vector<u8>>(&arg0.filled_subtrees, (v0 as u64)))
            } else {
                hash_pair_poseidon(*0x1::vector::borrow<vector<u8>>(&arg0.filled_subtrees, (v0 as u64)), arg2)
            };
            arg2 = v1;
            arg1 = arg1 / 2;
            v0 = v0 + 1;
        };
    }

    public fun verify_proof(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: u64) : bool {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = if (arg3 % 2 == 0) {
                hash_pair_poseidon(v0, *0x1::vector::borrow<vector<u8>>(&arg1, v1))
            } else {
                hash_pair_poseidon(*0x1::vector::borrow<vector<u8>>(&arg1, v1), v0)
            };
            v0 = v2;
            arg3 = arg3 / 2;
            v1 = v1 + 1;
        };
        v0 == arg2
    }

    // decompiled from Move bytecode v6
}

