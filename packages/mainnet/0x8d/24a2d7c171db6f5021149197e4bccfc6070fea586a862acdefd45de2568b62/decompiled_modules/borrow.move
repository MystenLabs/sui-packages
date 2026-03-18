module 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal,
        borrow_index: 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg1: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::obligation::ObligationOwnerCap, arg2: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>, arg3: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x70d0acb8fb07d5b50168d196d44c8c7eef422e6b0c7f46d778b5648cbd725060::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ensure_version_matches(arg0);
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::validate_market<T0>(arg0, arg2);
        assert!(!0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::has_circuit_break_triggered<T0>(arg2), 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let (v1, v2, v3) = 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::handle_borrow<T0, T1>(arg2, 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::obligation::id(arg1), arg4, arg3, arg5, arg6, v0);
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::borrow_liquidity_mining_mut<T0>(arg2), 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::liquidity_miner::get_borrow_reward_type(), 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::obligation::id(arg1), 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::floor(v3), arg6);
        let v4 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg7),
            market       : 0x1::type_name::with_defining_ids<T0>(),
            obligation   : 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::obligation::id(arg1),
            asset        : 0x1::type_name::with_defining_ids<T1>(),
            amount       : arg4,
            total_borrow : v3,
            borrow_index : v2,
            time         : v0,
        };
        0x2::event::emit<BorrowEvent>(v4);
        0x2::coin::from_balance<T1>(v1, arg7)
    }

    // decompiled from Move bytecode v6
}

