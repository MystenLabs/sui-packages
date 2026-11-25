module 0xc362e6da9c57ad85e61e3e0fad55dea339203783c45598514ec60a3b5023e8a7::party_link_youtube {
    struct YouTube has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: 0x1::string::String) {
        let v0 = 0x1::string::into_bytes(arg1);
        assert!(0x1::vector::length<u8>(&v0) == 24, 0);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            assert!(is_allowed(*0x1::vector::borrow<u8>(v1, v2)), 1);
            v2 = v2 + 1;
        };
        let v3 = b"UC";
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v3)) {
            assert!(*0x1::vector::borrow<u8>(&v0, v4) == *0x1::vector::borrow<u8>(&v3, v4), 2);
            v4 = v4 + 1;
        };
        let v5 = YouTube{dummy_field: false};
        0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<YouTube>(arg0, v5, v0);
    }

    fun is_allowed(arg0: u8) : bool {
        let v0 = b"-_";
        if (arg0 >= 48 && arg0 <= 57) {
            true
        } else if (arg0 >= 97 && arg0 <= 122) {
            true
        } else if (arg0 >= 65 && arg0 <= 90) {
            true
        } else {
            0x1::vector::contains<u8>(&v0, &arg0)
        }
    }

    // decompiled from Move bytecode v7
}

