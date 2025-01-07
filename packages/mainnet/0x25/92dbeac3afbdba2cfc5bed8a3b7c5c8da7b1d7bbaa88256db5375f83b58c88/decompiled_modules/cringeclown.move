module 0x2592dbeac3afbdba2cfc5bed8a3b7c5c8da7b1d7bbaa88256db5375f83b58c88::cringeclown {
    struct CRINGECLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRINGECLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRINGECLOWN>(arg0, 6, b"CRINGECLOWN", b"CRINGE", b"$Cringe is Good Cult!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3709_2d81e13b01.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRINGECLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRINGECLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

