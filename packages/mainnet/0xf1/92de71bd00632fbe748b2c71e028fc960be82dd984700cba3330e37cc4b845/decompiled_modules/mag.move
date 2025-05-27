module 0xf192de71bd00632fbe748b2c71e028fc960be82dd984700cba3330e37cc4b845::mag {
    struct MAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAG>(arg0, 9, b"MAG", b"MAGIQ", b"MAGIQ FORCE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/797e2cef7382ef39fc8bf309c7870f35blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

