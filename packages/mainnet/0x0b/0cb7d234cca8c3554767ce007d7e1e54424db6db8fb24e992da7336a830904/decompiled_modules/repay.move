module 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        borrow_index: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        refund: u64,
        time: u64,
    }

    public fun repay<T0, T1>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::obligation::ObligationOwnerCap, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = repay_coin_refund<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
        };
    }

    public fun repay_coin_refund<T0, T1>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::obligation::ObligationOwnerCap, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        repay_on_behalf<T0, T1>(0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::obligation::id(arg0), arg1, arg2, arg3, arg4)
    }

    public fun repay_on_behalf<T0, T1>(arg0: 0x2::object::ID, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::ensure_version_matches<T0>(arg1);
        assert!(!0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::has_circuit_break_triggered<T0>(arg1), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let (v1, v2, v3) = 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::handle_repay<T0, T1>(arg1, arg0, arg2, v0, arg4);
        let v4 = v1;
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::liquidity_miner::update_obligation_reward_manager<T0, T1>(0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::borrow_liquidity_mining_mut<T0>(arg1), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::liquidity_miner::get_borrow_reward_type(), arg0, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::floor(v3), arg3);
        let v5 = RepayEvent{
            repayer      : 0x2::tx_context::sender(arg4),
            market       : 0x1::type_name::with_defining_ids<T0>(),
            obligation   : arg0,
            asset        : 0x1::type_name::with_defining_ids<T1>(),
            amount       : 0x2::coin::value<T1>(&arg2),
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

