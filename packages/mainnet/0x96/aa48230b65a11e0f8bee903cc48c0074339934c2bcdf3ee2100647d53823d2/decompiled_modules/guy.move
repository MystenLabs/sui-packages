module 0x96aa48230b65a11e0f8bee903cc48c0074339934c2bcdf3ee2100647d53823d2::guy {
    struct GUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUY>(arg0, 6, b"GUY", b"The real sui guy", b"The real sui guy!! We are real and remember the truth always comes out. Welcome to the new God of Sui Memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih3jtj5l4d6inhj6ervjyqupl2n3btwy2grmfu2iqonycs3ok4pxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

