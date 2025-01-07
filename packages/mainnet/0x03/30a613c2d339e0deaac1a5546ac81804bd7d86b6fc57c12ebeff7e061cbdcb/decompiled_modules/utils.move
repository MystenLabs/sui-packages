module 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::utils {
    public(friend) fun calculate_hash_for_string(arg0: 0x1::string::String) : 0x1::string::String {
        0x1::string::utf8(0x2::hex::encode(0x2::hash::blake2b256(0x1::string::bytes(&arg0))))
    }

    public(friend) fun concatenate_strings(arg0: vector<0x1::string::String>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        while (!0x1::vector::is_empty<0x1::string::String>(&arg0)) {
            0x1::string::append(&mut v0, 0x1::vector::remove<0x1::string::String>(&mut arg0, 0));
        };
        v0
    }

    // decompiled from Move bytecode v6
}

