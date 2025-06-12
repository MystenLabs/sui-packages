module 0x22156d837ae9e4d3f97fae24083cbe0c9b1edd09ca90a800f76be2414fb19383::scallop_provider {
    struct ScallopProvider has drop {
        dummy_field: bool,
    }

    fun price_feed_from_scallop_balance_sheet(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed {
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::new(0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::new(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u128::mul_div(100000000, (arg0 as u128) + (arg1 as u128) - (arg2 as u128), (arg3 as u128)), 8, true), 0x2::clock::timestamp_ms(arg4) / 1000, 0)
    }

    public fun update_scallop_as_primary<T0>(arg0: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::XOracle, arg1: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::UpdatePriceRequest, arg2: &0x2::clock::Clock, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg3)), 0x1::type_name::get<T0>()));
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::update_price_feed_as_primary<T0, ScallopProvider>(arg0, arg1, price_feed_from_scallop_balance_sheet(v0, v1, v2, v3, arg2), arg2);
    }

    public fun update_scallop_as_secondary<T0>(arg0: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::XOracle, arg1: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::UpdatePriceRequest, arg2: &0x2::clock::Clock, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg3)), 0x1::type_name::get<T0>()));
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::update_price_feed_as_secondary<T0, ScallopProvider>(arg0, arg1, price_feed_from_scallop_balance_sheet(v0, v1, v2, v3, arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

