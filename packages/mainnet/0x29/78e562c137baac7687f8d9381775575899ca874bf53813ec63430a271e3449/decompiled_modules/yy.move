module 0x2978e562c137baac7687f8d9381775575899ca874bf53813ec63430a271e3449::yy {
    struct YY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YY>(arg0, 4, b"YY", b"YY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yswap.info/icon/yy.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<YY>>(0x2::coin::mint<YY>(&mut v2, 2100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YY>>(v2);
    }

    // decompiled from Move bytecode v6
}

