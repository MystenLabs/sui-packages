module 0x24322593037b0cdfc4dfe333c50531ff6ac4bc2f8ccb83c6f8fd7c04c74b551f::party_link_email {
    struct Email has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::PartyLinks, arg1: 0x1::string::String) {
        let v0 = Email{dummy_field: false};
        0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link::add<Email>(arg0, v0, 0x1::string::into_bytes(arg1));
    }

    // decompiled from Move bytecode v7
}

