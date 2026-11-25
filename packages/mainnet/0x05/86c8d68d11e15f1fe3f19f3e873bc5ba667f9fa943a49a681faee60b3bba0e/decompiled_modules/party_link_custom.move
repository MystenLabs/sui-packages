module 0x586c8d68d11e15f1fe3f19f3e873bc5ba667f9fa943a49a681faee60b3bba0e::party_link_custom {
    struct Custom has drop {
        dummy_field: bool,
    }

    struct CustomLink has drop {
        label: 0x1::string::String,
        url: 0x1::string::String,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v0 > 0 && v0 <= 20, 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == v0, 1);
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        let v1 = 0x1::vector::empty<CustomLink>();
        0x1::vector::reverse<0x1::string::String>(&mut arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v3 = &mut v1;
            let v4 = 0x1::vector::pop_back<0x1::string::String>(&mut arg1);
            let v5 = 0x1::vector::pop_back<0x1::string::String>(&mut arg2);
            let v6 = 0x1::string::length(&v4);
            assert!(v6 > 0 && v6 <= 40, 2);
            assert!(!0x1::string::is_empty(&v5), 3);
            let v7 = CustomLink{
                label : v4,
                url   : v5,
            };
            0x1::vector::push_back<CustomLink>(v3, v7);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg1);
        let v8 = Custom{dummy_field: false};
        0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<Custom>(arg0, v8, 0x1::bcs::to_bytes<vector<CustomLink>>(&v1));
    }

    // decompiled from Move bytecode v7
}

