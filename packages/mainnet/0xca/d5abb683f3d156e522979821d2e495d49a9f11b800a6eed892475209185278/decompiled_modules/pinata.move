module 0xcad5abb683f3d156e522979821d2e495d49a9f11b800a6eed892475209185278::pinata {
    struct PINATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINATA>(arg0, 6, b"PINATA", b"Pinata Bot", x"4173736574206d616e6167656d656e7420696e7369646520796f7572206d657373656e6765727320426f740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/26_Tm_Hqv_J_400x400_62b11dd4ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

