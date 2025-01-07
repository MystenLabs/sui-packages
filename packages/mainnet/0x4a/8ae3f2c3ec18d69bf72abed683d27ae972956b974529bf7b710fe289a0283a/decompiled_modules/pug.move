module 0x4a8ae3f2c3ec18d69bf72abed683d27ae972956b974529bf7b710fe289a0283a::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 5, b"PUG", b"PUG2", b"Just a Pug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/xMSZsXf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

