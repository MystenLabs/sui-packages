module 0x8799eb02079a22ed40f15b343879004d98e160c7a90162756450dbb2c705b45c::redstuff {
    fun decoding_safety_limit(arg0: u16, arg1: u8) : u16 {
        let v0 = &arg1;
        let v1 = 0;
        if (v0 == &v1) {
            0x1::u16::min(max_byzantine(arg0) / 5, 5)
        } else {
            let v3 = 1;
            assert!(v0 == &v3, 0);
            0
        }
    }

    public(friend) fun encoded_blob_length(arg0: u64, arg1: u16, arg2: u8) : u64 {
        (arg1 as u64) * (((source_symbols_primary(arg1, arg2) as u64) + (source_symbols_secondary(arg1, arg2) as u64)) * (symbol_size(arg0, arg1, arg2) as u64) + metadata_size(arg1))
    }

    fun max_byzantine(arg0: u16) : u16 {
        (arg0 - 1) / 3
    }

    fun metadata_size(arg0: u16) : u64 {
        (arg0 as u64) * 32 * 2 + 32
    }

    fun n_source_symbols(arg0: u16, arg1: u8) : u64 {
        (source_symbols_primary(arg0, arg1) as u64) * (source_symbols_secondary(arg0, arg1) as u64)
    }

    fun source_symbols_primary(arg0: u16, arg1: u8) : u16 {
        arg0 - 2 * max_byzantine(arg0) - decoding_safety_limit(arg0, arg1)
    }

    fun source_symbols_secondary(arg0: u16, arg1: u8) : u16 {
        arg0 - max_byzantine(arg0) - decoding_safety_limit(arg0, arg1)
    }

    fun symbol_size(arg0: u64, arg1: u16, arg2: u8) : u16 {
        if (arg0 == 0) {
            arg0 = 1;
        };
        let v0 = (((arg0 - 1) / n_source_symbols(arg1, arg2) + 1) as u16);
        let v1 = v0;
        if (arg2 == 1 && v0 % 2 == 1) {
            v1 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

