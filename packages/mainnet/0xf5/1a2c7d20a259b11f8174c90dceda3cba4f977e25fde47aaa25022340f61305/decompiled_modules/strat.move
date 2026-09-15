module 0xf51a2c7d20a259b11f8174c90dceda3cba4f977e25fde47aaa25022340f61305::strat {
    struct STRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STRAT>(arg0, 6, 0x1::string::utf8(b"STRAT"), 0x1::string::utf8(b"Strat_test"), 0x1::string::utf8(b"START"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/nK2r5I465SpMy9PX?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<STRAT>>(0x2::coin_registry::finalize<STRAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

