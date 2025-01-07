module 0x7dae9ff2fedb6d84c184a3604d12f1dd51b474d7343c14a54a2c5b663149530b::doge1 {
    struct DOGE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE1>(arg0, 6, b"Doge1", b"DOGE", b"doge meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_c_a2edd406f6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE1>>(v1);
    }

    // decompiled from Move bytecode v6
}

