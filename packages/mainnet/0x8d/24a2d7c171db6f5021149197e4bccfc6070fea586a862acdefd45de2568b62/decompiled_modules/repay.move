module 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal,
        borrow_index: 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal,
        refund: u64,
        time: u64,
    }

    public fun repay<T0, T1>(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg1: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::obligation::ObligationOwnerCap, arg2: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = repay_coin_refund<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
        };
    }

    public fun repay_coin_refund<T0, T1>(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg1: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::obligation::ObligationOwnerCap, arg2: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        repay_on_behalf<T0, T1>(arg0, 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::obligation::id(arg1), arg2, arg3, arg4, arg5)
    }

    public fun repay_on_behalf<T0, T1>(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg1: 0x2::object::ID, arg2: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::validate_market<T0>(arg0, arg2);
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ensure_version_matches(arg0);
        assert!(!0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::has_circuit_break_triggered<T0>(arg2), 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let (v1, v2, v3) = 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::handle_repay<T0, T1>(arg2, arg1, arg3, v0, arg5);
        let v4 = v1;
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::borrow_liquidity_mining_mut<T0>(arg2), 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::liquidity_miner::get_borrow_reward_type(), arg1, 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::floor(v3), arg4);
        let v5 = RepayEvent{
            repayer      : 0x2::tx_context::sender(arg5),
            market       : 0x1::type_name::with_defining_ids<T0>(),
            obligation   : arg1,
            asset        : 0x1::type_name::with_defining_ids<T1>(),
            amount       : 0x2::coin::value<T1>(&arg3),
            total_borrow : v3,
            borrow_index : v2,
            refund       : 0x2::coin::value<T1>(&v4),
            time         : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
        v4
    }

    // decompiled from Move bytecode v6
}

