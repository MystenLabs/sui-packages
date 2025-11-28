module 0xdc629b8a9f981e99891ae43f1671373323a02430a906f159bb1f1c75d64a9bc0::zo_mm {
    public fun test_lootbox(arg0: &0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::create_lootbox_treasury(arg0, arg1);
    }

    public fun test_sudo_nft(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::admin_create_points(arg0, arg1, arg2, arg3);
    }

    public fun test_zo_core(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPriceConfig, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::from_price(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

