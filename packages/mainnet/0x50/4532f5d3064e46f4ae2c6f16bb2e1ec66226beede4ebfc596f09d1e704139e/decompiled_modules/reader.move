module 0x504532f5d3064e46f4ae2c6f16bb2e1ec66226beede4ebfc596f09d1e704139e::reader {
    public fun current<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>) : (u64, u64, u64, u64, bool, u64, u64, bool) {
        decode_state(0x1::bcs::to_bytes<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0))
    }

    fun decode_state(arg0: vector<u8>) : (u64, u64, u64, u64, bool, u64, u64, bool) {
        assert!(0x1::vector::length<u8>(&arg0) == 116, 900);
        read_bool(&arg0, 114);
        read_bool(&arg0, 115);
        (read_u64(&arg0, 40), read_u64(&arg0, 32), read_u64(&arg0, 64), read_u64(&arg0, 72), read_bool(&arg0, 96), read_u64(&arg0, 97), read_u64(&arg0, 105), read_bool(&arg0, 113))
    }

    public fun pool_bcs<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>) : vector<u8> {
        0x1::bcs::to_bytes<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0)
    }

    fun read_bool(arg0: &vector<u8>, arg1: u64) : bool {
        let v0 = *0x1::vector::borrow<u8>(arg0, arg1);
        assert!(v0 <= 1, 900);
        v0 == 1
    }

    fun read_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u64) | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, arg1 + 4) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, arg1 + 5) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, arg1 + 6) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, arg1 + 7) as u64) << 56
    }

    // decompiled from Move bytecode v7
}

