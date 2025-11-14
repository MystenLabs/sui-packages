module 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::interest::InterestModel,
        utilization_rate: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::asset::AssetConfig,
        deposit_usage: 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::query_types::AssetDeposit,
        borrow_usage: 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::query_types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::x_oracle::XOracle, arg5: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg2, arg3, 0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::user_oracle::get_price(arg4, arg2, 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::emode::get_oracle_base_token(0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::emode::borrow_emode_group(0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::emode_registry<T0>(arg0), arg1)), arg5), arg5)
    }

    fun get_asset_detail_inner<T0>(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry, arg3: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::decimals(arg2, arg1);
        AssetData{
            coin_type          : arg1,
            interest_model     : *0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::asset::interest_model<T0>(v0),
            utilization_rate   : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::reserve::util_rate<T0>(v1),
            borrow_paused      : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::asset::flash_loan_paused<T0>(v0),
            reserve            : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::asset::asset_config<T0>(v0),
            deposit_usage      : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::query_types::new_asset_deposit(arg1, false, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::floor(0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), arg3, v2, 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::query_types::new_asset_borrow(arg1, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::floor(*0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::reserve::debt<T0>(v1)), arg3, v2, 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::reserve::calculate_borrow_index<T0>(v1, 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::interest::calc_interest(0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::asset::interest_model<T0>(v0), 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::reserve::util_rate<T0>(v1)), 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::value::clock_now(arg4))),
        }
    }

    public fun get_asset_detail_no_price<T0>(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero(), arg3)
    }

    // decompiled from Move bytecode v6
}

