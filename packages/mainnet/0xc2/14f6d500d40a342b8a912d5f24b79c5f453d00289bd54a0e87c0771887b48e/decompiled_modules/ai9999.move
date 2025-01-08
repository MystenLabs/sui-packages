module 0xc214f6d500d40a342b8a912d5f24b79c5f453d00289bd54a0e87c0771887b48e::ai9999 {
    struct AI9999 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI9999, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI9999>(arg0, 9, b"AI9999", b"Agent Launhpad", b"Launch and Co-Create Onchain AI Agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ebf7c5b362bfff025db81f63d5895825blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI9999>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI9999>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

