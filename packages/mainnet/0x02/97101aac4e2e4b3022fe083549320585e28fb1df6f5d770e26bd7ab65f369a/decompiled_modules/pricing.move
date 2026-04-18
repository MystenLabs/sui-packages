module 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing {
    struct PriceState has copy, drop, store {
        premium_ppm: u64,
        sale_count: u64,
    }

    public fun hierarchy_pool_for_price(arg0: u64) : u64 {
        arg0 - seller_proceeds_for_price(arg0) - treasury_fee_for_price(arg0)
    }

    public(friend) fun new_price_state(arg0: u64, arg1: u64) : PriceState {
        PriceState{
            premium_ppm : arg0,
            sale_count  : arg1,
        }
    }

    public fun next_resale_premium_ppm(arg0: u64, arg1: u64) : u64 {
        let v0 = vector[2950000, 2183829, 1897439, 1743779, 1646703, 1579291, 1529485, 1491036, 1460369, 1435281, 1414337, 1396563, 1381269, 1367957, 1356253, 1345874, 1336601, 1328260, 1320714, 1313851, 1307579, 1301822, 1296518, 1291613, 1287063, 1282829, 1278879, 1275183, 1271718, 1268461, 1265394, 1262500, 1259764, 1257174, 1254717, 1252384, 1250164, 1248050, 1246033, 1244108, 1242267, 1240505, 1238817, 1237199, 1235645, 1234152, 1232717, 1231335, 1230005, 1228722, 1227485, 1226290, 1225137, 1224021, 1222943, 1221899, 1220888, 1219909, 1218959, 1218038, 1217144, 1216276, 1215433, 1214614];
        let v1 = if (arg1 < 64) {
            *0x1::vector::borrow<u64>(&v0, arg1)
        } else {
            1150000
        };
        let v2 = (arg0 as u128) * (v1 as u128) / 1000000;
        if (v2 > (4900000000 as u128)) {
            4900000000
        } else {
            (v2 as u64)
        }
    }

    public fun post_registration_premium_ppm() : u64 {
        next_resale_premium_ppm(1000000, 0)
    }

    public(friend) fun premium_ppm(arg0: &PriceState) : u64 {
        arg0.premium_ppm
    }

    public fun prev_resale_premium_ppm(arg0: u64, arg1: u64) : u64 {
        let v0 = vector[2950000, 2183829, 1897439, 1743779, 1646703, 1579291, 1529485, 1491036, 1460369, 1435281, 1414337, 1396563, 1381269, 1367957, 1356253, 1345874, 1336601, 1328260, 1320714, 1313851, 1307579, 1301822, 1296518, 1291613, 1287063, 1282829, 1278879, 1275183, 1271718, 1268461, 1265394, 1262500, 1259764, 1257174, 1254717, 1252384, 1250164, 1248050, 1246033, 1244108, 1242267, 1240505, 1238817, 1237199, 1235645, 1234152, 1232717, 1231335, 1230005, 1228722, 1227485, 1226290, 1225137, 1224021, 1222943, 1221899, 1220888, 1219909, 1218959, 1218038, 1217144, 1216276, 1215433, 1214614];
        let v1 = if (arg1 - 1 < 64) {
            *0x1::vector::borrow<u64>(&v0, arg1 - 1)
        } else {
            1150000
        };
        (((arg0 as u128) * 1000000 / (v1 as u128)) as u64)
    }

    public fun quote_price_from_premium(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        let v1 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 == 0 || v1 <= 340282366920938463463374607431768211455 / v0, 3119);
        let v2 = v1 * v0 / 1000000000000;
        assert!(v2 <= 18446744073709551615, 3119);
        (v2 as u64)
    }

    public(friend) fun sale_count(arg0: &PriceState) : u64 {
        arg0.sale_count
    }

    public fun seller_proceeds_for_price(arg0: u64) : u64 {
        (((arg0 as u128) * (85 as u128) / 100) as u64)
    }

    public(friend) fun set_premium_ppm(arg0: &mut PriceState, arg1: u64) {
        arg0.premium_ppm = arg1;
    }

    public(friend) fun set_sale_count(arg0: &mut PriceState, arg1: u64) {
        arg0.sale_count = arg1;
    }

    public fun treasury_fee_for_price(arg0: u64) : u64 {
        (((arg0 as u128) * (7 as u128) / 100) as u64)
    }

    // decompiled from Move bytecode v7
}

