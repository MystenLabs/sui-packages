module 0x3d0c6faafc0b10ed1ad5ae772eae0252fb173e53276196a7d78a1b45bfc9af49::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 6, b"SPX", b"SuiPX6900", b"$SPX: FLIPPING THE STOCK MARKET | Now on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_meme_1_b24f4101b4_5b66b6c4b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

