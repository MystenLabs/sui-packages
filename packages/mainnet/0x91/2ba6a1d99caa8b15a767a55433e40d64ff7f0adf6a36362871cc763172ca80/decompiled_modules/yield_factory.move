module 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::yield_factory {
    struct YieldFactoryConfig has key {
        id: 0x2::object::UID,
        interest_fee_rate: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
        vault_bag: 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::BalanceBag,
    }

    struct ConfigInitEvent has copy, drop {
        interest_rate: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
    }

    struct ConfigUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        interest_rate: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
    }

    struct WithdrawInterestEvent<phantom T0: drop> has copy, drop {
        amount: u64,
        treasury: address,
    }

    struct PYCreationEvent<phantom T0: drop> has copy, drop {
        expiry: u64,
    }

    struct MintPyEvent<phantom T0: drop> has copy, drop {
        py_id: 0x2::object::ID,
        share_in: u64,
        amount_pt: u64,
        amount_yt: u64,
        expiry: u64,
    }

    struct RedeemPyEvent<phantom T0: drop> has copy, drop {
        py_id: 0x2::object::ID,
        amount_pt: u64,
        amount_yt: u64,
        amount_to_redeem: u64,
        share_out: u64,
        expiry: u64,
    }

    struct FeeCollectedEvent<phantom T0: drop> has copy, drop {
        amount: u64,
        treasury: address,
    }

    struct InterestCollectEvent<phantom T0: drop> has copy, drop {
        py_id: 0x2::object::ID,
        amount: u64,
        receiver: address,
    }

    public fun mint_py<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0>, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg4: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg5: &mut YieldFactoryConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::expiry(arg3) > 0x2::clock::timestamp_ms(arg6), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::factory_invalid_expiry());
        assert!(0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>>(arg4) == 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::py_state_id(arg3), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::factory_invalid_py());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_py_index_stored<T0>(arg4, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::get_price<T0>(arg0, arg2, arg7)), arg6);
        mint_py_internal<T0>(arg1, arg3, arg4, arg5, arg6, arg7)
    }

    public fun redeem_due_interest<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg3: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0>, arg4: &mut YieldFactoryConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>>(arg2) == 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::py_state_id(arg1), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::factory_invalid_py());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_py_index_stored<T0>(arg2, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::get_price<T0>(arg0, arg3, arg6)), arg5);
        if (0x2::clock::timestamp_ms(arg5) >= 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::py_expiry(arg1)) {
            let v0 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_post_expiry_data<T0>(arg4.interest_fee_rate, arg2, arg5, arg6);
            deposit_to_vault<T0>(arg4, arg2, v0);
        };
        let v1 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::update_user_interest<T0>(arg4.interest_fee_rate, arg1, arg2, arg5, arg6);
        deposit_to_vault<T0>(arg4, arg2, v1);
        let v2 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::redeem_due_interest<T0>(arg1, arg2, arg6);
        let v3 = InterestCollectEvent<T0>{
            py_id    : 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition>(arg1),
            amount   : 0x2::coin::value<T0>(&v2),
            receiver : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<InterestCollectEvent<T0>>(v3);
        v2
    }

    public fun collect_interest_to_treasury<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut YieldFactoryConfig, arg2: u64, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::State, arg4: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::redeem<T1, T0>(arg0, 0x2::coin::from_balance<T1>(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::split<T1>(&mut arg1.vault_bag, arg2), arg4), arg3, arg4), arg1.treasury);
        let v0 = WithdrawInterestEvent<T1>{
            amount   : arg2,
            treasury : arg1.treasury,
        };
        0x2::event::emit<WithdrawInterestEvent<T1>>(v0);
    }

    public fun create<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyStore, arg3: &YieldFactoryConfig, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg6), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        assert!(arg4 % arg3.expiry_divisor == 0 && arg4 > 0x2::clock::timestamp_ms(arg5), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::factory_invalid_expiry());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::create_py<T0>(arg2, arg4, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg6);
        let v0 = PYCreationEvent<T0>{expiry: arg4};
        0x2::event::emit<PYCreationEvent<T0>>(v0);
    }

    public(friend) fun deposit_to_vault<T0: drop>(arg0: &mut YieldFactoryConfig, arg1: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg2: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64) {
        if (!0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::contains<T0>(&arg0.vault_bag)) {
            0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::init_balance<T0>(&mut arg0.vault_bag);
        };
        if (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::greater(arg2, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::zero())) {
            0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::join<T0>(&mut arg0.vault_bag, 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::split_sy_balance<T0>(arg1, arg2));
        };
    }

    public fun init_config(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::State, arg2: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg3: u128, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::uid(arg1), b"init yield factory config"), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::init_config_already_initialized());
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg2, 0x2::tx_context::sender(arg6), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::update_config_invalid_sender());
        let v0 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(arg3);
        assert!(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::less_or_equal(v0, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_rational(1, 5)), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::interest_fee_rate_too_high());
        assert!(arg4 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::factory_zero_expiry_divisor());
        let v1 = YieldFactoryConfig{
            id                : 0x2::object::new(arg6),
            interest_fee_rate : v0,
            expiry_divisor    : arg4,
            treasury          : arg5,
            vault_bag         : 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::balance_bag::new(arg6),
        };
        let v2 = ConfigInitEvent{
            interest_rate  : v0,
            expiry_divisor : arg4,
            treasury       : arg5,
        };
        0x2::event::emit<ConfigInitEvent>(v2);
        0x2::dynamic_field::add<vector<u8>, bool>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::uid(arg1), b"init yield factory config", true);
        0x2::transfer::share_object<YieldFactoryConfig>(v1);
    }

    public(friend) fun interest_fee_rate(arg0: &YieldFactoryConfig) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        arg0.interest_fee_rate
    }

    public(friend) fun mint_py_internal<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg3: &mut YieldFactoryConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::truncate(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::sy_to_asset(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::current_py_index<T0>(arg2), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(v0)));
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::join_sy<T0>(arg0, arg2);
        let v2 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::update_user_interest<T0>(arg3.interest_fee_rate, arg1, arg2, arg4, arg5);
        deposit_to_vault<T0>(arg3, arg2, v2);
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::mint_py<T0>(v1, v1, arg1, arg2, arg4);
        let v3 = MintPyEvent<T0>{
            py_id     : 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition>(arg1),
            share_in  : v0,
            amount_pt : v1,
            amount_yt : v1,
            expiry    : 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::expiry(arg1),
        };
        0x2::event::emit<MintPyEvent<T0>>(v3);
        v1
    }

    public fun redeem_interest_for_treasury<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut YieldFactoryConfig, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg3: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::expiry<T0>(arg2) < 0x2::clock::timestamp_ms(arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::factory_yc_not_expired());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_py_index_stored<T0>(arg2, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::get_price<T0>(arg0, arg3, arg5)), arg4);
        let (_, _, v2) = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::collect_interest<T0>(arg1.interest_fee_rate, arg2);
        deposit_to_vault<T0>(arg1, arg2, v2);
    }

    public fun redeem_py<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: u64, arg2: u64, arg3: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0>, arg4: 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg5: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg6: &mut YieldFactoryConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>>(arg5) == 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::py_state_id(&arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::factory_invalid_py());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_py_index_stored<T0>(arg5, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::get_price<T0>(arg0, arg3, arg8)), arg7);
        let v0 = &mut arg4;
        let v1 = redeem_py_internal<T0>(arg1, arg2, v0, arg5, arg6, arg7, arg8);
        let v2 = if (0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::pt_balance(&arg4) == 0) {
            if (0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::yt_balance(&arg4) == 0) {
                0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::accured(&arg4) == 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::zero()
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::burn(arg4);
        } else {
            0x2::transfer::public_transfer<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition>(arg4, 0x2::tx_context::sender(arg8));
        };
        v1
    }

    public(friend) fun redeem_py_internal<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg4: &mut YieldFactoryConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg5) >= 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::expiry(arg2);
        let v1 = if (v0) {
            let v2 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_post_expiry_data<T0>(arg4.interest_fee_rate, arg3, arg5, arg6);
            deposit_to_vault<T0>(arg4, arg3, v2);
            arg1
        } else {
            0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math64::min(arg1, arg0)
        };
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::burn_py<T0>(v1, 0, arg2, arg3, arg5);
        if (!v0) {
            let v3 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::update_user_interest<T0>(arg4.interest_fee_rate, arg2, arg3, arg5, arg6);
            deposit_to_vault<T0>(arg4, arg3, v3);
            0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::burn_py<T0>(0, v1, arg2, arg3, arg5);
        };
        let v4 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::asset_to_sy(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::current_py_index<T0>(arg3), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(v1));
        let v5 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::zero();
        if (v0) {
            v5 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::sub(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::asset_to_sy(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::first_py_index<T0>(arg3), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(v1)), v4);
        };
        deposit_to_vault<T0>(arg4, arg3, v5);
        let v6 = RedeemPyEvent<T0>{
            py_id            : 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition>(arg2),
            amount_pt        : v1,
            amount_yt        : v1,
            amount_to_redeem : v1,
            share_out        : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::truncate(v4),
            expiry           : 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::expiry(arg2),
        };
        0x2::event::emit<RedeemPyEvent<T0>>(v6);
        let v7 = FeeCollectedEvent<T0>{
            amount   : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::truncate(v5),
            treasury : arg4.treasury,
        };
        0x2::event::emit<FeeCollectedEvent<T0>>(v7);
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::split_sy<T0>(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::truncate(v4), arg3, arg6)
    }

    public(friend) fun treasury(arg0: &YieldFactoryConfig) : address {
        arg0.treasury
    }

    public fun update_config(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut YieldFactoryConfig, arg3: u128, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg6), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::update_config_invalid_sender());
        let v0 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(arg3);
        assert!(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::less_or_equal(v0, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_rational(1, 5)), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::interest_fee_rate_too_high());
        assert!(arg4 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::factory_zero_expiry_divisor());
        arg2.expiry_divisor = arg4;
        arg2.interest_fee_rate = v0;
        arg2.treasury = arg5;
        let v1 = ConfigUpdateEvent{
            id             : 0x2::object::uid_to_inner(&arg2.id),
            interest_rate  : v0,
            expiry_divisor : arg4,
            treasury       : arg5,
        };
        0x2::event::emit<ConfigUpdateEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

