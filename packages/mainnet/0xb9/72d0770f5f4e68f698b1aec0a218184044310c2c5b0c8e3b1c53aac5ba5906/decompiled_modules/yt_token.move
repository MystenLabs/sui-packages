module 0xb972d0770f5f4e68f698b1aec0a218184044310c2c5b0c8e3b1c53aac5ba5906::yt_token {
    struct YT_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YT_TOKEN>(arg0, 9, 0x1::string::utf8(b"YT-NEMO"), 0x1::string::utf8(b"Nemo YT-Coin"), 0x1::string::utf8(b"Standardized per-market Nemo yield token coin. Redeemable pro-rata after maturity settlement."), 0x1::string::utf8(b"https://nemo.xyz/icon-yt.png"), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<YT_TOKEN>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

