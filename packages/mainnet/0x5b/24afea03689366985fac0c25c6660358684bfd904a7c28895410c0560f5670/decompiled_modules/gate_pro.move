module 0x43cb716bc44cf1a974385912c02141b7227fb737d300a66f77e508dd4157e336::gate_pro {
    public fun check_feed(arg0: u64, arg1: u8, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        assert!(arg1 < 64, 2);
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0));
        if (should_update_ts(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v1), 0x2::clock::timestamp_ms(arg5), arg3, arg4)) {
            arg0 | 1 << arg1
        } else {
            arg0
        }
    }

    public fun destroy_opt(arg0: 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>) {
        if (0x1::option::is_some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(&arg0)) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(0x1::option::destroy_some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(arg0));
        } else {
            0x1::option::destroy_none<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(arg0);
        };
    }

    public fun dispose_fee(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        } else {
            0x2::coin::send_funds<0x2::sui::SUI>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun maybe_update(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>, arg3: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>> {
        if (0x1::option::is_some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(&arg2)) {
            0x1::option::some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::update_single_price_feed(arg1, 0x1::option::destroy_some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(arg2), arg3, 0x2::coin::split<0x2::sui::SUI>(arg0, arg4, arg6), arg5))
        } else {
            arg2
        }
    }

    public fun maybe_verify(arg0: bool, arg1: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) : 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>> {
        if (arg0) {
            0x1::option::some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg4, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg1, arg3, arg5), arg5))
        } else {
            0x1::option::none<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>()
        }
    }

    public fun needs_update(arg0: bool, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: u64) : bool {
        if (arg0) {
            return true
        };
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0));
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v1) < arg2
    }

    public fun redeem_for_mask(arg0: u64, arg1: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg0 != 0) {
            0x2::coin::redeem_funds<0x2::sui::SUI>(arg1, arg2)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg2)
        }
    }

    public fun redeem_or_drop(arg0: bool, arg1: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg0) {
            0x2::coin::redeem_funds<0x2::sui::SUI>(arg1, arg2)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg2)
        }
    }

    public(friend) fun should_update_ts(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg2 > 0 && arg0 < arg2 || arg3 > 0 && (arg1 as u128) >= (arg0 as u128) * 1000 + (arg3 as u128)
    }

    public(friend) fun slice_pnau(arg0: vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 >= 8, 1);
        let v1 = if (*0x1::vector::borrow<u8>(&arg0, 0) == 80) {
            if (*0x1::vector::borrow<u8>(&arg0, 1) == 78) {
                if (*0x1::vector::borrow<u8>(&arg0, 2) == 65) {
                    *0x1::vector::borrow<u8>(&arg0, 3) == 85
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = 7 + (*0x1::vector::borrow<u8>(&arg0, 6) as u64) + 1;
        assert!(v2 + 2 <= v0, 1);
        let v3 = v2 + 2 + ((*0x1::vector::borrow<u8>(&arg0, v2) as u64) << 8 | (*0x1::vector::borrow<u8>(&arg0, v2 + 1) as u64));
        assert!(v3 < v0, 1);
        let v4 = (*0x1::vector::borrow<u8>(&arg0, v3) as u64);
        assert!(v4 > 0 && v4 <= 64, 1);
        let v5 = v3 + 1;
        let v6 = if (v4 == 64) {
            18446744073709551615
        } else {
            (1 << (v4 as u8)) - 1
        };
        assert!(arg1 & (18446744073709551615 ^ v6) == 0, 2);
        assert!(arg1 != 0, 1);
        if (arg1 == v6) {
            return arg0
        };
        let v7 = b"";
        let v8 = 0;
        while (v8 < v3) {
            0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&arg0, v8));
            v8 = v8 + 1;
        };
        0x1::vector::push_back<u8>(&mut v7, 0);
        let v9 = 0;
        let v10 = 0;
        while (v10 < v4) {
            let v11 = v5;
            assert!(v5 + 2 <= v0, 1);
            let v12 = v5 + 2 + ((*0x1::vector::borrow<u8>(&arg0, v5) as u64) << 8 | (*0x1::vector::borrow<u8>(&arg0, v5 + 1) as u64));
            assert!(v12 < v0, 1);
            let v13 = v12 + 1 + (*0x1::vector::borrow<u8>(&arg0, v12) as u64) * 20;
            v5 = v13;
            assert!(v13 <= v0, 1);
            if (arg1 >> (v10 as u8) & 1 == 1) {
                let v14 = v11;
                while (v14 < v13) {
                    0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&arg0, v14));
                    v14 = v14 + 1;
                };
                v9 = v9 + 1;
            };
            v10 = v10 + 1;
        };
        assert!(v5 == v0, 1);
        assert!(v9 > 0, 1);
        *0x1::vector::borrow_mut<u8>(&mut v7, v3) = v9;
        v7
    }

    public fun update_masked(arg0: u64, arg1: u8, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg4: 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>> {
        assert!(arg1 < 64, 2);
        if (arg0 >> arg1 & 1 == 1 && 0x1::option::is_some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(&arg4)) {
            0x1::option::some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::update_single_price_feed(arg3, 0x1::option::destroy_some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(arg4), arg5, 0x2::coin::split<0x2::sui::SUI>(arg2, arg6, arg8), arg7))
        } else {
            arg4
        }
    }

    public fun verify_masked(arg0: u64, arg1: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) : 0x1::option::Option<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>> {
        if (arg0 != 0) {
            0x1::option::some<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg2, slice_pnau(arg4, arg0), 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg1, arg3, arg5), arg5))
        } else {
            0x1::option::none<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>>()
        }
    }

    // decompiled from Move bytecode v7
}

