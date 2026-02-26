module 0xc33e6d080d5721c89ee5625e3974b352f0f4db25c5f46bb3e978cc64a6ab08d::gusd4 {
    struct GUSD4 has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<GUSD4>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<GUSD4>(arg0, arg1, arg2);
    }

    fun init(arg0: GUSD4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GUSD4>(arg0, 9, 0x1::string::utf8(b"GUSD4"), 0x1::string::utf8(b"Generalized USD v4"), 0x1::string::utf8(b"Generalized USD vault token v4"), 0x1::string::utf8(b"https://aftermath.finance/gusd.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD4>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GUSD4>>(0x2::coin_registry::finalize<GUSD4>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

