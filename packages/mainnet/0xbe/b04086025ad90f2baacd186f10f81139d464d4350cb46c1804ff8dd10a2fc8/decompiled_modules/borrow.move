module 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        borrow_index: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::obligation::ObligationOwnerCap, arg1: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>, arg2: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x1e1e32c7e9b4dd68fe84eb7285005ad5c23099e2e8b215ab32b2facf750029f::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::ensure_version_matches<T0>(arg1);
        assert!(!0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::has_circuit_break_triggered<T0>(arg1), 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2, v3) = 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::handle_borrow<T0, T1>(arg1, 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::obligation::id(arg0), arg3, arg2, arg4, arg5, v0);
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::liquidity_miner::update_obligation_reward_manager<T0, T1>(0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::borrow_liquidity_mining_mut<T0>(arg1), 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::liquidity_miner::get_borrow_reward_type(), 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::obligation::id(arg0), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::floor(v3), arg5);
        let v4 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg6),
            market       : 0x1::type_name::get<T0>(),
            obligation   : 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::obligation::id(arg0),
            asset        : 0x1::type_name::get<T1>(),
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

