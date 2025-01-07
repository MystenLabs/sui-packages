module 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::display {
    public fun from_vec(arg0: vector<0x1::string::String>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"[");
        0x1::vector::reverse<0x1::string::String>(&mut arg0);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg0);
        while (v1 > 0) {
            0x1::string::append_utf8(&mut v0, b"\"");
            0x1::string::append(&mut v0, 0x1::vector::pop_back<0x1::string::String>(&mut arg0));
            0x1::string::append_utf8(&mut v0, b"\"");
            v1 = v1 - 1;
            if (v1 != 0) {
                0x1::string::append_utf8(&mut v0, b",");
            };
        };
        0x1::string::append_utf8(&mut v0, b"]");
        v0
    }

    public fun from_vec_map(arg0: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"{");
        let v1 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&arg0);
        0x1::vector::reverse<0x1::string::String>(&mut v1);
        let v2 = 0x1::vector::length<0x1::string::String>(&v1);
        while (v2 > 0) {
            let v3 = 0x1::vector::pop_back<0x1::string::String>(&mut v1);
            let (v4, v5) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0, &v3);
            0x1::string::append_utf8(&mut v0, b"\"");
            0x1::string::append(&mut v0, v4);
            0x1::string::append_utf8(&mut v0, b"\": ");
            0x1::string::append_utf8(&mut v0, b"\"");
            0x1::string::append(&mut v0, v5);
            0x1::string::append_utf8(&mut v0, b"\"");
            v2 = v2 - 1;
            if (v2 != 0) {
                0x1::string::append_utf8(&mut v0, b",");
            };
        };
        0x1::string::append_utf8(&mut v0, b"}");
        v0
    }

    public fun from_vec_map_ref(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: bool) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"{");
        let v1 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(arg0);
        0x1::vector::reverse<0x1::string::String>(&mut v1);
        let v2 = 0x1::vector::length<0x1::string::String>(&v1);
        while (v2 > 0) {
            let v3 = 0x1::vector::pop_back<0x1::string::String>(&mut v1);
            0x1::string::append_utf8(&mut v0, b"\"");
            0x1::string::append(&mut v0, v3);
            0x1::string::append_utf8(&mut v0, b"\": ");
            if (arg1) {
                0x1::string::append_utf8(&mut v0, b"\"");
            };
            0x1::string::append(&mut v0, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg0, &v3));
            if (arg1) {
                0x1::string::append_utf8(&mut v0, b"\"");
            };
            v2 = v2 - 1;
            if (v2 != 0) {
                0x1::string::append_utf8(&mut v0, b",");
            };
        };
        0x1::string::append_utf8(&mut v0, b"}");
        v0
    }

    public fun from_vec_utf8(arg0: vector<vector<u8>>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"[");
        0x1::vector::reverse<vector<u8>>(&mut arg0);
        let v1 = 0x1::vector::length<vector<u8>>(&arg0);
        while (v1 > 0) {
            0x1::string::append_utf8(&mut v0, b"\"");
            0x1::string::append_utf8(&mut v0, 0x1::vector::pop_back<vector<u8>>(&mut arg0));
            0x1::string::append_utf8(&mut v0, b"\"");
            v1 = v1 - 1;
            if (v1 != 0) {
                0x1::string::append_utf8(&mut v0, b",");
            };
        };
        0x1::string::append_utf8(&mut v0, b"]");
        v0
    }

    // decompiled from Move bytecode v6
}

