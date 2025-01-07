module 0xd696b92275528c2636c166d79ebd4f2cb964f6b5b2b460fa1232292ab24ddb4a::strykr {
    struct STRYKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRYKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRYKR>(arg0, 6, b"STRYKR", b"Strykr Agent", b"We aggregate economic news into one calendar, giving you a volatility score and AI-powered predictive analysis to trade w/ confidence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9198_54d89cc36e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRYKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRYKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

