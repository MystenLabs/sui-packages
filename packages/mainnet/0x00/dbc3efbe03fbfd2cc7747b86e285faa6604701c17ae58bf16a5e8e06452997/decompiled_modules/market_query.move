module 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::interest::InterestModel,
        utilization_rate: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset::AssetConfig,
        deposit_usage: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::query_types::AssetDeposit,
        borrow_usage: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::query_types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x82b78a855db4069292c5c88118121d52c47c536b08cfbc982df030f6f2d4a538::x_oracle::XOracle, arg5: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0x82b78a855db4069292c5c88118121d52c47c536b08cfbc982df030f6f2d4a538::user_oracle::get_price(arg4, arg2, 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode::get_oracle_base_token(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode::borrow_emode_group(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::emode_registry<T0>(arg0), arg1)), arg5), arg5)
    }

    fun get_asset_detail_inner<T0>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::coin_decimals_registry::CoinDecimalsRegistry, arg4: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal, arg5: &0x2::clock::Clock) : AssetData {
        let v0 = 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::asset_by_type<T0>(arg0, arg2);
        let v1 = 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::reserve_by_type<T0>(arg0, arg2);
        let v2 = 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::coin_decimals_registry::decimals(arg3, arg2);
        AssetData{
            coin_type          : arg2,
            interest_model     : *0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset::interest_model<T0>(v0),
            utilization_rate   : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::reserve::util_rate<T0>(v1),
            borrow_paused      : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset::flash_loan_paused<T0>(v0),
            reserve            : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset::asset_config<T0>(v0),
            deposit_usage      : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::query_types::new_asset_deposit(arg2, false, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::floor(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), arg4, v2, 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::query_types::new_asset_borrow(arg2, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::floor(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode::borrow_amount(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode::borrow_emode_group(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::emode_registry<T0>(arg0), arg1), arg2)), arg4, v2, 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::reserve::calculate_borrow_index<T0>(v1, 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::interest::calc_interest(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::asset::interest_model<T0>(v0), 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::reserve::util_rate<T0>(v1)), 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::value::clock_now(arg5))),
        }
    }

    public fun get_asset_detail_no_price<T0>(arg0: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::zero(), arg4)
    }

    // decompiled from Move bytecode v6
}

