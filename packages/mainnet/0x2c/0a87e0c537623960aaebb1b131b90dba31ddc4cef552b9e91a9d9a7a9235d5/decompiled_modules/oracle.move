module 0x2c0a87e0c537623960aaebb1b131b90dba31ddc4cef552b9e91a9d9a7a9235d5::oracle {
    struct PriceOracle {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>,
    }

    public fun new_price_oracle(arg0: &mut 0x2::tx_context::TxContext) : PriceOracle {
        PriceOracle{
            id     : 0x2::object::new(arg0),
            prices : 0x2::table::new<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(arg0),
        }
    }

    public fun update_cetus_pool_price<T0, T1>(arg0: &mut PriceOracle, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        let v1 = b"cetus";
        if (!0x2::table::contains<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(&arg0.prices, v1)) {
            0x2::table::add<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(&mut arg0.prices, v1, 0x2::table::new<0x2::object::ID, u128>(arg3));
        };
        let v2 = 0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(&mut arg0.prices, v1);
        if (0x2::table::contains<0x2::object::ID, u128>(v2, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, u128>(v2, v0) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        } else {
            0x2::table::add<0x2::object::ID, u128>(v2, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

