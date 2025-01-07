module 0x51b033d0fd9d519dd10f0069cff6c0c4356033ab8dab5b230ba0cb43cf86fef5::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 9, b"WOOF", b"Woof Bucks", b"Woof Bucks is a dog-inspired meme coin focused on community and fun. Each transaction supports dog-themed giveaways, animal shelter donations, and rewards for members. Trade, hold, and enjoy with WOOF!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cf74382-0f8e-467d-89e4-e1f3654e05d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

