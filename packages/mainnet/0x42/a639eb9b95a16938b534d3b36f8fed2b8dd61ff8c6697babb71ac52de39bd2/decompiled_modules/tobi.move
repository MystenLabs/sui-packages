module 0x42a639eb9b95a16938b534d3b36f8fed2b8dd61ff8c6697babb71ac52de39bd2::tobi {
    struct TOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBI>(arg0, 6, b"TOBI", b"TOBI SUI", x"4d656d652041727469737473206f776e20546f626920436f6d6d756e6974792e204d656d6520636f6e7465737420616e642066616e2061727420636f6e74657374206f70656e206576657279207765656b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/da7_Eb53_N_400x400_ff02c191b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

