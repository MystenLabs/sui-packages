module 0x7a1c9adde2a59af539adf2f8bb459a213e7449c7e04e2b009925575a5423bf0d::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"Cto All Chain", x"4a7573742062757920616e642073656c6c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960881192.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

