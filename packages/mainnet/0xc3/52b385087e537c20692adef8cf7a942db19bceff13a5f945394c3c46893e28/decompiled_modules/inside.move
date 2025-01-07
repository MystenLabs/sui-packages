module 0xc352b385087e537c20692adef8cf7a942db19bceff13a5f945394c3c46893e28::inside {
    struct INSIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSIDE>(arg0, 6, b"INSIDE", b"INSIDERS DAO", b"The sharpest alpha group in Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_23_08_55_62a007cda1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

