module 0x50260e8e7a495d6770a2012a25eda1f7bbd299085212271ea139b88b96e237c1::lt {
    struct LT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LT>(arg0, 6, b"LT", b"L Token", b"LT is da best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/c3b502e0-d947-11ef-a74b-b3b817eed47e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LT>>(v1);
        0x2::coin::mint_and_transfer<LT>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

