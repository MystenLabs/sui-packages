module 0xa20054e4de2663edf14bea32da569ad3f6f4dca5f5b9509ba7319b6e5c00b265::ruggy {
    struct RUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGGY>(arg0, 6, b"RUGGY", b"Ruggy", b"Bringing yo the latest scoops from the rugged side of icp! Stay tuned for the most exslusive updated with ruggy news", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053373_5a53e81143.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

