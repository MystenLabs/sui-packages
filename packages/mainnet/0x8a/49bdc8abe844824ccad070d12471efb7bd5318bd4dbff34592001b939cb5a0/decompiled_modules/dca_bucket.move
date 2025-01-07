module 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca_bucket {
    struct DCAKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SwapReceipt {
        vault_id: 0x2::object::ID,
        type: 0x1::type_name::TypeName,
        spent: u64,
        amount: u64,
    }

    public fun escrow_contributor_token_borrow<T0>(arg0: &0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0> {
        let v0 = DCAKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::borrow_uid<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v0)
    }

    public fun execute_order<T0>(arg0: &mut 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::coin::Coin<T0>, SwapReceipt) {
        assert!(is_dca_bucket<T0>(arg0), 102);
        assert!(!0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::price_enabled<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), 101);
        assert!(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_last_claimed_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0) <= 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_current_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg4), 107);
        assert!(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::filled_orders<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0) < 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::total_orders<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), 106);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_tank_mut<T0>(arg1);
        let v0 = DCAKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::remove<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::borrow_uid_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v0);
        let (v2, _, _, _, _, _) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_contributor_token_value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(&v1);
        let (v8, v9, v10) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::tank_withdraw<T0>(arg1, arg2, arg4, arg3, v1, arg5);
        let v11 = v10;
        let v12 = v9;
        let v13 = v8;
        let v14 = 0x2::balance::value<T0>(&v12);
        let v15 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v13);
        let v16 = v2 - v15;
        let v17 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_output_y<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::divided_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), arg4);
        let (v18, v19, v20) = if (v14 > v17) {
            let v21 = v14 - v17;
            let v22 = SwapReceipt{
                vault_id : 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::id<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0),
                type     : 0x1::type_name::get<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(),
                spent    : v16,
                amount   : 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::utils::mul_div(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_output_x<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v21, arg4), 10000 - 50, 10000),
            };
            0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::add_total_spent<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, v16);
            (0x2::coin::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg5), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, v21), arg5), v22)
        } else {
            let v23 = v17 - v14;
            let v24 = v23;
            let v25 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_output_x<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v23, arg4);
            let v26 = 0x2::math::min(v15, v25);
            if (v26 != v25) {
                v24 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_output_y<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v26, arg4);
            };
            let v27 = SwapReceipt{
                vault_id : 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::id<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0),
                type     : 0x1::type_name::get<T0>(),
                spent    : v16 + v26,
                amount   : 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::utils::mul_div(v24, 10000 - 50, 10000),
            };
            0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::add_total_spent<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, v16 + v26);
            (0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v13, v26), arg5), 0x2::coin::zero<T0>(arg5), v27)
        };
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v13);
        0x2::balance::join<T0>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::balance_y_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v12);
        if (0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&v11) == 0) {
            0x2::balance::destroy_zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v11);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v11, arg5), 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0));
        };
        (v18, v19, v20)
    }

    public fun get_contributor_token_value<T0>(arg0: &0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : (u64, u64, u64, u64, u64, u64) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_contributor_token_value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun get_escrow_bkt_reward_amount<T0>(arg0: &0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_bkt_reward_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun get_escrow_collateral_reward_amount<T0>(arg0: &0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_collateral_reward_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun get_escrow_required_amount<T0>(arg0: &0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg3: &0x2::clock::Clock) : (bool, u64, u64) {
        let (_, v1, v2, _) = get_escrow_tank_info<T0>(arg0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_tank<T0>(arg1));
        let v4 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_output_y<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::divided_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), arg3);
        if (v1 > v4) {
            let v8 = v1 - v4;
            (true, v8, 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::utils::mul_div(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_output_x<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v8, arg3), 10000 - 50, 10000))
        } else {
            let v9 = v4 - v1;
            let v10 = v9;
            let v11 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_output_x<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v9, arg3);
            let v12 = 0x2::math::min(v2, v11);
            if (v12 != v11) {
                v10 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::get_output_y<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg2, v12, arg3);
            };
            (false, v12, 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::utils::mul_div(v10, 10000 - 50, 10000))
        }
    }

    public fun get_escrow_tank_info<T0>(arg0: &0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : (u64, u64, u64, u64) {
        (get_escrow_bkt_reward_amount<T0>(arg0, arg1), get_escrow_collateral_reward_amount<T0>(arg0, arg1), get_escrow_token_weight<T0>(arg0, arg1), get_escrow_token_ctx_epoch<T0>(arg0))
    }

    public fun get_escrow_token_ctx_epoch<T0>(arg0: &0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_token_ctx_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun get_escrow_token_weight<T0>(arg0: &0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_token_weight<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, escrow_contributor_token_borrow<T0>(arg0))
    }

    public fun is_dca_bucket<T0>(arg0: &0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>) : bool {
        let v0 = DCAKey{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::borrow_uid<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v0)
    }

    public fun repay_order_in_buck<T0>(arg0: &mut 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::DCAReg, arg1: &mut 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: SwapReceipt, arg4: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg1) == arg3.vault_id, 103);
        let v0 = 0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg4);
        assert!(v0 >= arg3.amount, 104);
        assert!(arg3.type == 0x1::type_name::get<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(), 105);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::roll_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, arg5);
        let SwapReceipt {
            vault_id : _,
            type     : _,
            spent    : v3,
            amount   : _,
        } = arg3;
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::add_filled_orders<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, 1);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::remove_total_spent<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, v0);
        0x2::coin::put<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1), arg4);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::adjust_order<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1);
        let v5 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::balance_y_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1)), arg6);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::apply_fee<T0>(arg0, &mut v5);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::add_total_withdrawn_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, 0x2::coin::value<T0>(&v5));
        let v6 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v6);
        stake_tank<T0>(arg1, arg2, arg6);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::event::order_executed<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(0x2::object::id<0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg1), v6, 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::utils::get_sec(arg5), v3 - v0, 0x2::coin::value<T0>(&v5));
    }

    public fun repay_order_in_collateral<T0>(arg0: &mut 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::DCAReg, arg1: &mut 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: SwapReceipt, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg1) == arg3.vault_id, 103);
        assert!(0x2::coin::value<T0>(&arg4) >= arg3.amount, 104);
        assert!(arg3.type == 0x1::type_name::get<T0>(), 105);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::roll_epoch<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, arg5);
        let SwapReceipt {
            vault_id : _,
            type     : _,
            spent    : v2,
            amount   : _,
        } = arg3;
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::adjust_order<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::add_filled_orders<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, 1);
        let v4 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::balance_y_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1)), arg6);
        0x2::coin::join<T0>(&mut v4, arg4);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::add_total_withdrawn_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1, 0x2::coin::value<T0>(&v4));
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::apply_fee<T0>(arg0, &mut v4);
        let v5 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v5);
        stake_tank<T0>(arg1, arg2, arg6);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::event::order_executed<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(0x2::object::id<0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg1), v5, 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::utils::get_sec(arg5), v2, 0x2::coin::value<T0>(&v4));
    }

    public fun stake_tank<T0>(arg0: &mut 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0);
        assert!(v0 == 0x2::tx_context::sender(arg2), 109);
        assert!(!0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::price_enabled<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), 101);
        assert!(!is_dca_bucket<T0>(arg0), 108);
        assert!(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::balance_x_value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0) > 0, 110);
        let v1 = 0x2::balance::withdraw_all<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0));
        let v2 = DCAKey{dummy_field: false};
        0x2::dynamic_object_field::add<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::borrow_uid_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_tank_mut<T0>(arg1), v1, arg2));
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::event::stake_tank<T0>(0x2::object::id<0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg0), v0, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v1));
    }

    public fun unstake_tank<T0>(arg0: &mut 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::coin::Coin<T0>) {
        let v0 = 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::owner<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0);
        assert!(v0 == 0x2::tx_context::sender(arg5), 109);
        assert!(!0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::price_enabled<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), 101);
        assert!(is_dca_bucket<T0>(arg0), 108);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_tank_mut<T0>(arg1);
        let v1 = DCAKey{dummy_field: false};
        let (v2, v3, v4) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::tank_withdraw<T0>(arg1, arg2, arg4, arg3, 0x2::dynamic_object_field::remove<DCAKey, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::borrow_uid_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v1), arg5);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v7);
        let v9 = 0x2::balance::value<T0>(&v6);
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v7);
        let v10 = v8 - 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::adjust_order<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0) * 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::divided_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0);
        let v11 = if (v10 > 0) {
            0x2::coin::take<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::balance_x_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0), v10, arg5)
        } else {
            0x2::coin::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg5)
        };
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::add_total_withdrawn_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v5, arg5), v0);
        0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::event::unstake_tank<T0>(0x2::object::id<0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::dca::Escrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg0), v0, v8, v9, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&v5));
        (v11, 0x2::coin::from_balance<T0>(v6, arg5))
    }

    // decompiled from Move bytecode v6
}

