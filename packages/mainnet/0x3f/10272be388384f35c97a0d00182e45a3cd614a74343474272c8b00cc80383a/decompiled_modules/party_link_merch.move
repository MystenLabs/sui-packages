module 0x3f10272be388384f35c97a0d00182e45a3cd614a74343474272c8b00cc80383a::party_link_merch {
    struct Merch has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: 0x1::string::String) {
        let v0 = Merch{dummy_field: false};
        0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<Merch>(arg0, v0, 0x1::string::into_bytes(arg1));
    }

    // decompiled from Move bytecode v7
}

