module 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::util {
    public fun assert_name_valid(arg0: &0x1::ascii::String) {
        let v0 = false;
        let v1 = 0;
        let v2 = 0x1::ascii::into_bytes(*arg0);
        let v3 = 0x1::vector::length<u8>(&v2);
        if (v3 >= 1 && v3 <= 256) {
            v0 = true;
        };
        while (v0 && v1 < 0x1::vector::length<u8>(&v2)) {
            let v4 = *0x1::vector::borrow<u8>(&v2, v1);
            v0 = false;
            if (v4 >= 48 && v4 <= 57) {
                v0 = true;
            } else if (v4 >= 97 && v4 <= 122) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 200);
    }

    public fun make_domain(arg0: &0x1::ascii::String, arg1: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = *0x1::ascii::as_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, b".");
        0x1::vector::append<u8>(&mut v0, *0x1::ascii::as_bytes(arg1));
        0x1::ascii::string(v0)
    }

    public fun max_domain_length() : u64 {
        256
    }

    public fun min_domain_length() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

