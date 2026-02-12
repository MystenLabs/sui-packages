module 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::deposit {
    struct DepositEvent has copy, drop {
        minter: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        ctoken_amount: u64,
        total_ctoken_amount: u64,
        time: u64,
    }

    public fun deposit<T0, T1>(arg0: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::app::ProtocolApp, arg1: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::Market<T0>, arg2: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::obligation::ObligationOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::app::validate_market<T0>(arg0, arg1);
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::ensure_version_matches<T0>(arg1);
        assert!(!0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::has_circuit_break_triggered<T0>(arg1), 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let (v1, v2) = 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::handle_mint<T0, T1>(arg1, 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::obligation::id(arg2), arg3, v0);
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::borrow_liquidity_mining_mut<T0>(arg1), 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::liquidity_miner::get_deposit_reward_type(), 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::obligation::id(arg2), v2, arg4);
        let v3 = DepositEvent{
            minter              : 0x2::tx_context::sender(arg5),
            market              : 0x1::type_name::with_defining_ids<T0>(),
            obligation          : 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::obligation::id(arg2),
            deposit_asset       : 0x1::type_name::with_defining_ids<T1>(),
            deposit_amount      : 0x2::coin::value<T1>(&arg3),
            ctoken_amount       : v1,
            total_ctoken_amount : v2,
            time                : v0,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

