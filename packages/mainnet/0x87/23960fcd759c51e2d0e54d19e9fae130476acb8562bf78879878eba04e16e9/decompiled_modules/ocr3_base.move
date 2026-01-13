module 0x8723960fcd759c51e2d0e54d19e9fae130476acb8562bf78879878eba04e16e9::ocr3_base {
    struct ConfigSet has copy, drop {
        ocr_plugin_type: u8,
        config_digest: vector<u8>,
        signers: vector<vector<u8>>,
        transmitters: vector<address>,
        big_f: u8,
    }

    public fun emit_config_set() {
        let v0 = ConfigSet{
            ocr_plugin_type : 1,
            config_digest   : b"",
            signers         : vector[],
            transmitters    : vector[@0x7f8e09ea5a9d6e72854af8d6fa3e4d6f5466d9c11b498e0d9d4f64d8cabe8d32, @0xc8cc7f57a25e6e96e6be7bcd606a1a8d59d85d757d08e7e045e87a8cfe0bcbc7, @0x5],
            big_f           : 2,
        };
        0x2::event::emit<ConfigSet>(v0);
    }

    // decompiled from Move bytecode v6
}

