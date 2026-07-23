module 0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::logic_getter_unchecked {
    public fun calculate_avg_ltv(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let v7 = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_asset_ltv(arg2, *v6);
            let v8 = user_collateral_value(arg0, arg1, arg2, *v6, arg3);
            v4 = v4 + v8;
            v5 = v5 + 0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_mul(v7, v8);
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_div(v5, v4)
        };
        0
    }

    public fun calculate_avg_threshold(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let (_, _, v9) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_liquidation_factors(arg2, *v6);
            let v10 = user_collateral_value(arg0, arg1, arg2, *v6, arg3);
            v4 = v4 + v10;
            v5 = v5 + 0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_mul(v9, v10);
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_div(v5, v4)
        };
        0
    }

    public fun dynamic_liquidation_threshold(arg0: &0x2::clock::Clock, arg1: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg2: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg3: address) : u256 {
        let (v0, _) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_user_assets(arg1, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let (_, _, v9) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_liquidation_factors(arg1, *v6);
            let v10 = user_collateral_value(arg0, arg2, arg1, *v6, arg3);
            v5 = v5 + 0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_mul(v10, v9);
            v4 = v4 + v10;
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_div(v5, v4)
        };
        0
    }

    public fun is_collateral(arg0: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg1: u8, arg2: address) : bool {
        let (v0, _) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_user_assets(arg0, arg2);
        let v2 = v0;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public fun is_health(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: address) : bool {
        user_health_factor(arg0, arg2, arg1, arg3) >= 0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray()
    }

    public fun is_loan(arg0: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg1: u8, arg2: address) : bool {
        let (_, v1) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_user_assets(arg0, arg2);
        let v2 = v1;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public fun user_collateral_balance(arg0: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (v0, _) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_user_balance(arg0, arg1, arg2);
        let (v2, _) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_index(arg0, arg1);
        0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_mul(v0, v2)
    }

    public fun user_collateral_value(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: u8, arg4: address) : u256 {
        let v0 = user_collateral_balance(arg2, arg3, arg4);
        0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::unchecked_calculator::calculate_value(arg0, arg1, v0, 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_oracle_id(arg2, arg3))
    }

    public fun user_health_collateral_value(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + user_collateral_value(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&v2, v4), arg3);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_health_factor(arg0: &0x2::clock::Clock, arg1: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg2: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg3: address) : u256 {
        let v0 = user_health_collateral_value(arg0, arg2, arg1, arg3);
        let v1 = dynamic_liquidation_threshold(arg0, arg1, arg2, arg3);
        let v2 = user_health_loan_value(arg0, arg2, arg1, arg3);
        if (v2 > 0) {
            0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_mul(0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_div(v0, v2), v1)
        } else {
            0x2::address::max()
        }
    }

    public fun user_health_factor_batch(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: vector<address>) : vector<u256> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u256>();
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            0x1::vector::push_back<u256>(&mut v1, user_health_factor(arg0, arg2, arg1, *0x1::vector::borrow<address>(&arg3, v0)));
            v0 = v0 + 1;
        };
        v1
    }

    public fun user_health_loan_value(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: address) : u256 {
        let (_, v1) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_user_assets(arg2, arg3);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + user_loan_value(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&v2, v4), arg3);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_loan_balance(arg0: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (_, v1) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_user_balance(arg0, arg1, arg2);
        let (_, v3) = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_index(arg0, arg1);
        0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::ray_math::ray_mul(v1, v3)
    }

    public fun user_loan_value(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: u8, arg4: address) : u256 {
        let v0 = user_loan_balance(arg2, arg3, arg4);
        0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::unchecked_calculator::calculate_value(arg0, arg1, v0, 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::get_oracle_id(arg2, arg3))
    }

    // decompiled from Move bytecode v7
}

