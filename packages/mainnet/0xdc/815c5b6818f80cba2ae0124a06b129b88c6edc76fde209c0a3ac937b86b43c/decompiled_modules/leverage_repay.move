module 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinSplitEvent has copy, drop {
        input_amount: u64,
        split_amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::app::ProtocolApp, arg1: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg2: &mut 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_market::LeverageMarket, arg3: &0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::FlashLoan<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0x1a0736fb2df41236bd00010023e95f2503bed82339e54f13c0b4c032e69697ec::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_market::ensure_leverage_on_going(arg2);
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_market::mark_leverage_finished(arg2);
        let v0 = 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::fee<T0, T1>(&arg4) + 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::loan_amount<T0, T1>(&arg4);
        assert!(0x2::coin::value<T1>(&arg6) >= v0, 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_error::cannot_repay_flash_loan());
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::flash_loan::repay_flash_loan_increase_referral_qualification<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg6, v0, arg10), arg4, arg5, arg9, arg7, arg8, arg10);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::id(arg3), arg7, arg8, 0x2::coin::value<T1>(&arg6), arg9));
        arg6
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x1a0736fb2df41236bd00010023e95f2503bed82339e54f13c0b4c032e69697ec::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x1a0736fb2df41236bd00010023e95f2503bed82339e54f13c0b4c032e69697ec::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::with_defining_ids<T0>(),
        }
    }

    public fun split_with_event<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = CoinSplitEvent{
            input_amount : 0x2::coin::value<T0>(arg0),
            split_amount : arg1,
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<CoinSplitEvent>(v0);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

