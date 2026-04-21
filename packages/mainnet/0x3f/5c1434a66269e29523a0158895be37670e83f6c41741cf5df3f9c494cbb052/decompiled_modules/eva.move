module 0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva {
    struct EVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<EVA>(arg0, 9, 0x1::string::utf8(b"EVA"), 0x1::string::utf8(b"EVA Protocol Coin"), 0x1::string::utf8(b"EVA Protocol Coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<EVA>>(0x2::coin_registry::finalize<EVA>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<EVA>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<EVA>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

