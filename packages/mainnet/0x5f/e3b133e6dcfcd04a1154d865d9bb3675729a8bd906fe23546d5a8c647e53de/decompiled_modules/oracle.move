module 0x5fe3b133e6dcfcd04a1154d865d9bb3675729a8bd906fe23546d5a8c647e53de::oracle {
    struct PriceVoucher<phantom T0: drop> {
        underlying_price: u64,
        epoch: u64,
    }

    public fun get_price<T0: drop>(arg0: PriceVoucher<T0>, arg1: &0x2::tx_context::TxContext) : u64 {
        let PriceVoucher {
            underlying_price : v0,
            epoch            : v1,
        } = arg0;
        assert!(v1 == 0x2::tx_context::epoch(arg1), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::invalid_epoch());
        v0
    }

    public entry fun get_price_from_oracle<T0: drop>(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u64 {
        0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg0, 0x1::type_name::get<T0>(), arg1))
    }

    public fun get_price_voucher_from_x_oracle<T0: drop, T1: drop>(arg0: &0x5fe3b133e6dcfcd04a1154d865d9bb3675729a8bd906fe23546d5a8c647e53de::sy::State, arg1: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : PriceVoucher<T0> {
        assert!(0x5fe3b133e6dcfcd04a1154d865d9bb3675729a8bd906fe23546d5a8c647e53de::sy::is_sy_bind<T1, T0>(arg0), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::sy_not_supported());
        PriceVoucher<T0>{
            underlying_price : 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg1, 0x1::type_name::get<T1>(), arg2)),
            epoch            : 0x2::tx_context::epoch(arg3),
        }
    }

    // decompiled from Move bytecode v6
}

