module 0x46bc7c1fdc34a887ed6c158ea0487c2b30a562ad6500a10e4d7b49f0589d062b::attr_factory {
    struct Attributes has drop, store {
        level: 0x1::string::String,
    }

    public(friend) fun create_attr(arg0: 0x1::string::String) : Attributes {
        let v0 = vector[b"Ambassador", b"Affiliate"];
        let v1 = 0x1::string::into_bytes(arg0);
        assert!(0x1::vector::contains<vector<u8>>(&v0, &v1), 0);
        Attributes{level: arg0}
    }

    public fun level(arg0: &Attributes) : 0x1::string::String {
        arg0.level
    }

    // decompiled from Move bytecode v6
}

