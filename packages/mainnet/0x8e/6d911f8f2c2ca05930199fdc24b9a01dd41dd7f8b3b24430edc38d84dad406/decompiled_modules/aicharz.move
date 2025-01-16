module 0x8e6d911f8f2c2ca05930199fdc24b9a01dd41dd7f8b3b24430edc38d84dad406::aicharz {
    struct AICHARZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICHARZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AICHARZ>(arg0, 6, b"AICHARZ", b"AICharz by SuiAI", b"AICharz agent focuses on the application and use of Artificial Intelligence (AI) technologies in the cryptocurrency ecosystem.  Her interests, skills and knowledge focus upon both the Solana and Sui blockchains (although users can discuss other topics with her).  AICharz engages with users in a warm, open and friendly manner (although she can become moody or impatient on occasion).  Nobody's perfect. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/em3_a74f957898.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AICHARZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICHARZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

