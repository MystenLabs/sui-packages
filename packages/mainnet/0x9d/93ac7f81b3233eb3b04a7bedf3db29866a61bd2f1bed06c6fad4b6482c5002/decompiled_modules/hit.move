module 0x9d93ac7f81b3233eb3b04a7bedf3db29866a61bd2f1bed06c6fad4b6482c5002::hit {
    struct HIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HIT>(arg0, 9, 0x1::string::utf8(b"HIT"), 0x1::string::utf8(b"hitl"), 0x1::string::utf8(b"hitl (HIT)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HIT>>(0x2::coin_registry::finalize<HIT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

