module 0xf8a578b23d33c6fe0e00ebb3ebe61684e0d098d07d1111f22eb6de5501b61004::fartdc {
    struct FARTDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FARTDC>(arg0, 6, 0x1::string::utf8(b"fartdc"), 0x1::string::utf8(b"farttesetusdc"), 0x1::string::utf8(b"test against usdc"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/nK2r5I465SpMy9PX?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FARTDC>>(0x2::coin_registry::finalize<FARTDC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

