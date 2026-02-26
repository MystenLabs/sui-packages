module 0xbd2167c0f026951a16439632cc5e76c7f900030da0fa481673427f16ebd77ad0::gusd3 {
    struct GUSD3 has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<GUSD3>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<GUSD3>(arg0, arg1, arg2);
    }

    fun init(arg0: GUSD3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GUSD3>(arg0, 9, 0x1::string::utf8(b"GUSD3"), 0x1::string::utf8(b"Generalized USD v3"), 0x1::string::utf8(b"Generalized USD vault token v3"), 0x1::string::utf8(b"https://aftermath.finance/gusd.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GUSD3>>(0x2::coin_registry::finalize<GUSD3>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

