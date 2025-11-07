module 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::InterestModel,
        utilization_rate: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::AssetConfig,
        deposit_usage: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::query_types::AssetDeposit,
        borrow_usage: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::query_types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg5: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg2, arg3, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::user_oracle::get_price(arg4, arg2, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode::get_oracle_base_token(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode::borrow_emode_group(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::emode_registry<T0>(arg0), arg1)), arg5), arg5)
    }

    fun get_asset_detail_inner<T0>(arg0: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg3: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::decimals(arg2, arg1);
        AssetData{
            coin_type          : arg1,
            interest_model     : *0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::interest_model<T0>(v0),
            utilization_rate   : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::reserve::util_rate<T0>(v1),
            borrow_paused      : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::flash_loan_paused<T0>(v0),
            reserve            : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::asset_config<T0>(v0),
            deposit_usage      : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::query_types::new_asset_deposit(arg1, false, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), arg3, v2, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::query_types::new_asset_borrow(arg1, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(*0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::reserve::debt<T0>(v1)), arg3, v2, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::reserve::calculate_borrow_index<T0>(v1, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::interest::calc_interest(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::asset::interest_model<T0>(v0), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::reserve::util_rate<T0>(v1)), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::value::clock_now(arg4))),
        }
    }

    public fun get_asset_detail_no_price<T0>(arg0: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::zero(), arg3)
    }

    // decompiled from Move bytecode v6
}

