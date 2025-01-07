module 0xaea97b1211742c2e0d1f720f7a2a87466aeb2ac17b5072cefadc18015c08d92d::swift {
    struct SWIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIFT>(arg0, 6, b"SWIFT", b"Suiwifhat", b"Suiwifhat bringing the solana meme-coin narrative $WIF into SuiNetwork ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6229_196861db71.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

