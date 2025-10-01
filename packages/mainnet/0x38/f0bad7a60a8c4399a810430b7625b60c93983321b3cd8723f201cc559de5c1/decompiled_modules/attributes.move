module 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::attributes {
    struct Attribute has copy, drop {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    public(friend) fun get_ANCIENT_ATTRIBUTES() : vector<Attribute> {
        let v0 = Attribute{
            key   : 0x1::string::utf8(b"Background"),
            value : 0x1::string::utf8(b"Badlands Dawn"),
        };
        let v1 = Attribute{
            key   : 0x1::string::utf8(b"Background"),
            value : 0x1::string::utf8(b"Badlands Dusk"),
        };
        let v2 = Attribute{
            key   : 0x1::string::utf8(b"Background"),
            value : 0x1::string::utf8(b"Crystal Lake"),
        };
        let v3 = Attribute{
            key   : 0x1::string::utf8(b"Background"),
            value : 0x1::string::utf8(b"Glades Dusk"),
        };
        let v4 = Attribute{
            key   : 0x1::string::utf8(b"Background"),
            value : 0x1::string::utf8(b"Grassland"),
        };
        let v5 = Attribute{
            key   : 0x1::string::utf8(b"Background"),
            value : 0x1::string::utf8(b"Midday Sky"),
        };
        let v6 = Attribute{
            key   : 0x1::string::utf8(b"Background"),
            value : 0x1::string::utf8(b"Moonlit"),
        };
        let v7 = Attribute{
            key   : 0x1::string::utf8(b"Background"),
            value : 0x1::string::utf8(b"Badlands"),
        };
        let v8 = Attribute{
            key   : 0x1::string::utf8(b"Skin"),
            value : 0x1::string::utf8(b"Midas"),
        };
        let v9 = Attribute{
            key   : 0x1::string::utf8(b"Skin"),
            value : 0x1::string::utf8(b"Wireframe"),
        };
        let v10 = 0x1::vector::empty<Attribute>();
        let v11 = &mut v10;
        0x1::vector::push_back<Attribute>(v11, v0);
        0x1::vector::push_back<Attribute>(v11, v1);
        0x1::vector::push_back<Attribute>(v11, v2);
        0x1::vector::push_back<Attribute>(v11, v3);
        0x1::vector::push_back<Attribute>(v11, v4);
        0x1::vector::push_back<Attribute>(v11, v5);
        0x1::vector::push_back<Attribute>(v11, v6);
        0x1::vector::push_back<Attribute>(v11, v7);
        0x1::vector::push_back<Attribute>(v11, v8);
        0x1::vector::push_back<Attribute>(v11, v9);
        v10
    }

    public(friend) fun get_RAT_ATTRIBUTES() : vector<Attribute> {
        let v0 = Attribute{
            key   : 0x1::string::utf8(b"Species"),
            value : 0x1::string::utf8(b"Rat"),
        };
        let v1 = 0x1::vector::empty<Attribute>();
        0x1::vector::push_back<Attribute>(&mut v1, v0);
        v1
    }

    public(friend) fun get_key(arg0: &Attribute) : &0x1::string::String {
        &arg0.key
    }

    public(friend) fun get_value(arg0: &Attribute) : &0x1::string::String {
        &arg0.value
    }

    // decompiled from Move bytecode v6
}

