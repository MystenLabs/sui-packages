module 0xf30d80f22f77c0895ac466d74d0baa86289a0d45f956b0b482abfdb3c72c0256::deposit_action {
    struct DepositAction has drop {
        dummy_field: bool,
    }

    public fun deposit<T0, T1>(arg0: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::action_receipt::ActionReceipt, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::action_policy_registry::ActionPolicyRegistry, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::Vault<T0, T1>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositAction{dummy_field: false};
        let v1 = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::actions::pop_input_asset<0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::OwnerKey, DepositAction>(v0, arg0, arg1);
        let v2 = DepositAction{dummy_field: false};
        let v3 = 0x2::coin::from_balance<T0>(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::actions::pop_input_asset<0x2::balance::Balance<T0>, DepositAction>(v2, arg0, arg1), arg12);
        0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::deposit::deposit_b<T0, T1>(arg2, arg3, arg4, &v1, 0x2::coin::split<T0>(&mut v3, arg10, arg12), arg5, arg6, arg7, arg8, arg9, arg11, arg12);
        let v4 = DepositAction{dummy_field: false};
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::actions::add_output_asset<0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::OwnerKey, DepositAction>(v4, arg0, arg1, v1);
        let v5 = DepositAction{dummy_field: false};
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::actions::add_output_asset<0x2::coin::Coin<T0>, DepositAction>(v5, arg0, arg1, v3);
    }

    // decompiled from Move bytecode v6
}

