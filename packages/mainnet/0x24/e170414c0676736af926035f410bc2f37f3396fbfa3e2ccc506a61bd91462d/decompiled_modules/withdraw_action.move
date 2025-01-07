module 0x24e170414c0676736af926035f410bc2f37f3396fbfa3e2ccc506a61bd91462d::withdraw_action {
    struct WithdrawAction has drop {
        dummy_field: bool,
    }

    public fun withdraw<T0, T1>(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::action_receipt::ActionReceipt, arg1: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::action_policy_registry::ActionPolicyRegistry, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::Vault<T0, T1>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawAction{dummy_field: false};
        let v1 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::actions::pop_input_asset<0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::OwnerKey, WithdrawAction>(v0, arg0, arg1);
        let v2 = WithdrawAction{dummy_field: false};
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::actions::add_output_asset<0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::OwnerKey, WithdrawAction>(v2, arg0, arg1, v1);
        let v3 = WithdrawAction{dummy_field: false};
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::actions::add_output_asset<0x2::coin::Coin<T0>, WithdrawAction>(v3, arg0, arg1, 0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::withdraw::withdraw_b<T0, T1>(arg2, arg3, arg4, &v1, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    // decompiled from Move bytecode v6
}

