module 0xe001398c48a85500267827d9782d736f20f02817161c4b1a08576c15b108d2ab::yy {
    struct YY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YY>(arg0, 9, b"SUI", b"SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yswap.info/icon/yy.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<YY>>(0x2::coin::mint<YY>(&mut v2, 2100000000000000, arg1), @0x28b2496b0b6d6ebd4e2ec3befca8f679ea84334b2eb27494b9388ed3ecbcd6ee);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YY>>(v2);
    }

    // decompiled from Move bytecode v6
}

