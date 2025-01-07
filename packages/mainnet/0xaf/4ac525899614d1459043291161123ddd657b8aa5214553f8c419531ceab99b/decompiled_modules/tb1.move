module 0xaf4ac525899614d1459043291161123ddd657b8aa5214553f8c419531ceab99b::tb1 {
    struct TB1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TB1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TB1>(arg0, 6, b"TB1", b"Thunderbird1", b"Thunderbird one of four | Get 'm all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TB_1_618e8026c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TB1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TB1>>(v1);
    }

    // decompiled from Move bytecode v6
}

