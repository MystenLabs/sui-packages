module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_create_receipt_id {
    public(friend) fun create_receipt_id(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b":"));
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b":"));
        0x1::string::append(&mut v0, arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

