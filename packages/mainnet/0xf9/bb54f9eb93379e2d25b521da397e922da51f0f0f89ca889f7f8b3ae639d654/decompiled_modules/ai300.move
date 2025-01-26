module 0xf9bb54f9eb93379e2d25b521da397e922da51f0f0f89ca889f7f8b3ae639d654::ai300 {
    struct AI300 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI300, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI300>(arg0, 6, b"AI300", b"AI300 ON SUI", b"AI300 stands as the cornerstone of the Global Crypto Ecosystem, leveraging cutting-edge AI-driven insights to provide unparalleled support for crypto enthusiast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AI_300_in_ASCII_art_style_29027964cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI300>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI300>>(v1);
    }

    // decompiled from Move bytecode v6
}

