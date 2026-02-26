module 0x95050b76bbb4c29a38e9c30dd40d8bed834852dd42f0b9af1ec868d95e81887a::subgusd2 {
    struct SUBGUSD2 has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<SUBGUSD2>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<SUBGUSD2>(arg0, arg1, arg2);
    }

    fun init(arg0: SUBGUSD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUBGUSD2>(arg0, 9, 0x1::string::utf8(b"SUBGUSD2"), 0x1::string::utf8(b"Sub Generalized USD v2"), 0x1::string::utf8(b"Sub GUSD vault token for recursive vault v2"), 0x1::string::utf8(b"https://aftermath.finance/gusd.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBGUSD2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUBGUSD2>>(0x2::coin_registry::finalize<SUBGUSD2>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

