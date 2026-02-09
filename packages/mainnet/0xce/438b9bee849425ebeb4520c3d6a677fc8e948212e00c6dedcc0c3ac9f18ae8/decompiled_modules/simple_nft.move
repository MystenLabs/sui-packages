module 0xce438b9bee849425ebeb4520c3d6a677fc8e948212e00c6dedcc0c3ac9f18ae8::simple_nft {
    struct Hero has store, key {
        id: 0x2::object::UID,
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Hero>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

