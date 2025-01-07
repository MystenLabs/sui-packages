module 0xbbcf00ea985faea39092822bcc46dfb1af4e4a43586541d80a8e70b4d2e3f650::AGO {
    struct AGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGO>(arg0, 8, b"AGO", b"AGORA", b"AGORA is a token that aims to facilitate community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeief6mcru55intv6lf2ohnlfzxclpqlxr4yxkctevi6zpsdclh32eq.ipfs.w3s.link/agora-logo_-_Brian_Oh.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

