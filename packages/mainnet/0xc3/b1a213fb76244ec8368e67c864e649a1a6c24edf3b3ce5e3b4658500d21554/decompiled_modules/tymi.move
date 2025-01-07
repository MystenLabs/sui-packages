module 0xc3b1a213fb76244ec8368e67c864e649a1a6c24edf3b3ce5e3b4658500d21554::tymi {
    struct TYMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYMI>(arg0, 6, b"TYMI", b"Cats make us happy", b"Cats are beautiful animals and make us happy to make them live in safety and love and to protect homeless cats from being lost", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_11768d544f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

