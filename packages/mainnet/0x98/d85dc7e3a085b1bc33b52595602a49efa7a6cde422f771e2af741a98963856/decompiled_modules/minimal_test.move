module 0x98d85dc7e3a085b1bc33b52595602a49efa7a6cde422f771e2af741a98963856::minimal_test {
    struct Store has key {
        id: 0x2::object::UID,
        data: 0x1::string::String,
    }

    public entry fun calculate(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 1);
        0x1::vector::push_back<u64>(&mut v2, 2);
        0x1::vector::push_back<u64>(&mut v2, 3);
        0x1::vector::push_back<u64>(&mut v2, 4);
        0x1::vector::push_back<u64>(&mut v2, 5);
        0x1::vector::push_back<u64>(&mut v2, 6);
        0x1::vector::push_back<u64>(&mut v2, 7);
        0x1::vector::push_back<u64>(&mut v2, 8);
        0x1::vector::push_back<u64>(&mut v2, 9);
        0x1::vector::push_back<u64>(&mut v2, 10);
        0x1::vector::push_back<u64>(&mut v2, 11);
        0x1::vector::push_back<u64>(&mut v2, 12);
        0x1::vector::push_back<u64>(&mut v2, 13);
        0x1::vector::push_back<u64>(&mut v2, 14);
        0x1::vector::push_back<u64>(&mut v2, 15);
        0x1::vector::push_back<u64>(&mut v2, 16);
        let v3 = 0;
        while (v3 < arg1) {
            v3 = v3 + 1;
            v0 = (v0 * 1664525 + 1013904223) % 4294967296;
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::swap_remove<u64>(&mut v2, v0 % 0x1::vector::length<u64>(&v2)));
        };
    }

    // decompiled from Move bytecode v6
}

