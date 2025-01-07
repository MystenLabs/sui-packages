module 0xe8a15f446d254d4898e460ad0f6c7b2bebff18ef2039f90fbb4b964d77fff33a::gpt101 {
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

