module 0xc32da3618157ddd6eca21fbdaed19981d490b7bd945452a08595b95a911a7159::x890 {
    struct X890 has drop {
        dummy_field: bool,
    }

    fun init(arg0: X890, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X890>(arg0, 6, b"X890", b"x-890 AI", b"890890890", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IS_9ite_HC_400x400_c64967679f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X890>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X890>>(v1);
    }

    // decompiled from Move bytecode v6
}

