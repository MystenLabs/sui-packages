module 0x53768fba1dfc33ce37881091aae1ff14ae9e3d3ab1e4f6514bb8ba3cab284a72::rof {
    struct ROF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ROF>(arg0, 9, 0x1::string::utf8(b"ROF"), 0x1::string::utf8(b"roffl"), 0x1::string::utf8(b"roffl (ROF)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ROF>>(0x2::coin_registry::finalize<ROF>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

