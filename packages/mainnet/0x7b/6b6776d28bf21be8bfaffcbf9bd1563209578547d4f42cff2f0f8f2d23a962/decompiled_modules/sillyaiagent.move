module 0x7b6b6776d28bf21be8bfaffcbf9bd1563209578547d4f42cff2f0f8f2d23a962::sillyaiagent {
    struct SILLYAIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLYAIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLYAIAGENT>(arg0, 6, b"SillyAIAgent", b"Silly Dragon AI Agent", b"Silly AI Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Oip9k_Q5_400x400_51bc1ff962.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLYAIAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILLYAIAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

