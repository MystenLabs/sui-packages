module 0xf9cb66cb0b4d577f35f4861756c100e8889c9a80620ee81d642597dfbb744590::yy {
    struct YY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YY>(arg0, 6, b"YY", b"YY", b"aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yswap.info/icon/yy.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<YY>>(0x2::coin::mint<YY>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YY>>(v2);
    }

    // decompiled from Move bytecode v6
}

