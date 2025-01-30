module 0xa4794fc3cf0db1fc6b156e29710adc9fcdf7283daac26cfa3f5ffc6e42159098::TYP {
    struct TYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYP>(arg0, 9, b"TYP", b"TYP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TYP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TYP>>(0x2::coin::mint<TYP>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

