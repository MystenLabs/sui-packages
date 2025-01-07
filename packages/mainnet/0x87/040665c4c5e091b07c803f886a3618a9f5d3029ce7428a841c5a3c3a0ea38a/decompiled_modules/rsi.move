module 0x87040665c4c5e091b07c803f886a3618a9f5d3029ce7428a841c5a3c3a0ea38a::rsi {
    struct RSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSI>(arg0, 6, b"RSI", b"Retardio SUI", b"Retardio suiIndex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_3_1a42dcad7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

