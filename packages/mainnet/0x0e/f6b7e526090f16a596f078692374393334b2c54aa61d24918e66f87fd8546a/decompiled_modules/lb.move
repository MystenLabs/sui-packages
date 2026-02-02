module 0xef6b7e526090f16a596f078692374393334b2c54aa61d24918e66f87fd8546a::lb {
    struct LB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LB>(arg0, 9, b"LBEST", b"LBEST", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxwallet.s3.us-west-1.amazonaws.com/photo_2026-02-02_10-46-09.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LB>>(0x2::coin::mint<LB>(&mut v2, 64000000000000000, arg1), @0x28b2496b0b6d6ebd4e2ec3befca8f679ea84334b2eb27494b9388ed3ecbcd6ee);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LB>>(v2);
    }

    // decompiled from Move bytecode v6
}

