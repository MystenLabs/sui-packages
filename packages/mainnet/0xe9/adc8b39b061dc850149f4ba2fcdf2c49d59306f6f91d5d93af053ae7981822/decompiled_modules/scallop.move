module 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::scallop {
    struct ScallopAdapterModule has drop {
        dummy_field: bool,
    }

    struct CollateralDepositEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CollateralWithdrawEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun deposit<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::AuthorizedTransferTicket, arg3: &0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::AgentAdapterAcl, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        let v1 = 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::withdraw_coin<T0, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::Access, ScallopAdapterModule>(arg2, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::access(arg3), 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::asset_balance<T0>(arg2), &v0, arg5);
        let v2 = if (0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::has_asset_type<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg2)) {
            0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::withdraw_object<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::Access, ScallopAdapterModule>(arg2, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::access(arg3), &v0)
        } else {
            let (v3, v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg0, arg5);
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg0, v3, v5);
            v4
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg0, arg1, arg4, v1, arg5);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::add_object<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::Access, ScallopAdapterModule>(arg2, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::access(arg3), v2, &v0);
        let v6 = CollateralDepositEvent{
            obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            asset_type    : 0x1::type_name::get<T0>(),
            amount        : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<CollateralDepositEvent>(v6);
    }

    public fun withdraw<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::AuthorizedTransferTicket, arg3: &0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::AgentAdapterAcl, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        assert!(0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::has_asset_type<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg2), 0);
        let v1 = 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::withdraw_object<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::Access, ScallopAdapterModule>(arg2, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::access(arg3), &v0);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::add_object<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::Access, ScallopAdapterModule>(arg2, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::access(arg3), v1, &v0);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::add_coin<T0, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::Access, ScallopAdapterModule>(arg2, 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::access(arg3), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<T0>(arg0, arg1, &v1, arg4, arg5, arg8, arg6, arg7, arg9), &v0);
        let v2 = CollateralWithdrawEvent{
            obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            asset_type    : 0x1::type_name::get<T0>(),
            amount        : arg8,
        };
        0x2::event::emit<CollateralWithdrawEvent>(v2);
    }

    public fun withdraw_all<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket::AuthorizedTransferTicket, arg3: &0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl::AgentAdapterAcl, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 18446744073709551615, arg8);
    }

    // decompiled from Move bytecode v6
}

