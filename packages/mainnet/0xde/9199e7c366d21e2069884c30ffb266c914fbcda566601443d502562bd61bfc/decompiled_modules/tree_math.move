module 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::tree_math {
    struct TreeUint24 has store {
        level0: u256,
        level1: 0x2::table::Table<u64, u256>,
        level2: 0x2::table::Table<u64, u256>,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : TreeUint24 {
        TreeUint24{
            level0 : 0,
            level1 : 0x2::table::new<u64, u256>(arg0),
            level2 : 0x2::table::new<u64, u256>(arg0),
        }
    }

    public fun add(arg0: &mut TreeUint24, arg1: u32) : bool {
        assert!(arg1 <= 16777215, 65536);
        let v0 = ((arg1 >> 8) as u64);
        let v1 = safe_borrow_table(&arg0.level2, v0);
        let v2 = v1 | 1 << ((arg1 & (255 as u32)) as u8);
        if (v1 == v2) {
            false
        } else {
            if (v1 == 0) {
                0x2::table::add<u64, u256>(&mut arg0.level2, v0, v2);
            } else {
                *0x2::table::borrow_mut<u64, u256>(&mut arg0.level2, v0) = v2;
            };
            if (v1 == 0) {
                let v4 = v0 >> 8;
                let v5 = safe_borrow_table(&arg0.level1, v4);
                if (v5 == 0) {
                    0x2::table::add<u64, u256>(&mut arg0.level1, v4, v5 | 1 << ((v0 & (255 as u64)) as u8));
                } else {
                    *0x2::table::borrow_mut<u64, u256>(&mut arg0.level1, v4) = v5 | 1 << ((v0 & (255 as u64)) as u8);
                };
                if (v5 == 0) {
                    arg0.level0 = arg0.level0 | 1 << ((v4 & (255 as u64)) as u8);
                };
            };
            true
        }
    }

    public fun contains(arg0: &TreeUint24, arg1: u32) : bool {
        assert!(arg1 <= 16777215, 65536);
        if (arg0.level0 == 0) {
            return false
        };
        safe_borrow_table(&arg0.level2, ((arg1 >> 8) as u64)) & 1 << ((arg1 & (255 as u32)) as u8) != 0
    }

    public fun remove(arg0: &mut TreeUint24, arg1: u32) : bool {
        assert!(arg1 <= 16777215, 65536);
        if (arg0.level0 == 0) {
            return false
        };
        let v0 = ((arg1 >> 8) as u64);
        if (!0x2::table::contains<u64, u256>(&arg0.level2, v0)) {
            return false
        };
        let v1 = *0x2::table::borrow<u64, u256>(&arg0.level2, v0);
        let v2 = v1 & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 1 << ((arg1 & (255 as u32)) as u8));
        if (v1 == v2) {
            false
        } else {
            if (v2 == 0) {
                0x2::table::remove<u64, u256>(&mut arg0.level2, v0);
            } else {
                *0x2::table::borrow_mut<u64, u256>(&mut arg0.level2, v0) = v2;
            };
            if (v2 == 0) {
                let v4 = v0 >> 8;
                if (0x2::table::contains<u64, u256>(&arg0.level1, v4)) {
                    let v5 = *0x2::table::borrow<u64, u256>(&arg0.level1, v4) & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 1 << ((v0 & (255 as u64)) as u8));
                    if (v5 == 0) {
                        0x2::table::remove<u64, u256>(&mut arg0.level1, v4);
                    } else {
                        *0x2::table::borrow_mut<u64, u256>(&mut arg0.level1, v4) = v5;
                    };
                    if (v5 == 0) {
                        arg0.level0 = arg0.level0 & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 1 << ((v4 & (255 as u64)) as u8));
                    };
                };
            };
            true
        }
    }

    public fun find_first_left(arg0: &TreeUint24, arg1: u32) : u32 {
        assert!(arg1 <= 16777215, 65536);
        if (arg0.level0 == 0) {
            return 0
        };
        let v0 = ((arg1 >> 8) as u64);
        let v1 = ((arg1 & (255 as u32)) as u8);
        if (v1 < 255) {
            let v2 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::closest_bit_left_u256(safe_borrow_table(&arg0.level2, v0), v1 + 1);
            if (v2 != 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                return (((v0 as u256) << 8 | v2) as u32)
            };
        };
        let v3 = v0 >> 8;
        let v4 = ((v0 & (255 as u64)) as u8);
        if (v4 < 255) {
            let v5 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::closest_bit_left_u256(safe_borrow_table(&arg0.level1, v3), v4 + 1);
            if (v5 != 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                let v6 = (v3 as u256) << 8 | v5;
                return ((v6 << 8 | (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::least_significant_bit_u256(safe_borrow_table(&arg0.level2, (v6 as u64))) as u256)) as u32)
            };
        };
        let v7 = ((v3 & (255 as u64)) as u8);
        if (v7 < 255) {
            let v8 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::closest_bit_left_u256(arg0.level0, v7 + 1);
            if (v8 != 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                let v9 = v8 << 8 | (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::least_significant_bit_u256(safe_borrow_table(&arg0.level1, (v8 as u64))) as u256);
                return ((v9 << 8 | (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::least_significant_bit_u256(safe_borrow_table(&arg0.level2, (v9 as u64))) as u256)) as u32)
            };
        };
        0
    }

    public fun find_first_right(arg0: &TreeUint24, arg1: u32) : u32 {
        assert!(arg1 <= 16777215, 65536);
        if (arg0.level0 == 0) {
            return 16777215
        };
        let v0 = ((arg1 >> 8) as u64);
        let v1 = ((arg1 & (255 as u32)) as u8);
        if (v1 > 0) {
            let v2 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::closest_bit_right_u256(safe_borrow_table(&arg0.level2, v0), v1 - 1);
            if (v2 != 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                return (((v0 as u256) << 8 | v2) as u32)
            };
        };
        let v3 = v0 >> 8;
        let v4 = ((v0 & (255 as u64)) as u8);
        if (v4 > 0) {
            let v5 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::closest_bit_right_u256(safe_borrow_table(&arg0.level1, v3), v4 - 1);
            if (v5 != 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                let v6 = (v3 as u256) << 8 | v5;
                return ((v6 << 8 | (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::most_significant_bit_u256(safe_borrow_table(&arg0.level2, (v6 as u64))) as u256)) as u32)
            };
        };
        let v7 = ((v3 & (255 as u64)) as u8);
        if (v7 > 0) {
            let v8 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::closest_bit_right_u256(arg0.level0, v7 - 1);
            if (v8 != 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                let v9 = v8 << 8 | (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::most_significant_bit_u256(safe_borrow_table(&arg0.level1, (v8 as u64))) as u256);
                return ((v9 << 8 | (0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::most_significant_bit_u256(safe_borrow_table(&arg0.level2, (v9 as u64))) as u256)) as u32)
            };
        };
        16777215
    }

    public fun is_empty(arg0: &TreeUint24) : bool {
        arg0.level0 == 0
    }

    fun safe_borrow_table(arg0: &0x2::table::Table<u64, u256>, arg1: u64) : u256 {
        if (0x2::table::contains<u64, u256>(arg0, arg1)) {
            *0x2::table::borrow<u64, u256>(arg0, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

