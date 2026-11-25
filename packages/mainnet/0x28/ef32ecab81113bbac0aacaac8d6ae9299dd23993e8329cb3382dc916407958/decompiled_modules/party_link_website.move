module 0x28ef32ecab81113bbac0aacaac8d6ae9299dd23993e8329cb3382dc916407958::party_link_website {
    struct Website has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: 0x1::string::String) {
        let v0 = Website{dummy_field: false};
        0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<Website>(arg0, v0, 0x1::string::into_bytes(arg1));
    }

    // decompiled from Move bytecode v7
}

