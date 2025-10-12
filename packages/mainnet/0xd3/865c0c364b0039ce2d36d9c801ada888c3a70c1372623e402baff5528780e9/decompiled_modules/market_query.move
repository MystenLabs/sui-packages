module 0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::interest::InterestModel,
        utilization_rate: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::asset::AssetConfig,
        deposit_usage: 0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::AssetDeposit,
        borrow_usage: 0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::value::get_price(arg3, arg1, arg4);
        let v3 = 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, arg1);
        AssetData{
            coin_type          : arg1,
            interest_model     : *0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::asset::interest_model<T0>(v0),
            utilization_rate   : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::util_rate<T0>(v1),
            borrow_paused      : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::asset::flash_loan_paused<T0>(v0),
            reserve            : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::asset::asset_config<T0>(v0),
            deposit_usage      : 0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::new_asset_deposit(arg1, false, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), v2, v3, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0xd3865c0c364b0039ce2d36d9c801ada888c3a70c1372623e402baff5528780e9::types::new_asset_borrow(arg1, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(*0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::debt<T0>(v1)), v2, v3, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::calculate_borrow_index<T0>(v1, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::interest::calc_interest(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::asset::interest_model<T0>(v0), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::util_rate<T0>(v1)), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::value::clock_now(arg4))),
        }
    }

    // decompiled from Move bytecode v6
}

