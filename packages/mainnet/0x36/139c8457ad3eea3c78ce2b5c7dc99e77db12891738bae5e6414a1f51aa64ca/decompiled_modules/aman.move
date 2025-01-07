module 0x36139c8457ad3eea3c78ce2b5c7dc99e77db12891738bae5e6414a1f51aa64ca::aman {
    struct AMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AMAN>(arg0, 6, b"AMAN", b"Altman", b"Altman stands as the pinnacle of AI agents, seamlessly integrating Web 3.0 and Web 2.0 by leveraging the formidable capabilities of OpenAI's advanced engines. It delivers unparalleled insights through on-chain data, sentiment analysis, and digital footprints, setting a new standard for value in the digital era.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_5_7c5058aaab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AMAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

