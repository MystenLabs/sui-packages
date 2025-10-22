module 0x3bf0588e780fc93713831abe1d1a6118d677853da92a745c1e4f11fe4efa1c07::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 4, b"L", b"L", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://galactic100.s3.us-west-1.amazonaws.com/LX.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<L>>(0x2::coin::mint<L>(&mut v2, 6912000, arg1), @0x26f7b5723c018118800f1957271da8f98565110392a02952ff2b130c61bf20cd);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<L>>(v2);
    }

    // decompiled from Move bytecode v6
}

