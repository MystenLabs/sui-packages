module 0x1035f56dc32ec315e30818696834e6f513a77c17f7325e38ad2a834f23d2afdb::migo {
    struct MIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGO>(arg0, 6, b"MIGO", b"Amigos coin", x"284c61756e6368696e6720736f6f6e206f6e20547572626f7329205468652023416d69676f73206d656d6520636f696e206f6e2023537569200a237375696d656d6520237375696d656d65636f696e2023616d69676f73636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954224997.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

