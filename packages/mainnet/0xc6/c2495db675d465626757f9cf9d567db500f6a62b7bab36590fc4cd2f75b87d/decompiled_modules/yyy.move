module 0xc6c2495db675d465626757f9cf9d567db500f6a62b7bab36590fc4cd2f75b87d::yyy {
    struct YYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYY>(arg0, 9, b"YYY", b"yyy", b"yyyyyyyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YYY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

