module 0xc4c6ed03ad0f75f13b11ed78c54af33a4a974798237450ea190ff21a2c6aa256::tbr {
    struct TBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TBR>(arg0, 6, 0x1::string::utf8(b"TBR"), 0x1::string::utf8(b"TBR bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TBR>>(0x2::coin_registry::finalize<TBR>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

