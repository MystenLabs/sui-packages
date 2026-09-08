module 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::bitmap {
    struct BinBitmap has store {
        level0: u256,
        level1: 0x2::table::Table<u8, u256>,
        level2: 0x2::table::Table<u32, u256>,
    }

    fun bin_id_from_l2(arg0: u32, arg1: u8) : u32 {
        arg0 * 256 + (arg1 as u32)
    }

    fun clear_bit(arg0: u256, arg1: u8) : u256 {
        arg0 & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 1 << arg1)
    }

    public fun find_next_above(arg0: &BinBitmap, arg1: u32) : (bool, u32) {
        if (arg1 > 16777215) {
            return (false, 0)
        };
        let v0 = l2_key_of(arg1);
        let v1 = l1_key_of(arg1);
        let v2 = l1_bit_index_of(v0);
        if (0x2::table::contains<u32, u256>(&arg0.level2, v0)) {
            let v3 = mask_at_and_above(*0x2::table::borrow<u32, u256>(&arg0.level2, v0), l2_bit_index_of(arg1));
            if (v3 > 0) {
                return (true, bin_id_from_l2(v0, lowest_set_bit(v3)))
            };
        };
        if (v2 < 255 && 0x2::table::contains<u8, u256>(&arg0.level1, v1)) {
            let v4 = mask_at_and_above(*0x2::table::borrow<u8, u256>(&arg0.level1, v1), v2 + 1);
            if (v4 > 0) {
                let v5 = l2_key_from_l1(v1, lowest_set_bit(v4));
                return (true, bin_id_from_l2(v5, lowest_set_bit(*0x2::table::borrow<u32, u256>(&arg0.level2, v5))))
            };
        };
        if ((v1 as u32) < 255) {
            let v6 = mask_at_and_above(arg0.level0, (v1 as u32) + 1);
            if (v6 > 0) {
                let v7 = lowest_set_bit(v6);
                let v8 = l2_key_from_l1((v7 as u8), lowest_set_bit(*0x2::table::borrow<u8, u256>(&arg0.level1, (v7 as u8))));
                return (true, bin_id_from_l2(v8, lowest_set_bit(*0x2::table::borrow<u32, u256>(&arg0.level2, v8))))
            };
        };
        (false, 0)
    }

    public fun find_next_below(arg0: &BinBitmap, arg1: u32) : (bool, u32) {
        let v0 = if (arg1 > 16777215) {
            16777215
        } else {
            arg1
        };
        let v1 = l2_key_of(v0);
        let v2 = l1_key_of(v0);
        let v3 = l1_bit_index_of(v1);
        if (0x2::table::contains<u32, u256>(&arg0.level2, v1)) {
            let v4 = mask_at_and_below(*0x2::table::borrow<u32, u256>(&arg0.level2, v1), l2_bit_index_of(v0));
            if (v4 > 0) {
                return (true, bin_id_from_l2(v1, highest_set_bit(v4)))
            };
        };
        if (v3 > 0 && 0x2::table::contains<u8, u256>(&arg0.level1, v2)) {
            let v5 = mask_at_and_below(*0x2::table::borrow<u8, u256>(&arg0.level1, v2), v3 - 1);
            if (v5 > 0) {
                let v6 = l2_key_from_l1(v2, highest_set_bit(v5));
                return (true, bin_id_from_l2(v6, highest_set_bit(*0x2::table::borrow<u32, u256>(&arg0.level2, v6))))
            };
        };
        if (v2 > 0) {
            let v7 = mask_at_and_below(arg0.level0, (v2 as u32) - 1);
            if (v7 > 0) {
                let v8 = highest_set_bit(v7);
                let v9 = l2_key_from_l1((v8 as u8), highest_set_bit(*0x2::table::borrow<u8, u256>(&arg0.level1, (v8 as u8))));
                return (true, bin_id_from_l2(v9, highest_set_bit(*0x2::table::borrow<u32, u256>(&arg0.level2, v9))))
            };
        };
        (false, 0)
    }

    fun highest_set_bit(arg0: u256) : u8 {
        assert!(arg0 > 0, 251);
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >= 1 << 128) {
            v2 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (v2 >= 1 << 64) {
            v2 = v2 >> 64;
            v1 = v1 + 64;
        };
        if (v2 >= 1 << 32) {
            v2 = v2 >> 32;
            v1 = v1 + 32;
        };
        if (v2 >= 1 << 16) {
            v2 = v2 >> 16;
            v1 = v1 + 16;
        };
        if (v2 >= 1 << 8) {
            v2 = v2 >> 8;
            v1 = v1 + 8;
        };
        if (v2 >= 1 << 4) {
            v2 = v2 >> 4;
            v1 = v1 + 4;
        };
        if (v2 >= 1 << 2) {
            v2 = v2 >> 2;
            v1 = v1 + 2;
        };
        if (v2 >= 1 << 1) {
            v1 = v1 + 1;
        };
        v1
    }

    fun l1_bit_index_of(arg0: u32) : u32 {
        arg0 & 255
    }

    fun l1_bit_of(arg0: u32) : u8 {
        ((arg0 & 255) as u8)
    }

    fun l1_key_of(arg0: u32) : u8 {
        ((arg0 >> 16) as u8)
    }

    fun l2_bit_index_of(arg0: u32) : u32 {
        arg0 & 255
    }

    fun l2_bit_of(arg0: u32) : u8 {
        ((arg0 & 255) as u8)
    }

    fun l2_key_from_l1(arg0: u8, arg1: u8) : u32 {
        (arg0 as u32) * 256 + (arg1 as u32)
    }

    fun l2_key_of(arg0: u32) : u32 {
        arg0 >> 8
    }

    fun lowest_set_bit(arg0: u256) : u8 {
        assert!(arg0 > 0, 251);
        highest_set_bit(arg0 ^ arg0 & arg0 - 1)
    }

    fun mask_at_and_above(arg0: u256, arg1: u32) : u256 {
        if (arg1 == 0) {
            arg0
        } else {
            arg0 & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ (1 << (arg1 as u8)) - 1)
        }
    }

    fun mask_at_and_below(arg0: u256, arg1: u32) : u256 {
        if (arg1 >= 255) {
            arg0
        } else {
            arg0 & (1 << ((arg1 + 1) as u8)) - 1
        }
    }

    public fun max_bin_id() : u32 {
        16777215
    }

    public fun new_bitmap(arg0: &mut 0x2::tx_context::TxContext) : BinBitmap {
        BinBitmap{
            level0 : 0,
            level1 : 0x2::table::new<u8, u256>(arg0),
            level2 : 0x2::table::new<u32, u256>(arg0),
        }
    }

    public fun set(arg0: &mut BinBitmap, arg1: u32) {
        assert!(arg1 <= 16777215, 250);
        let v0 = l2_key_of(arg1);
        let v1 = l2_bit_of(arg1);
        if (0x2::table::contains<u32, u256>(&arg0.level2, v0)) {
            if (*0x2::table::borrow<u32, u256>(&arg0.level2, v0) >> v1 & 1 == 1) {
                return
            };
        };
        let v2 = l1_key_of(arg1);
        if (!0x2::table::contains<u32, u256>(&arg0.level2, v0)) {
            0x2::table::add<u32, u256>(&mut arg0.level2, v0, 0);
        };
        let v3 = 0x2::table::borrow_mut<u32, u256>(&mut arg0.level2, v0);
        *v3 = *v3 | 1 << v1;
        if (!0x2::table::contains<u8, u256>(&arg0.level1, v2)) {
            0x2::table::add<u8, u256>(&mut arg0.level1, v2, 0);
        };
        let v4 = 0x2::table::borrow_mut<u8, u256>(&mut arg0.level1, v2);
        *v4 = *v4 | 1 << l1_bit_of(v0);
        arg0.level0 = arg0.level0 | 1 << v2;
    }

    public fun unset(arg0: &mut BinBitmap, arg1: u32) {
        assert!(arg1 <= 16777215, 250);
        let v0 = l2_key_of(arg1);
        let v1 = l1_key_of(arg1);
        if (!0x2::table::contains<u32, u256>(&arg0.level2, v0)) {
            return
        };
        let v2 = 0x2::table::borrow_mut<u32, u256>(&mut arg0.level2, v0);
        *v2 = clear_bit(*v2, l2_bit_of(arg1));
        if (*v2 != 0) {
            return
        };
        0x2::table::remove<u32, u256>(&mut arg0.level2, v0);
        let v3 = 0x2::table::borrow_mut<u8, u256>(&mut arg0.level1, v1);
        *v3 = clear_bit(*v3, l1_bit_of(v0));
        if (*v3 != 0) {
            return
        };
        0x2::table::remove<u8, u256>(&mut arg0.level1, v1);
        arg0.level0 = clear_bit(arg0.level0, v1);
    }

    // decompiled from Move bytecode v7
}

