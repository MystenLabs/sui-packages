module 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinSplitEvent has copy, drop {
        input_amount: u64,
        split_amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct LeverageHotPotato<phantom T0, phantom T1> {
        flash_loan: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::FlashLoan<T0, T1>,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::LeverageMarket, arg3: &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::LeverageMarketOwnerCap, arg4: LeverageHotPotato<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let LeverageHotPotato { flash_loan: v0 } = arg4;
        complete_leverage_inner<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public(friend) fun complete_leverage_inner<T0, T1>(arg0: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::LeverageMarket, arg3: &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::LeverageMarketOwnerCap, arg4: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::FlashLoan<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::ensure_leverage_on_going(arg2);
        0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::mark_leverage_finished(arg2);
        0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::ensure_supporting_market<T0>(arg2, arg1);
        0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::ensure_same_market<T0>(arg3);
        0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::ensure_same_emode(arg3, 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::emode_group(arg2));
        let v0 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::fee<T0, T1>(&arg4) + 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::loan_amount<T0, T1>(&arg4);
        assert!(0x2::coin::value<T1>(&arg6) >= v0, 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_error::cannot_repay_flash_loan());
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::flash_loan::repay_flash_loan_increase_referral_qualification<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg6, v0, arg10), arg4, arg5, arg9, arg7, arg8, arg10);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::id(arg3), arg7, arg8, 0x2::coin::value<T1>(&arg6), arg9));
        arg6
    }

    public(friend) fun flash_loan<T0, T1>(arg0: &LeverageHotPotato<T0, T1>) : &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::FlashLoan<T0, T1> {
        &arg0.flash_loan
    }

    public(friend) fun new_leverage_hot_potato<T0, T1>(arg0: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::FlashLoan<T0, T1>) : LeverageHotPotato<T0, T1> {
        LeverageHotPotato<T0, T1>{flash_loan: arg0}
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
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

