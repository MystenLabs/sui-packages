module 0x5fd2f48a0d9763006c3a13c3a7609cbbed083e6ab733f318cee8cd3c9a7e238b::qwen {
    struct QWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWEN>(arg0, 6, b"Qwen", b"Qwen 2.5", x"416c6962616261204149206167656e74202d20446565707365656b206b696c6c65720a0a4c6574206368696e6573652041492074616b65206f766572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PDLNXPBF_400x400_f0d63eac13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QWEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

