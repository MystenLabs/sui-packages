module 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory {
    struct YieldFactoryConfig has key {
        id: 0x2::object::UID,
        interest_fee_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        reward_fee_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        do_cache_index_same_block: bool,
        treasury: address,
    }

    struct ConfigInitEvent has copy, drop {
        interest_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        reward_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
        do_cache_index_same_block: bool,
    }

    struct ConfigUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        interest_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        reward_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
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

    public fun mint_py<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg3: &YieldFactoryConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_expiry(arg1) >= 0x2::clock::timestamp_ms(arg4), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::factory_invalid_expiry());
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::truncate(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::sy::sy_to_asset(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::current_py_index<T0>(arg3.do_cache_index_same_block, arg2, arg5), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(v0)));
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::join_sy<T0>(arg0, arg2, arg5);
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::update_user_interest<T0>(arg3.do_cache_index_same_block, arg3.treasury, arg3.interest_fee_rate, arg1, arg2, arg5);
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::mint_py<T0>(v1, v1, arg1, arg2, arg5);
        let v2 = MintPyEvent<T0>{
            py_id     : 0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition>(arg1),
            share_in  : v0,
            amount_pt : v1,
            amount_yt : v1,
            expiry    : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_expiry(arg1),
        };
        0x2::event::emit<MintPyEvent<T0>>(v2);
    }

    public fun redeem_due_interest<T0: drop>(arg0: address, arg1: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg3: &YieldFactoryConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>>(arg2) == 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_id(arg1), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::factory_invalid_py());
        if (0x2::clock::timestamp_ms(arg4) > 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_expiry(arg1)) {
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::set_post_expiry_data<T0>(arg3.do_cache_index_same_block, arg3.treasury, arg3.interest_fee_rate, arg2, arg5);
        };
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::update_user_interest<T0>(arg3.do_cache_index_same_block, arg3.treasury, arg3.interest_fee_rate, arg1, arg2, arg5);
        let v0 = InterestCollectEvent<T0>{
            py_id    : 0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition>(arg1),
            amount   : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::truncate(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::redeem_due_interest<T0>(arg0, arg1, arg2, arg5)),
            receiver : arg0,
        };
        0x2::event::emit<InterestCollectEvent<T0>>(v0);
    }

    public(friend) fun cache_in_same_block(arg0: &YieldFactoryConfig) : bool {
        arg0.do_cache_index_same_block
    }

    public fun create<T0: drop>(arg0: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyStore, arg1: &YieldFactoryConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 % arg1.expiry_divisor == 0 && arg2 > 0x2::clock::timestamp_ms(arg3), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::factory_invalid_expiry());
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x1::ascii::insert(&mut v0, 0, 0x1::ascii::string(b"PY"));
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::create_py<T0>(arg0, arg2, v0, 0x1::ascii::string(b"Nemo PY"), 0x1::ascii::string(b""), arg4);
        let v1 = PYCreationEvent<T0>{expiry: arg2};
        0x2::event::emit<PYCreationEvent<T0>>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_config(arg0: u128, arg1: u128, arg2: u64, arg3: bool, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::create_from_raw_value(arg0);
        let v1 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::create_from_raw_value(arg1);
        let v2 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::create_from_rational(1, 5);
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::less_or_equal(v0, v2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::interest_fee_rate_too_high());
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::less_or_equal(v1, v2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::reward_fee_rate_too_high());
        assert!(arg2 > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::factory_zero_expiry_divisor());
        let v3 = YieldFactoryConfig{
            id                        : 0x2::object::new(arg5),
            interest_fee_rate         : v0,
            reward_fee_rate           : v1,
            expiry_divisor            : arg2,
            do_cache_index_same_block : arg3,
            treasury                  : arg4,
        };
        let v4 = ConfigInitEvent{
            interest_rate             : v0,
            reward_rate               : v1,
            expiry_divisor            : arg2,
            treasury                  : arg4,
            do_cache_index_same_block : arg3,
        };
        0x2::event::emit<ConfigInitEvent>(v4);
        0x2::transfer::share_object<YieldFactoryConfig>(v3);
    }

    public(friend) fun interest_fee_rate(arg0: &YieldFactoryConfig) : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64 {
        arg0.interest_fee_rate
    }

    public fun redeem_interest_and_reward_for_treasury<T0: drop>(arg0: &YieldFactoryConfig, arg1: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_expiry<T0>(arg1) < 0x2::clock::timestamp_ms(arg2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::factory_yc_not_expired());
        let (_, _) = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::collect_interest<T0>(arg0.do_cache_index_same_block, arg0.treasury, arg0.interest_fee_rate, arg1, arg3);
    }

    public fun redeem_py<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg3: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg4: &YieldFactoryConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>>(arg3) == 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_id(arg2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::factory_invalid_py());
        let v0 = 0x2::clock::timestamp_ms(arg5) > 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_expiry(arg2);
        let v1 = if (v0) {
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::set_post_expiry_data<T0>(arg4.do_cache_index_same_block, arg4.treasury, arg4.interest_fee_rate, arg3, arg6);
            arg1
        } else {
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math64::min(arg1, arg0)
        };
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::burn_pt<T0>(arg2, arg3, v1);
        if (!v0) {
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::update_user_interest<T0>(arg4.do_cache_index_same_block, arg4.treasury, arg4.interest_fee_rate, arg2, arg3, arg6);
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::burn_yt<T0>(arg2, arg3, v1);
        };
        let v2 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::truncate(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::sy::asset_to_sy(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::current_py_index<T0>(arg4.do_cache_index_same_block, arg3, arg6), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(v1)));
        let v3 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero();
        if (v0) {
            v3 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::sy::asset_to_sy(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::first_py_index<T0>(arg3), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(v1));
        };
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::transfer_sy<T0>(arg4.treasury, arg3, v3, arg6);
        let v4 = RedeemPyEvent<T0>{
            py_id            : 0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition>(arg2),
            amount_pt        : v1,
            amount_yt        : v1,
            amount_to_redeem : v1,
            share_out        : v2,
            expiry           : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_expiry(arg2),
        };
        0x2::event::emit<RedeemPyEvent<T0>>(v4);
        let v5 = FeeCollectedEvent<T0>{
            amount   : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::truncate(v3),
            treasury : arg4.treasury,
        };
        0x2::event::emit<FeeCollectedEvent<T0>>(v5);
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::split_sy<T0>(v2, arg3, arg6)
    }

    public(friend) fun treasury(arg0: &YieldFactoryConfig) : address {
        arg0.treasury
    }

    public fun update_config(arg0: &mut YieldFactoryConfig, arg1: u128, arg2: u128, arg3: u64, arg4: address) {
        let v0 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::create_from_raw_value(arg1);
        let v1 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::create_from_raw_value(arg2);
        let v2 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::create_from_rational(1, 5);
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::less_or_equal(v0, v2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::interest_fee_rate_too_high());
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::less_or_equal(v1, v2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::reward_fee_rate_too_high());
        assert!(arg3 > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::factory_zero_expiry_divisor());
        arg0.expiry_divisor = arg3;
        arg0.interest_fee_rate = v0;
        arg0.reward_fee_rate = v1;
        arg0.treasury = arg4;
        let v3 = ConfigUpdateEvent{
            id             : 0x2::object::uid_to_inner(&arg0.id),
            interest_rate  : v0,
            reward_rate    : v1,
            expiry_divisor : arg3,
            treasury       : arg4,
        };
        0x2::event::emit<ConfigUpdateEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

