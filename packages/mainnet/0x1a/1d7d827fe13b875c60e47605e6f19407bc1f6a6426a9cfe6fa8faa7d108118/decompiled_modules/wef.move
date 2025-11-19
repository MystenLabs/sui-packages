module 0x1a1d7d827fe13b875c60e47605e6f19407bc1f6a6426a9cfe6fa8faa7d108118::wef {
    struct WEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WEF>(arg0, 9, 0x1::string::utf8(b"WEF"), 0x1::string::utf8(b"homie"), 0x1::string::utf8(b"12"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WEF>>(0x2::coin_registry::finalize<WEF>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEF>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<WEF>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<WEF>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

