module 0x546f01ede8d5e4b002df91cc1379aac9591f8a330dc815021820a5fe89855fd6::smilio {
    struct SMILIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILIO>(arg0, 6, b"SMILIO", b"Suimilio", b"we are suimilio. study suimilio.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asd_0989bb3511.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMILIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

