module 0x4d4d773e28faa5b33f4a0701f7003b685b59c853b171250d1c90b568752b297e::yyy {
    struct YYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYY>(arg0, 9, b"YYY", b"yyy", b"yyyyyyyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YYY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YYY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

