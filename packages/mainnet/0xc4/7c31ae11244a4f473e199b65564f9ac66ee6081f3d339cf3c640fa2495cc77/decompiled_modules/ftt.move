module 0xc47c31ae11244a4f473e199b65564f9ac66ee6081f3d339cf3c640fa2495cc77::ftt {
    struct FTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FTT>(arg0, 6, 0x1::string::utf8(b"FTT"), 0x1::string::utf8(b"FartpadTest"), 0x1::string::utf8(b"some description"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/vXbA_sj8gvXngQhV?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FTT>>(0x2::coin_registry::finalize<FTT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

