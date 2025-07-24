module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::redstuff {
    public(friend) fun encoded_blob_length(arg0: u64, arg1: u16) : u64 {
        (arg1 as u64) * (((source_symbols_primary(arg1) as u64) + (source_symbols_secondary(arg1) as u64)) * (symbol_size(arg0, arg1) as u64) + metadata_size(arg1))
    }

    fun max_byzantine(arg0: u16) : u16 {
        (arg0 - 1) / 3
    }

    fun metadata_size(arg0: u16) : u64 {
        (arg0 as u64) * 32 * 2 + 32
    }

    fun n_source_symbols(arg0: u16) : u64 {
        (source_symbols_primary(arg0) as u64) * (source_symbols_secondary(arg0) as u64)
    }

    fun source_symbols_primary(arg0: u16) : u16 {
        arg0 - 2 * max_byzantine(arg0)
    }

    fun source_symbols_secondary(arg0: u16) : u16 {
        arg0 - max_byzantine(arg0)
    }

    fun symbol_size(arg0: u64, arg1: u16) : u16 {
        if (arg0 == 0) {
            arg0 = 1;
        };
        let v0 = (((arg0 - 1) / n_source_symbols(arg1) + 1) as u16);
        let v1 = v0;
        if (v0 % 2 == 1) {
            v1 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

