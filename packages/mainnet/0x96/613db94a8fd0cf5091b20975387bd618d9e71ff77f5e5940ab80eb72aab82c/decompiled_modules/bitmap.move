module 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::bitmap {
    fun highest_set_bit(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >= 340282366920938463463374607431768211456) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >= 18446744073709551616) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >= 4294967296) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >= 65536) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >= 256) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >= 16) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >= 4) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >= 2) {
            v1 = v1 + 1;
        };
        v1
    }

    public(friend) fun scan_down_excluding(arg0: &0x2::table::Table<u16, u256>, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, arg2: 0x1::option::Option<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>) : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick {
        let v0 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::word_of(arg1);
        let v1 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::bit_of(arg1);
        let v2 = if (v1 == 0) {
            0
        } else {
            (1 << v1) - 1
        };
        let v3 = word_value(arg0, v0) & v2;
        if (v3 != 0) {
            return 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::tick_at(v0, highest_set_bit(v3))
        };
        if (0x1::option::is_some<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>(&arg2) && 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::lt(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::first_tick_of_word(v0), *0x1::option::borrow<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>(&arg2))) {
            return 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick()
        };
        if (v0 == 0) {
            return 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick()
        };
        scan_down_from(arg0, v0 - 1, arg2)
    }

    public(friend) fun scan_down_from(arg0: &0x2::table::Table<u16, u256>, arg1: u16, arg2: 0x1::option::Option<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>) : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick {
        loop {
            let v0 = word_value(arg0, arg1);
            if (v0 != 0) {
                return 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::tick_at(arg1, highest_set_bit(v0))
            };
            if (0x1::option::is_some<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>(&arg2) && 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::lt(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::first_tick_of_word(arg1), *0x1::option::borrow<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick>(&arg2))) {
                return 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick()
            };
            if (arg1 == 0) {
                break
            };
            arg1 = arg1 - 1;
        };
        0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick()
    }

    fun word_value(arg0: &0x2::table::Table<u16, u256>, arg1: u16) : u256 {
        if (0x2::table::contains<u16, u256>(arg0, arg1)) {
            *0x2::table::borrow<u16, u256>(arg0, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

