module 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yield_factory {
    struct YieldFactoryConfig has key {
        id: 0x2::object::UID,
        interestFeeRate: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        rewardFeeRate: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        expiryDivisor: u64,
        doCacheIndexSameBlock: bool,
        treasury: address,
    }

    struct PyInterest<phantom T0: drop> has store {
        index: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        accured: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        pyIndex: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
    }

    struct YieldTokenConfig<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        expiry: u64,
        sy_balance: 0x2::balance::Balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>,
        currentIndex: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        indexStored: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        indexLastUpdatedEpoch: u64,
        firstIndex: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        lastInterestEpoch: u64,
        lastCollectInterestIndex: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        globalInterestIndex: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        totalSyInterestForTreasury: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        firstRewardIndex: 0x2::table::Table<address, u256>,
        userRewardOwed: 0x2::table::Table<address, u256>,
        userInterest: 0x2::table::Table<address, PyInterest<T0>>,
    }

    struct YieldTokenStore<phantom T0> has store, key {
        id: 0x2::object::UID,
        pt: 0x2::bag::Bag,
        yt: 0x2::bag::Bag,
    }

    struct ConfigInitEvent has copy, drop {
        interestFeeRate: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        rewardFeeRate: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        expiryDivisor: u64,
        treasury: address,
        doCacheIndexSameBlock: bool,
    }

    struct ConfigUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        interestFeeRate: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        rewardFeeRate: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64,
        expiryDivisor: u64,
        treasury: address,
    }

    struct ConfigStoreInitEvent<phantom T0: drop> has copy, drop {
        id: 0x2::object::ID,
    }

    struct PYCreationEvent<phantom T0: drop> has copy, drop {
        syId: 0x2::object::ID,
        tokenConfigId: 0x2::object::ID,
        exiry: u64,
    }

    struct MintPyEvent<phantom T0: drop> has copy, drop {
        syId: 0x2::object::ID,
        ptId: 0x2::object::ID,
        ytId: 0x2::object::ID,
        ptReceiver: address,
        ytReceiver: address,
        shareIn: u64,
        amountPT: u64,
        amountYT: u64,
        expiry: u64,
    }

    struct RedeemPyEvent<phantom T0: drop> has copy, drop {
        syId: 0x2::object::ID,
        ptId: 0x2::object::ID,
        ytId: 0x2::object::ID,
        receiver: address,
        amountPT: u64,
        amountYT: u64,
        amountToRedeem: u64,
        shareOut: u64,
        expiry: u64,
    }

    struct FeeCollectedEvent<phantom T0: drop> has copy, drop {
        amount: u64,
        treasury: address,
    }

    struct InterestCollectEvent<phantom T0: drop> has copy, drop {
        syId: 0x2::object::ID,
        ytId: 0x2::object::ID,
        amount: u64,
        receiver: address,
    }

    public fun create<T0: drop>(arg0: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg1: &mut YieldTokenStore<T0>, arg2: &YieldFactoryConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 % arg2.expiryDivisor == 0 && arg3 > 0x2::clock::timestamp_ms(arg4), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::factory_invalid_expiry());
        assert!(!0x2::bag::contains<u64>(&arg1.pt, arg3), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::factory_contract_exists());
        let v0 = 0x1::ascii::string(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::name<T0>(arg0));
        let v1 = 0x1::ascii::string(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::symbol<T0>(arg0));
        let v2 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::decimals<T0>(arg0);
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
        0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::create<T0>(0x1::ascii::into_bytes(v5), 0x1::ascii::into_bytes(v6), v2, arg3, arg5);
        0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::create<T0>(0x1::ascii::into_bytes(v7), 0x1::ascii::into_bytes(v8), v2, arg3, arg5);
        0x2::bag::add<u64, bool>(&mut arg1.pt, arg3, true);
        0x2::bag::add<u64, bool>(&mut arg1.yt, arg3, true);
        let v9 = YieldTokenConfig<T0>{
            id                         : 0x2::object::new(arg5),
            expiry                     : arg3,
            sy_balance                 : 0x2::balance::zero<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(),
            currentIndex               : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero(),
            indexStored                : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero(),
            indexLastUpdatedEpoch      : 0,
            firstIndex                 : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero(),
            lastInterestEpoch          : 0,
            lastCollectInterestIndex   : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero(),
            globalInterestIndex        : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero(),
            totalSyInterestForTreasury : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero(),
            firstRewardIndex           : 0x2::table::new<address, u256>(arg5),
            userRewardOwed             : 0x2::table::new<address, u256>(arg5),
            userInterest               : 0x2::table::new<address, PyInterest<T0>>(arg5),
        };
        let v10 = PYCreationEvent<T0>{
            syId          : 0x2::object::id<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>>(arg0),
            tokenConfigId : 0x2::object::id<YieldTokenConfig<T0>>(&v9),
            exiry         : arg3,
        };
        0x2::event::emit<PYCreationEvent<T0>>(v10);
        0x2::transfer::share_object<YieldTokenConfig<T0>>(v9);
    }

    fun collectInterest<T0: drop>(arg0: &YieldFactoryConfig, arg1: &mut YieldTokenConfig<T0>, arg2: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg3: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64) {
        let v0 = arg1.lastCollectInterestIndex;
        let v1 = currentPyIndex<T0>(arg0, arg1, arg3, arg4);
        let v2 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero();
        if (!0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::is_zero(v0) && !0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::equal(v0, v1)) {
            let v3 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::one();
            if (0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::is_zero(arg1.firstIndex)) {
                v3 = arg0.interestFeeRate;
            };
            let v4 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::divDown(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::multiply(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::from_uint64(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::totalSupply<T0>(arg2)), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::sub(v1, v0)), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::multiply(v0, v1));
            let v5 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::multiply(v4, v3);
            v2 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::sub(v4, v5);
            transferSY<T0>(arg0.treasury, arg1, v5, arg4);
        };
        arg1.lastCollectInterestIndex = v1;
        (v2, v1)
    }

    public fun currentPyIndex<T0: drop>(arg0: &YieldFactoryConfig, arg1: &mut YieldTokenConfig<T0>, arg2: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg3: &0x2::tx_context::TxContext) : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64 {
        if (arg0.doCacheIndexSameBlock && arg1.indexLastUpdatedEpoch == 0x2::tx_context::epoch(arg3)) {
            arg1.indexStored
        } else {
            let v1 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::max(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::exchangeRate<T0>(arg2), arg1.indexStored);
            arg1.currentIndex = v1;
            arg1.indexStored = v1;
            arg1.indexLastUpdatedEpoch = 0x2::tx_context::epoch(arg3);
            v1
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_config(arg0: u128, arg1: u128, arg2: u64, arg3: bool, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::create_from_raw_value(arg0);
        let v1 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::create_from_raw_value(arg1);
        let v2 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::create_from_rational(1, 5);
        assert!(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::less_or_equal(v0, v2), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::interest_fee_rate_too_high());
        assert!(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::less_or_equal(v1, v2), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::reward_fee_rate_too_high());
        assert!(arg2 > 0, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::factory_zero_expiry_divisor());
        let v3 = YieldFactoryConfig{
            id                    : 0x2::object::new(arg5),
            interestFeeRate       : v0,
            rewardFeeRate         : v1,
            expiryDivisor         : arg2,
            doCacheIndexSameBlock : arg3,
            treasury              : arg4,
        };
        let v4 = ConfigInitEvent{
            interestFeeRate       : v0,
            rewardFeeRate         : v1,
            expiryDivisor         : arg2,
            treasury              : arg4,
            doCacheIndexSameBlock : arg3,
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

    public fun mintPY<T0: drop>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>, arg3: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTStruct<T0>, arg5: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg6: &mut YieldTokenConfig<T0>, arg7: &YieldFactoryConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>, 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>) {
        let v0 = 0x2::coin::into_balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(arg2);
        assert!(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::expiry<T0>(arg4) == 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::expiry<T0>(arg5) && 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::expiry<T0>(arg4) == arg6.expiry, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::mismatch_yt_pt_tokens());
        assert!(arg6.expiry >= 0x2::clock::timestamp_ms(arg8), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::factory_yc_expired());
        let v1 = currentPyIndex<T0>(arg7, arg6, arg3, arg9);
        let v2 = 0x2::balance::value<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(&v0);
        let v3 = (0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::divide_u128(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::multiply_u128((v2 as u128), v1), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::one()) as u64);
        0x2::balance::join<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(&mut arg6.sy_balance, v0);
        let v4 = MintPyEvent<T0>{
            syId       : 0x2::object::id<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>>(arg3),
            ptId       : 0x2::object::id<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTStruct<T0>>(arg4),
            ytId       : 0x2::object::id<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>>(arg5),
            ptReceiver : arg0,
            ytReceiver : arg1,
            shareIn    : v2,
            amountPT   : v3,
            amountYT   : v3,
            expiry     : arg6.expiry,
        };
        0x2::event::emit<MintPyEvent<T0>>(v4);
        (0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::mint<T0>(arg4, arg0, v3, arg9), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::mint<T0>(arg5, arg1, v3, arg9))
    }

    public fun redeemDueInterest<T0: drop>(arg0: address, arg1: &0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>, arg2: &mut YieldTokenConfig<T0>, arg3: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg5: &YieldFactoryConfig, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>(arg1);
        let (v1, v2) = updateInterestIndex<T0>(arg5, arg2, arg3, arg4, arg6);
        if (!0x2::table::contains<address, PyInterest<T0>>(&arg2.userInterest, arg0)) {
            let v3 = PyInterest<T0>{
                index   : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero(),
                accured : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero(),
                pyIndex : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero(),
            };
            0x2::table::add<address, PyInterest<T0>>(&mut arg2.userInterest, arg0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, PyInterest<T0>>(&mut arg2.userInterest, arg0);
        let v5 = v4.index;
        if (!0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::equal(v5, v1)) {
            v4.index = v1;
            v4.pyIndex = v2;
            if (!0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::is_zero(v5)) {
                v4.accured = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::multiply(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::sub(v1, v5), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::from_uint64(0x2::balance::value<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>(v0)));
            };
        };
        let v6 = v4.accured;
        v4.accured = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero();
        transferSY<T0>(arg0, arg2, v6, arg6);
        let v7 = InterestCollectEvent<T0>{
            syId     : 0x2::object::id<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>>(arg3),
            ytId     : 0x2::object::id<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>>(arg4),
            amount   : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::truncate(v6),
            receiver : arg0,
        };
        0x2::event::emit<InterestCollectEvent<T0>>(v7);
    }

    public fun redeemInterestAndRewardForTreasury<T0: drop>(arg0: &mut YieldTokenConfig<T0>, arg1: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg2: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg3: &YieldFactoryConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.expiry < 0x2::clock::timestamp_ms(arg4), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::factory_yc_not_expired());
        let (_, _) = collectInterest<T0>(arg3, arg0, arg2, arg1, arg5);
        let v2 = FeeCollectedEvent<T0>{
            amount   : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::truncate(arg0.totalSyInterestForTreasury),
            treasury : arg3.treasury,
        };
        0x2::event::emit<FeeCollectedEvent<T0>>(v2);
    }

    public fun redeemPY<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>, arg2: 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>, arg3: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &mut YieldTokenConfig<T0>, arg5: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTStruct<T0>, arg6: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg7: &YieldFactoryConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = redeem_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>>(v2, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>>(v0, 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>>(v1, 0x2::tx_context::sender(arg9));
    }

    public fun redeemPY_with_coin_back<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>, arg2: 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>, arg3: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &mut YieldTokenConfig<T0>, arg5: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTStruct<T0>, arg6: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg7: &YieldFactoryConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>, 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>, 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>) {
        redeem_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun redeem_internal<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>, arg2: 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>, arg3: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg4: &mut YieldTokenConfig<T0>, arg5: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTStruct<T0>, arg6: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg7: &YieldFactoryConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>, 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>, 0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>) {
        let v0 = 0x2::coin::into_balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>(arg1);
        let v1 = 0x2::coin::into_balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg8) > arg4.expiry;
        let v3 = if (v2) {
            updatePostExpiryData<T0>(arg7, arg4, arg3, arg6, arg9);
            0x2::balance::value<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>(&v0)
        } else {
            0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::math64::min(0x2::balance::value<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>(&v0), 0x2::balance::value<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>(&v1))
        };
        0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::burn<T0>(arg5, 0x2::balance::split<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>(&mut v0, v3));
        if (!v2) {
            0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::burn<T0>(arg6, 0x2::balance::split<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>(&mut v1, v3));
        };
        let v4 = currentPyIndex<T0>(arg7, arg4, arg3, arg9);
        let v5 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::divDown(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::from_uint64(v3), v4);
        let v6 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::zero();
        if (v2) {
            v6 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::sub(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::divDown(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::from_uint64(v3), arg4.firstIndex), v5);
        };
        transferSY<T0>(arg7.treasury, arg4, v6, arg9);
        let v7 = RedeemPyEvent<T0>{
            syId           : 0x2::object::id<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>>(arg3),
            ptId           : 0x2::object::id<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTStruct<T0>>(arg5),
            ytId           : 0x2::object::id<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>>(arg6),
            receiver       : arg0,
            amountPT       : 0x2::balance::value<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>(&v0),
            amountYT       : 0x2::balance::value<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>(&v1),
            amountToRedeem : v3,
            shareOut       : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::truncate(v5),
            expiry         : arg4.expiry,
        };
        0x2::event::emit<RedeemPyEvent<T0>>(v7);
        let v8 = FeeCollectedEvent<T0>{
            amount   : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::truncate(v6),
            treasury : arg7.treasury,
        };
        0x2::event::emit<FeeCollectedEvent<T0>>(v8);
        (0x2::coin::from_balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::pt::PTCoin<T0>>(v0, arg9), 0x2::coin::from_balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTCoin<T0>>(v1, arg9), 0x2::coin::from_balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(0x2::balance::split<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(&mut arg4.sy_balance, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::truncate(v5)), arg9))
    }

    fun transferSY<T0: drop>(arg0: address, arg1: &mut YieldTokenConfig<T0>, arg2: 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>>(0x2::coin::from_balance<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(0x2::balance::split<0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYCoin<T0>>(&mut arg1.sy_balance, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::truncate(arg2)), arg3), arg0);
    }

    public fun updateAndDistributeInterest<T0: drop>(arg0: &mut YieldTokenConfig<T0>, arg1: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg2: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg3: &YieldFactoryConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.expiry < 0x2::clock::timestamp_ms(arg4), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::factory_yc_not_expired());
        updatePostExpiryData<T0>(arg3, arg0, arg1, arg2, arg5);
        let (_, _) = collectInterest<T0>(arg3, arg0, arg2, arg1, arg5);
    }

    fun updateInterestIndex<T0: drop>(arg0: &YieldFactoryConfig, arg1: &mut YieldTokenConfig<T0>, arg2: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg3: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64) {
        if (arg1.lastInterestEpoch != 0x2::tx_context::epoch(arg4)) {
            arg1.lastInterestEpoch = 0x2::tx_context::epoch(arg4);
            let v0 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::totalSupply<T0>(arg3);
            let (v1, _) = collectInterest<T0>(arg0, arg1, arg3, arg2, arg4);
            let v3 = arg1.globalInterestIndex;
            let v4 = v3;
            if (0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::is_zero(v3)) {
                v4 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::create_from_raw_value(1);
            };
            if (v0 != 0) {
                v4 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::add(v4, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::divDown(v1, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::from_uint64(v0)));
            };
            arg1.globalInterestIndex = v4;
        };
        (arg1.globalInterestIndex, arg1.indexStored)
    }

    fun updatePostExpiryData<T0: drop>(arg0: &YieldFactoryConfig, arg1: &mut YieldTokenConfig<T0>, arg2: &mut 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy::SYStruct<T0>, arg3: &0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::yt::YTStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::is_zero(arg1.firstIndex)) {
            let (_, _) = updateInterestIndex<T0>(arg0, arg1, arg2, arg3, arg4);
            let v2 = currentPyIndex<T0>(arg0, arg1, arg2, arg4);
            arg1.firstIndex = v2;
        };
    }

    public fun update_config(arg0: &mut YieldFactoryConfig, arg1: u128, arg2: u128, arg3: u64, arg4: address) {
        let v0 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::create_from_raw_value(arg1);
        let v1 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::create_from_raw_value(arg2);
        let v2 = 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::create_from_rational(1, 5);
        assert!(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::less_or_equal(v0, v2), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::interest_fee_rate_too_high());
        assert!(0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::less_or_equal(v1, v2), 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::reward_fee_rate_too_high());
        assert!(arg3 > 0, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::factory_zero_expiry_divisor());
        arg0.expiryDivisor = arg3;
        arg0.interestFeeRate = v0;
        arg0.rewardFeeRate = v1;
        arg0.treasury = arg4;
        let v3 = ConfigUpdateEvent{
            id              : 0x2::object::uid_to_inner(&arg0.id),
            interestFeeRate : v0,
            rewardFeeRate   : v1,
            expiryDivisor   : arg3,
            treasury        : arg4,
        };
        0x2::event::emit<ConfigUpdateEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

