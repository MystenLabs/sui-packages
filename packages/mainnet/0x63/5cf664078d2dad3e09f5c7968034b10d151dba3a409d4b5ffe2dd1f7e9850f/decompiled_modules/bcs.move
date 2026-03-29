module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs {
    public fun peel_string(arg0: &mut 0x2::bcs::BCS) : 0x1::ascii::String {
        0x1::ascii::string(0x2::bcs::peel_vec_u8(arg0))
    }

    public fun peel_vec_string(arg0: &mut 0x2::bcs::BCS) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x2::bcs::peel_vec_vec_u8(arg0);
        0x1::vector::reverse<vector<u8>>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(0x1::vector::pop_back<vector<u8>>(&mut v1)));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

