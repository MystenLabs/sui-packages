module 0x5e09f06f659d8fdb9f5b4120ac4ed1f6c48423fa2c93aa33806b1a0a09600177::walpe {
    struct WALPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALPE>(arg0, 6, b"WALPE", b"Wal Vape", x"4d657420746865207465616d206174204e5943204f766572666c6f772e20457373656e7469616c6c7920616c6c207075666673207265636f72646564206f6e2d636861696e2c2074686572657320616e20696e63656e746976697a6174696f6e2070726f6772616d2c20616e6420616c6c207075666620686162697420646174612069732073746f726564206f6e2057616c7275730a0a5468657920616c736f20676f7420637574652057616c72757320766170657321200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076388_02295c1085.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

