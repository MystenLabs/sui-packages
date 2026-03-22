module 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        borrow_index: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg1: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::obligation::ObligationOwnerCap, arg2: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg3: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xf04916dd9886f2404e7ab846fb3e7ef6134ea06d242f86c33192a7e4877e42c4::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ensure_version_matches(arg0);
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::validate_market<T0>(arg0, arg2);
        assert!(!0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::has_circuit_break_triggered<T0>(arg2), 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let (v1, v2, v3) = 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::handle_borrow<T0, T1>(arg2, 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::obligation::id(arg1), arg4, arg3, arg5, arg6, v0);
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::borrow_liquidity_mining_mut<T0>(arg2), 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::liquidity_miner::get_borrow_reward_type(), 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::obligation::id(arg1), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(v3), arg6);
        let v4 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg7),
            market       : 0x1::type_name::with_defining_ids<T0>(),
            obligation   : 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::obligation::id(arg1),
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

