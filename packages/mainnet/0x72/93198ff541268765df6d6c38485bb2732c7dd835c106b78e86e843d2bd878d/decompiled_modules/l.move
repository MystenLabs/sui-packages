module 0x7293198ff541268765df6d6c38485bb2732c7dd835c106b78e86e843d2bd878d::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 4, b"LTEST", b"LTEST", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://galactic100.s3.us-west-1.amazonaws.com/LX.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<L>>(0x2::coin::mint<L>(&mut v2, 69120000000, arg1), @0x28b2496b0b6d6ebd4e2ec3befca8f679ea84334b2eb27494b9388ed3ecbcd6ee);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<L>>(v2);
    }

    // decompiled from Move bytecode v6
}

