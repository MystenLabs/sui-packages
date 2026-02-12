module 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        borrow_index: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::obligation::ObligationOwnerCap, arg1: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::Market<T0>, arg2: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::ensure_version_matches<T0>(arg1);
        assert!(!0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::has_circuit_break_triggered<T0>(arg1), 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2, v3) = 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::handle_borrow<T0, T1>(arg1, 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::obligation::id(arg0), arg3, arg2, arg4, arg5, v0);
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::borrow_liquidity_mining_mut<T0>(arg1), 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::liquidity_miner::get_borrow_reward_type(), 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::obligation::id(arg0), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::floor(v3), arg5);
        let v4 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg6),
            market       : 0x1::type_name::with_defining_ids<T0>(),
            obligation   : 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::obligation::id(arg0),
            asset        : 0x1::type_name::with_defining_ids<T1>(),
            amount       : arg3,
            total_borrow : v3,
            borrow_index : v2,
            time         : v0,
        };
        0x2::event::emit<BorrowEvent>(v4);
        0x2::coin::from_balance<T1>(v1, arg6)
    }

    // decompiled from Move bytecode v6
}

