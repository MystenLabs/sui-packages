module 0xea0984f47fb625f998a677c0a5c87302d62c762a4e57c6b68e0852502bccf3b6::merkle_tree {
    struct MerkleTree has store {
        depth: u8,
        next_index: u64,
        filled_subtrees: vector<vector<u8>>,
        empty_subtree_roots: vector<vector<u8>>,
        root: vector<u8>,
    }

    public fun append(arg0: &mut MerkleTree, arg1: vector<u8>) : u64 {
        assert!(arg0.next_index < 1 << arg0.depth, 0);
        let v0 = arg0.next_index;
        let v1 = hash_leaf(&arg1);
        let v2 = 0;
        while (v2 < arg0.depth) {
            let v3 = (v2 as u64);
            let (v4, v5) = if (v0 % 2 == 0) {
                *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.filled_subtrees, v3) = v1;
                (v1, *0x1::vector::borrow<vector<u8>>(&arg0.empty_subtree_roots, v3))
            } else {
                (*0x1::vector::borrow<vector<u8>>(&arg0.filled_subtrees, v3), v1)
            };
            let v6 = v5;
            let v7 = v4;
            v1 = hash_node(&v7, &v6);
            v0 = v0 / 2;
            v2 = v2 + 1;
        };
        arg0.root = v1;
        arg0.next_index = v0 + 1;
        v0
    }

    fun empty_leaf() : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    fun hash_leaf(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"zcash_v1/leaf";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::hash::blake2b256(&v0)
    }

    fun hash_node(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = b"zcash_v1/node";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun new(arg0: u8) : MerkleTree {
        assert!(arg0 > 0 && arg0 <= 32, 1);
        let v0 = empty_leaf();
        let v1 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v1, hash_leaf(&v0));
        let v2 = 0;
        while (v2 < arg0) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&v1, 0x1::vector::length<vector<u8>>(&v1) - 1);
            0x1::vector::push_back<vector<u8>>(&mut v1, hash_node(&v3, &v3));
            v2 = v2 + 1;
        };
        let v4 = vector[];
        let v5 = 0;
        while (v5 < (arg0 as u64)) {
            0x1::vector::push_back<vector<u8>>(&mut v4, *0x1::vector::borrow<vector<u8>>(&v1, v5));
            v5 = v5 + 1;
        };
        MerkleTree{
            depth               : arg0,
            next_index          : 0,
            filled_subtrees     : v4,
            empty_subtree_roots : v1,
            root                : *0x1::vector::borrow<vector<u8>>(&v1, (arg0 as u64)),
        }
    }

    public fun root(arg0: &MerkleTree) : vector<u8> {
        arg0.root
    }

    public fun verify_path(arg0: &vector<u8>, arg1: u64, arg2: &vector<vector<u8>>, arg3: &vector<u8>, arg4: u8) : bool {
        if (0x1::vector::length<vector<u8>>(arg2) != (arg4 as u64)) {
            return false
        };
        let v0 = hash_leaf(arg0);
        let v1 = 0;
        while (v1 < arg4) {
            let v2 = if (arg1 % 2 == 0) {
                hash_node(&v0, 0x1::vector::borrow<vector<u8>>(arg2, (v1 as u64)))
            } else {
                hash_node(0x1::vector::borrow<vector<u8>>(arg2, (v1 as u64)), &v0)
            };
            v0 = v2;
            arg1 = arg1 / 2;
            v1 = v1 + 1;
        };
        &v0 == arg3
    }

    // decompiled from Move bytecode v7
}

