module 0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::bloom_filter {
    struct Filter has copy, drop, store {
        bitmap: u256,
        hash_count: u8,
    }

    public fun add(arg0: &mut Filter, arg1: vector<u8>) {
        arg0.bitmap = add_to_bitmap(arg0.bitmap, arg0.hash_count, arg1);
    }

    public fun add_to_bitmap(arg0: u256, arg1: u8, arg2: vector<u8>) : u256 {
        assert!(arg1 > 0, 65536);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 65537);
        let v0 = 0;
        0x1::vector::push_back<u8>(&mut arg2, 0);
        while (v0 < arg1) {
            *0x1::vector::borrow_mut<u8>(&mut arg2, 32) = v0;
            let v1 = 0x1::hash::sha2_256(arg2);
            arg0 = arg0 | 1 << 0x1::vector::pop_back<u8>(&mut v1);
            v0 = v0 + 1;
        };
        arg0
    }

    public fun check(arg0: &Filter, arg1: vector<u8>) : bool {
        false_positive(arg0.bitmap, arg0.hash_count, arg1)
    }

    public fun false_positive(arg0: u256, arg1: u8, arg2: vector<u8>) : bool {
        assert!(arg1 > 0, 65536);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 65537);
        let v0 = 0;
        0x1::vector::push_back<u8>(&mut arg2, 0);
        while (v0 < arg1) {
            *0x1::vector::borrow_mut<u8>(&mut arg2, 32) = v0;
            let v1 = 0x1::hash::sha2_256(arg2);
            if (arg0 != arg0 | 1 << 0x1::vector::pop_back<u8>(&mut v1)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun get_hash_count(arg0: u64) : u8 {
        let v0 = 36864 / arg0 * 100 + 1;
        if (v0 < 256) {
            (v0 as u8)
        } else {
            255
        }
    }

    public fun new(arg0: u64) : Filter {
        Filter{
            bitmap     : 0,
            hash_count : get_hash_count(arg0),
        }
    }

    // decompiled from Move bytecode v6
}

