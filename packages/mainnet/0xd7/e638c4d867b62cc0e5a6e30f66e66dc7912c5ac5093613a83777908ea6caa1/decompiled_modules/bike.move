module 0xd7e638c4d867b62cc0e5a6e30f66e66dc7912c5ac5093613a83777908ea6caa1::bike {
    struct BIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIKE>(arg0, 9, b"BIKE", b"BIKE", b"Bike Motisport", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIKE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

