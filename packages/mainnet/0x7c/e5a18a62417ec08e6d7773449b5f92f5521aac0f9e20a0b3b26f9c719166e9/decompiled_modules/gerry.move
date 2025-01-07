module 0x7ce5a18a62417ec08e6d7773449b5f92f5521aac0f9e20a0b3b26f9c719166e9::gerry {
    struct GERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GERRY>(arg0, 6, b"GERRY", b"Gerry on Sui", b"ack in the cryptosphere with $GERRY . Fear and distrust is rampant in the crypto market. Our current goal is to simply make people laugh and regain trust in the crypto market with a project driven by a hopeful and positive community spreading memes and laughters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043345_65fcbd79cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

