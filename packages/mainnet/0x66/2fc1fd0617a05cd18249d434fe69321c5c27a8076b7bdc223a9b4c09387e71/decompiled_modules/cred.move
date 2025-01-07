module 0x662fc1fd0617a05cd18249d434fe69321c5c27a8076b7bdc223a9b4c09387e71::cred {
    struct CRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRED>(arg0, 6, b"CRED", b"CREDSYNC  by SuiAI", b"With the rapid growth of decentralized finance (DeFi), the need for secure and transparent systems has become paramount. Traditional reputation systems cannot cater to decentralized ecosystems, leaving a gap for solutions that offer trust without intermediaries. CREDSYNC, The AI Reputation Scoring Agent fills this gap by introducing data-driven, AI-powered risk assessment tailored for DeFi applications. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1001196345_1632d9c5b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRED>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRED>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

