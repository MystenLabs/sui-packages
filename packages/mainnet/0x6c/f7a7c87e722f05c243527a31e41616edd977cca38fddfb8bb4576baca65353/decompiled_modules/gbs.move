module 0x6cf7a7c87e722f05c243527a31e41616edd977cca38fddfb8bb4576baca65353::gbs {
    struct GBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBS>(arg0, 6, b"GBS", b"Giga Brett Sui", b"Yo, check this out. Were not just talking about another meme coin here. This is Chad Brett Sui, the Gigachad of gains mixed with Bretts big brain, who moves straight out of Sui Chain and is now the king of the sea hill. We are launching on Movepump, so get ready to go bubbly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Final_Logo_749fc09354.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

