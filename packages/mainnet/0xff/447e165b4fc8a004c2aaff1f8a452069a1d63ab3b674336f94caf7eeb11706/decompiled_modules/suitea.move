module 0xff447e165b4fc8a004c2aaff1f8a452069a1d63ab3b674336f94caf7eeb11706::suitea {
    struct SUITEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEA>(arg0, 6, b"SUITEA", b"SUI-TEA", x"54686520666972737420616e64206f6e6c79205355492d54454120636f696e206f6e2074686520535549206e6574776f726b200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7334_9478d15e60.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

