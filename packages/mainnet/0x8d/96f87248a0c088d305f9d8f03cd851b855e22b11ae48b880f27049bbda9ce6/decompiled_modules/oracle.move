module 0x8d96f87248a0c088d305f9d8f03cd851b855e22b11ae48b880f27049bbda9ce6::oracle {
    struct PriceVoucher<phantom T0: drop> {
        underlying_price: u128,
        epoch: u64,
    }

    fun calc_scoin_to_coin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, v0 + v1 - v2, v3)
    }

    public fun get_price<T0: drop>(arg0: PriceVoucher<T0>, arg1: &0x2::tx_context::TxContext) : u128 {
        let PriceVoucher {
            underlying_price : v0,
            epoch            : v1,
        } = arg0;
        assert!(v1 == 0x2::tx_context::epoch(arg1), 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::invalid_epoch());
        v0
    }

    public fun get_price_voucher_from_x_oracle<T0: drop, T1: drop>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x8d96f87248a0c088d305f9d8f03cd851b855e22b11ae48b880f27049bbda9ce6::sy::State, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : PriceVoucher<T0> {
        assert!(0x8d96f87248a0c088d305f9d8f03cd851b855e22b11ae48b880f27049bbda9ce6::sy::is_sy_bind_with_underlying_token<T1, T0>(arg2), 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::sy_not_supported());
        let v0 = 1000000000;
        PriceVoucher<T0>{
            underlying_price : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_rational((calc_scoin_to_coin(arg0, arg1, 0x1::type_name::get<T1>(), arg3, v0) as u128), (v0 as u128))),
            epoch            : 0x2::tx_context::epoch(arg4),
        }
    }

    fun get_reserve_stats(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), arg2))
    }

    // decompiled from Move bytecode v6
}

