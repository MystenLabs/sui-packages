module 0xce9cc0b4b7be3680c0cd1fd577f0e0e41a26b770dff2c95ba4c0f22eac69d8c2::genki {
    struct GENKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENKI>(arg0, 6, b"Genki", b"GENKI", b"Genki is the newest member to the dog family", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0543_6165863665.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

