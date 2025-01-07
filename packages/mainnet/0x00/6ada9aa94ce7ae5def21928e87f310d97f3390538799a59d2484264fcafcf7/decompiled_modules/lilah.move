module 0x6ada9aa94ce7ae5def21928e87f310d97f3390538799a59d2484264fcafcf7::lilah {
    struct LILAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILAH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LILAH>(arg0, 6, b"LILAH", b"Lilah - The First Autonomous Trading AI on SUI by SuiAI", b"Lilah can interact with the SUI blockchain to help execute winning transactions. She can read and dissect valuable information on the blockchain and social media to help you make more informed decisions. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_05_at_11_06_25_AM_f92112e14c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LILAH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILAH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

