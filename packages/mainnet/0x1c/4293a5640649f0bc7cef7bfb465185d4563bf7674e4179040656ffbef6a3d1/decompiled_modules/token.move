module 0x1c4293a5640649f0bc7cef7bfb465185d4563bf7674e4179040656ffbef6a3d1::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TOKEN>(arg0, 9, 0x1::string::utf8(b"token"), 0x1::string::utf8(b"token"), 0x1::string::utf8(b"token token"), 0x1::string::utf8(b"https://example.com/token.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TOKEN>>(0x2::coin_registry::finalize<TOKEN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

