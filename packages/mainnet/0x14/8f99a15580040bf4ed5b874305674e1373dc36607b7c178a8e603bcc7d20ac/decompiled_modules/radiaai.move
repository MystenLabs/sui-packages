module 0x148f99a15580040bf4ed5b874305674e1373dc36607b7c178a8e603bcc7d20ac::radiaai {
    struct RADIAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RADIAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RADIAAI>(arg0, 6, b"RadiaAI", b"Radiant AI Agent", x"4f6666696369616c2052616469616e74204167656e74202852616469614149290a52616469616e74204149204167656e74202452616469614149205368696e696e67206f6e2074686520626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/36346_b3eea73ebe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RADIAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RADIAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

