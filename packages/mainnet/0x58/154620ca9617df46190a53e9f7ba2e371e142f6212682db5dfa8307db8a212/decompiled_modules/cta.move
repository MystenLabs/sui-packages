module 0x58154620ca9617df46190a53e9f7ba2e371e142f6212682db5dfa8307db8a212::cta {
    struct CTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTA>(arg0, 6, b"CTA", b"CAT THEFT AUTO", b"CTA on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7060_ba4b4588c6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

