module 0x4d993fbf71f605174c7281cabe09b41c5ba09d20d0a6eee5032a80f39dd38686::hfjki7 {
    struct HFJKI7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFJKI7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFJKI7>(arg0, 6, b"Hfjki7", b"6666", b"777", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifcu324ias76nirow7zyakgsa5biq7axfuue2f36mfzf7p6tz3eeu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFJKI7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HFJKI7>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

