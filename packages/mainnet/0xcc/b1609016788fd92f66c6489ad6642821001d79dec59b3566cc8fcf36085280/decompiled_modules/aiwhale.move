module 0xccb1609016788fd92f66c6489ad6642821001d79dec59b3566cc8fcf36085280::aiwhale {
    struct AIWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIWHALE>(arg0, 6, b"AIWHALE", b"http://whalesaiagent.xyz/", b"The AI AGENT Focusing on Trading Advice and Real Time Suggestions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/86df96fa_a188_4a83_80e6_f4db74987681_8f7e4f1ef1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

