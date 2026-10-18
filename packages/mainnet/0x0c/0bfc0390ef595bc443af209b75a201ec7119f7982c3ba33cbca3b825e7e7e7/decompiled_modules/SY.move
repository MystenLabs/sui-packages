module 0xc0bfc0390ef595bc443af209b75a201ec7119f7982c3ba33cbca3b825e7e7e7::SY {
    struct SY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SY>(arg0, 6, 0x1::string::utf8(b"SY-sSUI"), 0x1::string::utf8(b"SY-sSUI"), 0x1::string::utf8(b"SY token for Jitter Scallop sSUI."), 0x1::string::utf8(b"https://admin.jitter.fi/ssui.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SY>>(0x2::coin_registry::finalize<SY>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

