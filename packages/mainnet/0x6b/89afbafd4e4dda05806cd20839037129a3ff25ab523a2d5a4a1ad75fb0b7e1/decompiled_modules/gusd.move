module 0x6b89afbafd4e4dda05806cd20839037129a3ff25ab523a2d5a4a1ad75fb0b7e1::gusd {
    struct GUSD has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<GUSD>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<GUSD>(arg0, arg1, arg2);
    }

    fun init(arg0: GUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GUSD>(arg0, 9, 0x1::string::utf8(b"GUSD"), 0x1::string::utf8(b"Generalized USD"), 0x1::string::utf8(b"Generalized USD vault token"), 0x1::string::utf8(b"https://aftermath.finance/gusd.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GUSD>>(0x2::coin_registry::finalize<GUSD>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

