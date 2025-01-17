module 0x18643f65a18ace6c465a20ca21c11b24de5cf868ca8502334afaaa5c507f57b3::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCAM>(arg0, 6, b"SCAM", b"SCAM Dolphin Agent by SuiAI", b"If you were scammed by the Dolphin Agent like me and thousands of others, join this cause to report these thieves and keep the community clean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SCAM_c704fbb26e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCAM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

