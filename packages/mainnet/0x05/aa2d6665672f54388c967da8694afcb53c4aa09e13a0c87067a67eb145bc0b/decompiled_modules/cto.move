module 0x5aa2d6665672f54388c967da8694afcb53c4aa09e13a0c87067a67eb145bc0b::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"Cto All Chain", b"Just buy and sell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/piccto2_6e4f290c28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

