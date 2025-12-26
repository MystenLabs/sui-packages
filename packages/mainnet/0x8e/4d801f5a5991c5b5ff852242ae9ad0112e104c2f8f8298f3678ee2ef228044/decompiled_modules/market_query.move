module 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::interest::InterestModel,
        utilization_rate: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::asset::AssetConfig,
        deposit_usage: 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::query_types::AssetDeposit,
        borrow_usage: 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::query_types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xfe91675bc6d4cef3cf3b6045567189b5a7fc98bca6199190cf0ebed3a793343a::x_oracle::XOracle, arg5: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0xfe91675bc6d4cef3cf3b6045567189b5a7fc98bca6199190cf0ebed3a793343a::user_oracle::get_price(arg4, arg2, 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::emode::get_oracle_base_token(0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::emode::borrow_emode_group(0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::emode_registry<T0>(arg0), arg1)), arg5), arg5)
    }

    fun get_asset_detail_inner<T0>(arg0: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::CoinDecimalsRegistry, arg4: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg5: &0x2::clock::Clock) : AssetData {
        let v0 = 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::asset_by_type<T0>(arg0, arg2);
        let v1 = 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::reserve_by_type<T0>(arg0, arg2);
        let v2 = 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::decimals(arg3, arg2);
        AssetData{
            coin_type          : arg2,
            interest_model     : *0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::asset::interest_model<T0>(v0),
            utilization_rate   : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::reserve::util_rate<T0>(v1),
            borrow_paused      : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::asset::flash_loan_paused<T0>(v0),
            reserve            : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::asset::asset_config<T0>(v0),
            deposit_usage      : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::query_types::new_asset_deposit(arg2, false, 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::floor(0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), arg4, v2, 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::query_types::new_asset_borrow(arg2, 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::floor(0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::emode::borrow_amount(0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::emode::borrow_emode_group(0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::emode_registry<T0>(arg0), arg1), arg2)), arg4, v2, 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::reserve::calculate_borrow_index<T0>(v1, 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::interest::calc_interest(0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::asset::interest_model<T0>(v0), 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::reserve::util_rate<T0>(v1)), 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::value::clock_now(arg5))),
        }
    }

    public fun get_asset_detail_no_price<T0>(arg0: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::zero(), arg4)
    }

    // decompiled from Move bytecode v6
}

