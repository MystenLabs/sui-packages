module 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca_bucket {
    struct DCAKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SwapReceipt {
        escrow_id: 0x2::object::ID,
        required_output: u64,
        type: 0x1::type_name::TypeName,
        spent: u64,
        amount: u64,
    }

    public fun escrow_contributor_token_borrow<T0>(arg0: &0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0> {
        let v0 = DCAKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::borrow_uid<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v0)
    }

    public fun execute_order<T0>(arg0: &mut 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::coin::Coin<T0>, SwapReceipt) {
        assert!(is_dca_bucket<T0>(arg0), 102);
        assert!(!0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::price_enabled<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), 101);
        assert!(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_last_claimed_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0) <= 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_current_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg4), 107);
        assert!(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::filled_orders<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0) < 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::total_orders<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), 106);
        let v0 = DCAKey{dummy_field: false};
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::remove_extension<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0, DCAKey>(arg0, &v0);
        let v1 = DCAKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::borrow_uid_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v1);
        let (v3, _, _, _, _, _) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_contributor_token_value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(&v2);
        let (v9, v10, v11) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::tank_withdraw<T0>(arg1, arg2, arg4, arg3, v2, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let v15 = 0x2::balance::value<T0>(&v13);
        let v16 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v14);
        let v17 = v3 - v16;
        let v18 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_output_y<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::divided_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), arg4);
        let (v19, v20, v21) = if (v15 > v18) {
            let v22 = v15 - v18;
            let v23 = SwapReceipt{
                escrow_id       : 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::id<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0),
                required_output : v18,
                type            : 0x1::type_name::get<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(),
                spent           : v17,
                amount          : 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::utils::mul_div(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_output_x<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v22, arg4), 10000 - 50, 10000),
            };
            0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::add_total_spent<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, v17);
            (0x2::coin::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg5), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v13, v22), arg5), v23)
        } else {
            let v24 = v18 - v15;
            let v25 = v24;
            let v26 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_output_x<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v24, arg4);
            let v27 = 0x2::math::min(v16, v26);
            if (v27 != v26) {
                v25 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_output_y<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v27, arg4);
            };
            let v28 = SwapReceipt{
                escrow_id       : 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::id<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0),
                required_output : v18,
                type            : 0x1::type_name::get<T0>(),
                spent           : v17 + v27,
                amount          : 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::utils::mul_div(v25, 10000 - 50, 10000),
            };
            0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::add_total_spent<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, v17 + v27);
            (0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v14, v27), arg5), 0x2::coin::zero<T0>(arg5), v28)
        };
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v14);
        0x2::balance::join<T0>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_y_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v13);
        if (0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&v12) == 0) {
            0x2::balance::destroy_zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v12);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v12, arg5), 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0));
        };
        (v19, v20, v21)
    }

    public fun get_contributor_token_value<T0>(arg0: &0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : (u64, u64, u64, u64, u64, u64) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_contributor_token_value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun get_escrow_bkt_reward_amount<T0>(arg0: &0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_bkt_reward_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun get_escrow_collateral_reward_amount<T0>(arg0: &0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_collateral_reward_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun get_escrow_required_amount<T0>(arg0: &0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg3: &0x2::clock::Clock) : (bool, u64, u64) {
        let (_, v1, v2, _) = get_escrow_tank_info<T0>(arg0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_tank<T0>(arg1));
        let v4 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_output_y<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::divided_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), arg3);
        if (v1 > v4) {
            let v8 = v1 - v4;
            (true, v8, 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::utils::mul_div(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_output_x<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v8, arg3), 10000 - 50, 10000))
        } else {
            let v9 = v4 - v1;
            let v10 = v9;
            let v11 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_output_x<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v9, arg3);
            let v12 = 0x2::math::min(v2, v11);
            if (v12 != v11) {
                v10 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::get_output_y<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v12, arg3);
            };
            (false, v12, 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::utils::mul_div(v10, 10000 - 50, 10000))
        }
    }

    public fun get_escrow_tank_info<T0>(arg0: &0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : (u64, u64, u64, u64) {
        (get_escrow_bkt_reward_amount<T0>(arg0, arg1), get_escrow_collateral_reward_amount<T0>(arg0, arg1), get_escrow_token_weight<T0>(arg0, arg1), get_escrow_token_ctx_epoch<T0>(arg0))
    }

    public fun get_escrow_token_ctx_epoch<T0>(arg0: &0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_token_ctx_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun get_escrow_token_weight<T0>(arg0: &0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_token_weight<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun is_dca_bucket<T0>(arg0: &0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : bool {
        let v0 = DCAKey{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::borrow_uid<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v0)
    }

    public fun repay_order_in_buck<T0>(arg0: &mut 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::DCAReg, arg1: &mut 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: SwapReceipt, arg4: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg1) == arg3.escrow_id, 103);
        let v0 = 0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg4);
        assert!(v0 >= arg3.amount, 104);
        assert!(arg3.type == 0x1::type_name::get<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(), 105);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::roll_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, arg5);
        let SwapReceipt {
            escrow_id       : _,
            required_output : v2,
            type            : _,
            spent           : v4,
            amount          : _,
        } = arg3;
        0x2::coin::put<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1), arg4);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::add_filled_orders<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, 1);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::remove_total_spent<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, v0);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::adjust_order<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1);
        let v6 = 0x2::coin::take<T0>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_y_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1), v2, arg6);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::add_total_withdrawn_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, 0x2::coin::value<T0>(&v6));
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::apply_fee<T0>(arg0, &mut v6);
        0x2::coin::put<T0>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_y_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1), v6);
        let v7 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1);
        stake_tank<T0>(arg1, arg2, arg6);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::event::order_executed<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(0x2::object::id<0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg1), v7, 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::utils::get_sec(arg5), v4 - v0, v2);
    }

    public fun repay_order_in_collateral<T0>(arg0: &mut 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::DCAReg, arg1: &mut 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: SwapReceipt, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg1) == arg3.escrow_id, 103);
        assert!(0x2::coin::value<T0>(&arg4) >= arg3.amount, 104);
        assert!(arg3.type == 0x1::type_name::get<T0>(), 105);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::roll_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, arg5);
        let SwapReceipt {
            escrow_id       : _,
            required_output : v1,
            type            : _,
            spent           : v3,
            amount          : _,
        } = arg3;
        0x2::coin::put<T0>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_y_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1), arg4);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::adjust_order<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::add_filled_orders<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, 1);
        let v5 = 0x2::coin::take<T0>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_y_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1), v1, arg6);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::add_total_withdrawn_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, 0x2::coin::value<T0>(&v5));
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::apply_fee<T0>(arg0, &mut v5);
        0x2::coin::put<T0>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_y_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1), v5);
        let v6 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1);
        stake_tank<T0>(arg1, arg2, arg6);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::event::order_executed<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(0x2::object::id<0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg1), v6, 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::utils::get_sec(arg5), v3, v1);
    }

    public fun stake_tank<T0>(arg0: &mut 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0);
        assert!(v0 == 0x2::tx_context::sender(arg2), 109);
        assert!(!0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::price_enabled<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), 101);
        assert!(!is_dca_bucket<T0>(arg0), 108);
        assert!(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_x_value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0) > 0, 110);
        let v1 = 0x2::balance::withdraw_all<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0));
        let v2 = DCAKey{dummy_field: false};
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::add_extension<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0, DCAKey>(arg0, &v2);
        let v3 = DCAKey{dummy_field: false};
        0x2::dynamic_object_field::add<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::borrow_uid_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v3, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_tank_mut<T0>(arg1), v1, arg2));
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::event::stake_tank<T0>(0x2::object::id<0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg0), v0, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v1));
    }

    public fun unstake_tank<T0>(arg0: &mut 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::coin::Coin<T0>) {
        let v0 = 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0);
        assert!(v0 == 0x2::tx_context::sender(arg5), 109);
        assert!(!0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::price_enabled<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), 101);
        assert!(is_dca_bucket<T0>(arg0), 108);
        let v1 = DCAKey{dummy_field: false};
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::remove_extension<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0, DCAKey>(arg0, &v1);
        let v2 = DCAKey{dummy_field: false};
        let (v3, v4, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::tank_withdraw<T0>(arg1, arg2, arg4, arg3, 0x2::dynamic_object_field::remove<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::borrow_uid_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v2), arg5);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v8);
        let v10 = 0x2::balance::value<T0>(&v7);
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v8);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::add_total_withdrawn_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v6, arg5), v0);
        0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::event::unstake_tank<T0>(0x2::object::id<0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg0), v0, v9, v10, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&v6));
        (0x2::coin::take<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v9 - 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::adjust_order<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0) * 0x12640e0ab1ad05bc90548cafc035cf7f03c883145f38d8e6dcdebca7ea93c752::dca::divided_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), arg5), 0x2::coin::from_balance<T0>(v7, arg5))
    }

    // decompiled from Move bytecode v6
}

