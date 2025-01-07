module 0xa9f5ad5953c44382554d969d2f31b832bcf475092987d4721b4d516952b36456::pape {
    struct PAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPE>(arg0, 6, b"Pape", b"PAPE SUI", b"$PAPE The OG meme will become the father of Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3940_96e91f742a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

