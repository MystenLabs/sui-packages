module 0x719942d809e3b5aaf718ae895d214a3f2784ef5af100cdaac91aa64ceced5e35::rizo {
    struct RIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZO>(arg0, 6, b"RIZO", b"Haha, Yes.", b"HahaYes & RIZO, Tesla's Hedgehog Mascot on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_8a6f993920.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

