module 0x7347898f58ec4fca92b77b5f9d258a2c6fc7592633e9703875359b53d881eecc::cattt {
    struct CATTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTT>(arg0, 9, b"catttt", b"cattt", b"catttcattt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

