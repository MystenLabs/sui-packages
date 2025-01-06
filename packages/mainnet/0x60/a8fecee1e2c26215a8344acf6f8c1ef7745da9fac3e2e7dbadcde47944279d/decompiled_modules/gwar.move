module 0x60a8fecee1e2c26215a8344acf6f8c1ef7745da9fac3e2e7dbadcde47944279d::gwar {
    struct GWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWAR>(arg0, 9, b"GWAR", b"Galaxy War", b"The war is about to begin. The purgatorius army who have been made the galaxy suffering by destroying the planets on the galaxy  must be stopped. Collect the limited character of Galaxy Ranger and build up your team to defend the galaxy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a6a0578-4be8-426b-8d0d-28991964216d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

