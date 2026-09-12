module 0x74dcf2c659a053722da6d3693032a49e933668a10b34ba6d9183a5ebe6499c26::reader {
    public fun current<T0>(arg0: &0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg3: bool) : (u8, u8, u64, u64, bool, bool) {
        let v0 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::decimal<T0>(arg0);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::aggregated_price<T0>(arg2));
        let v2 = v1 > 0 && (v1 >= 1000000000 && v1 - 1000000000 <= 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::price_tolerance<T0>(arg0)) || 1000000000 - v1 <= 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::price_tolerance<T0>(arg0)));
        let v3 = 0x1::type_name::get<0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>();
        let v4 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::module_config_map(arg1);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::ModuleConfig>(v4, &v3)) {
            return (0, 0, 0, 0, false, false)
        };
        let v5 = 0x2::vec_map::get<0x1::type_name::TypeName, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::ModuleConfig>(v4, &v3);
        let v6 = 2;
        if (!0x2::vec_set::contains<u16>(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::valid_versions(v5), &v6)) {
            return (0, 0, 0, 0, false, false)
        };
        let v7 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::limited_supply(v5);
        let v8 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::supply(v7);
        let v9 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::limit(v7);
        if (v8 > v9) {
            return (0, 0, 0, 0, false, false)
        };
        let v10 = if (arg3) {
            0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in_fee_rate<T0>(arg0, 0x1::option::none<address>())
        } else {
            0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out_fee_rate<T0>(arg0, 0x1::option::none<address>())
        };
        let v11 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v10);
        let v12 = if (arg3) {
            source_capacity(v9 - v8, 6, v0)
        } else {
            let v13 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::usdb_supply<T0>(arg0);
            let v14 = source_capacity(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::balance<T0>(arg0), v0, 6);
            let v15 = if (v13 < v8) {
                v13
            } else {
                v8
            };
            if (v15 < v14) {
                v15
            } else {
                v14
            }
        };
        let v16 = if (arg3) {
            v0
        } else {
            6
        };
        let v17 = if (arg3) {
            6
        } else {
            v0
        };
        let v18 = if (v11 <= 1000000000) {
            (v11 as u64)
        } else {
            0
        };
        (v16, v17, v18, v12, v11 <= 1000000000, v2)
    }

    fun source_capacity(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg2 == arg1) {
            return arg0
        };
        let v0 = 1;
        let v1 = 0;
        let v2 = if (arg2 > arg1) {
            arg2 - arg1
        } else {
            arg1 - arg2
        };
        while (v1 < v2) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        let v3 = if (arg2 > arg1) {
            ((arg0 as u128) + 1) * v0 - 1
        } else {
            (arg0 as u128) / v0
        };
        if (v3 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v3 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

