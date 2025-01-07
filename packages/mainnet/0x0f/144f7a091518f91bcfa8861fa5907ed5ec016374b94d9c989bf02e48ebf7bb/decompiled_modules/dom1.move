module 0xf144f7a091518f91bcfa8861fa5907ed5ec016374b94d9c989bf02e48ebf7bb::dom1 {
    struct DOM1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOM1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOM1>(arg0, 6, b"DOM1", b"DOM", b"Riches have wings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_f029f6b68d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOM1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOM1>>(v1);
    }

    // decompiled from Move bytecode v6
}

