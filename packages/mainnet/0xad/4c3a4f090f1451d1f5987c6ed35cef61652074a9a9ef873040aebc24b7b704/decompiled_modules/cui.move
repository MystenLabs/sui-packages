module 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::cui {
    struct CUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CUI>(arg0, 9, 0x1::string::utf8(b"CUI"), 0x1::string::utf8(b"CUI"), 0x1::string::utf8(b"CUI"), 0x1::string::utf8(b"no link"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CUI>>(0x2::coin_registry::finalize<CUI>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CUI>>(v1);
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<CUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<CUI>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

