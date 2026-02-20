module 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::interest::InterestModel,
        utilization_rate: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset::AssetConfig,
        deposit_usage: 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::query_types::AssetDeposit,
        borrow_usage: 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::query_types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::x_oracle::XOracle, arg5: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::user_oracle::get_price(arg4, arg2, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::emode::get_oracle_base_token(0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::emode::borrow_emode_group(0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market::emode_registry<T0>(arg0), arg1)), arg5), arg5)
    }

    fun get_asset_detail_inner<T0>(arg0: &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::coin_decimals_registry::CoinDecimalsRegistry, arg4: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal, arg5: &0x2::clock::Clock) : AssetData {
        let v0 = 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market::asset_by_type<T0>(arg0, arg2);
        let v1 = 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market::reserve_by_type<T0>(arg0, arg2);
        let v2 = 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::coin_decimals_registry::decimals(arg3, arg2);
        AssetData{
            coin_type          : arg2,
            interest_model     : *0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset::interest_model<T0>(v0),
            utilization_rate   : 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::reserve::util_rate<T0>(v1),
            borrow_paused      : 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset::flash_loan_paused<T0>(v0),
            reserve            : 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset::asset_config<T0>(v0),
            deposit_usage      : 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::query_types::new_asset_deposit(arg2, false, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::floor(0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), arg4, v2, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::query_types::new_asset_borrow(arg2, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::floor(0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::emode::borrow_amount(0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::emode::borrow_emode_group(0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market::emode_registry<T0>(arg0), arg1), arg2)), arg4, v2, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::reserve::calculate_borrow_index<T0>(v1, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::interest::calc_interest(0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::asset::interest_model<T0>(v0), 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::reserve::util_rate<T0>(v1)), 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::value::clock_now(arg5))),
        }
    }

    public fun get_asset_detail_no_price<T0>(arg0: &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::zero(), arg4)
    }

    // decompiled from Move bytecode v6
}

