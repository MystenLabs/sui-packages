module 0xe7b6d9aa742f374394893177ab674d4107b10adcb1fdd4977fd8125921c4043c::cybdil {
    struct CYBDIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBDIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CYBDIL>(arg0, 6, b"CYBDIL", b"CyberDildonics by SuiAI", b"The intersection of technology, cyberculture, and sexual wellness.  At the intersection of hardware and self love, with a focus on personal enhancement technologies and sexual health.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cyberdildonics_b06eee3a91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CYBDIL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBDIL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

