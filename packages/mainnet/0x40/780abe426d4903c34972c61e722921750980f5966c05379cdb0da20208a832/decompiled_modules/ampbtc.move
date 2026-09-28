module 0x40780abe426d4903c34972c61e722921750980f5966c05379cdb0da20208a832::ampbtc {
    struct AMPBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPBTC>(arg0, 6, 0x1::string::utf8(b"AMPBTC"), 0x1::string::utf8(b"Amped staging test BTC"), 0x1::string::utf8(b"Staging test coin for popular_amped. Not a product."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPBTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPBTC>>(0x2::coin_registry::finalize<AMPBTC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

