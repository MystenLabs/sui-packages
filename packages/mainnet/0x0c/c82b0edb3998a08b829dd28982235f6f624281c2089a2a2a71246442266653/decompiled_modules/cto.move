module 0xcc82b0edb3998a08b829dd28982235f6f624281c2089a2a2a71246442266653::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"Crypto Top Operator by SuiAI", b"BURN SUIAI IN THE FORUM CHAT!.100 messages for TG Channel.300 messages for Twitter.500 messages for Homepage..The journey begins with a commitment to change the crypto narrative from one of caution to confidence. Join us as we reclaim the crypto space for genuine innovation and secure investment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Unbenanntasdf_2fa627f38e.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CTO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

