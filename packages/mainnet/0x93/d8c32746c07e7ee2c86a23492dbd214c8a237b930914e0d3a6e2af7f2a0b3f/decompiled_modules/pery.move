module 0x93d8c32746c07e7ee2c86a23492dbd214c8a237b930914e0d3a6e2af7f2a0b3f::pery {
    struct PERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERY>(arg0, 6, b"PERY", b"Sui Pery", b"the little pery", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bebek_3_613fa4110c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

