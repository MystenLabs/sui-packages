module 0xdd98ca742caed619da7fe687defb175953e0d780a1af72bb3c47347f360234a5::noos {
    struct NOOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOS>(arg0, 6, b"NOOS", b"Waternoos", b"Meet Mr. Waternoos, the iconic character from Monsters, Inc., now making waves in the world of Sui memecoins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053207_936655cb0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

