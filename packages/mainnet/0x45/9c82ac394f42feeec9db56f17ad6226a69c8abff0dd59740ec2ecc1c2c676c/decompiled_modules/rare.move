module 0x459c82ac394f42feeec9db56f17ad6226a69c8abff0dd59740ec2ecc1c2c676c::rare {
    struct RARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RARE>(arg0, 1, b"RARE", b"RARE", b"RAR3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RARE>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RARE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

