module 0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::interest::InterestModel,
        utilization_rate: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        collateral_setting: 0x1::option::Option<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        deposit_rate_limit: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::limiter::RateLimitUsage,
        borrow_rate_limit: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::limiter::RateLimitUsage,
        asset_setting: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::BorrowConfig,
        deposit_usage: 0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::AssetDeposit,
        borrow_usage: 0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::AssetBorrow,
    }

    struct MarketData has copy, drop {
        assets: vector<AssetData>,
    }

    public fun get_asset_detail<T0>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::value::get_price(arg3, arg1, arg4);
        let v3 = 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, arg1);
        let v4 = 0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::new_asset_borrow(arg1, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(*0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::reserve::debt<T0>(v1)), v2, v3, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::borrow_index::value(0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::reserve::borrow_index<T0>(v1)));
        let (v5, v6) = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::rate_limit_usage<T0>(arg0, arg1, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::value::clock_now(arg4));
        let v7 = if (0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::can_be_collateral<T0>(v0)) {
            0x1::option::some<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>(*0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::collateral_setting<T0>(v0))
        } else {
            0x1::option::none<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>()
        };
        AssetData{
            coin_type          : arg1,
            interest_model     : *0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::interest_model<T0>(v0),
            utilization_rate   : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::reserve::util_rate<T0>(v1),
            collateral_setting : v7,
            borrow_paused      : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::flash_loan_paused<T0>(v0),
            reserve            : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::reserve::protocol_reserve<T0>(v1),
            deposit_rate_limit : v5,
            borrow_rate_limit  : v6,
            asset_setting      : *0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::borrow_setting<T0>(v0),
            deposit_usage      : 0x9f55cb1ee0f04dcdaa5bf75691a466bf72ce4d45a374afddcc81fa843472759::types::new_asset_deposit(arg1, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::can_be_collateral<T0>(v0), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), v2, v3, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : v4,
        }
    }

    public fun get_market_detail<T0>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg1: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg3: &0x2::clock::Clock) : MarketData {
        let v0 = 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::supported_assets<T0>(arg0);
        let v1 = 0x1::vector::empty<AssetData>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            0x1::vector::push_back<AssetData>(&mut v1, get_asset_detail<T0>(arg0, *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2), arg1, arg2, arg3));
            v2 = v2 + 1;
        };
        MarketData{assets: v1}
    }

    // decompiled from Move bytecode v6
}

