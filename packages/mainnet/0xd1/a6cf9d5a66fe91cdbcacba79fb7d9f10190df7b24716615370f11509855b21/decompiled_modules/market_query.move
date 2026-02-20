module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::interest::InterestModel,
        utilization_rate: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset::AssetConfig,
        deposit_usage: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::query_types::AssetDeposit,
        borrow_usage: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::query_types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::x_oracle::XOracle, arg5: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::user_oracle::get_price(arg4, arg2, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode::get_oracle_base_token(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode::borrow_emode_group(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::emode_registry<T0>(arg0), arg1)), arg5), arg5)
    }

    fun get_asset_detail_inner<T0>(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry, arg4: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg5: &0x2::clock::Clock) : AssetData {
        let v0 = 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::asset_by_type<T0>(arg0, arg2);
        let v1 = 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::reserve_by_type<T0>(arg0, arg2);
        let v2 = 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::decimals(arg3, arg2);
        AssetData{
            coin_type          : arg2,
            interest_model     : *0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset::interest_model<T0>(v0),
            utilization_rate   : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::reserve::util_rate<T0>(v1),
            borrow_paused      : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset::flash_loan_paused<T0>(v0),
            reserve            : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset::asset_config<T0>(v0),
            deposit_usage      : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::query_types::new_asset_deposit(arg2, false, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), arg4, v2, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::query_types::new_asset_borrow(arg2, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode::borrow_amount(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode::borrow_emode_group(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::emode_registry<T0>(arg0), arg1), arg2)), arg4, v2, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::reserve::calculate_borrow_index<T0>(v1, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::interest::calc_interest(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset::interest_model<T0>(v0), 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::reserve::util_rate<T0>(v1)), 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::value::clock_now(arg5))),
        }
    }

    public fun get_asset_detail_no_price<T0>(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero(), arg4)
    }

    // decompiled from Move bytecode v6
}

