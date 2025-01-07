module 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::yield_factory {
    struct YieldFactoryConfig has key {
        id: 0x2::object::UID,
        interest_fee_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        reward_fee_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        do_cache_index_same_block: bool,
        treasury: address,
    }

    struct ConfigInitEvent has copy, drop {
        interest_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        reward_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
        do_cache_index_same_block: bool,
    }

    struct ConfigUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        interest_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        reward_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
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

    public fun mint_py<T0: drop>(arg0: &0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::oracle::PriceVoucher<T0>, arg3: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::PyPosition, arg4: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::PyState<T0>, arg5: &YieldFactoryConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::assert_current_version(arg0);
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::oracle::get_price<T0>(arg2, arg7));
        mint_py_internal<T0>(arg1, v0, arg3, arg4, arg5, arg6, arg7);
    }

    public fun redeem_due_interest<T0: drop>(arg0: address, arg1: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::PyPosition, arg2: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::PyState<T0>, arg3: 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::oracle::PriceVoucher<T0>, arg4: &YieldFactoryConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::PyState<T0>>(arg2) == 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::py_state_id(arg1), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::factory_invalid_py());
        let v0 = 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::oracle::get_price<T0>(arg3, arg6);
        if (0x2::clock::timestamp_ms(arg5) > 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::py_expiry(arg1)) {
            0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::set_post_expiry_data<T0>(arg4.do_cache_index_same_block, arg4.treasury, arg4.interest_fee_rate, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(v0), arg2, arg6);
        };
        0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::update_user_interest<T0>(arg4.do_cache_index_same_block, arg4.treasury, arg4.interest_fee_rate, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(v0), arg1, arg2, arg6);
        let v1 = InterestCollectEvent<T0>{
            py_id    : 0x2::object::id<0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::PyPosition>(arg1),
            amount   : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::truncate(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::redeem_due_interest<T0>(arg0, arg1, arg2, arg6)),
            receiver : arg0,
        };
        0x2::event::emit<InterestCollectEvent<T0>>(v1);
    }

    public(friend) fun cache_in_same_block(arg0: &YieldFactoryConfig) : bool {
        arg0.do_cache_index_same_block
    }

    public fun create<T0: drop>(arg0: &0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::Version, arg1: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::PyStore, arg2: &YieldFactoryConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::assert_current_version(arg0);
        assert!(arg3 % arg2.expiry_divisor == 0 && arg3 > 0x2::clock::timestamp_ms(arg4), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::factory_invalid_expiry());
        0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::create_py<T0>(arg1, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg5);
        let v0 = PYCreationEvent<T0>{expiry: arg3};
        0x2::event::emit<PYCreationEvent<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_config(arg0: &0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::Version, arg1: u128, arg2: u128, arg3: u64, arg4: bool, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::assert_current_version(arg0);
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(arg1);
        let v1 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(arg2);
        let v2 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_rational(1, 5);
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::less_or_equal(v0, v2), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::interest_fee_rate_too_high());
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::less_or_equal(v1, v2), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::reward_fee_rate_too_high());
        assert!(arg3 > 0, 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::factory_zero_expiry_divisor());
        let v3 = YieldFactoryConfig{
            id                        : 0x2::object::new(arg6),
            interest_fee_rate         : v0,
            reward_fee_rate           : v1,
            expiry_divisor            : arg3,
            do_cache_index_same_block : arg4,
            treasury                  : arg5,
        };
        let v4 = ConfigInitEvent{
            interest_rate             : v0,
            reward_rate               : v1,
            expiry_divisor            : arg3,
            treasury                  : arg5,
            do_cache_index_same_block : arg4,
        };
        0x2::event::emit<ConfigInitEvent>(v4);
        0x2::transfer::share_object<YieldFactoryConfig>(v3);
    }

    public(friend) fun interest_fee_rate(arg0: &YieldFactoryConfig) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        arg0.interest_fee_rate
    }

    public(friend) fun mint_py_internal<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg2: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::PyPosition, arg3: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::PyState<T0>, arg4: &YieldFactoryConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::expiry(arg2) >= 0x2::clock::timestamp_ms(arg5), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::factory_invalid_expiry());
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::truncate(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::sy::sy_to_asset(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::current_py_index<T0>(arg4.do_cache_index_same_block, arg1, arg3, arg6), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(v0)));
        0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::join_sy<T0>(arg0, arg3, arg6);
        0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::update_user_interest<T0>(arg4.do_cache_index_same_block, arg4.treasury, arg4.interest_fee_rate, arg1, arg2, arg3, arg6);
        0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::mint_py<T0>(v1, v1, arg2, arg3, arg6);
        let v2 = MintPyEvent<T0>{
            py_id     : 0x2::object::id<0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::PyPosition>(arg2),
            share_in  : v0,
            amount_pt : v1,
            amount_yt : v1,
            expiry    : 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::expiry(arg2),
        };
        0x2::event::emit<MintPyEvent<T0>>(v2);
    }

    public fun redeem_interest_and_reward_for_treasury<T0: drop>(arg0: &0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::Version, arg1: &YieldFactoryConfig, arg2: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::PyState<T0>, arg3: 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::oracle::PriceVoucher<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::assert_current_version(arg0);
        assert!(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::py_state_expiry<T0>(arg2) < 0x2::clock::timestamp_ms(arg4), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::factory_yc_not_expired());
        let (_, _) = 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::collect_interest<T0>(arg1.do_cache_index_same_block, arg1.treasury, arg1.interest_fee_rate, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::oracle::get_price<T0>(arg3, arg5)), arg2, arg5);
    }

    public fun redeem_py<T0: drop>(arg0: &0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::Version, arg1: u64, arg2: u64, arg3: 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::oracle::PriceVoucher<T0>, arg4: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::PyPosition, arg5: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::PyState<T0>, arg6: &YieldFactoryConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::assert_current_version(arg0);
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::oracle::get_price<T0>(arg3, arg8));
        redeem_py_internal<T0>(arg1, arg2, v0, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun redeem_py_internal<T0: drop>(arg0: u64, arg1: u64, arg2: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg3: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::PyPosition, arg4: &mut 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::PyState<T0>, arg5: &YieldFactoryConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::PyState<T0>>(arg4) == 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::py_state_id(arg3), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::factory_invalid_py());
        let v0 = 0x2::clock::timestamp_ms(arg6) > 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::expiry(arg3);
        let v1 = if (v0) {
            0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::set_post_expiry_data<T0>(arg5.do_cache_index_same_block, arg5.treasury, arg5.interest_fee_rate, arg2, arg4, arg7);
            arg1
        } else {
            0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math64::min(arg1, arg0)
        };
        0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::burn_pt<T0>(arg3, arg4, v1);
        if (!v0) {
            0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::update_user_interest<T0>(arg5.do_cache_index_same_block, arg5.treasury, arg5.interest_fee_rate, arg2, arg3, arg4, arg7);
            0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::burn_yt<T0>(arg3, arg4, v1);
        };
        let v2 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::truncate(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::sy::asset_to_sy(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::current_py_index<T0>(arg5.do_cache_index_same_block, arg2, arg4, arg7), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(v1)));
        let v3 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::zero();
        if (v0) {
            v3 = 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::sy::asset_to_sy(0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::first_py_index<T0>(arg4), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(v1));
        };
        0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::transfer_sy<T0>(arg5.treasury, arg4, v3, arg7);
        let v4 = RedeemPyEvent<T0>{
            py_id            : 0x2::object::id<0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::PyPosition>(arg3),
            amount_pt        : v1,
            amount_yt        : v1,
            amount_to_redeem : v1,
            share_out        : v2,
            expiry           : 0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py_position::expiry(arg3),
        };
        0x2::event::emit<RedeemPyEvent<T0>>(v4);
        let v5 = FeeCollectedEvent<T0>{
            amount   : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::truncate(v3),
            treasury : arg5.treasury,
        };
        0x2::event::emit<FeeCollectedEvent<T0>>(v5);
        0x529f140f0e78f2f52d4ceab861c6d48cb3a097915da219f189d5a705df0b2cfb::py::split_sy<T0>(v2, arg4, arg7)
    }

    public(friend) fun treasury(arg0: &YieldFactoryConfig) : address {
        arg0.treasury
    }

    public fun update_config(arg0: &0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::Version, arg1: &mut YieldFactoryConfig, arg2: u128, arg3: u128, arg4: u64, arg5: address) {
        0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::assert_current_version(arg0);
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(arg2);
        let v1 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(arg3);
        let v2 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_rational(1, 5);
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::less_or_equal(v0, v2), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::interest_fee_rate_too_high());
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::less_or_equal(v1, v2), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::reward_fee_rate_too_high());
        assert!(arg4 > 0, 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::factory_zero_expiry_divisor());
        arg1.expiry_divisor = arg4;
        arg1.interest_fee_rate = v0;
        arg1.reward_fee_rate = v1;
        arg1.treasury = arg5;
        let v3 = ConfigUpdateEvent{
            id             : 0x2::object::uid_to_inner(&arg1.id),
            interest_rate  : v0,
            reward_rate    : v1,
            expiry_divisor : arg4,
            treasury       : arg5,
        };
        0x2::event::emit<ConfigUpdateEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

