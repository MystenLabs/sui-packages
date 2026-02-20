module 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinSplitEvent has copy, drop {
        input_amount: u64,
        split_amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct LeverageHotPotato<phantom T0, phantom T1> {
        flash_loan: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::FlashLoan<T0, T1>,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg1: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: &mut 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_market::LeverageMarket, arg3: &0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::LeverageMarketOwnerCap, arg4: LeverageHotPotato<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let LeverageHotPotato { flash_loan: v0 } = arg4;
        complete_leverage_inner<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public(friend) fun complete_leverage_inner<T0, T1>(arg0: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg1: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: &mut 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_market::LeverageMarket, arg3: &0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::LeverageMarketOwnerCap, arg4: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::FlashLoan<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_market::ensure_leverage_on_going(arg2);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_market::mark_leverage_finished(arg2);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_market::ensure_supporting_market<T0>(arg2, arg1);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::ensure_same_market<T0>(arg3);
        let v0 = 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::fee<T0, T1>(&arg4) + 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::loan_amount<T0, T1>(&arg4);
        assert!(0x2::coin::value<T1>(&arg6) >= v0, 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_error::cannot_repay_flash_loan());
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::flash_loan::repay_flash_loan_increase_referral_qualification<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg6, v0, arg10), arg4, arg5, arg9, arg7, arg8, arg10);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::id(arg3), arg7, arg8, 0x2::coin::value<T1>(&arg6), arg9));
        arg6
    }

    public(friend) fun flash_loan<T0, T1>(arg0: &LeverageHotPotato<T0, T1>) : &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::FlashLoan<T0, T1> {
        &arg0.flash_loan
    }

    public(friend) fun new_leverage_hot_potato<T0, T1>(arg0: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::FlashLoan<T0, T1>) : LeverageHotPotato<T0, T1> {
        LeverageHotPotato<T0, T1>{flash_loan: arg0}
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
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

