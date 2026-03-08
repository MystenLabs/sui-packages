module 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::state {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExtensionStateV1 has store, key {
        id: 0x2::object::UID,
        scoins: 0x2::object_bag::ObjectBag,
        coin_types: vector<0x1::type_name::TypeName>,
        deposits_enabled: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ExtensionStateV1 {
        ExtensionStateV1{
            id               : 0x2::object::new(arg0),
            scoins           : 0x2::object_bag::new(arg0),
            coin_types       : 0x1::vector::empty<0x1::type_name::TypeName>(),
            deposits_enabled : true,
        }
    }

    public(friend) fun create_extension_key() : ExtensionKey {
        ExtensionKey{dummy_field: false}
    }

    public(friend) fun deposit_into_extension<T0>(arg0: &mut ExtensionStateV1, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deposits_enabled, 13835340621180698627);
        let v0 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        if (!0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.scoins, v0)) {
            0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.scoins, v0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg1, arg3, arg4, arg5));
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.coin_types, v0);
        } else {
            0x2::coin::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.scoins, v0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg1, arg3, arg4, arg5));
        };
    }

    public(friend) fun destroy(arg0: ExtensionStateV1) {
        assert!(0x2::object_bag::is_empty(&arg0.scoins), 13835058476188958721);
        let ExtensionStateV1 {
            id               : v0,
            scoins           : v1,
            coin_types       : _,
            deposits_enabled : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::object_bag::destroy_empty(v1);
    }

    public(friend) fun destroy_zero_scoin<T0>(arg0: &mut ExtensionStateV1) {
        let v0 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.scoins, v0), 13835621743970222085);
        0x2::coin::destroy_zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::object_bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.scoins, v0));
    }

    public(friend) fun disable_deposits(arg0: &mut ExtensionStateV1) {
        arg0.deposits_enabled = false;
    }

    public(friend) fun enable_deposits(arg0: &mut ExtensionStateV1) {
        arg0.deposits_enabled = true;
    }

    public(friend) fun take_profit<T0>(arg0: &mut ExtensionStateV1, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        if (arg4 == 0 || !0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.scoins, v0)) {
            return 0x2::coin::zero<T0>(arg5)
        };
        let v1 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.scoins, v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg2, arg1, arg3);
        let (v2, v3, v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), 0x1::type_name::with_defining_ids<T0>()));
        let v6 = if (v5 == 0) {
            0
        } else {
            assert!(v5 > 0, 13836466924814860297);
            let v7 = (0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v1) as u128);
            let v8 = ((v2 + v3 - v4) as u128);
            let v9 = (v5 as u128);
            let (v10, v11) = if (v7 >= v8) {
                (v7, v8)
            } else {
                (v8, v7)
            };
            let v12 = if (!(340282366920938463463374607431768211455 / v10 >= v11)) {
                let v13 = v10 / v9;
                assert!(340282366920938463463374607431768211455 / v13 >= v11, 13836185359643705351);
                let v14 = v10 % v9;
                assert!(340282366920938463463374607431768211455 / v14 >= v11, 13836185359643705351);
                v13 * v11 + v14 * v11 / v9
            } else {
                v10 * v11 / v9
            };
            assert!(v12 <= 18446744073709551615, 13836185505672593415);
            (v12 as u64)
        };
        if (v6 > arg4) {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg2, arg1, arg3);
            let (v15, v16, v17, v18) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), 0x1::type_name::with_defining_ids<T0>()));
            let v19 = if (v18 == 0) {
                v6 - arg4
            } else {
                assert!(v15 + v16 - v17 > 0, 13836466924814860297);
                let v20 = ((v6 - arg4) as u128);
                let v21 = (v18 as u128);
                let v22 = ((v15 + v16 - v17) as u128);
                let (v23, v24) = if (v20 >= v21) {
                    (v20, v21)
                } else {
                    (v21, v20)
                };
                let v25 = if (!(340282366920938463463374607431768211455 / v23 >= v24)) {
                    let v26 = v23 / v22;
                    assert!(340282366920938463463374607431768211455 / v26 >= v24, 13836185359643705351);
                    let v27 = v23 % v22;
                    assert!(340282366920938463463374607431768211455 / v27 >= v24, 13836185359643705351);
                    v26 * v24 + v27 * v24 / v22
                } else {
                    v23 * v24 / v22
                };
                assert!(v25 <= 18446744073709551615, 13836185505672593415);
                (v25 as u64)
            };
            return 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg1, 0x2::coin::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v1, v19, arg5), arg3, arg5)
        };
        0x2::coin::zero<T0>(arg5)
    }

    public(friend) fun total_active_liquidity<T0>(arg0: &ExtensionStateV1, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        if (!0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.scoins, v0)) {
            return 0
        };
        let v1 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::object_bag::borrow<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg0.scoins, v0));
        if (v1 == 0) {
            return 0
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg2, arg1, arg3);
        let (v2, v3, v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), 0x1::type_name::with_defining_ids<T0>()));
        if (v5 == 0) {
            0
        } else {
            assert!(v5 > 0, 13836466924814860297);
            let v7 = (v1 as u128);
            let v8 = ((v2 + v3 - v4) as u128);
            let v9 = (v5 as u128);
            let (v10, v11) = if (v7 >= v8) {
                (v7, v8)
            } else {
                (v8, v7)
            };
            let v12 = if (!(340282366920938463463374607431768211455 / v10 >= v11)) {
                let v13 = v10 / v9;
                assert!(340282366920938463463374607431768211455 / v13 >= v11, 13836185359643705351);
                let v14 = v10 % v9;
                assert!(340282366920938463463374607431768211455 / v14 >= v11, 13836185359643705351);
                v13 * v11 + v14 * v11 / v9
            } else {
                v10 * v11 / v9
            };
            assert!(v12 <= 18446744073709551615, 13836185505672593415);
            (v12 as u64)
        }
    }

    public(friend) fun withdraw_from_extension<T0>(arg0: &mut ExtensionStateV1, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.scoins, v0), 13835622276546166789);
        let v1 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.scoins, v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg2, arg1, arg4);
        let (v2, v3, v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), 0x1::type_name::with_defining_ids<T0>()));
        let v6 = if (v5 == 0) {
            arg3
        } else {
            assert!(v2 + v3 - v4 > 0, 13836466924814860297);
            let v7 = (arg3 as u128);
            let v8 = (v5 as u128);
            let v9 = ((v2 + v3 - v4) as u128);
            let (v10, v11) = if (v7 >= v8) {
                (v7, v8)
            } else {
                (v8, v7)
            };
            let v12 = if (!(340282366920938463463374607431768211455 / v10 >= v11)) {
                let v13 = v10 / v9;
                assert!(340282366920938463463374607431768211455 / v13 >= v11, 13836185359643705351);
                let v14 = v10 % v9;
                assert!(340282366920938463463374607431768211455 / v14 >= v11, 13836185359643705351);
                v13 * v11 + v14 * v11 / v9
            } else {
                v10 * v11 / v9
            };
            assert!(v12 <= 18446744073709551615, 13836185505672593415);
            (v12 as u64)
        };
        let v15 = 0x1::u64::min(v6, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v1));
        if (v15 == 0) {
            return 0x2::coin::zero<T0>(arg5)
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg1, 0x2::coin::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v1, v15, arg5), arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

