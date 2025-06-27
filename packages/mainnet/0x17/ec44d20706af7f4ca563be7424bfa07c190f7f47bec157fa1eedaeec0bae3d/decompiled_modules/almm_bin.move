module 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_bin {
    struct Bin has copy, drop, store {
        storage_id: u32,
        price_q128: u256,
        reserve_x: u64,
        reserve_y: u64,
        staked_liquidity: u256,
        staked_lp_amount: u64,
        fee_x: u64,
        fee_y: u64,
        fee_growth_x: u256,
        fee_growth_y: u256,
        rewarder_growth: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        distribution_growth: u256,
        distribution_last_updated: u64,
    }

    public(friend) fun accumulate_fees(arg0: &mut Bin, arg1: u64, arg2: bool) {
        if (arg1 == 0 || get_liquidity(arg0.reserve_x, arg0.reserve_y, arg0.price_q128) == 0) {
            return
        };
        if (arg2) {
            arg0.fee_x = arg0.fee_x + arg1;
        } else {
            arg0.fee_y = arg0.fee_y + arg1;
        };
    }

    public(friend) fun add_reserves(arg0: &mut Bin, arg1: u64, arg2: u64) {
        arg0.reserve_x = arg0.reserve_x + arg1;
        arg0.reserve_y = arg0.reserve_y + arg2;
    }

    public(friend) fun borrow_rewarders(arg0: &Bin) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u256> {
        &arg0.rewarder_growth
    }

    public fun distribution_growth(arg0: &Bin) : u256 {
        arg0.distribution_growth
    }

    public fun distribution_last_updated(arg0: &Bin) : u64 {
        arg0.distribution_last_updated
    }

    public(friend) fun download_rewarders(arg0: &mut Bin, arg1: &0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::RewarderManager) {
        let v0 = 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::borrow_rewarders(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(v0)) {
            let v2 = 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::reward_coin(0x1::vector::borrow<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(v0, v1));
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.rewarder_growth, &v2)) {
                let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u256>(&mut arg0.rewarder_growth, &v2);
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.rewarder_growth, v2, 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::growth_global(0x1::vector::borrow<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(v0, v1)));
            v1 = v1 + 1;
        };
    }

    public fun fee_growth_x(arg0: &Bin) : u256 {
        arg0.fee_growth_x
    }

    public fun fee_growth_y(arg0: &Bin) : u256 {
        arg0.fee_growth_y
    }

    public fun fee_x(arg0: &Bin) : u64 {
        arg0.fee_x
    }

    public fun fee_y(arg0: &Bin) : u64 {
        arg0.fee_y
    }

    public fun get_amount_out_of_bin(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        if (arg0 > 0) {
            v0 = 0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::full_math_u64::mul_div_floor(arg2, arg0, arg3);
        };
        if (arg1 > 0) {
            v1 = 0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::full_math_u64::mul_div_floor(arg2, arg1, arg3);
        };
        (v0, v1)
    }

    public fun get_amounts(arg0: u64, arg1: u64, arg2: u16, arg3: u64, arg4: bool, arg5: u32, arg6: u64) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_price::get_price_from_storage_id(arg5, arg2);
        let v1 = if (arg4) {
            arg1
        } else {
            arg0
        };
        let v2 = if (arg4) {
            0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64(0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::u128x128::to_u128x128((v1 as u128), 0) / v0)
        } else {
            let (v3, _) = 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::u128x128::from_u128x128((v1 as u256) * v0);
            0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((v3 as u256))
        };
        let v5 = 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_fee::get_fee_amount(v2, arg3);
        let v6 = v2 + v5;
        let (v7, v8, v9) = if (arg6 >= v6) {
            (v5, v6, v1)
        } else {
            let v10 = 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_fee::get_fee_amount_from(arg6, arg3);
            let v11 = if (arg4) {
                let (v12, _) = 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::u128x128::from_u128x128(((arg6 - v10) as u256) * v0);
                0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((v12 as u256))
            } else {
                0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64(0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::u128x128::to_u128x128(((arg6 - v10) as u128), 0) / v0)
            };
            let v14 = v11;
            if (v11 > v1) {
                v14 = v1;
            };
            (v10, arg6, v14)
        };
        let (v15, v16, v17, v18, v19, v20) = if (arg4) {
            assert!(get_liquidity(arg0 + v8, arg1 - v9, v0) <= 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::max_liquidity_per_bin(), 2);
            (v9, v7, 0, v8, 0, 0)
        } else {
            assert!(get_liquidity(arg0 - v9, arg1 + v8, v0) <= 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::max_liquidity_per_bin(), 2);
            (0, 0, v7, 0, v8, v9)
        };
        (v18, v19, v20, v15, v16, v17)
    }

    public fun get_composition_fees(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let (v0, v1) = get_amount_out_of_bin(arg0 + arg2, arg1 + arg3, arg5, arg4 + arg5);
        if (v0 > arg2) {
            return (0, 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_fee::get_composition_fee(arg3 - v1, arg6) as u256)))
        };
        if (v1 > arg3) {
            return (0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_fee::get_composition_fee(arg2 - v0, arg6) as u256)), 0)
        };
        (0, 0)
    }

    public fun get_liquidity(arg0: u64, arg1: u64, arg2: u256) : u256 {
        let v0 = 0;
        if (arg0 > 0) {
            let v1 = arg2 * (arg0 as u256);
            v0 = v1;
            assert!(v1 / (arg0 as u256) == arg2, 1);
        };
        if (arg1 > 0) {
            let v2 = (arg1 as u256) << 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::scale_offset();
            let v3 = v0 + v2;
            v0 = v3;
            assert!(v3 >= v2, 1);
        };
        v0
    }

    public fun get_shares_and_effective_amounts_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u256, arg5: u64) : (u64, u64, u64) {
        let v0 = get_liquidity(arg2, arg3, arg4);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = get_liquidity(arg0, arg1, arg4);
        if (v1 == 0 || arg5 == 0) {
            return (0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64(v0 / 2 >> 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::scale_offset()), arg2, arg3)
        };
        let v2 = v0 * (arg5 as u256) / v1;
        let v3 = v2 * v1 / (arg5 as u256);
        let (v4, v5) = if (v0 > v3) {
            let v6 = v0 - v3;
            let v7 = v6;
            let v8 = if (v6 > 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::scale()) {
                let v9 = v6 >> 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::scale_offset();
                let v10 = if (v9 > (arg3 as u256)) {
                    (arg3 as u256)
                } else {
                    v9
                };
                v7 = v6 - ((v10 as u256) << 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::scale_offset());
                (arg3 as u256) - v10
            } else {
                (arg3 as u256)
            };
            let v11 = if (v7 > arg4) {
                let v12 = v7 / arg4;
                let v13 = if (v12 > (arg2 as u256)) {
                    (arg2 as u256)
                } else {
                    v12
                };
                (arg2 as u256) - v13
            } else {
                (arg2 as u256)
            };
            (0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64(v11), 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64(v8))
        } else {
            (arg2, arg3)
        };
        assert!(get_liquidity(arg0 + v4, arg1 + v5, arg4) <= 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::max_liquidity_per_bin(), 2);
        (0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64(v2), v4, v5)
    }

    public(friend) fun grow_distribution(arg0: &mut Bin, arg1: u256, arg2: u64) {
        arg0.distribution_growth = arg0.distribution_growth + arg1;
        arg0.distribution_last_updated = arg2;
    }

    public fun grow_fee_x(arg0: &mut Bin, arg1: u256) {
        arg0.fee_growth_x = arg0.fee_growth_x + arg1;
    }

    public fun grow_fee_y(arg0: &mut Bin, arg1: u256) {
        arg0.fee_growth_y = arg0.fee_growth_y + arg1;
    }

    public fun is_empty(arg0: &Bin) : bool {
        arg0.reserve_x == 0 && arg0.reserve_y == 0
    }

    public fun liquidity(arg0: &Bin) : u256 {
        get_liquidity(arg0.reserve_x, arg0.reserve_y, arg0.price_q128)
    }

    public(friend) fun new(arg0: u32, arg1: u256, arg2: &vector<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>) : Bin {
        let v0 = if (0x1::vector::length<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(arg2) == 0) {
            0x2::vec_map::empty<0x1::type_name::TypeName, u256>()
        } else {
            let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(arg2)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v1, 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::reward_coin(0x1::vector::borrow<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(arg2, v2)), 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::growth_global(0x1::vector::borrow<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(arg2, v2)));
                v2 = v2 + 1;
            };
            v1
        };
        Bin{
            storage_id                : arg0,
            price_q128                : arg1,
            reserve_x                 : 0,
            reserve_y                 : 0,
            staked_liquidity          : 0,
            staked_lp_amount          : 0,
            fee_x                     : 0,
            fee_y                     : 0,
            fee_growth_x              : 0,
            fee_growth_y              : 0,
            rewarder_growth           : v0,
            distribution_growth       : 0,
            distribution_last_updated : 0,
        }
    }

    public fun price(arg0: &Bin) : u256 {
        arg0.price_q128
    }

    public fun reserve_x(arg0: &Bin) : u64 {
        arg0.reserve_x
    }

    public fun reserve_y(arg0: &Bin) : u64 {
        arg0.reserve_y
    }

    public fun rewarder_growth(arg0: &Bin, arg1: 0x1::type_name::TypeName) : u256 {
        *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.rewarder_growth, &arg1)
    }

    public(friend) fun set_distribution_last_updated(arg0: &mut Bin, arg1: u64) {
        arg0.distribution_last_updated = arg1;
    }

    public fun stake_liquidity(arg0: &mut Bin, arg1: u256) {
        arg0.staked_liquidity = arg0.staked_liquidity + arg1;
    }

    public fun staked_liquidity(arg0: &Bin) : u256 {
        arg0.staked_liquidity
    }

    public fun staked_lp_amount(arg0: &Bin) : u64 {
        arg0.staked_lp_amount
    }

    public fun storage_id(arg0: &Bin) : u32 {
        arg0.storage_id
    }

    public(friend) fun sub_reserves(arg0: &mut Bin, arg1: u64, arg2: u64) {
        arg0.reserve_x = arg0.reserve_x - arg1;
        arg0.reserve_y = arg0.reserve_y - arg2;
    }

    public fun unstake_liquidity(arg0: &mut Bin, arg1: u256) {
        arg0.staked_liquidity = arg0.staked_liquidity - arg1;
    }

    public(friend) fun upload_rewarders(arg0: &Bin, arg1: &mut 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::RewarderManager) {
        let v0 = 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::borrow_rewarders_mut(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(v0)) {
            let v2 = 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::reward_coin(0x1::vector::borrow<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(v0, v1));
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.rewarder_growth, &v2)) {
                0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::update_growth(0x1::vector::borrow_mut<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(v0, v1), *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.rewarder_growth, &v2));
            } else {
                0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::update_growth(0x1::vector::borrow_mut<0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_rewarder::Rewarder>(v0, v1), 0);
            };
            v1 = v1 + 1;
        };
    }

    public fun verify_amounts(arg0: u64, arg1: u64, arg2: u32, arg3: u32) {
        if (arg3 < arg2 && arg0 > 0) {
            abort 3
        };
        if (arg3 > arg2 && arg1 > 0) {
            abort 3
        };
    }

    // decompiled from Move bytecode v6
}

