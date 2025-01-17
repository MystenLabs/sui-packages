module 0xe56d405077311d000bd476d62dbde65146101c6f0331adfdb17e62f585d1b442::riftai {
    struct RIFTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIFTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RIFTAI>(arg0, 6, b"RIFTAI", b"Rift AI by SuiAI", b"Rift AI is an innovative AI agent designed to break through conventional boundaries in problem-solving and innovation. It specializes in exploring new dimensions of thought, data, and technology, making it an ideal companion for pioneering ventures or complex analytical tasks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_3_3da6b8b19a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIFTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIFTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

