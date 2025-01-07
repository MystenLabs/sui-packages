module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::computing_room {
    struct Maze has drop, store {
        does_sequential: bool,
        bits: 0x1::option::Option<vector<0x1::bit_vector::BitVector>>,
    }

    public fun create_maze(arg0: bool, arg1: u64) : Maze {
        let v0 = 0x1::option::none<vector<0x1::bit_vector::BitVector>>();
        if (!arg0) {
            0x1::option::fill<vector<0x1::bit_vector::BitVector>>(&mut v0, 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::utils::create_bit_mask(arg1));
        };
        Maze{
            does_sequential : arg0,
            bits            : v0,
        }
    }

    public fun get_mint_index(arg0: &mut Maze, arg1: u64, arg2: u64, arg3: address) : u64 {
        if (arg0.does_sequential) {
            arg2
        } else {
            get_random_index(arg0, arg1, arg3)
        }
    }

    fun get_random_index(arg0: &mut Maze, arg1: u64, arg2: address) : u64 {
        let v0 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::utils::pseudo_random(arg2, arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x1::bit_vector::BitVector>();
        let v5 = 0x1::option::borrow_mut<vector<0x1::bit_vector::BitVector>>(&mut arg0.bits);
        while (v1 < v0) {
            let v6 = *0x1::vector::borrow_mut<0x1::bit_vector::BitVector>(v5, v2);
            let v7 = 0;
            while (v7 < 0x1::bit_vector::length(&v6)) {
                if (!0x1::bit_vector::is_index_set(&v6, v7)) {
                    v1 = v1 + 1;
                };
                if (v1 == v0) {
                    0x1::bit_vector::set(&mut v6, v7);
                    0x1::vector::push_back<0x1::bit_vector::BitVector>(&mut v4, v6);
                    break
                };
                v3 = v3 + 1;
                v7 = v7 + 1;
            };
            0x1::vector::push_back<0x1::bit_vector::BitVector>(&mut v4, v6);
            v2 = v2 + 1;
        };
        while (v2 < 0x1::vector::length<0x1::bit_vector::BitVector>(v5)) {
            0x1::vector::push_back<0x1::bit_vector::BitVector>(&mut v4, *0x1::vector::borrow_mut<0x1::bit_vector::BitVector>(v5, v2));
            v2 = v2 + 1;
        };
        *v5 = v4;
        v3 + 1
    }

    // decompiled from Move bytecode v6
}

