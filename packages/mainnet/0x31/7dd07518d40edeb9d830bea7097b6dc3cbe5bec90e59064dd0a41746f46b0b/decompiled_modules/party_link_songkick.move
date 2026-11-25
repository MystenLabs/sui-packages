module 0x317dd07518d40edeb9d830bea7097b6dc3cbe5bec90e59064dd0a41746f46b0b::party_link_songkick {
    struct Songkick has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: 0x1::string::String) {
        let v0 = 0x1::string::into_bytes(arg1);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(v1 >= 1 && v1 <= 20, 0);
        let v2 = &v0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v2)) {
            assert!(is_allowed(*0x1::vector::borrow<u8>(v2, v3)), 1);
            v3 = v3 + 1;
        };
        let v4 = Songkick{dummy_field: false};
        0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<Songkick>(arg0, v4, v0);
    }

    fun is_allowed(arg0: u8) : bool {
        arg0 >= 48 && arg0 <= 57
    }

    // decompiled from Move bytecode v7
}

