module 0xb05a4e1eca3828673e2e9c489e89361dcd4388862101ba3603cf58771ec1bb9a::reader {
    public fun current<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>) : (u64, u64, u64, u64, bool, u64, u64, bool) {
        decode_state(0x1::bcs::to_bytes<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0))
    }

    fun decode_state(arg0: vector<u8>) : (u64, u64, u64, u64, bool, u64, u64, bool) {
        (read_u64(&arg0, 40), read_u64(&arg0, 32), read_u64(&arg0, 64), read_u64(&arg0, 72), read_bool(&arg0, 96), read_u64(&arg0, 97), read_u64(&arg0, 105), read_bool(&arg0, 113))
    }

    public fun pool_bcs<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>) : vector<u8> {
        0x1::bcs::to_bytes<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0)
    }

    fun read_bool(arg0: &vector<u8>, arg1: u64) : bool {
        *0x1::vector::borrow<u8>(arg0, arg1) == 1
    }

    fun read_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u64) | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, arg1 + 4) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, arg1 + 5) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, arg1 + 6) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, arg1 + 7) as u64) << 56
    }

    // decompiled from Move bytecode v7
}

