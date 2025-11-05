module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::functions_create_receipt_id {
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

