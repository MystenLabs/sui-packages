module 0x812625138b42b627d49233a91c37cdd1e27a215a05ebf6be20d079acceeba6b6::SY {
    struct SY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SY>(arg0, 6, 0x1::string::utf8(b"SY-haSUI"), 0x1::string::utf8(b"SY-haSUI"), 0x1::string::utf8(b"SY token for Jitter Haedal haSUI."), 0x1::string::utf8(b"https://assets.haedal.xyz/logos/hasui.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SY>>(0x2::coin_registry::finalize<SY>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

