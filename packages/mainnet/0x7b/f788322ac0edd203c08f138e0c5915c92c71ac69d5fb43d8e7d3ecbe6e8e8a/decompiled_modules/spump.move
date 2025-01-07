module 0x7bf788322ac0edd203c08f138e0c5915c92c71ac69d5fb43d8e7d3ecbe6e8e8a::spump {
    struct SPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUMP>(arg0, 6, b"Spump", b"Sui Pump", b"Nothing to say", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722673328310_468_88d9301cf9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

