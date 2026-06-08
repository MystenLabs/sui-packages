module 0x2c73a62ef3b92b13b32fd38f1766a259b7353acebd582ac124c7fa0a620569bc::xyz {
    struct XYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XYZ>(arg0, 9, b"XYZ", b"XYZ Squirrel", b"Cute squirrel on chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/BlhwG3J.md.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XYZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYZ>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<XYZ>>(0x2::coin::mint<XYZ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

