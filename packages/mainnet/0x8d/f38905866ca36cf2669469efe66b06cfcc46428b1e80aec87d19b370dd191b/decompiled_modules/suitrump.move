module 0x8df38905866ca36cf2669469efe66b06cfcc46428b1e80aec87d19b370dd191b::suitrump {
    struct SUITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMP>(arg0, 6, b"SUITRUMP", b"SUI TRUMP", x"5355495452554d500a57696e6e696e6720536f204d7563682c20596f75276c6c204265205469726564206f662057696e6e696e6721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xdeb831e796f16f8257681c0d5d4108fa94333060300b2459133a96631bf470b8_suitrump_suitrump_c93f4fa2de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

