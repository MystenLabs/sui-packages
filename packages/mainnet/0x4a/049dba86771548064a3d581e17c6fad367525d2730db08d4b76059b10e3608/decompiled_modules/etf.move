module 0x4a049dba86771548064a3d581e17c6fad367525d2730db08d4b76059b10e3608::etf {
    struct ETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETF>(arg0, 6, b"ETF", b"SUICHAINETF", b"This is a high-quality token growth ETF based on the Sui chain, utilizing quantitative tools for trading operations to achieve sustainable returns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3736_51cf5273a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETF>>(v1);
    }

    // decompiled from Move bytecode v6
}

