module 0x5a908fa946caf68f494c0a9f2d49ea29e7461aec6ffca1689d263ac76540476d::constancy_coin {
    struct CONSTANCY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONSTANCY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CONSTANCY_COIN>(arg0, 9, 0x1::string::utf8(b"CyC"), 0x1::string::utf8(b"Constancy Coin"), 0x1::string::utf8(b"Constancy Coin (CyC), inspired by continuity and permanence."), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-object-id/0xf065a662ed35ffc094ee4daa8ce4bdd726d4c57cf8ee042729b0c02e4b6a4ec1"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<CONSTANCY_COIN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CONSTANCY_COIN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CONSTANCY_COIN>>(0x2::coin::mint<CONSTANCY_COIN>(&mut v2, 200000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

