module 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types {
    public fun assert_supported(arg0: u8) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else {
            arg0 == 6
        };
        assert!(v0, 5);
    }

    public fun blog_post() : u8 {
        2
    }

    public fun code(arg0: u8, arg1: u64, arg2: &0x2::object::ID) : 0x1::string::String {
        assert_supported(arg0);
        let v0 = 0x1::string::utf8(b"PaperProof-");
        0x1::string::append(&mut v0, name(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, epoch6_to_string(arg1));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, id_hex_prefix_12(arg2));
        v0
    }

    public fun dataset() : u8 {
        4
    }

    fun epoch6_to_string(arg0: u64) : 0x1::string::String {
        let v0 = arg0 % 1000000;
        let v1 = 100000;
        let v2 = 0x1::vector::empty<u8>();
        while (v1 > 0) {
            0x1::vector::push_back<u8>(&mut v2, 48 + ((v0 / v1) as u8));
            v0 = v0 % v1;
            v1 = v1 / 10;
        };
        0x1::string::utf8(v2)
    }

    public fun generic_file() : u8 {
        6
    }

    fun hex_digit(arg0: u8) : u8 {
        if (arg0 < 10) {
            48 + arg0
        } else {
            87 + arg0
        }
    }

    fun id_hex_prefix_12(arg0: &0x2::object::ID) : 0x1::string::String {
        let v0 = 0x2::object::id_to_bytes(arg0);
        assert!(0x1::vector::length<u8>(&v0) >= 6, 6);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 6) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            0x1::vector::push_back<u8>(&mut v1, hex_digit(v3 / 16));
            0x1::vector::push_back<u8>(&mut v1, hex_digit(v3 % 16));
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    public fun name(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"preprint")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"blog_post")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"technical_report")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"dataset")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"software_release")
        } else {
            assert!(arg0 == 6, 5);
            0x1::string::utf8(b"generic_file")
        }
    }

    public fun preprint() : u8 {
        1
    }

    public fun software_release() : u8 {
        5
    }

    public fun technical_report() : u8 {
        3
    }

    // decompiled from Move bytecode v7
}

