module 0x6e103376c15503eb2d650c1b7e9ef6976cdf28ce2e9b23ddfc37bbea1b0a91ca::bta {
    struct BTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BTA>(arg0, 6, 0x1::string::utf8(b"BTA"), 0x1::string::utf8(b"BTA bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BTA>>(0x2::coin_registry::finalize<BTA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

