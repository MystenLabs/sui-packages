module 0x9e4d245ad1eeb60d0871cab6ef7cb5793253a9907481df0f9a31c09308ae2be3::lx {
    struct LX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LX>(arg0, 4, b"LTEST", b"LTEST", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://galactic100.s3.us-west-1.amazonaws.com/LX.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LX>>(0x2::coin::mint<LX>(&mut v2, 69120000000, arg1), @0x28b2496b0b6d6ebd4e2ec3befca8f679ea84334b2eb27494b9388ed3ecbcd6ee);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LX>>(v2);
    }

    // decompiled from Move bytecode v6
}

