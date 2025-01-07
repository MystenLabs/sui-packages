module 0x6a2ae540457e39e7cdf2901ea4f83b394bd9ee9bb893201a801f03d1bcc5509c::TESTCOIN {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 8, b"TESTCOIN", b"TESTCOIN", b"sadfasdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeief6mcru55intv6lf2ohnlfzxclpqlxr4yxkctevi6zpsdclh32eq.ipfs.w3s.link/agora-logo_-_Brian_Oh.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

