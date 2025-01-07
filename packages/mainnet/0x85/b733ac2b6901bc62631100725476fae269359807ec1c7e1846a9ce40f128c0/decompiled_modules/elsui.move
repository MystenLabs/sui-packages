module 0x85b733ac2b6901bc62631100725476fae269359807ec1c7e1846a9ce40f128c0::elsui {
    struct ELSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELSUI>(arg0, 6, b"Elsui", b"Elsui Dogo", b"Elsui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_9_5f0fce3989.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

