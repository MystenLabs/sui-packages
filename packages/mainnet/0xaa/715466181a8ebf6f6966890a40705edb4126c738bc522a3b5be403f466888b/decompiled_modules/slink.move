module 0xaa715466181a8ebf6f6966890a40705edb4126c738bc522a3b5be403f466888b::slink {
    struct SLINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLINK>(arg0, 6, b"SLINK", b"SuiLink", b"Telegram Cross-Chain Bridge direct token swaps across 25 different networks. Swap native tokens or stablecoins for a 0.5% fee.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_15_24_56_a18d71c776.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

