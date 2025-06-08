module 0xf7de0d6b442728b570f7ddd420b13e8ebb6568d69e114c4602d4e0a4ab2b9d90::unit {
    public fun bytes_to_kb(arg0: u64) : u64 {
        arg0 / 1024
    }

    public fun bytes_to_mb(arg0: u64) : u64 {
        arg0 / 1048576
    }

    public fun fmt_size(arg0: u64) : 0x1::string::String {
        if (arg0 >= 1048576 && arg0 % 1048576 == 0) {
            let v1 = u64_to_string(arg0 / 1048576);
            0x1::string::append(&mut v1, 0x1::string::utf8(b"MB"));
            v1
        } else if (arg0 >= 1024 && arg0 % 1024 == 0) {
            let v2 = u64_to_string(arg0 / 1024);
            0x1::string::append(&mut v2, 0x1::string::utf8(b"KB"));
            v2
        } else {
            let v3 = u64_to_string(arg0);
            0x1::string::append(&mut v3, 0x1::string::utf8(b" bytes"));
            v3
        }
    }

    public fun fmt_size_precise(arg0: u64) : 0x1::string::String {
        if (arg0 >= 1048576) {
            if (arg0 % 1048576 == 0) {
                let v1 = u64_to_string(arg0 / 1048576);
                0x1::string::append(&mut v1, 0x1::string::utf8(b"MB"));
                v1
            } else {
                let v2 = u64_to_string(arg0 / 1024);
                0x1::string::append(&mut v2, 0x1::string::utf8(b"KB"));
                v2
            }
        } else if (arg0 >= 1024) {
            if (arg0 % 1024 == 0) {
                let v3 = u64_to_string(arg0 / 1024);
                0x1::string::append(&mut v3, 0x1::string::utf8(b"KB"));
                v3
            } else {
                let v4 = u64_to_string(arg0);
                0x1::string::append(&mut v4, 0x1::string::utf8(b" bytes"));
                v4
            }
        } else {
            let v5 = u64_to_string(arg0);
            0x1::string::append(&mut v5, 0x1::string::utf8(b" bytes"));
            v5
        }
    }

    public fun kb_to_bytes(arg0: u64) : u64 {
        arg0 * 1024
    }

    public fun mb_to_bytes(arg0: u64) : u64 {
        arg0 * 1048576
    }

    public fun parse_size(arg0: u64, arg1: 0x1::string::String) : u64 {
        if (arg1 == 0x1::string::utf8(b"MB")) {
            mb_to_bytes(arg0)
        } else if (arg1 == 0x1::string::utf8(b"KB")) {
            kb_to_bytes(arg0)
        } else {
            arg0
        }
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

