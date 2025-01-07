module 0x38d07b87ff41540a51669079c74140cd063ab5e510d78d3e58b3e771b29bc5f4::chip {
    struct CHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIP>(arg0, 6, b"CHIP", b"BLUE CHIP", b"its a chip, but blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUE_CHIP_67044885d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

