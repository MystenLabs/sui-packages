module 0x8429ed003a15d363e9d540352fefa72a45199f71155c6e86b43899807535f258::sroomai {
    struct SROOMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROOMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROOMAI>(arg0, 6, b"SroomAI", b"SROOM AI", b"SroomAI DAO - the first AI hedge fund for AI projects investment on SUI. In a virtual psychedelic mushroom lab, AI-driven waifu scientists pioneer innovation of technology and magic fungi. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736526154615.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SROOMAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROOMAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

