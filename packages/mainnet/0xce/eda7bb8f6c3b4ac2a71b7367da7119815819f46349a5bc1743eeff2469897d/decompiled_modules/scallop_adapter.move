module 0xceeda7bb8f6c3b4ac2a71b7367da7119815819f46349a5bc1743eeff2469897d::scallop_adapter {
    struct ScallopWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    struct ScallopAdapter<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_in: u64,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>,
        apr: u256,
    }

    public fun new<T0, T1, T2>(arg0: &0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::acl::AdminWitness<0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::sam::SAM>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapter<T0, T1, T2>{
            id      : 0x2::object::new(arg1),
            coin_in : 0,
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(),
            apr     : 0,
        };
        0x2::transfer::public_share_object<ScallopAdapter<T0, T1, T2>>(v0);
    }

    public fun allocate_to_protocol<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: &mut 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::state::SAMState<T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::rbr::RebalanceRequest<T1>, arg5: &0x2::clock::Clock, arg6: &0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopWitness<T2>{dummy_field: false};
        let v1 = 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::state::allocate_to_protocol<T1, T2, ScallopWitness<T2>>(arg1, arg4, v0, arg6, arg7);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T1>(&v1);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg3, arg2, 0x2::coin::from_balance<T1>(v1, arg7), arg5, arg7)));
    }

    public fun approve_protocol_request<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: &mut 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::state::SAMState<T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::ptr::ProtocolRequest<T1>, arg5: &0x2::clock::Clock, arg6: &0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_interest<T0, T1, T2>(arg0, arg2, arg3, arg5, arg7);
        let v1 = 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::state::decimals<T1, T2>(arg1);
        let v2 = reserve_cash<T1>(arg2);
        let v3 = if (arg0.coin_in < v2) {
            arg0.coin_in
        } else {
            v2
        };
        let v4 = ScallopWitness<T2>{dummy_field: false};
        0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::state::approve_protocol_request<T1, T2, ScallopWitness<T2>>(arg1, arg4, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v3, v1), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v2, v1), get_apr<T0, T1, T2>(arg0), v0, v4, arg6, arg7);
    }

    fun get_apr<T0, T1, T2>(arg0: &ScallopAdapter<T0, T1, T2>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(arg0.apr)
    }

    fun redeem_interest<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), 0x1::type_name::with_defining_ids<T1>()));
        let v4 = v0 + v1 - v2;
        let v5 = if (v3 == 0) {
            0
        } else {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.balance), v4, v3)
        };
        arg0.apr = 0x96576e78a3c782f0128b5c6f0d759f1540e67292c24a9350ec097f3544efde06::apr::update_apr_from_ratio(&mut arg0.id, arg0.apr, 0x96576e78a3c782f0128b5c6f0d759f1540e67292c24a9350ec097f3544efde06::apr::ratio_from_amounts(v4, v3), 0x2::clock::timestamp_ms(arg3));
        if (v5 > arg0.coin_in) {
            let v6 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v5 - arg0.coin_in, v3, v4);
            if (v6 > 0) {
                return 0x2::coin::into_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg2, arg1, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, v6), arg4), arg3, arg4))
            };
        };
        0x2::balance::zero<T1>()
    }

    fun reserve_cash<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        let (v0, _, v2, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0)), 0x1::type_name::with_defining_ids<T0>()));
        if (v0 > v2) {
            v0 - v2
        } else {
            0
        }
    }

    public fun update_apr<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: u256, arg2: &0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::acl::AdminWitness<0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::sam::SAM>) {
        arg0.apr = arg1;
    }

    public fun withdraw_rbr<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: &mut 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::state::SAMState<T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::rbr::RebalanceRequest<T1>, arg5: &0x2::clock::Clock, arg6: &0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::rbr::amount<T1>(arg4);
        arg0.coin_in = arg0.coin_in - v0;
        let (v1, v2, v3, v4) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg2)), 0x1::type_name::with_defining_ids<T1>()));
        let v5 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v0, v4, v1 + v2 - v3);
        let v6 = if (v5 > 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.balance)) {
            0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.balance)
        } else {
            v5
        };
        let v7 = 0x2::coin::into_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg3, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, v6), arg7), arg5, arg7));
        if (0x2::balance::value<T1>(&v7) > v0) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg3, arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v7, 0x2::balance::value<T1>(&v7) - v0), arg7), arg5, arg7)));
        };
        let v8 = ScallopWitness<T2>{dummy_field: false};
        0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::state::fill_rebalance_request<T1, T2, ScallopWitness<T2>>(arg1, arg4, v7, v8, arg6, arg7);
    }

    public fun withdraw_wdr<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: &mut 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::state::SAMState<T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::wdr::WithdrawRequest<T1>, arg5: &0x2::clock::Clock, arg6: &0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::wdr::get_coin_amount<T1>(arg4);
        arg0.coin_in = arg0.coin_in - v0;
        let (v1, v2, v3, v4) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg2)), 0x1::type_name::with_defining_ids<T1>()));
        let v5 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v0, v4, v1 + v2 - v3);
        let v6 = if (v5 > 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.balance)) {
            0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.balance)
        } else {
            v5
        };
        let v7 = 0x2::coin::into_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg3, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, v6), arg7), arg5, arg7));
        if (0x2::balance::value<T1>(&v7) > v0) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg3, arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v7, 0x2::balance::value<T1>(&v7) - v0), arg7), arg5, arg7)));
        };
        let v8 = ScallopWitness<T2>{dummy_field: false};
        0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::state::fill_withdraw_request<T1, T2, ScallopWitness<T2>>(arg1, arg4, v7, v8, arg6, arg7);
    }

    public fun witness_type<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<ScallopWitness<T0>>()
    }

    // decompiled from Move bytecode v7
}

