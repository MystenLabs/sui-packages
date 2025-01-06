module 0xb0835122a159f9febfe6616156b31d543658a0a2c1d55f249b920170eea1fd7d::york {
    struct YORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: YORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YORK>(arg0, 6, b"YORK", b"Yeti Fork", b"$YORK will surf the waves of the chart to the top! Grab your $YORK now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5958_c8980a8bb2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

