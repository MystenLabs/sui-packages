module 0x765b132f01ff70dbf18cf36dc24c5f689a2ff0bf7d65dd7cdb2ed280d8cce82d::batch_add_v1_tick {
    struct AddV1TickEvent has copy, drop, store {
        length: u64,
        firstTick: 0x1::string::String,
        lastTick: 0x1::string::String,
    }

    public fun batch_add_v1_tick(arg0: &mut 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::GlobalConfig, arg1: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::AdminCap, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u8>, arg7: vector<u64>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 1);
        assert!(0x1::vector::length<u64>(&arg4) == v0, 1);
        assert!(0x1::vector::length<u64>(&arg5) == v0, 1);
        assert!(0x1::vector::length<u8>(&arg6) == v0, 1);
        assert!(0x1::vector::length<u64>(&arg7) == v0, 1);
        let v1 = 0;
        while (v1 < v0) {
            0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::suirc20::add_v1_tick(arg0, arg1, 0x1::vector::pop_back<0x1::string::String>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4), 0x1::vector::pop_back<u64>(&mut arg5), 0x1::vector::pop_back<u8>(&mut arg6), 0x1::vector::pop_back<u64>(&mut arg7), arg8, arg9);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

