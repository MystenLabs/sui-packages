module 0xea412eb7a022f269402b0955f1549e483ddb65c5a3b330d62e223255b5a5de9f::left_pad {
    public fun left_pad(arg0: 0x1::string::String, arg1: u32, arg2: 0x1::option::Option<0x1::ascii::Char>) : 0x1::string::String {
        if ((arg1 as u64) <= 0x1::string::length(&arg0)) {
            return arg0
        };
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < (((arg1 as u64) - 0x1::string::length(&arg0)) as u64)) {
            0x1::vector::push_back<u8>(&mut v0, 0x1::ascii::byte(0x1::option::get_with_default<0x1::ascii::Char>(&arg2, 0x1::ascii::char(32))));
            v1 = v1 + 1;
        };
        let v2 = 0x1::string::from_ascii(0x1::ascii::string(v0));
        0x1::string::append(&mut v2, arg0);
        v2
    }

    // decompiled from Move bytecode v6
}

