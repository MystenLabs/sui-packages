module 0x93b500bc9eb7212cfeeacd74a94d2aa650eb11d863d14495bbe812ecc78953c7::gate {
    public fun destroy_opt(arg0: 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>) {
        if (0x1::option::is_some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(&arg0)) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(0x1::option::destroy_some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(arg0));
        } else {
            0x1::option::destroy_none<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(arg0);
        };
    }

    fun do_update(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>, arg3: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo> {
        if (onchain_ts(arg3) >= arg4) {
            return arg2
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::update_single_price_feed(arg1, arg2, arg3, 0x2::coin::split<0x2::sui::SUI>(arg0, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_total_update_fee(arg1, 1), arg6), arg5)
    }

    public fun maybe_update(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>, arg3: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>> {
        if (0x1::option::is_none<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(&arg2) || onchain_ts(arg3) >= arg4) {
            return arg2
        };
        0x1::option::destroy_none<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(arg2);
        0x1::option::some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::update_single_price_feed(arg1, 0x1::option::extract<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(&mut arg2), arg3, 0x2::coin::split<0x2::sui::SUI>(arg0, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_total_update_fee(arg1, 1), arg6), arg5))
    }

    public fun maybe_verify(arg0: bool, arg1: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) : 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>> {
        if (!arg0) {
            return 0x1::option::none<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>()
        };
        0x1::option::some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg4, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg1, arg3, arg5), arg5))
    }

    public fun needs_update(arg0: bool, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: u64) : bool {
        arg0 || onchain_ts(arg1) < arg2
    }

    fun onchain_ts(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0));
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v1)
    }

    public fun update_1(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (onchain_ts(arg5) >= arg6) {
            return
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(do_update(arg0, arg2, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg4, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg1, arg3, arg7), arg7), arg5, arg6, arg7, arg8));
    }

    public fun update_2(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (onchain_ts(arg5) >= arg7 && onchain_ts(arg6) >= arg7) {
            return
        };
        let v0 = do_update(arg0, arg2, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg4, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg1, arg3, arg8), arg8), arg5, arg7, arg8, arg9);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(do_update(arg0, arg2, v0, arg6, arg7, arg8, arg9));
    }

    public fun update_3(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (onchain_ts(arg5) >= arg8) {
            if (onchain_ts(arg6) >= arg8) {
                onchain_ts(arg7) >= arg8
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return
        };
        let v1 = do_update(arg0, arg2, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg4, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg1, arg3, arg9), arg9), arg5, arg8, arg9, arg10);
        let v2 = do_update(arg0, arg2, v1, arg6, arg8, arg9, arg10);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(do_update(arg0, arg2, v2, arg7, arg8, arg9, arg10));
    }

    public fun update_4(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = if (onchain_ts(arg5) >= arg9) {
            if (onchain_ts(arg6) >= arg9) {
                if (onchain_ts(arg7) >= arg9) {
                    onchain_ts(arg8) >= arg9
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return
        };
        let v1 = do_update(arg0, arg2, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg4, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg1, arg3, arg10), arg10), arg5, arg9, arg10, arg11);
        let v2 = do_update(arg0, arg2, v1, arg6, arg9, arg10, arg11);
        let v3 = do_update(arg0, arg2, v2, arg7, arg9, arg10, arg11);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(do_update(arg0, arg2, v3, arg8, arg9, arg10, arg11));
    }

    public fun update_5(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (onchain_ts(arg5) >= arg10) {
            if (onchain_ts(arg6) >= arg10) {
                if (onchain_ts(arg7) >= arg10) {
                    if (onchain_ts(arg8) >= arg10) {
                        onchain_ts(arg9) >= arg10
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return
        };
        let v1 = do_update(arg0, arg2, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg4, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg1, arg3, arg11), arg11), arg5, arg10, arg11, arg12);
        let v2 = do_update(arg0, arg2, v1, arg6, arg10, arg11, arg12);
        let v3 = do_update(arg0, arg2, v2, arg7, arg10, arg11, arg12);
        let v4 = do_update(arg0, arg2, v3, arg8, arg10, arg11, arg12);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(do_update(arg0, arg2, v4, arg9, arg10, arg11, arg12));
    }

    public fun update_6(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (onchain_ts(arg5) >= arg11) {
            if (onchain_ts(arg6) >= arg11) {
                if (onchain_ts(arg7) >= arg11) {
                    if (onchain_ts(arg8) >= arg11) {
                        if (onchain_ts(arg9) >= arg11) {
                            onchain_ts(arg10) >= arg11
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return
        };
        let v1 = do_update(arg0, arg2, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg4, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg1, arg3, arg12), arg12), arg5, arg11, arg12, arg13);
        let v2 = do_update(arg0, arg2, v1, arg6, arg11, arg12, arg13);
        let v3 = do_update(arg0, arg2, v2, arg7, arg11, arg12, arg13);
        let v4 = do_update(arg0, arg2, v3, arg8, arg11, arg12, arg13);
        let v5 = do_update(arg0, arg2, v4, arg9, arg11, arg12, arg13);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(do_update(arg0, arg2, v5, arg10, arg11, arg12, arg13));
    }

    // decompiled from Move bytecode v7
}

