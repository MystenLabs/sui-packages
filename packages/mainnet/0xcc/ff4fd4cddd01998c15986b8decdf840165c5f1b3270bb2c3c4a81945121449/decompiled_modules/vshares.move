module 0xccff4fd4cddd01998c15986b8decdf840165c5f1b3270bb2c3c4a81945121449::vshares {
    struct VSHARES has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSHARES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<VSHARES>(arg0, 6, 0x1::string::utf8(b"vSHARES"), 0x1::string::utf8(b"Suilend Vault Shares"), 0x1::string::utf8(b"Suilend Vault Shares"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSHARES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VSHARES>>(0x2::coin_registry::finalize<VSHARES>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

