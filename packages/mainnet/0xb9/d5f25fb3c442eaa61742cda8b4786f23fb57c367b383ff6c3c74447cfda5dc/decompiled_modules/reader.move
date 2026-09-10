module 0xb9d5f25fb3c442eaa61742cda8b4786f23fb57c367b383ff6c3c74447cfda5dc::reader {
    fun accrue(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : (u128, u128, u128, bool) {
        let v0 = if (arg5 == 0) {
            true
        } else if (arg6 == 0) {
            true
        } else if (arg8 < arg7) {
            true
        } else {
            arg8 - arg7 > 4294967295
        };
        if (v0) {
            return (0, 0, 0, false)
        };
        let v1 = (arg6 as u256) + (arg6 as u256) * ((arg8 - arg7) as u256) * (arg4 as u256) / (4294967296 as u256) / (arg5 as u256);
        if (v1 > (18446744073709551615 as u256)) {
            return (0, 0, 0, false)
        };
        let v2 = (arg1 as u256) * (v1 * (4294967296 as u256) / (arg6 as u256) - (4294967296 as u256)) / (4294967296 as u256);
        let v3 = (arg1 as u256) + v2;
        let v4 = (arg2 as u256) + v2 * (arg9 as u256) / (4294967296 as u256);
        let v5 = if (v3 > (18446744073709551615 as u256)) {
            true
        } else if (v4 > (18446744073709551615 as u256)) {
            true
        } else if ((arg0 as u256) + v3 > (18446744073709551615 as u256)) {
            true
        } else {
            v4 > (arg0 as u256) + v3
        };
        if (v5) {
            return (0, 0, 0, false)
        };
        let v6 = (((arg0 as u256) + v3 - v4) as u128);
        let v7 = if (arg3 == 0) {
            1000000000000000000
        } else {
            v6 * 1000000000000000000 / (arg3 as u128)
        };
        (v7, (v4 as u128), v6, v7 > 0)
    }

    public fun current<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: bool, arg5: &0x2::tx_context::TxContext) : (u128, u128, u64, bool) {
        let v0 = 0x1::type_name::get<0x2::sui::SUI>();
        let v1 = if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::value(arg0) != 9) {
            true
        } else if (!0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg1), 0x2::tx_context::sender(arg5))) {
            true
        } else {
            arg4 && !0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::is_base_asset_active(arg1, v0)
        };
        if (v1) {
            return (0, 1, 0, false)
        };
        let (v2, v3, v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), v0));
        let v6 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::BorrowDynamic>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::borrow_dynamics(arg1), v0);
        let (v7, v8, v9, v10) = accrue(v2, v3, v4, v5, 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::interest_rate(v6)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::interest_rate_scale(v6), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::borrow_index(v6), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::last_updated(v6), 0x2::clock::timestamp_ms(arg3) / 1000, 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::revenue_factor(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::interest_model(arg1, v0))));
        if (!v10) {
            return (0, 1, 0, false)
        };
        let v11 = 0x1::bcs::to_bytes<0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>>(arg2);
        assert!(0x1::vector::length<u8>(&v11) == 48, 1);
        let v12 = if (arg4) {
            let v13 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::supply_limit_key(v0);
            if (!0x2::dynamic_field::exists_<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::SupplyLimitKey>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg1), v13)) {
                return (0, 1, 0, false)
            };
            let v14 = *0x2::dynamic_field::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::SupplyLimitKey, u64>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg1), v13);
            if ((v14 as u128) <= v9) {
                return (1000000000000000000, v7, 0, false)
            };
            (0x1::u128::min(0x1::u128::min(0x1::u128::min((v14 as u128) - v9, 18446744073709551615 - (v2 as u128)), (0x1::u256::min((0x1::u128::min(0x1::u128::min(18446744073709551615 - (v5 as u128), 18446744073709551615 - (0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::total_supply<T0, 0x2::sui::SUI>(arg2) as u128)), 18446744073709551615 - (u64_at(&v11, 40) as u128)) as u256) * (v7 as u256) / (1000000000000000000 as u256), (18446744073709551615 as u256)) as u128)), 18446744073709551615) as u64)
        } else {
            if ((v2 as u128) < v8) {
                return (v7, 1000000000000000000, 0, false)
            };
            (0x1::u128::min(0x1::u128::min(0x1::u128::min(((v2 as u128) - v8) * 1000000000000000000 / v7, (v5 as u128)), (0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::total_supply<T0, 0x2::sui::SUI>(arg2) as u128)), (u64_at(&v11, 40) as u128)) as u64)
        };
        let (v15, v16, v17) = if (arg4) {
            (1000000000000000000, v7, v12 > 0)
        } else {
            (v7, 1000000000000000000, v12 > 0)
        };
        (v15, v16, v12, v17)
    }

    fun u64_at(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << ((v1 * 8) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

