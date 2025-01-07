module 0x24e170414c0676736af926035f410bc2f37f3396fbfa3e2ccc506a61bd91462d::deposit_action {
    struct DepositAction has drop {
        dummy_field: bool,
    }

    public fun deposit<T0, T1>(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::action_receipt::ActionReceipt, arg1: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::action_policy_registry::ActionPolicyRegistry, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::Vault<T0, T1>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositAction{dummy_field: false};
        let v1 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::actions::pop_input_asset<0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::OwnerKey, DepositAction>(v0, arg0, arg1);
        let v2 = DepositAction{dummy_field: false};
        let v3 = 0x2::coin::from_balance<T0>(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::actions::pop_input_asset<0x2::balance::Balance<T0>, DepositAction>(v2, arg0, arg1), arg12);
        0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::deposit::deposit_b<T0, T1>(arg2, arg3, arg4, &v1, 0x2::coin::split<T0>(&mut v3, arg10, arg12), arg5, arg6, arg7, arg8, arg9, arg11, arg12);
        let v4 = DepositAction{dummy_field: false};
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::actions::add_output_asset<0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::OwnerKey, DepositAction>(v4, arg0, arg1, v1);
        let v5 = DepositAction{dummy_field: false};
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::actions::add_output_asset<0x2::balance::Balance<T0>, DepositAction>(v5, arg0, arg1, 0x2::coin::into_balance<T0>(v3));
    }

    // decompiled from Move bytecode v6
}

