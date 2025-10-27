module 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::state {
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
        assert!(arg0.deposits_enabled, 1);
        let v0 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        if (!0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.scoins, v0)) {
            0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.scoins, v0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg1, arg3, arg4, arg5));
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.coin_types, v0);
        } else {
            0x2::coin::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.scoins, v0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg1, arg3, arg4, arg5));
        };
    }

    public(friend) fun destroy(arg0: ExtensionStateV1) {
        assert!(0x2::object_bag::is_empty(&arg0.scoins), 0);
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
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.scoins, v0), 4);
        0x2::coin::destroy_zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::object_bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.scoins, v0));
    }

    public(friend) fun disable_deposits(arg0: &mut ExtensionStateV1) {
        arg0.deposits_enabled = false;
    }

    public(friend) fun enable_deposits(arg0: &mut ExtensionStateV1) {
        arg0.deposits_enabled = true;
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
            assert!(v5 > 0, 13836185157780176902);
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
                assert!(340282366920938463463374607431768211455 / v13 >= v11, 13835903592609021956);
                let v14 = v10 % v9;
                assert!(340282366920938463463374607431768211455 / v14 >= v11, 13835903592609021956);
                v13 * v11 + v14 * v11 / v9
            } else {
                v10 * v11 / v9
            };
            assert!(v12 <= 18446744073709551615, 13835903738637910020);
            (v12 as u64)
        }
    }

    public(friend) fun withdraw_from_extension<T0>(arg0: &mut ExtensionStateV1, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.scoins, v0), 4);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg2, arg1, arg4);
        let (v1, v2, v3, v4) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), 0x1::type_name::with_defining_ids<T0>()));
        let v5 = if (v4 == 0) {
            arg3
        } else {
            assert!(v1 + v2 - v3 > 0, 13836185157780176902);
            let v6 = (arg3 as u128);
            let v7 = (v4 as u128);
            let v8 = ((v1 + v2 - v3) as u128);
            let (v9, v10) = if (v6 >= v7) {
                (v6, v7)
            } else {
                (v7, v6)
            };
            let v11 = if (!(340282366920938463463374607431768211455 / v9 >= v10)) {
                let v12 = v9 / v8;
                assert!(340282366920938463463374607431768211455 / v12 >= v10, 13835903592609021956);
                let v13 = v9 % v8;
                assert!(340282366920938463463374607431768211455 / v13 >= v10, 13835903592609021956);
                v12 * v10 + v13 * v10 / v8
            } else {
                v9 * v10 / v8
            };
            assert!(v11 <= 18446744073709551615, 13835903738637910020);
            (v11 as u64)
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg1, 0x2::coin::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.scoins, v0), v5, arg5), arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

