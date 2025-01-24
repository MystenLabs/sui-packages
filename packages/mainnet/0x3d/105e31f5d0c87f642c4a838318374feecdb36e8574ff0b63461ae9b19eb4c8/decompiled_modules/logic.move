module 0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::logic {
    public fun calculate_avg_ltv(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let v7 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg2, *v6);
            let v8 = user_collateral_value(arg0, arg1, arg2, *v6, arg3);
            v4 = v4 + v8;
            v5 = v5 + 0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_mul(v7, v8);
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_div(v5, v4)
        };
        0
    }

    public fun calculate_avg_threshold(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let (_, _, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, *v6);
            let v10 = user_collateral_value(arg0, arg1, arg2, *v6, arg3);
            v4 = v4 + v10;
            v5 = v5 + 0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_mul(v9, v10);
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_div(v5, v4)
        };
        0
    }

    public fun dynamic_liquidation_threshold(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg1, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v6 = 0x1::vector::borrow<u8>(&v2, v3);
            let (_, _, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg1, *v6);
            let v10 = user_collateral_value(arg0, arg2, arg1, *v6, arg3);
            v5 = v5 + 0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_mul(v10, v9);
            v4 = v4 + v10;
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            return 0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_div(v5, v4)
        };
        0
    }

    public fun is_collateral(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) : bool {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg2);
        let v2 = v0;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public fun is_health(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : bool {
        user_health_factor(arg0, arg2, arg1, arg3) >= 0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray()
    }

    public fun is_loan(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) : bool {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg2);
        let v2 = v1;
        0x1::vector::contains<u8>(&v2, &arg1)
    }

    public fun user_collateral_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_mul(v0, v2)
    }

    public fun user_collateral_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: address) : u256 {
        let v0 = user_collateral_balance(arg2, arg3, arg4);
        0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::unchecked_calculator::calculate_value(arg0, arg1, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, arg3))
    }

    public fun user_health_collateral_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + user_collateral_value(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&v2, v4), arg3);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_health_factor(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address) : u256 {
        let v0 = user_health_collateral_value(arg0, arg2, arg1, arg3);
        let v1 = dynamic_liquidation_threshold(arg0, arg1, arg2, arg3);
        let v2 = user_health_loan_value(arg0, arg2, arg1, arg3);
        if (v2 > 0) {
            0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_mul(0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_div(v0, v2), v1)
        } else {
            0x2::address::max()
        }
    }

    public fun user_health_factor_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: vector<address>) : vector<u256> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u256>();
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            0x1::vector::push_back<u256>(&mut v1, user_health_factor(arg0, arg2, arg1, *0x1::vector::borrow<address>(&arg3, v0)));
            v0 = v0 + 1;
        };
        v1
    }

    public fun user_health_loan_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u256 {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + user_loan_value(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&v2, v4), arg3);
            v4 = v4 + 1;
        };
        v3
    }

    public fun user_loan_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) : u256 {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        let (_, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::ray_math::ray_mul(v1, v3)
    }

    public fun user_loan_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: address) : u256 {
        let v0 = user_loan_balance(arg2, arg3, arg4);
        0x3d105e31f5d0c87f642c4a838318374feecdb36e8574ff0b63461ae9b19eb4c8::unchecked_calculator::calculate_value(arg0, arg1, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, arg3))
    }

    // decompiled from Move bytecode v6
}

