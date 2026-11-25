module 0x42a461bf1a90ac2c1a7c09c67b5ff98a43065a6e3afac339e137f8877f4dd30b::party_link_spotify {
    struct Spotify has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: 0x1::string::String) {
        let v0 = 0x1::string::into_bytes(arg1);
        assert!(0x1::vector::length<u8>(&v0) == 22, 0);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            assert!(is_allowed(*0x1::vector::borrow<u8>(v1, v2)), 1);
            v2 = v2 + 1;
        };
        let v3 = Spotify{dummy_field: false};
        0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<Spotify>(arg0, v3, v0);
    }

    fun is_allowed(arg0: u8) : bool {
        if (arg0 >= 48 && arg0 <= 57) {
            true
        } else if (arg0 >= 97 && arg0 <= 122) {
            true
        } else {
            arg0 >= 65 && arg0 <= 90
        }
    }

    // decompiled from Move bytecode v7
}

