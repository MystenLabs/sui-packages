module 0x5748138aa3ac838df6d2a2fe2d27ae373af0659c4a070ef7341eede03639832e::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 4, b"L", b"L", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://galactic100.s3.us-west-1.amazonaws.com/LX.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<L>>(0x2::coin::mint<L>(&mut v2, 69120000000, arg1), @0x26f7b5723c018118800f1957271da8f98565110392a02952ff2b130c61bf20cd);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<L>>(v2);
    }

    // decompiled from Move bytecode v6
}

