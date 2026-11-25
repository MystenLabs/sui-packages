module 0xe252cf51741d0001241260c7752b74ad5d98325cf92236c507f30b990a5af5f8::party_link_amazon_music {
    struct AmazonMusic has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: 0x1::string::String) {
        let v0 = 0x1::string::into_bytes(arg1);
        assert!(0x1::vector::length<u8>(&v0) == 10, 0);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            assert!(is_allowed(*0x1::vector::borrow<u8>(v1, v2)), 1);
            v2 = v2 + 1;
        };
        let v3 = AmazonMusic{dummy_field: false};
        0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<AmazonMusic>(arg0, v3, v0);
    }

    fun is_allowed(arg0: u8) : bool {
        arg0 >= 48 && arg0 <= 57 || arg0 >= 65 && arg0 <= 90
    }

    // decompiled from Move bytecode v7
}

