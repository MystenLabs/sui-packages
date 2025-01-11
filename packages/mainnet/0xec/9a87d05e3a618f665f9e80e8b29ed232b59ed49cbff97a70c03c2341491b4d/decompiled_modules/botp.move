module 0xec9a87d05e3a618f665f9e80e8b29ed232b59ed49cbff97a70c03c2341491b4d::botp {
    struct BOTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOTP>(arg0, 6, b"BOTP", b"botp by SuiAI", b"AIAgent BotP is first bot of BochuNFT Creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/BOTP_1_5d65fb45a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOTP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

