module 0x358e10b333ce6563f40fdf46f95d020aa6f8e221d4299a2d9b2592968a7da467::wrapper_coin {
    struct WRAPPER_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRAPPER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WRAPPER_COIN>(arg0, 2, 0x1::string::utf8(b"WRAP"), 0x1::string::utf8(b"WrapperCoin"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRAPPER_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WRAPPER_COIN>>(0x2::coin_registry::finalize<WRAPPER_COIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

