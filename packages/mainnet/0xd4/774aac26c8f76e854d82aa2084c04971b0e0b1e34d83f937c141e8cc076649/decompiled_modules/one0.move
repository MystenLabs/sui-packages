module 0xd4774aac26c8f76e854d82aa2084c04971b0e0b1e34d83f937c141e8cc076649::one0 {
    struct ONE0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE0>(arg0, 6, b"ONE0", b"ONEON", b".  .     `    .    ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bf59ca2cb5a3c53b556bbcd0e5227bb2_9815d7ab46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONE0>>(v1);
    }

    // decompiled from Move bytecode v6
}

