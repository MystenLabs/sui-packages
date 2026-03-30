module 0x30baf87047f59a55a11d55f2401ffa9e4da73ea4b6d1e6547e631d8ec437a502::liq {
    public fun liquidate_and_close<T0, T1>(arg0: 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::ClearingHouse<T0>, arg1: &0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::account::AccountCap<T1>, arg2: &mut 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::account::Account<T0>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg6: &0x2::clock::Clock, arg7: u64, arg8: bool, arg9: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == @0xdf7efdffbf183228108382c8e31491104be6d6ecfa66ed17743d627195ed4526, 1);
        let v0 = 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::interface::start_session<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        let v1 = 0x1::vector::empty<u128>();
        0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::interface::liquidate<T0>(&mut v0, arg7, &v1);
        let v2 = 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::get_summary_in_session_<T0>(&v0);
        0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::interface::place_limit_order<T0>(&mut v0, arg8, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::get_session_liquidated_size(&v2), 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::get_liquidation_mark_price_u64<T0>(&v0), 1, true, 0x1::option::none<u64>());
        let (v3, _) = 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::interface::end_session<T0>(v0, arg2, false, 0x1::option::none<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::IntegratorInfo>());
        0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::interface::share_clearing_house<T0>(v3);
    }

    // decompiled from Move bytecode v6
}

