module 0x6b19c57e4befa063f0d26123cbc0bb25be3715ea3c08617d74e4cf0ca54bb377::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"Community Takeover", b"From the Community For the Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f7f4b613_81b5_48ea_ae8b_17a856322e0e_7c72067a5b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

