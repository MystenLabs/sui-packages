module 0x162ed326f6a1a907748de0ca275c6ef1e441e0943bbb7f5e68f9630f1a31bd71::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DEEP>(arg0, 9, untag(b"SDEEP"), untag(b"NDeepBook Token"), untag(b"DThe DEEP token secures the DeepBook protocol, the premier wholesale liquidity venue for on-chain trading.||{\"twitter\":\"https://x.com/DeepBookonSui\",\"website\":\"https://deepbook.tech/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreig37n7j7e5i5gyasj6f2lrr73cxc5rauvmfsjhr2w4ncnr3bgqnhq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<DEEP>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<DEEP>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEEP>>(0x2::coin::mint<DEEP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

