module 0xbe03dcefa80fabbf9be834564e97bee2e28ea9b71aabfadae44971010a3e4201::PT {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PT>(arg0, 6, 0x1::string::utf8(b"PT-haSUI"), 0x1::string::utf8(b"PT-haSUI"), 0x1::string::utf8(b"PT token for Jitter Haedal haSUI, maturity 2027-01-18."), 0x1::string::utf8(b"https://assets.haedal.xyz/logos/hasui.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PT>>(0x2::coin_registry::finalize<PT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

