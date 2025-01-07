module 0x1040bb4c9934a9eadd2df97ba8278829e13b7779465ff0978fee590531ee2091::warrior {
    struct WARRIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARRIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARRIOR>(arg0, 6, b"WARRIOR", b"CryptoWarrior", b"Shhhhhhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_24_21_09_50_53f09a1fdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARRIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARRIOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

