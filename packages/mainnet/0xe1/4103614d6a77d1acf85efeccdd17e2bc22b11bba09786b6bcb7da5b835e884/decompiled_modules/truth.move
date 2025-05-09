module 0xe14103614d6a77d1acf85efeccdd17e2bc22b11bba09786b6bcb7da5b835e884::truth {
    struct TRUTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUTH>(arg0, 6, b"TRUTH", b"TERMINAL OF SUI", b"But language is an astonishingly powerful interface for being light as information, portable, noninvasive, and robust to deprecation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif5th2xdiwukp4jbvja7kkp3hci7t5qtpxpjrziih3yoazq2aqcga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUTH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

