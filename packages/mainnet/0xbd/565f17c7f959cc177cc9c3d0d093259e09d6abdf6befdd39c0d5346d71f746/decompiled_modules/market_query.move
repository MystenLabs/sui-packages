module 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::interest::InterestModel,
        utilization_rate: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::asset::AssetConfig,
        deposit_usage: 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::query_types::AssetDeposit,
        borrow_usage: 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::query_types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::XOracle, arg5: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg2, arg3, 0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::user_oracle::get_price(arg4, arg2, 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::emode::get_oracle_base_token(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::emode::borrow_emode_group(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::emode_registry<T0>(arg0), arg1)), arg5), arg5)
    }

    fun get_asset_detail_inner<T0>(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::coin_decimals_registry::CoinDecimalsRegistry, arg3: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::coin_decimals_registry::decimals(arg2, arg1);
        AssetData{
            coin_type          : arg1,
            interest_model     : *0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::asset::interest_model<T0>(v0),
            utilization_rate   : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::reserve::util_rate<T0>(v1),
            borrow_paused      : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::asset::flash_loan_paused<T0>(v0),
            reserve            : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::asset::asset_config<T0>(v0),
            deposit_usage      : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::query_types::new_asset_deposit(arg1, false, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), arg3, v2, 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::query_types::new_asset_borrow(arg1, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(*0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::reserve::debt<T0>(v1)), arg3, v2, 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::reserve::calculate_borrow_index<T0>(v1, 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::interest::calc_interest(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::asset::interest_model<T0>(v0), 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::reserve::util_rate<T0>(v1)), 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::value::clock_now(arg4))),
        }
    }

    public fun get_asset_detail_no_price<T0>(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::zero(), arg3)
    }

    // decompiled from Move bytecode v6
}

