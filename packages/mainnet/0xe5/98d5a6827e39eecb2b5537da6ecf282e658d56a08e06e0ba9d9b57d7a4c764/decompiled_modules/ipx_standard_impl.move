module 0xe598d5a6827e39eecb2b5537da6ecf282e658d56a08e06e0ba9d9b57d7a4c764::ipx_standard_impl {
    public fun mint_and_lock_treasury<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::set_maximum_supply(&mut v2, 100000000);
        let v4 = 0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::create_mint_cap(&mut v2, arg1);
        let v5 = 0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::mint<T0>(&v4, &mut v3, 100000000, arg1);
        0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::destroy_mint_cap(&mut v3, v4);
        let v6 = 0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::create_burn_cap(&mut v2, arg1);
        0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::cap_burn<T0>(&v6, &mut v3, 0x2::coin::split<T0>(&mut v5, 100000000 / 50, arg1));
        0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::destroy_burn_cap(&mut v3, v6);
        0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::destroy_witness<T0>(&mut v3, v2);
        0x2::transfer::public_share_object<0x103bc8a715277926ad0821a2b754c493e705dc5f0943b9f354338c9482d40492::ipx_coin_standard::IPXTreasuryStandard>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

