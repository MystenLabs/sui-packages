module 0xf0812727e1019bc49e3729d9b6a6ad35510ecc609cfb6900878bec89ba26268a::ADTEST {
    struct ADTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADTEST>(arg0, 8, b"ADTEST", b"ADTEST", b"Just testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeief6mcru55intv6lf2ohnlfzxclpqlxr4yxkctevi6zpsdclh32eq.ipfs.w3s.link/agora-logo_-_Brian_Oh.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

