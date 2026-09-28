module 0xbcdbe2e63fccb59784e3307ce0e38ebe0fc16d7efa086418eeb7999526c29472::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BOSS>(arg0, 6, 0x1::string::utf8(b"BOSS"), 0x1::string::utf8(b"BOSS"), 0x1::string::utf8(b"BOSS memecoin is just for fun"), 0x1::string::utf8(b"https://popularsui.xyz/media/50bb82f97f1fdb1c3a0e72e1250b5d0beb3a806ed21fd295ae13d413e7f8f696.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BOSS>>(0x2::coin_registry::finalize<BOSS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

