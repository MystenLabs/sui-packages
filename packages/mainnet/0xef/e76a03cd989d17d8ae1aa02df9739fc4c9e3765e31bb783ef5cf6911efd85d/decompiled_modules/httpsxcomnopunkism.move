module 0xefe76a03cd989d17d8ae1aa02df9739fc4c9e3765e31bb783ef5cf6911efd85d::httpsxcomnopunkism {
    struct HTTPSXCOMNOPUNKISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTTPSXCOMNOPUNKISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTTPSXCOMNOPUNKISM>(arg0, 6, b"httpsxcomNoPunkism", b"No-Punks", b"This Token & NFT collection may or may not be visible", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_1765ed023a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTTPSXCOMNOPUNKISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTTPSXCOMNOPUNKISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

