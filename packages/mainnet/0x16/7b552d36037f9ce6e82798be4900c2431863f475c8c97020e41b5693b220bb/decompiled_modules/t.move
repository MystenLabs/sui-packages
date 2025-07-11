module 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::t {
    struct Buckets has store, key {
        id: 0x2::object::UID,
        buckets: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Bucket<phantom T0> has key {
        id: 0x2::object::UID,
        v: 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::Vault,
        treasury_id: 0x2::coin::TreasuryCap<T0>,
        reserve: 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::B,
        treasury_fees: 0x2::bag::Bag,
        pricing_kind: 0x1::option::Option<0x1::type_name::TypeName>,
        aum: u128,
        treasury_rate: u64,
    }

    struct FlashBorrow {
        clmm_id: 0x2::object::ID,
        borrow_type: 0x1::type_name::TypeName,
        borrow_amount: u64,
    }

    struct WithdrawBorrow {
        clmm_id: 0x2::object::ID,
        rewards_amounts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public fun add<T0, T1, T2>(arg0: &mut Bucket<T2>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::Tokens, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::pool_id(&arg0.v), 4039);
        let v0 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::get_price<T0>(arg2, arg5);
        let v1 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::get_price<T1>(arg2, arg5);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_value(&v0), 0x1::u64::pow(10, 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_factor()), 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_value(&v1));
        if (10000 * 0x1::u128::diff((v2 as u128), 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::sqrt_price_to_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4), 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_decimal(&v0), 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_decimal(&v1), 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_factor())) / (v2 as u128) > (0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::get_bps(arg1) as u128)) {
            return
        };
        let v3 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::take_all<T0>(&mut arg0.reserve);
        let v4 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::take_all<T1>(&mut arg0.reserve);
        let (_, _, _) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::add_liquidity<T0, T1>(&mut arg0.v, arg3, arg4, &mut v3, &mut v4, arg5);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T0>(&mut arg0.reserve, v3);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T1>(&mut arg0.reserve, v4);
    }

    public fun add_fund<T0, T1, T2>(arg0: &mut Bucket<T2>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::Tokens, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_user(arg1, 0x2::tx_context::sender(arg8));
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::coin::value<T1>(&arg6);
        assert!(v0 > 0 || v1 > 0, 4009);
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::get<T0>(), v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::get<T1>(), v1);
        let v3 = get_aum(arg2, &v2, arg0.pricing_kind, arg7);
        let v4 = 0x2::coin::total_supply<T2>(&arg0.treasury_id);
        let v5 = if (v4 == 0) {
            v3
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((v4 as u128), v3, arg0.aum)
        };
        assert!(v5 > 0, 4014);
        assert!(v5 < 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::max_u64() - 1 - (v4 as u128), 4015);
        let v6 = 0x2::coin::mint<T2>(&mut arg0.treasury_id, (v5 as u64), arg8);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg5));
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T1>(&mut arg0.reserve, 0x2::coin::into_balance<T1>(arg6));
        arg0.aum = arg0.aum + v3;
        add<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::send_coin<T2>(v6, 0x2::tx_context::sender(arg8));
    }

    fun add_treasury_fees<T0, T1>(arg0: &mut Bucket<T0>, arg1: &mut 0x2::balance::Balance<T1>) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::add_to_bag<T1>(&mut arg0.treasury_fees, 0x2::balance::split<T1>(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(0x2::balance::value<T1>(arg1), arg0.treasury_rate, 10000)));
    }

    public fun aum<T0, T1, T2>(arg0: &mut Bucket<T2>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::Tokens, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::pool_id(&arg0.v), 4006);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::valid_all_removed<T0, T1>(arg2, arg3, &arg0.v, arg4);
        let (v0, v1) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::amount_ab<T0, T1>(&arg0.v, arg3);
        let v2 = 0;
        let v3 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v4 = *0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::balances(&arg0.reserve);
        while (v2 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v4)) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v4, v2);
            let v7 = *v5;
            let v8 = *v6;
            let v9 = v8;
            if (0x1::type_name::get<T0>() == v7) {
                v9 = v8 + v0;
            } else if (0x1::type_name::get<T1>() == v7) {
                v9 = v8 + v1;
            };
            if (!0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::contain(arg1, v7) || v9 == 0) {
                v2 = v2 + 1;
                continue
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v3, v7, v9);
            v2 = v2 + 1;
        };
        arg0.aum = get_aum(arg1, &v3, arg0.pricing_kind, arg4);
    }

    public fun burn_borrow<T0, T1>(arg0: &mut Bucket<T0>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: FlashBorrow, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_keeper_role(arg1, 0x2::tx_context::sender(arg4));
        let FlashBorrow {
            clmm_id       : v0,
            borrow_type   : v1,
            borrow_amount : v2,
        } = arg2;
        assert!(0x1::type_name::get<T1>() == v1, 4031);
        assert!(0x2::coin::value<T1>(&arg3) >= v2, 4032);
        assert!(0x2::object::id<Bucket<T0>>(arg0) == v0, 4033);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T1>(&mut arg0.reserve, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun burn_withdraw_borrow<T0>(arg0: &mut Bucket<T0>, arg1: WithdrawBorrow) {
        let WithdrawBorrow {
            clmm_id         : v0,
            rewards_amounts : v1,
        } = arg1;
        let v2 = v1;
        assert!(v0 == 0x2::object::id<Bucket<T0>>(arg0), 4020);
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(&v2), 4021);
    }

    public fun create<T0, T1, T2>(arg0: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg1: &mut Buckets, arg2: 0x2::coin::TreasuryCap<T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: u32, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_admin(arg0, 0x2::tx_context::sender(arg9));
        assert!(0x2::coin::total_supply<T2>(&arg2) == 0, 4000);
        assert!(arg8 == 0 || arg8 == 1, 4001);
        let v0 = if (arg8 == 0) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>())
        } else if (arg8 == 1) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>())
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        };
        let v1 = Bucket<T2>{
            id            : 0x2::object::new(arg9),
            v             : 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::new<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg9),
            treasury_id   : arg2,
            reserve       : 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::new(arg9),
            treasury_fees : 0x2::bag::new(arg9),
            pricing_kind  : v0,
            aum           : 0,
            treasury_rate : 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::get_p(arg0),
        };
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T0>(&mut v1.reserve, 0x2::balance::zero<T0>());
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T1>(&mut v1.reserve, 0x2::balance::zero<T1>());
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.buckets, 0x2::object::id<Bucket<T2>>(&v1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
        0x2::transfer::share_object<Bucket<T2>>(v1);
    }

    public fun flash_borrow<T0, T1, T2>(arg0: &mut Bucket<T2>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::Tokens, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashBorrow) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_keeper_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(arg3 > 0, 4028);
        let v0 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::get_price<T0>(arg2, arg4);
        let v1 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::get_price<T1>(arg2, arg4);
        let (v2, _) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::get_prices(&v0, &v1);
        let _ = 0x1::type_name::get<T0>();
        let v5 = 0x1::type_name::get<T1>();
        let (v6, v7) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::coin_types(&arg0.v);
        assert!(v5 == v6 || v5 == v7, 4029);
        let v8 = FlashBorrow{
            clmm_id       : 0x2::object::id<Bucket<T2>>(arg0),
            borrow_type   : v5,
            borrow_amount : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(v2, arg3, 0x1::u64::pow(10, 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_factor())), 10000 - 200, 10000),
        };
        (0x2::coin::from_balance<T0>(0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::split<T0>(&mut arg0.reserve, arg3), arg5), v8)
    }

    fun get_aum(arg0: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::Tokens, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg2: 0x1::option::Option<0x1::type_name::TypeName>, arg3: &0x2::clock::Clock) : u128 {
        let v0 = if (0x1::option::is_none<0x1::type_name::TypeName>(&arg2)) {
            0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::new(1 * 0x1::u64::pow(10, 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_factor()), 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_factor())
        } else {
            0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::get_price_by_type(arg0, *0x1::option::borrow<0x1::type_name::TypeName>(&arg2), arg3)
        };
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(arg1)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(arg1, v3);
            let v6 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::get_price_by_type(arg0, *v4, arg3);
            let (v7, _) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::get_prices(&v6, &v1);
            v2 = v2 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v7 as u128), (*v5 as u128), (0x1::u64::pow(10, 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::price_factor()) as u128));
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_fee<T0, T1>(arg0: &mut Bucket<T0>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_admin(arg1, 0x2::tx_context::sender(arg2));
        0x2::coin::from_balance<T1>(remove_treasury_fees<T0, T1>(arg0), arg2)
    }

    public fun getf<T0, T1, T2>(arg0: &mut Bucket<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::pool_id(&arg0.v), 4035);
        let (v0, v1) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::collect_fee<T0, T1>(&arg0.v, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        add_treasury_fees<T2, T0>(arg0, v4);
        let v5 = &mut v2;
        add_treasury_fees<T2, T1>(arg0, v5);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T0>(&mut arg0.reserve, v3);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T1>(&mut arg0.reserve, v2);
    }

    public fun getr<T0, T1, T2, T3>(arg0: &mut Bucket<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::pool_id(&arg0.v), 4037);
        let v0 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::collect_reward<T0, T1, T3>(&arg0.v, arg1, arg2, arg3, arg4);
        let v1 = &mut v0;
        add_treasury_fees<T2, T3>(arg0, v1);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T3>(&mut arg0.reserve, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Buckets{
            id      : 0x2::object::new(arg0),
            buckets : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Buckets>(v0);
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut Bucket<T2>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::Tokens, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_keeper_role(arg1, 0x2::tx_context::sender(arg6));
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::pool_id(&arg0.v), 4039);
        let (v0, v1, v2) = valid_rebalance<T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4), 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::threshold(&arg0.v));
        assert!(v0, 4040);
        rebalance_do<T0, T1, T2>(arg0, arg3, arg4, v1, v2, arg5, arg6);
    }

    fun rebalance_do<T0, T1, T2>(arg0: &mut Bucket<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::valid_all_removed<T0, T1>(arg1, arg2, &arg0.v, arg5);
        let (v0, v1) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::rebalance<T0, T1>(&mut arg0.v, arg1, arg2, 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::take_all<T0>(&mut arg0.reserve), 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::take_all<T1>(&mut arg0.reserve), arg3, arg4, arg5, arg6);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T0>(&mut arg0.reserve, v0);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::join<T1>(&mut arg0.reserve, v1);
    }

    public fun remove_fund<T0, T1, T2>(arg0: &mut Bucket<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, WithdrawBorrow) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::pool_id(&arg0.v), 4023);
        let v0 = 0x2::coin::value<T2>(&arg3);
        assert!(v0 > 0, 4024);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::valid_all_removed<T0, T1>(arg1, arg2, &arg0.v, arg4);
        let v1 = 0x2::coin::total_supply<T2>(&arg0.treasury_id);
        let v2 = *0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::balances(&arg0.reserve);
        let v3 = 0x1::type_name::get<T0>();
        let (_, v5) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v2, &v3);
        let v6 = 0x1::type_name::get<T1>();
        let (_, v8) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v2, &v6);
        let v9 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::split<T0>(&mut arg0.reserve, (share_from_lp(v1, v0, (v5 as u128)) as u64));
        let v10 = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::split<T1>(&mut arg0.reserve, (share_from_lp(v1, v0, (v8 as u128)) as u64));
        let v11 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v12 = 0;
        while (v12 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v2)) {
            let (v13, v14) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v2, v12);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v11, *v13, (share_from_lp(v1, v0, (*v14 as u128)) as u64));
            v12 = v12 + 1;
        };
        let v15 = WithdrawBorrow{
            clmm_id         : 0x2::object::id<Bucket<T2>>(arg0),
            rewards_amounts : v11,
        };
        let v16 = share_from_lp(v1, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::borrow_position(&arg0.v)));
        let (v17, v18) = if (v16 > 0) {
            0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::remove_liquidity<T0, T1>(&mut arg0.v, arg1, arg2, v16, arg4)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x2::balance::join<T0>(&mut v9, v17);
        0x2::balance::join<T1>(&mut v10, v18);
        0x2::coin::burn<T2>(&mut arg0.treasury_id, arg3);
        (0x2::coin::from_balance<T0>(v9, arg5), 0x2::coin::from_balance<T1>(v10, arg5), v15)
    }

    public fun remove_reward<T0, T1>(arg0: &mut Bucket<T0>, arg1: &mut WithdrawBorrow, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.clmm_id == 0x2::object::id<Bucket<T0>>(arg0), 4017);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.rewards_amounts, &v0), 4018);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg1.rewards_amounts, &v0);
        0x2::coin::from_balance<T1>(0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::split<T1>(&mut arg0.reserve, v2), arg2)
    }

    fun remove_treasury_fees<T0, T1>(arg0: &mut Bucket<T0>) : 0x2::balance::Balance<T1> {
        let (v0, _) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::remove_from_bag<T1>(&mut arg0.treasury_fees, 0, true);
        v0
    }

    fun share_from_lp(arg0: u64, arg1: u64, arg2: u128) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((arg1 as u128), arg2, (arg0 as u128))
    }

    public fun update_offset<T0, T1, T2>(arg0: &mut Bucket<T2>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::Tokens, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_admin(arg1, 0x2::tx_context::sender(arg8));
        let (v0, v1, _) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::get_range(&arg0.v);
        assert!(arg5 != v0 || arg6 != v1, 4003);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::update_offset(&mut arg0.v, arg5, arg6);
        let (v3, v4, v5) = valid_rebalance<T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4), 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op::get_sqrt_price_latest<T0, T1>(arg2, arg7), 1);
        if (v3) {
            rebalance_do<T0, T1, T2>(arg0, arg3, arg4, v4, v5, arg7, arg8);
        };
    }

    public fun update_p<T0>(arg0: &mut Bucket<T0>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_admin(arg1, 0x2::tx_context::sender(arg3));
        arg0.treasury_rate = arg2;
    }

    public fun update_threshold<T0>(arg0: &mut Bucket<T0>, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_admin(arg1, 0x2::tx_context::sender(arg3));
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::update_threshold(&mut arg0.v, arg2);
    }

    fun valid_rebalance<T0>(arg0: &Bucket<T0>, arg1: u32, arg2: u128, arg3: u32) : (bool, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let (v0, v1, _) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::get_range(&arg0.v);
        let (v3, v4) = 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::proposed_range(v0, v1, arg1, arg2);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::v::borrow_position(&arg0.v));
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v4, v5) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v3, v6)) {
            return (true, v3, v4)
        };
        let v7 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v3, v5)) >= arg3 || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v4, v6)) >= arg3;
        (v7, v3, v4)
    }

    // decompiled from Move bytecode v6
}

