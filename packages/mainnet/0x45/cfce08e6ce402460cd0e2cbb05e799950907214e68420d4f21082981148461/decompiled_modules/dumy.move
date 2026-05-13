module 0x45cfce08e6ce402460cd0e2cbb05e799950907214e68420d4f21082981148461::dumy {
    struct DUMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = init_treasury(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DUMY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DUMY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun init_treasury(arg0: DUMY, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<DUMY>, 0x2::coin::DenyCapV2<DUMY>, 0x2::coin_registry::MetadataCap<DUMY>) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DUMY>(arg0, 9, 0x1::string::utf8(b"DUMY"), 0x1::string::utf8(b"Dummy Coin"), 0x1::string::utf8(b"A dummy coin deployed from the token template"), 0x1::string::utf8(b"icon_url"), arg1);
        let v2 = v0;
        (v1, 0x2::coin_registry::make_regulated<DUMY>(&mut v2, true, arg1), 0x2::coin_registry::finalize<DUMY>(v2, arg1))
    }

    // decompiled from Move bytecode v6
}

