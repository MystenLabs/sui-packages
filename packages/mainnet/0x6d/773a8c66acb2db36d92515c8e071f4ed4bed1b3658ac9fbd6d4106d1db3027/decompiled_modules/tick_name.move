module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name {
    public fun disallowed_tick_chars() : vector<u8> {
        b" .\"'\\/<>?;:[]{}()!@#$%^&*+=|~-,`"
    }

    public fun is_tick_name_reserved(arg0: vector<u8>) : bool {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg0);
        arg0 == b"MOVE" || arg0 == b"TICK" || arg0 == b"NAME" || arg0 == b"TEST"
    }

    public fun is_tick_name_valid(arg0: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 < 4 || v0 > 32) {
            return false
        };
        let v1 = b" .\"'\\/<>?;:[]{}()!@#$%^&*+=|~-,`";
        if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::contains_any(&arg0, &v1)) {
            return false
        };
        let v2 = 0x1::ascii::try_string(arg0);
        if (0x1::option::is_none<0x1::ascii::String>(&v2)) {
            return false
        };
        let v3 = 0x1::option::destroy_some<0x1::ascii::String>(v2);
        0x1::ascii::all_characters_printable(&v3)
    }

    public fun max_tick_length() : u64 {
        32
    }

    public fun min_tick_length() : u64 {
        4
    }

    public fun move_tick() : vector<u8> {
        b"MOVE"
    }

    public fun name_tick() : vector<u8> {
        b"NAME"
    }

    public fun test_tick() : vector<u8> {
        b"TEST"
    }

    public fun tick_tick() : vector<u8> {
        b"TICK"
    }

    // decompiled from Move bytecode v6
}

