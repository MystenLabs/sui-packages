module 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin_tree {
    struct BinTree has store {
        level0: u256,
        level1: 0x2::vec_map::VecMap<u256, u256>,
        level2: 0x2::vec_map::VecMap<u256, u256>,
    }

    public fun contains(arg0: &BinTree, arg1: u32) : bool {
        assert!(arg1 >> 24 == 0, 1);
        let v0 = ((arg1 >> 8) as u256);
        if (!0x2::vec_map::contains<u256, u256>(&arg0.level2, &v0)) {
            return false
        };
        *0x2::vec_map::get<u256, u256>(&arg0.level2, &v0) & ((1 << ((arg1 & (255 as u32)) as u8)) as u256) > 0
    }

    public fun remove(arg0: &mut BinTree, arg1: u32) : bool {
        assert!(arg1 >> 24 == 0, 1);
        let v0 = ((arg1 >> 8) as u256);
        let v1 = if (0x2::vec_map::contains<u256, u256>(&arg0.level2, &v0)) {
            *0x2::vec_map::get<u256, u256>(&arg0.level2, &v0)
        } else {
            0
        };
        let v2 = v1 & 115792089237316195423570985008687907853269984665640564039457584007913129639935 - (1 << ((arg1 & 255) as u8));
        if (v2 != v1) {
            let (_, _) = 0x2::vec_map::remove<u256, u256>(&mut arg0.level2, &v0);
            0x2::vec_map::insert<u256, u256>(&mut arg0.level2, v0, v2);
            if (v2 == 0) {
                let v5 = v0 >> 8;
                let (_, v7) = 0x2::vec_map::remove<u256, u256>(&mut arg0.level1, &v5);
                let v8 = v7 & 115792089237316195423570985008687907853269984665640564039457584007913129639935 - (1 << ((v0 & 255) as u8));
                0x2::vec_map::insert<u256, u256>(&mut arg0.level1, v5, v8);
                if (v8 == 0) {
                    arg0.level0 = arg0.level0 & 115792089237316195423570985008687907853269984665640564039457584007913129639935 - (1 << ((v5 & 255) as u8));
                };
            };
            return true
        };
        false
    }

    public fun add(arg0: &mut BinTree, arg1: u32) : bool {
        assert!(arg1 >> 24 == 0, 1);
        let v0 = ((arg1 >> 8) as u256);
        let v1 = if (0x2::vec_map::contains<u256, u256>(&arg0.level2, &v0)) {
            *0x2::vec_map::get<u256, u256>(&arg0.level2, &v0)
        } else {
            0
        };
        let v2 = v1 | 1 << ((arg1 & (255 as u32)) as u8);
        if (v1 != v2) {
            if (0x2::vec_map::contains<u256, u256>(&arg0.level2, &v0)) {
                let (_, _) = 0x2::vec_map::remove<u256, u256>(&mut arg0.level2, &v0);
            };
            0x2::vec_map::insert<u256, u256>(&mut arg0.level2, v0, v2);
            if (v1 == 0) {
                let v5 = v0 >> 8;
                let v6 = if (0x2::vec_map::contains<u256, u256>(&arg0.level1, &v5)) {
                    let (_, v8) = 0x2::vec_map::remove<u256, u256>(&mut arg0.level1, &v5);
                    v8
                } else {
                    0
                };
                0x2::vec_map::insert<u256, u256>(&mut arg0.level1, v5, v6 | 1 << ((v0 & (255 as u256)) as u8));
                if (v6 == 0) {
                    arg0.level0 = arg0.level0 | 1 << ((v5 & 255) as u8);
                };
            };
            return true
        };
        false
    }

    fun closest_bit_left(arg0: u256, arg1: u8) : (u8, bool) {
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math::closest_bit_left(arg0, arg1 + 1)
    }

    fun closest_bit_right(arg0: u256, arg1: u8) : (u8, bool) {
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math::closest_bit_right(arg0, arg1 - 1)
    }

    public(friend) fun create_bin_tree() : BinTree {
        BinTree{
            level0 : 0,
            level1 : 0x2::vec_map::empty<u256, u256>(),
            level2 : 0x2::vec_map::empty<u256, u256>(),
        }
    }

    public fun find_first_left(arg0: &BinTree, arg1: u32) : (u32, bool) {
        assert!(arg1 >> 24 == 0, 1);
        let v0 = ((arg1 & (255 as u32)) as u8);
        let v1 = ((arg1 >> 8) as u256);
        if (v0 < 255) {
            assert!(0x2::vec_map::contains<u256, u256>(&arg0.level2, &v1), 3);
            let (v2, v3) = closest_bit_left(*0x2::vec_map::get<u256, u256>(&arg0.level2, &v1), v0);
            if (v3) {
                return (((v1 << 8 | (v2 as u256)) as u32), true)
            };
        };
        let v4 = v1 >> 8;
        let v5 = ((v1 & (255 as u256)) as u8);
        if (v5 < 255) {
            assert!(0x2::vec_map::contains<u256, u256>(&arg0.level1, &v4), 2);
            let (v6, v7) = closest_bit_left(*0x2::vec_map::get<u256, u256>(&arg0.level1, &v4), v5);
            if (v7) {
                let v8 = v4 << 8 | (v6 as u256);
                assert!(0x2::vec_map::contains<u256, u256>(&arg0.level2, &v8), 3);
                let (v9, _) = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math::least_significant_bit(*0x2::vec_map::get<u256, u256>(&arg0.level2, &v8));
                return (((v8 << 8 | (v9 as u256)) as u32), true)
            };
        };
        let v11 = ((v4 & (255 as u256)) as u8);
        if (v11 < 255) {
            let (v12, v13) = closest_bit_left(arg0.level0, v11);
            if (v13) {
                let v14 = (v12 as u256);
                assert!(0x2::vec_map::contains<u256, u256>(&arg0.level1, &v14), 2);
                let (v15, _) = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math::least_significant_bit(*0x2::vec_map::get<u256, u256>(&arg0.level1, &v14));
                let v17 = v14 << 8 | (v15 as u256);
                assert!(0x2::vec_map::contains<u256, u256>(&arg0.level2, &v17), 3);
                let (v18, _) = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math::least_significant_bit(*0x2::vec_map::get<u256, u256>(&arg0.level2, &v17));
                return (((v17 << 8 | (v18 as u256)) as u32), true)
            };
        };
        (0, false)
    }

    public fun find_first_right(arg0: &BinTree, arg1: u32) : (u32, bool) {
        assert!(arg1 >> 24 == 0, 1);
        let v0 = ((arg1 & (255 as u32)) as u8);
        let v1 = ((arg1 >> 8) as u256);
        if (v0 > 0) {
            assert!(0x2::vec_map::contains<u256, u256>(&arg0.level2, &v1), 3);
            let (v2, v3) = closest_bit_right(*0x2::vec_map::get<u256, u256>(&arg0.level2, &v1), v0);
            if (v3) {
                return (((v1 << 8 | (v2 as u256)) as u32), true)
            };
        };
        let v4 = v1 >> 8;
        let v5 = ((v1 & (255 as u256)) as u8);
        if (v5 > 0) {
            let (v6, v7) = closest_bit_right(*0x2::vec_map::get<u256, u256>(&arg0.level1, &v4), v5);
            if (v7) {
                let v8 = v4 << 8 | (v6 as u256);
                assert!(0x2::vec_map::contains<u256, u256>(&arg0.level2, &v8), 3);
                let (v9, _) = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math::most_significant_bit(*0x2::vec_map::get<u256, u256>(&arg0.level2, &v8));
                return (((v8 << 8 | (v9 as u256)) as u32), true)
            };
        };
        let v11 = ((v4 & (255 as u256)) as u8);
        if (v11 > 0) {
            let (v12, v13) = closest_bit_right(arg0.level0, v11);
            if (v13) {
                let v14 = (v12 as u256);
                assert!(0x2::vec_map::contains<u256, u256>(&arg0.level1, &v14), 2);
                let (v15, _) = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math::most_significant_bit(*0x2::vec_map::get<u256, u256>(&arg0.level1, &v14));
                let v17 = v14 << 8 | (v15 as u256);
                assert!(0x2::vec_map::contains<u256, u256>(&arg0.level2, &v17), 3);
                let (v18, _) = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math::most_significant_bit(*0x2::vec_map::get<u256, u256>(&arg0.level2, &v17));
                return (((v17 << 8 | (v18 as u256)) as u32), true)
            };
        };
        (0, false)
    }

    // decompiled from Move bytecode v6
}

