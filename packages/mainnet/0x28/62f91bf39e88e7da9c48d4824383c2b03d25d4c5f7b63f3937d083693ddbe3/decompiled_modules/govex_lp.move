module 0x2862f91bf39e88e7da9c48d4824383c2b03d25d4c5f7b63f3937d083693ddbe3::govex_lp {
    struct GOVEX_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOVEX_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GOVEX_LP>(arg0, 9, 0x1::string::utf8(b"GOVEX_LP_TOKEN"), 0x1::string::utf8(b"GOVEX_LP_TOKEN"), 0x1::string::utf8(b"LP token for the Govex DAO AMM pool."), 0x1::string::utf8(b"https://raw.githubusercontent.com/govex-dao/coin/main/govex-icon.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOVEX_LP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GOVEX_LP>>(0x2::coin_registry::finalize<GOVEX_LP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

