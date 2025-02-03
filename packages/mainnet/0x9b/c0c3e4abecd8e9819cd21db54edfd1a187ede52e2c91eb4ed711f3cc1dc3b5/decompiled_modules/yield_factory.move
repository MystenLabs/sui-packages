module 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yield_factory {
    struct YieldFactoryConfig has key {
        id: 0x2::object::UID,
        interest_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        reward_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        do_cache_index_same_block: bool,
        treasury: address,
    }

    struct PyInterest<phantom T0: drop> has store {
        index: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        accured: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        py_index: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
    }

    struct YieldTokenConfig<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        expiry: u64,
        sy_balance: 0x2::balance::Balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>,
        current_index: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        index_stored: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        index_last_updated_epoch: u64,
        first_index: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        last_interest_epoch: u64,
        last_collect_interest_index: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        global_interest_index: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        total_sy_interest_for_treasury: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        first_reward_index: 0x2::table::Table<address, u256>,
        user_reward_owed: 0x2::table::Table<address, u256>,
        user_interest: 0x2::table::Table<address, PyInterest<T0>>,
    }

    struct YieldTokenStore<phantom T0> has store, key {
        id: 0x2::object::UID,
        pt: 0x2::bag::Bag,
        yt: 0x2::bag::Bag,
    }

    struct ConfigInitEvent has copy, drop {
        interest_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        reward_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
        do_cache_index_same_block: bool,
    }

    struct ConfigUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        interest_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        reward_rate: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
    }

    struct ConfigStoreInitEvent<phantom T0: drop> has copy, drop {
        id: 0x2::object::ID,
    }

    struct PYCreationEvent<phantom T0: drop> has copy, drop {
        sy_id: 0x2::object::ID,
        token_config_id: 0x2::object::ID,
        expiry: u64,
    }

    struct MintPyEvent<phantom T0: drop> has copy, drop {
        sy_id: 0x2::object::ID,
        pt_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        pt_receiver: address,
        yt_receiver: address,
        share_in: u64,
        amount_pt: u64,
        amount_yt: u64,
        expiry: u64,
    }

    struct RedeemPyEvent<phantom T0: drop> has copy, drop {
        sy_id: 0x2::object::ID,
        pt_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        receiver: address,
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
        sy_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        amount: u64,
        receiver: address,
    }

    public fun create<T0: drop>(arg0: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg1: &mut YieldTokenStore<T0>, arg2: &YieldFactoryConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 % arg2.expiry_divisor == 0 && arg3 > 0x2::clock::timestamp_ms(arg4), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::factory_invalid_expiry());
        assert!(!0x2::bag::contains<u64>(&arg1.pt, arg3), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::factory_contract_exists());
        let v0 = 0x1::ascii::string(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::name<T0>(arg0));
        let v1 = 0x1::ascii::string(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::symbol<T0>(arg0));
        let v2 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::decimals<T0>(arg0);
        let v3 = 0x1::ascii::substring(&v0, 2, 0x1::ascii::length(&v0));
        let v4 = 0x1::ascii::substring(&v1, 3, 0x1::ascii::length(&v1));
        let v5 = 0x1::ascii::substring(&v3, 0, 0x1::ascii::length(&v3));
        let v6 = 0x1::ascii::substring(&v4, 0, 0x1::ascii::length(&v4));
        0x1::ascii::insert(&mut v5, 0, 0x1::ascii::string(b"PT"));
        0x1::ascii::insert(&mut v6, 0, 0x1::ascii::string(b"PT-"));
        let v7 = 0x1::ascii::substring(&v3, 0, 0x1::ascii::length(&v3));
        let v8 = 0x1::ascii::substring(&v4, 0, 0x1::ascii::length(&v4));
        0x1::ascii::insert(&mut v7, 0, 0x1::ascii::string(b"YT"));
        0x1::ascii::insert(&mut v8, 0, 0x1::ascii::string(b"YT-"));
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::create<T0>(0x1::ascii::into_bytes(v5), 0x1::ascii::into_bytes(v6), v2, arg3, arg5);
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::create<T0>(0x1::ascii::into_bytes(v7), 0x1::ascii::into_bytes(v8), v2, arg3, arg5);
        0x2::bag::add<u64, bool>(&mut arg1.pt, arg3, true);
        0x2::bag::add<u64, bool>(&mut arg1.yt, arg3, true);
        let v9 = YieldTokenConfig<T0>{
            id                             : 0x2::object::new(arg5),
            expiry                         : arg3,
            sy_balance                     : 0x2::balance::zero<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(),
            current_index                  : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
            index_stored                   : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
            index_last_updated_epoch       : 0,
            first_index                    : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
            last_interest_epoch            : 0,
            last_collect_interest_index    : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
            global_interest_index          : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
            total_sy_interest_for_treasury : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
            first_reward_index             : 0x2::table::new<address, u256>(arg5),
            user_reward_owed               : 0x2::table::new<address, u256>(arg5),
            user_interest                  : 0x2::table::new<address, PyInterest<T0>>(arg5),
        };
        let v10 = PYCreationEvent<T0>{
            sy_id           : 0x2::object::id<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>>(arg0),
            token_config_id : 0x2::object::id<YieldTokenConfig<T0>>(&v9),
            expiry          : arg3,
        };
        0x2::event::emit<PYCreationEvent<T0>>(v10);
        0x2::transfer::share_object<YieldTokenConfig<T0>>(v9);
    }

    fun collect_interest<T0: drop>(arg0: &YieldFactoryConfig, arg1: &mut YieldTokenConfig<T0>, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64) {
        let v0 = arg1.last_collect_interest_index;
        let v1 = current_py_index<T0>(arg0, arg1, arg3, arg4);
        let v2 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero();
        if (!0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::is_zero(v0) && !0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::equal(v0, v1)) {
            let v3 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::one();
            if (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::is_zero(arg1.first_index)) {
                v3 = arg0.interest_rate;
            };
            let v4 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::divDown(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::multiply(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::total_supply<T0>(arg2)), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::sub(v1, v0)), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::multiply(v0, v1));
            let v5 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::multiply(v4, v3);
            v2 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::sub(v4, v5);
            transfer_sy<T0>(arg0.treasury, arg1, v5, arg4);
        };
        arg1.last_collect_interest_index = v1;
        (v2, v1)
    }

    public fun current_py_index<T0: drop>(arg0: &YieldFactoryConfig, arg1: &mut YieldTokenConfig<T0>, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg3: &0x2::tx_context::TxContext) : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64 {
        if (arg0.do_cache_index_same_block && arg1.index_last_updated_epoch == 0x2::tx_context::epoch(arg3)) {
            arg1.index_stored
        } else {
            let v1 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::max(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::exchange_rate<T0>(arg2), arg1.index_stored);
            arg1.current_index = v1;
            arg1.index_stored = v1;
            arg1.index_last_updated_epoch = 0x2::tx_context::epoch(arg3);
            v1
        }
    }

    public fun get_sy_amount_in_for_exact_py_out<T0: drop>(arg0: u64, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg2: &mut YieldTokenConfig<T0>, arg3: &YieldFactoryConfig, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::truncate(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::divDown(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::multiply(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(arg0), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::one()), current_py_index<T0>(arg3, arg2, arg1, arg4)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_config(arg0: u128, arg1: u128, arg2: u64, arg3: bool, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::create_from_raw_value(arg0);
        let v1 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::create_from_raw_value(arg1);
        let v2 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::create_from_rational(1, 5);
        assert!(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::less_or_equal(v0, v2), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::interest_fee_rate_too_high());
        assert!(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::less_or_equal(v1, v2), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::reward_fee_rate_too_high());
        assert!(arg2 > 0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::factory_zero_expiry_divisor());
        let v3 = YieldFactoryConfig{
            id                        : 0x2::object::new(arg5),
            interest_rate             : v0,
            reward_rate               : v1,
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

    public fun init_store<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldTokenStore<T0>{
            id : 0x2::object::new(arg0),
            pt : 0x2::bag::new(arg0),
            yt : 0x2::bag::new(arg0),
        };
        let v1 = ConfigStoreInitEvent<T0>{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<ConfigStoreInitEvent<T0>>(v1);
        0x2::transfer::share_object<YieldTokenStore<T0>>(v0);
    }

    public fun mint_py<T0: drop>(arg0: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>, arg1: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg2: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTStruct<T0>, arg3: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg4: &mut YieldTokenConfig<T0>, arg5: &YieldFactoryConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>, 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>) {
        let v0 = 0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(arg0);
        assert!(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::expiry<T0>(arg2) == 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::expiry<T0>(arg3) && 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::expiry<T0>(arg2) == arg4.expiry, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::mismatch_yt_pt_tokens());
        assert!(arg4.expiry >= 0x2::clock::timestamp_ms(arg6), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::factory_yc_expired());
        let v1 = current_py_index<T0>(arg5, arg4, arg1, arg7);
        let v2 = 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&v0);
        let v3 = (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::divide_u128(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::multiply_u128((v2 as u128), v1), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::one()) as u64);
        0x2::balance::join<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg4.sy_balance, v0);
        let v4 = MintPyEvent<T0>{
            sy_id       : 0x2::object::id<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>>(arg1),
            pt_id       : 0x2::object::id<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTStruct<T0>>(arg2),
            yt_id       : 0x2::object::id<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>>(arg3),
            pt_receiver : 0x2::tx_context::sender(arg7),
            yt_receiver : 0x2::tx_context::sender(arg7),
            share_in    : v2,
            amount_pt   : v3,
            amount_yt   : v3,
            expiry      : arg4.expiry,
        };
        0x2::event::emit<MintPyEvent<T0>>(v4);
        (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::mint<T0>(arg2, v3, arg7), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::mint<T0>(arg3, v3, arg7))
    }

    public fun redeem_due_interest<T0: drop>(arg0: address, arg1: &0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>, arg2: &mut YieldTokenConfig<T0>, arg3: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg4: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg5: &YieldFactoryConfig, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(arg1);
        let (v1, v2) = update_interest_index<T0>(arg5, arg2, arg3, arg4, arg6);
        if (!0x2::table::contains<address, PyInterest<T0>>(&arg2.user_interest, arg0)) {
            let v3 = PyInterest<T0>{
                index    : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
                accured  : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
                py_index : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero(),
            };
            0x2::table::add<address, PyInterest<T0>>(&mut arg2.user_interest, arg0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, PyInterest<T0>>(&mut arg2.user_interest, arg0);
        let v5 = v4.index;
        if (!0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::equal(v5, v1)) {
            v4.index = v1;
            v4.py_index = v2;
            if (!0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::is_zero(v5)) {
                v4.accured = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::multiply(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::sub(v1, v5), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(v0)));
            };
        };
        let v6 = v4.accured;
        v4.accured = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero();
        transfer_sy<T0>(arg0, arg2, v6, arg6);
        let v7 = InterestCollectEvent<T0>{
            sy_id    : 0x2::object::id<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>>(arg3),
            yt_id    : 0x2::object::id<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>>(arg4),
            amount   : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::truncate(v6),
            receiver : arg0,
        };
        0x2::event::emit<InterestCollectEvent<T0>>(v7);
    }

    public fun redeem_interest_and_reward_for_treasury<T0: drop>(arg0: &mut YieldTokenConfig<T0>, arg1: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg3: &YieldFactoryConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.expiry < 0x2::clock::timestamp_ms(arg4), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::factory_yc_not_expired());
        let (_, _) = collect_interest<T0>(arg3, arg0, arg2, arg1, arg5);
        let v2 = FeeCollectedEvent<T0>{
            amount   : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::truncate(arg0.total_sy_interest_for_treasury),
            treasury : arg3.treasury,
        };
        0x2::event::emit<FeeCollectedEvent<T0>>(v2);
    }

    public fun redeem_py<T0: drop>(arg0: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>, arg1: 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>, arg2: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg3: &mut YieldTokenConfig<T0>, arg4: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTStruct<T0>, arg5: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg6: &YieldFactoryConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>, 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>, 0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>) {
        let v0 = 0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(arg0);
        let v1 = 0x2::coin::into_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg7) > arg3.expiry;
        let v3 = if (v2) {
            update_post_expiry_data<T0>(arg6, arg3, arg2, arg5, arg8);
            0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&v0)
        } else {
            0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::math64::min(0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&v0), 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(&v1))
        };
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::burn<T0>(arg4, 0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&mut v0, v3));
        if (!v2) {
            0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::burn<T0>(arg5, 0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(&mut v1, v3));
        };
        let v4 = current_py_index<T0>(arg6, arg3, arg2, arg8);
        let v5 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::divDown(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(v3), v4);
        let v6 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::zero();
        if (v2) {
            v6 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::sub(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::divDown(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(v3), arg3.first_index), v5);
        };
        transfer_sy<T0>(arg6.treasury, arg3, v6, arg8);
        let v7 = RedeemPyEvent<T0>{
            sy_id            : 0x2::object::id<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>>(arg2),
            pt_id            : 0x2::object::id<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTStruct<T0>>(arg4),
            yt_id            : 0x2::object::id<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>>(arg5),
            receiver         : 0x2::tx_context::sender(arg8),
            amount_pt        : 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(&v0),
            amount_yt        : 0x2::balance::value<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(&v1),
            amount_to_redeem : v3,
            share_out        : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::truncate(v5),
            expiry           : arg3.expiry,
        };
        0x2::event::emit<RedeemPyEvent<T0>>(v7);
        let v8 = FeeCollectedEvent<T0>{
            amount   : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::truncate(v6),
            treasury : arg6.treasury,
        };
        0x2::event::emit<FeeCollectedEvent<T0>>(v8);
        (0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::pt::PTCoin<T0>>(v0, arg8), 0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTCoin<T0>>(v1, arg8), 0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg3.sy_balance, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::truncate(v5)), arg8))
    }

    fun transfer_sy<T0: drop>(arg0: address, arg1: &mut YieldTokenConfig<T0>, arg2: 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>>(0x2::coin::from_balance<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(0x2::balance::split<0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYCoin<T0>>(&mut arg1.sy_balance, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::truncate(arg2)), arg3), arg0);
    }

    public fun update_and_distribute_interest<T0: drop>(arg0: &mut YieldTokenConfig<T0>, arg1: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg3: &YieldFactoryConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.expiry < 0x2::clock::timestamp_ms(arg4), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::factory_yc_not_expired());
        update_post_expiry_data<T0>(arg3, arg0, arg1, arg2, arg5);
        let (_, _) = collect_interest<T0>(arg3, arg0, arg2, arg1, arg5);
    }

    public fun update_config(arg0: &mut YieldFactoryConfig, arg1: u128, arg2: u128, arg3: u64, arg4: address) {
        let v0 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::create_from_raw_value(arg1);
        let v1 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::create_from_raw_value(arg2);
        let v2 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::create_from_rational(1, 5);
        assert!(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::less_or_equal(v0, v2), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::interest_fee_rate_too_high());
        assert!(0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::less_or_equal(v1, v2), 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::reward_fee_rate_too_high());
        assert!(arg3 > 0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::factory_zero_expiry_divisor());
        arg0.expiry_divisor = arg3;
        arg0.interest_rate = v0;
        arg0.reward_rate = v1;
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

    fun update_interest_index<T0: drop>(arg0: &YieldFactoryConfig, arg1: &mut YieldTokenConfig<T0>, arg2: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64) {
        if (arg1.last_interest_epoch != 0x2::tx_context::epoch(arg4)) {
            arg1.last_interest_epoch = 0x2::tx_context::epoch(arg4);
            let v0 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::total_supply<T0>(arg3);
            let (v1, _) = collect_interest<T0>(arg0, arg1, arg3, arg2, arg4);
            let v3 = arg1.global_interest_index;
            let v4 = v3;
            if (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::is_zero(v3)) {
                v4 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::create_from_raw_value(1);
            };
            if (v0 != 0) {
                v4 = 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::add(v4, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::divDown(v1, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::from_uint64(v0)));
            };
            arg1.global_interest_index = v4;
        };
        (arg1.global_interest_index, arg1.index_stored)
    }

    fun update_post_expiry_data<T0: drop>(arg0: &YieldFactoryConfig, arg1: &mut YieldTokenConfig<T0>, arg2: &mut 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy::SYStruct<T0>, arg3: &0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::yt::YTStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::is_zero(arg1.first_index)) {
            let (_, _) = update_interest_index<T0>(arg0, arg1, arg2, arg3, arg4);
            let v2 = current_py_index<T0>(arg0, arg1, arg2, arg4);
            arg1.first_index = v2;
        };
    }

    // decompiled from Move bytecode v6
}

