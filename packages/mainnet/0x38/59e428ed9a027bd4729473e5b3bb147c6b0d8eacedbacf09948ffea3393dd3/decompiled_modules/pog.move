module 0x3859e428ed9a027bd4729473e5b3bb147c6b0d8eacedbacf09948ffea3393dd3::pog {
    struct POG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POG>(arg0, 6, b"POG", b"Pog The Frog", b"Pog is a meme featuring an image of the Frog with a surprised and excited emotion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048488_956dee6f09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POG>>(v1);
    }

    // decompiled from Move bytecode v6
}

