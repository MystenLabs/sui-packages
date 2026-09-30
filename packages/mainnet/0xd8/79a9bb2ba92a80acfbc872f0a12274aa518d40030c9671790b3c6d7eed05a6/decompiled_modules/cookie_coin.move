module 0xd879a9bb2ba92a80acfbc872f0a12274aa518d40030c9671790b3c6d7eed05a6::cookie_coin {
    struct COOKIE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKIE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<COOKIE_COIN>(arg0, 9, 0x1::string::utf8(b"CeC"), 0x1::string::utf8(b"Cookie Coin"), 0x1::string::utf8(b"Cookie Coin (CeC). Fixed supply of 200 coins; no minting, deny list, transaction tax, staking, or liquidity features."), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-object-id/0x8ac6a772f95994fa2a679f56ec3cb81e6bc036d603b8ab46f2d9ccbddb2ee768"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<COOKIE_COIN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<COOKIE_COIN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<COOKIE_COIN>>(0x2::coin::mint<COOKIE_COIN>(&mut v2, 200000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

