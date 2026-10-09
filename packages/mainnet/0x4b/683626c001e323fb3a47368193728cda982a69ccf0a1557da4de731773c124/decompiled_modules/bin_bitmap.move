module 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::bin_bitmap {
    struct BinBitmap has store {
        level0: 0x2::table::Table<u32, u256>,
        level1: 0x2::table::Table<u32, u256>,
        level2: u256,
    }

    public(friend) fun destroy_empty(arg0: BinBitmap) {
        let BinBitmap {
            level0 : v0,
            level1 : v1,
            level2 : _,
        } = arg0;
        0x2::table::destroy_empty<u32, u256>(v0);
        0x2::table::destroy_empty<u32, u256>(v1);
    }

    public fun contains(arg0: &BinBitmap, arg1: u32) : bool {
        assert!(arg1 <= 16777215, 1);
        let v0 = arg1 >> 8;
        0x2::table::contains<u32, u256>(&arg0.level0, v0) && *0x2::table::borrow<u32, u256>(&arg0.level0, v0) >> ((arg1 & 255) as u8) & 1 == 1
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : BinBitmap {
        BinBitmap{
            level0 : 0x2::table::new<u32, u256>(arg0),
            level1 : 0x2::table::new<u32, u256>(arg0),
            level2 : 0,
        }
    }

    fun above(arg0: u8) : u256 {
        if (arg0 == 255) {
            0
        } else {
            115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ (1 << arg0 + 1) - 1
        }
    }

    fun below(arg0: u8) : u256 {
        (1 << arg0) - 1
    }

    fun clear_bit(arg0: &mut 0x2::table::Table<u32, u256>, arg1: u32, arg2: u8) : bool {
        if (!0x2::table::contains<u32, u256>(arg0, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow_mut<u32, u256>(arg0, arg1);
        *v0 = *v0 & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 1 << arg2);
        if (*v0 != 0) {
            return false
        };
        0x2::table::remove<u32, u256>(arg0, arg1);
        true
    }

    public(friend) fun highest(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = 128;
        while (v1 > 0) {
            if (arg0 >> (v1 as u8) != 0) {
                arg0 = arg0 >> (v1 as u8);
                v0 = v0 + v1;
            };
            v1 = v1 / 2;
        };
        (v0 as u8)
    }

    public(friend) fun lowest(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = 128;
        while (v1 > 0) {
            if (arg0 & (1 << (v1 as u8)) - 1 == 0) {
                arg0 = arg0 >> (v1 as u8);
                v0 = v0 + v1;
            };
            v1 = v1 / 2;
        };
        (v0 as u8)
    }

    public fun next_above(arg0: &BinBitmap, arg1: u32) : 0x1::option::Option<u32> {
        assert!(arg1 <= 16777215, 1);
        let v0 = arg1 >> 8;
        let v1 = word(&arg0.level0, v0) & above(((arg1 & 255) as u8));
        if (v1 != 0) {
            return 0x1::option::some<u32>(v0 << 8 | (lowest(v1) as u32))
        };
        let v2 = v0 >> 8;
        let v3 = word(&arg0.level1, v2) & above(((v0 & 255) as u8));
        let v4 = if (v3 != 0) {
            v2 << 8 | (lowest(v3) as u32)
        } else {
            let v5 = arg0.level2 & above((v2 as u8));
            if (v5 == 0) {
                return 0x1::option::none<u32>()
            };
            let v6 = (lowest(v5) as u32);
            v6 << 8 | (lowest(*0x2::table::borrow<u32, u256>(&arg0.level1, v6)) as u32)
        };
        0x1::option::some<u32>(v4 << 8 | (lowest(*0x2::table::borrow<u32, u256>(&arg0.level0, v4)) as u32))
    }

    public fun next_below(arg0: &BinBitmap, arg1: u32) : 0x1::option::Option<u32> {
        assert!(arg1 <= 16777215, 1);
        let v0 = arg1 >> 8;
        let v1 = word(&arg0.level0, v0) & below(((arg1 & 255) as u8));
        if (v1 != 0) {
            return 0x1::option::some<u32>(v0 << 8 | (highest(v1) as u32))
        };
        let v2 = v0 >> 8;
        let v3 = word(&arg0.level1, v2) & below(((v0 & 255) as u8));
        let v4 = if (v3 != 0) {
            v2 << 8 | (highest(v3) as u32)
        } else {
            let v5 = arg0.level2 & below((v2 as u8));
            if (v5 == 0) {
                return 0x1::option::none<u32>()
            };
            let v6 = (highest(v5) as u32);
            v6 << 8 | (highest(*0x2::table::borrow<u32, u256>(&arg0.level1, v6)) as u32)
        };
        0x1::option::some<u32>(v4 << 8 | (highest(*0x2::table::borrow<u32, u256>(&arg0.level0, v4)) as u32))
    }

    public(friend) fun set(arg0: &mut BinBitmap, arg1: u32) {
        assert!(arg1 <= 16777215, 1);
        let v0 = arg1 >> 8;
        let v1 = &mut arg0.level0;
        if (set_bit(v1, v0, ((arg1 & 255) as u8))) {
            let v2 = v0 >> 8;
            let v3 = &mut arg0.level1;
            if (set_bit(v3, v2, ((v0 & 255) as u8))) {
                arg0.level2 = arg0.level2 | 1 << (v2 as u8);
            };
        };
    }

    fun set_bit(arg0: &mut 0x2::table::Table<u32, u256>, arg1: u32, arg2: u8) : bool {
        if (!0x2::table::contains<u32, u256>(arg0, arg1)) {
            0x2::table::add<u32, u256>(arg0, arg1, 1 << arg2);
            return true
        };
        let v0 = 0x2::table::borrow_mut<u32, u256>(arg0, arg1);
        *v0 = *v0 | 1 << arg2;
        false
    }

    public(friend) fun unset(arg0: &mut BinBitmap, arg1: u32) {
        assert!(arg1 <= 16777215, 1);
        let v0 = arg1 >> 8;
        let v1 = &mut arg0.level0;
        if (clear_bit(v1, v0, ((arg1 & 255) as u8))) {
            let v2 = v0 >> 8;
            let v3 = &mut arg0.level1;
            if (clear_bit(v3, v2, ((v0 & 255) as u8))) {
                arg0.level2 = arg0.level2 & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 1 << (v2 as u8));
            };
        };
    }

    fun word(arg0: &0x2::table::Table<u32, u256>, arg1: u32) : u256 {
        if (0x2::table::contains<u32, u256>(arg0, arg1)) {
            *0x2::table::borrow<u32, u256>(arg0, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

