module 0x7072d4357c2d34d78b7872808fc5e877688050b0a281547110775ecc4a5ddeb9::cone {
    struct CONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONE>(arg0, 6, b"CONE", b"Wet Ass Cone", b"CONE on SUI Making waves in the market! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CONESPLASH_cdb2283ed6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

