module 0x89d1c0e3973b2a2fa72e287cf79757c8f28e35e6ca52bf1a0d9eedc3b60865a3::llo {
    struct LLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLO>(arg0, 6, b"LLO", b"LlamaLoco", b"LlamaLoco is here to spice up your portfolio with some South American flair and eccentric memes. LlamaLoco is for the bold, quirky traders who dont play by the rules.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/llama_7ced933ea4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

