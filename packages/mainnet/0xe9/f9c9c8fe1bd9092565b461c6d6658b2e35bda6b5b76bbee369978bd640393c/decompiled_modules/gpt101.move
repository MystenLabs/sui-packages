module 0xe9f9c9c8fe1bd9092565b461c6d6658b2e35bda6b5b76bbee369978bd640393c::gpt101 {
    struct GPT101 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPT101, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPT101>(arg0, 6, b"GPT101", b"sui GPT", b"First decentralized Chatgpt on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_e4190f1e74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPT101>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPT101>>(v1);
    }

    // decompiled from Move bytecode v6
}

