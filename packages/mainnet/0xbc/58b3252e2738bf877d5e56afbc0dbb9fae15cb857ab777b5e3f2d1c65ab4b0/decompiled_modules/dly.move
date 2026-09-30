module 0xbc58b3252e2738bf877d5e56afbc0dbb9fae15cb857ab777b5e3f2d1c65ab4b0::dly {
    struct DLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLY>(arg0, 9, b"DLY", b"Delay        ", b"audit: backend launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://placehold.co/300x300.png?v=2")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DLY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DLY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DLY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

