module 0xd4d6e279185b021e8a69163c73f143069ccddcbf7e9f2455ff6a9712bc985bda::gptdog {
    struct GPTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPTDOG>(arg0, 6, b"GPTDOG", b"ChatGPT's disgusting dog", b"This is GPT's dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dog_7b9264f95e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPTDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPTDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

