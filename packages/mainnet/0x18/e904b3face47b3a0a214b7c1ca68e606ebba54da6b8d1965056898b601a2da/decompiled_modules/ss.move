module 0x18e904b3face47b3a0a214b7c1ca68e606ebba54da6b8d1965056898b601a2da::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SS>(arg0, 9, 0x1::string::utf8(b"SS"), 0x1::string::utf8(b"Sample Share"), 0x1::string::utf8(b"sssssssss"), 0x1::string::utf8(b"1111111.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SS>>(0x2::coin_registry::finalize<SS>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<SS>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<SS>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

