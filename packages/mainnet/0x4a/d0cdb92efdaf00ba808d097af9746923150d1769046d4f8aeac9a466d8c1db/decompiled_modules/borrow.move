module 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::borrow {
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

    public fun borrow<T0, T1>(arg0: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::obligation::ObligationOwnerCap, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>, arg3: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ensure_version_matches(arg0);
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::validate_market<T0>(arg0, arg2);
        assert!(!0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::has_circuit_break_triggered<T0>(arg2), 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let (v1, v2, v3) = 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::handle_borrow<T0, T1>(arg2, 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::obligation::id(arg1), arg4, arg3, arg5, arg6, v0);
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::borrow_liquidity_mining_mut<T0>(arg2), 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::liquidity_miner::get_borrow_reward_type(), 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::obligation::id(arg1), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(v3), arg6);
        let v4 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg7),
            market       : 0x1::type_name::with_defining_ids<T0>(),
            obligation   : 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::obligation::id(arg1),
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

