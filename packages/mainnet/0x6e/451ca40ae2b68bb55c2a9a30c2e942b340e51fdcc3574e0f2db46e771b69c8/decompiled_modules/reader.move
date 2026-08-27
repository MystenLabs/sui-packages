module 0x6e451ca40ae2b68bb55c2a9a30c2e942b340e51fdcc3574e0f2db46e771b69c8::reader {
    public fun read_batch(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: vector<0x2::object::ID>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::clock::Clock) : (vector<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>, vector<u8>, vector<u64>, vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 0);
        let v0 = 0x1::vector::empty<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>();
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg4)) {
            let v3 = *0x1::vector::borrow<u64>(&arg4, v2);
            0x1::vector::push_back<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg0, v3));
            0x1::vector::push_back<u8>(&mut v1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg0, v3));
            v2 = v2 + 1;
        };
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg3)) {
            let v7 = *0x1::vector::borrow<u64>(&arg2, v6);
            assert!(v7 < 0x1::vector::length<0x2::object::ID>(&arg1), 1);
            let v8 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v7);
            let v9 = *0x1::vector::borrow<u64>(&arg3, v6);
            0x1::vector::push_back<u64>(&mut v4, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg0, v9, v8, arg5));
            0x1::vector::push_back<u64>(&mut v5, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg0, v9, v8, arg5));
            v6 = v6 + 1;
        };
        (v0, v1, v4, v5)
    }

    // decompiled from Move bytecode v7
}

