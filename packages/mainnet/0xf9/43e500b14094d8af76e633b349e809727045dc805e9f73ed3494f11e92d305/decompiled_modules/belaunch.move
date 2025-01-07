module 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::belaunch {
    struct BELAUNCH has drop {
        dummy_field: bool,
    }

    struct FundraiserCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        is_settle: bool,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        treasury_admin_address: address,
        fee_create_sale: u64,
        fee_other: u64,
    }

    struct PoolConfig has store, key {
        id: 0x2::object::UID,
        fee_create_sale: u64,
        fee_other: u64,
    }

    struct VestingSchedule has store {
        using_vesting: bool,
        tge_percent: u64,
        lock_after_tge: u64,
        period_duration: u64,
        cycle_percent: u64,
    }

    struct VestingMap has store {
        total_amount: u64,
        released_amount: u64,
        vesting_start: u64,
        last_completed_period: u64,
        tge_status: bool,
    }

    struct UserInfo<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        image_url: 0x2::url::Url,
        img_url: 0x2::url::Url,
        url: 0x2::url::Url,
        purchased_amount: u64,
        is_claim: bool,
        ref_from: vector<address>,
        vesting_map: VestingMap,
        claimed_at: u64,
    }

    struct UserPayment has store, key {
        id: 0x2::object::UID,
        user: address,
        purchased_amount: u64,
        is_claim: bool,
    }

    struct Whitelist<phantom T0, phantom T1> has store {
        id: 0x2::object::UID,
        is_whitelist: bool,
        is_shutdown: bool,
        list: 0x2::object_table::ObjectTable<address, WhitelistedUser<T0, T1>>,
    }

    struct WhitelistedUser<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        account: address,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        fundraiser: address,
        decimals: u64,
        total_supply: u64,
        sale_type: u64,
        sale_amount: u64,
        sale_minum_amount: u64,
        sale_max_amount: u64,
        sale_rate: u64,
        start_sale_at: u64,
        end_sale_at: u64,
        soft_cap: u64,
        hard_cap: u64,
        lock_duration: u64,
        liquidity_lock_time: u64,
        raised_amount: u64,
        liquidity_percent: u64,
        listing_rate: u64,
        router: u64,
        to_sell: 0x2::balance::Balance<T0>,
        to_liquidity: 0x2::balance::Balance<T0>,
        raised: 0x2::balance::Balance<T1>,
        buyers: 0x2::object_table::ObjectTable<address, UserPayment>,
        contributors: u64,
        whitelist: Whitelist<T0, T1>,
        vesting: VestingSchedule,
        is_affiliate: bool,
        is_successful: bool,
    }

    struct PoolId has store, key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
    }

    struct ListedPools has store, key {
        id: 0x2::object::UID,
        lists: 0x2::object_table::ObjectTable<0x2::object::ID, PoolId>,
    }

    struct Referrer has store, key {
        id: 0x2::object::UID,
        referrer: address,
        total_rewards: u64,
        ref_list: vector<address>,
        is_claim: bool,
    }

    struct RefFrom has store, key {
        id: 0x2::object::UID,
        referrer: address,
        total_fee: u64,
    }

    struct Affiliate<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reward_percent: u64,
        total_rewards: u64,
        total_ref: u64,
        referrers: 0x2::object_table::ObjectTable<address, Referrer>,
    }

    struct BuyEvent has copy, drop {
        user: address,
        purchased: u64,
    }

    struct ClaimEvent has copy, drop {
        user: address,
        claimCoin: u64,
    }

    struct InitializePoolEvent has copy, drop {
        fundraiser: address,
        sale_amount: u64,
    }

    struct DepositToSellEvent has copy, drop {
        fundraiser: address,
        dep_sale_amount: u64,
    }

    struct WithdrawRaiseFundsEvent has copy, drop {
        fundraiser: address,
        raised_amount: u64,
        sale_amount: u64,
        sale_refunds_amount: u64,
        completed_percent: u64,
    }

    public entry fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut UserInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.start_sale_at < v0, 21);
        assert!(arg0.end_sale_at > v0, 10);
        assert!(arg4 > 0, 6);
        assert!(0x2::balance::value<T0>(&arg0.to_sell) > 0, 16);
        assert!(arg4 >= arg0.sale_minum_amount, 20);
        assert!(arg4 <= arg0.sale_max_amount, 28);
        assert!(0x2::coin::value<T1>(&arg3) == arg4, 39);
        let v1 = 0x2::tx_context::sender(arg6);
        if (arg0.is_affiliate) {
            if (arg5 != @0x1) {
                let v2 = 0x2::dynamic_object_field::borrow_mut<bool, Affiliate<T0, T1>>(&mut arg0.id, true);
                let v3 = arg4 * v2.reward_percent / 100;
                v2.total_rewards = v2.total_rewards + v3;
                if (!0x2::object_table::contains<address, Referrer>(&v2.referrers, arg5)) {
                    let v4 = Referrer{
                        id            : 0x2::object::new(arg6),
                        referrer      : arg5,
                        total_rewards : v3,
                        ref_list      : 0x1::vector::empty<address>(),
                        is_claim      : false,
                    };
                    0x1::vector::push_back<address>(&mut v4.ref_list, v1);
                    0x2::object_table::add<address, Referrer>(&mut v2.referrers, arg5, v4);
                    v2.total_ref = v2.total_ref + 1;
                } else {
                    let v5 = 0x2::object_table::borrow_mut<address, Referrer>(&mut v2.referrers, arg5);
                    if (v5.total_rewards == 0) {
                        v2.total_ref = v2.total_ref + 1;
                    };
                    v5.total_rewards = v5.total_rewards + v3;
                    0x1::vector::push_back<address>(&mut v5.ref_list, v1);
                };
                if (!0x2::dynamic_object_field::exists_<address>(&arg1.id, arg5)) {
                    let v6 = RefFrom{
                        id        : 0x2::object::new(arg6),
                        referrer  : arg5,
                        total_fee : v3,
                    };
                    0x2::dynamic_object_field::add<address, RefFrom>(&mut arg1.id, arg5, v6);
                    0x1::vector::push_back<address>(&mut arg1.ref_from, arg5);
                } else {
                    let v7 = 0x2::dynamic_object_field::borrow_mut<address, RefFrom>(&mut arg1.id, arg5);
                    if (v7.total_fee == 0) {
                        0x1::vector::push_back<address>(&mut arg1.ref_from, arg5);
                    };
                    v7.total_fee = v7.total_fee + v3;
                };
            };
        };
        if (arg0.sale_type == 0) {
            assert!(arg0.raised_amount + arg4 <= arg0.hard_cap, 19);
        };
        0x2::balance::join<T1>(&mut arg0.raised, 0x2::coin::into_balance<T1>(arg3));
        arg0.raised_amount = arg0.raised_amount + arg4;
        arg1.purchased_amount = arg1.purchased_amount + arg4;
        arg1.is_claim = false;
        let v8 = BuyEvent{
            user      : v1,
            purchased : arg4,
        };
        0x2::event::emit<BuyEvent>(v8);
        if (!0x2::object_table::contains<address, UserPayment>(&arg0.buyers, v1)) {
            let v9 = UserPayment{
                id               : 0x2::object::new(arg6),
                user             : v1,
                purchased_amount : arg1.purchased_amount,
                is_claim         : false,
            };
            0x2::object_table::add<address, UserPayment>(&mut arg0.buyers, v1, v9);
            arg0.contributors = arg0.contributors + 1;
        } else {
            let v10 = 0x2::object_table::borrow_mut<address, UserPayment>(&mut arg0.buyers, v1);
            if (v10.purchased_amount == 0) {
                arg0.contributors = arg0.contributors + 1;
            };
            v10.purchased_amount = v10.purchased_amount + arg4;
        };
    }

    fun calculate_total_vesting_time(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 > arg0) {
            (arg2 - arg0) / 86400000 / arg1
        } else {
            0
        }
    }

    fun calculate_vesting_amount<T0, T1>(arg0: &Pool<T0, T1>, arg1: &mut UserInfo<T0, T1>, arg2: u64) : u64 {
        if (arg0.vesting.using_vesting) {
            assert!(arg1.vesting_map.released_amount < arg1.vesting_map.total_amount, 42);
            let v1 = arg0.vesting.tge_percent;
            let v2 = arg0.vesting.period_duration;
            assert!(arg2 > arg1.vesting_map.vesting_start, 37);
            if (v1 > 0 && arg1.vesting_map.tge_status) {
                let v3 = 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(arg1.vesting_map.total_amount, v1, 100);
                arg1.vesting_map.released_amount = arg1.vesting_map.released_amount + v3;
                arg1.vesting_map.tge_status = false;
                v3
            } else {
                let v4 = calculate_total_vesting_time(arg1.vesting_map.last_completed_period, v2, arg2);
                assert!(v4 > 0, 38);
                let v5 = arg1.vesting_map.last_completed_period + v4 * v2 * 86400000;
                assert!(arg2 > v5, 37);
                let v6 = 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(arg1.vesting_map.total_amount, arg0.vesting.cycle_percent, 100) * v4;
                let v7 = arg1.vesting_map.total_amount - arg1.vesting_map.released_amount;
                let v8 = if (v6 >= v7) {
                    v7
                } else {
                    v6
                };
                arg1.vesting_map.released_amount = arg1.vesting_map.released_amount + v8;
                arg1.vesting_map.last_completed_period = v5;
                v8
            }
        } else {
            arg1.vesting_map.released_amount = arg1.vesting_map.total_amount;
            arg1.vesting_map.total_amount
        }
    }

    public entry fun claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut UserInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0 > arg0.end_sale_at + arg0.lock_duration, 9);
        assert!(arg1.purchased_amount > 0, 16);
        assert!(!arg1.is_claim, 24);
        if (arg0.raised_amount < arg0.soft_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.raised, arg1.purchased_amount, arg3), v1);
            arg1.is_claim = true;
            arg1.claimed_at = v0;
            0x2::object_table::borrow_mut<address, UserPayment>(&mut arg0.buyers, v1).is_claim = true;
            let v2 = ClaimEvent{
                user      : v1,
                claimCoin : 0,
            };
            0x2::event::emit<ClaimEvent>(v2);
        } else if (arg0.sale_type == 0) {
            if (arg0.raised_amount >= arg0.soft_cap && arg0.raised_amount <= arg0.hard_cap) {
                let v3 = arg1.purchased_amount / 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::power_decimals(9 - arg0.decimals) * arg0.sale_rate;
                arg1.vesting_map.total_amount = v3;
                let v4 = calculate_vesting_amount<T0, T1>(arg0, arg1, v0);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.to_sell, v4, arg3), v1);
                if (arg1.vesting_map.released_amount == arg1.vesting_map.total_amount) {
                    arg1.is_claim = true;
                    arg1.claimed_at = v0;
                    0x2::object_table::borrow_mut<address, UserPayment>(&mut arg0.buyers, v1).is_claim = true;
                };
                let v5 = ClaimEvent{
                    user      : v1,
                    claimCoin : v3,
                };
                0x2::event::emit<ClaimEvent>(v5);
            };
        } else if (arg0.raised_amount >= arg0.soft_cap) {
            let v6 = if (arg0.sale_type == 1) {
                0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(arg0.sale_amount, arg1.purchased_amount, arg0.raised_amount)
            } else {
                0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(arg1.purchased_amount, 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(arg0.sale_rate, arg0.soft_cap, arg0.raised_amount), 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::power_decimals(9 - arg0.decimals))
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.to_sell, v6, arg3), v1);
            if (arg0.sale_type == 2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.raised, arg1.purchased_amount - 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(arg1.purchased_amount, arg0.soft_cap, arg0.raised_amount), arg3), v1);
            };
            if (arg1.vesting_map.released_amount == arg1.vesting_map.total_amount) {
                arg1.is_claim = true;
                arg1.claimed_at = v0;
                0x2::object_table::borrow_mut<address, UserPayment>(&mut arg0.buyers, v1).is_claim = true;
            };
            let v7 = ClaimEvent{
                user      : v1,
                claimCoin : v6,
            };
            0x2::event::emit<ClaimEvent>(v7);
        };
    }

    public entry fun claim_ref_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_affiliate, 30);
        assert!(arg0.is_successful, 32);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_sale_at + arg0.lock_duration, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<bool, Affiliate<T0, T1>>(&mut arg0.id, true);
        assert!(0x2::object_table::contains<address, Referrer>(&v1.referrers, v0), 31);
        let v2 = 0x2::object_table::borrow_mut<address, Referrer>(&mut v1.referrers, v0);
        assert!(!v2.is_claim, 24);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.raised, v2.total_rewards, arg2), v0);
        v2.is_claim = true;
    }

    public entry fun create_sale<T0, T1>(arg0: &mut ListedPools, arg1: &0x2::clock::Clock, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::coin::Coin<T0>, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: 0x2::coin::Coin<0x2::sui::SUI>, arg26: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 2, 46);
        assert!(arg24 <= 2, 43);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::comparator::is_equal(&v2), 34);
        let v3 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        assert!(!0x2::object_table::contains<0x2::object::ID, PoolId>(&arg0.lists, v3), 1);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg10, 22);
        assert!(arg11 >= arg10, 2);
        assert!(arg12 > 0, 15);
        assert!(arg3 <= 9, 41);
        assert!(arg20 >= 0 && arg20 <= 10, 36);
        if (arg5 == 0) {
            assert!(arg13 > 0, 3);
            assert!(arg13 >= arg12, 29);
            assert!(arg9 > 0, 15);
            if (arg24 > 0) {
                assert!(arg18 > 0, 15);
            };
        } else {
            assert!(arg24 > 0, 43);
            assert!(arg21 == 0, 44);
            assert!(arg22 == 0, 44);
            assert!(arg23 == 0, 44);
        };
        if (arg5 == 2) {
            assert!(arg9 > 0, 15);
            assert!(arg18 > 0, 15);
            assert!(arg20 == 0, 35);
        };
        assert!(arg6 > 0, 13);
        if (arg24 > 0) {
            assert!(arg17 > 51 && arg17 <= 100, 33);
            assert!(arg15 >= 5097601, 2);
        };
        let v4 = 0x2::tx_context::sender(arg26);
        if (v4 != @0xbd98eff8cb12fbcb269a334137c00c693d704ce878d8e1fed640acedb235254f || v4 != @0xbd98eff8cb12fbcb269a334137c00c693d704ce878d8e1fed640acedb235254f) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg25) >= 1500000000000, 45);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg25, 1500000000000, arg26), @0xbd98eff8cb12fbcb269a334137c00c693d704ce878d8e1fed640acedb235254f);
            if (0x2::coin::value<0x2::sui::SUI>(&arg25) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg25, v4);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg25);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg25, v4);
        };
        let v5 = arg20 > 0;
        let v6 = arg5 == 0 && arg23 > 0 && arg22 > 0;
        let v7 = Whitelist<T0, T1>{
            id           : 0x2::object::new(arg26),
            is_whitelist : false,
            is_shutdown  : false,
            list         : 0x2::object_table::new<address, WhitelistedUser<T0, T1>>(arg26),
        };
        let v8 = VestingSchedule{
            using_vesting   : v6,
            tge_percent     : arg21,
            lock_after_tge  : arg16,
            period_duration : arg22,
            cycle_percent   : arg23,
        };
        let v9 = Pool<T0, T1>{
            id                  : 0x2::object::new(arg26),
            fundraiser          : v4,
            decimals            : arg3,
            total_supply        : arg4,
            sale_type           : arg5,
            sale_amount         : arg6,
            sale_minum_amount   : arg7,
            sale_max_amount     : arg8,
            sale_rate           : arg9,
            start_sale_at       : arg10,
            end_sale_at         : arg11,
            soft_cap            : arg12,
            hard_cap            : arg13,
            lock_duration       : arg14,
            liquidity_lock_time : arg15,
            raised_amount       : 0,
            liquidity_percent   : arg17,
            listing_rate        : arg18,
            router              : arg24,
            to_sell             : 0x2::balance::zero<T0>(),
            to_liquidity        : 0x2::balance::zero<T0>(),
            raised              : 0x2::balance::zero<T1>(),
            buyers              : 0x2::object_table::new<address, UserPayment>(arg26),
            contributors        : 0,
            whitelist           : v7,
            vesting             : v8,
            is_affiliate        : v5,
            is_successful       : false,
        };
        let v10 = 0x2::dynamic_object_field::borrow<bool, GlobalConfig>(&mut arg0.id, true);
        let v11 = PoolConfig{
            id              : 0x2::object::new(arg26),
            fee_create_sale : v10.fee_create_sale,
            fee_other       : v10.fee_create_sale,
        };
        0x2::dynamic_object_field::add<u64, PoolConfig>(&mut v9.id, 1, v11);
        let v12 = 0x2::coin::balance_mut<T0>(arg19);
        if (arg24 > 0) {
            let v13 = if (1 == arg5) {
                0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(arg6, arg17, 100)
            } else {
                let v14 = if (0 == arg5) {
                    0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(arg13, 95, 100)
                } else {
                    0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(arg12, 95, 100)
                };
                0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(v14, arg17, 100) / 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::power_decimals(9 - arg3) * arg18
            };
            assert!(0x2::balance::value<T0>(v12) >= arg6 + v13, 14);
            0x2::balance::join<T0>(&mut v9.to_liquidity, 0x2::balance::split<T0>(v12, v13));
        };
        let v15 = PoolId{
            id      : 0x2::object::new(arg26),
            item_id : v3,
        };
        0x2::object_table::add<0x2::object::ID, PoolId>(&mut arg0.lists, v3, v15);
        if (v5) {
            let v16 = Affiliate<T0, T1>{
                id             : 0x2::object::new(arg26),
                reward_percent : arg20,
                total_rewards  : 0,
                total_ref      : 0,
                referrers      : 0x2::object_table::new<address, Referrer>(arg26),
            };
            0x2::dynamic_object_field::add<bool, Affiliate<T0, T1>>(&mut v9.id, true, v16);
        };
        0x2::balance::join<T0>(&mut v9.to_sell, 0x2::balance::split<T0>(v12, arg6));
        let v17 = FundraiserCap<T0, T1>{
            id        : 0x2::object::new(arg26),
            is_settle : false,
        };
        0x2::transfer::transfer<FundraiserCap<T0, T1>>(v17, v4);
        0x2::transfer::share_object<Pool<T0, T1>>(v9);
        let v18 = InitializePoolEvent{
            fundraiser  : v4,
            sale_amount : arg6,
        };
        0x2::event::emit<InitializePoolEvent>(v18);
    }

    public entry fun emergency_withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut UserInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.purchased_amount > 0, 18);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_sale_at - 600000, 10);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.raised, arg1.purchased_amount - arg1.purchased_amount * 10 / 100, arg3), v0);
        arg0.raised_amount = arg0.raised_amount - arg1.purchased_amount;
        arg0.contributors = arg0.contributors - 1;
        arg1.is_claim = true;
        arg1.purchased_amount = 0;
        if (arg0.is_affiliate) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<bool, Affiliate<T0, T1>>(&mut arg0.id, true);
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&arg1.ref_from)) {
                let v3 = 0x1::vector::pop_back<address>(&mut arg1.ref_from);
                let v4 = 0x2::object_table::borrow_mut<address, Referrer>(&mut v1.referrers, v3);
                let v5 = 0x2::dynamic_object_field::borrow_mut<address, RefFrom>(&mut arg1.id, v3);
                let v6 = v5.total_fee;
                v1.total_rewards = v1.total_rewards - v6;
                v4.total_rewards = v4.total_rewards - v6;
                v5.total_fee = 0;
                if (v4.total_rewards == 0) {
                    v1.total_ref = v1.total_ref - 1;
                };
                v2 = v2 + 1;
            };
        };
        0x2::object_table::borrow_mut<address, UserPayment>(&mut arg0.buyers, v0).purchased_amount = 0;
    }

    public fun get_fee_create_sale(arg0: &GlobalConfig) : u64 {
        arg0.fee_create_sale
    }

    public fun get_treasury_admin_address(arg0: &GlobalConfig) : address {
        arg0.treasury_admin_address
    }

    fun init(arg0: BELAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<BELAUNCH>(arg0, arg1);
        let v0 = ListedPools{
            id    : 0x2::object::new(arg1),
            lists : 0x2::object_table::new<0x2::object::ID, PoolId>(arg1),
        };
        0x2::transfer::share_object<ListedPools>(v0);
        let v1 = GlobalConfig{
            id                     : 0x2::object::new(arg1),
            treasury_admin_address : 0x2::tx_context::sender(arg1),
            fee_create_sale        : 1500000000000,
            fee_other              : 0,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public entry fun mint_user_info<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (arg0.sale_type == 0 && arg0.whitelist.is_whitelist) {
            assert!(0x2::object_table::contains<address, WhitelistedUser<T0, T1>>(&arg0.whitelist.list, v0), 26);
        };
        let v1 = VestingMap{
            total_amount          : 0,
            released_amount       : 0,
            vesting_start         : arg0.end_sale_at + arg0.lock_duration,
            last_completed_period : arg0.end_sale_at + arg0.lock_duration + arg0.vesting.lock_after_tge,
            tge_status            : true,
        };
        let v2 = UserInfo<T0, T1>{
            id               : 0x2::object::new(arg1),
            image_url        : 0x2::url::new_unsafe_from_bytes(b"https://belaunch.infura-ipfs.io/ipfs/Qmd1vEvdC517MNFGVy1iNWi8TFDuftrYyUveknXFS9U91H"),
            img_url          : 0x2::url::new_unsafe_from_bytes(b"https://belaunch.infura-ipfs.io/ipfs/Qmd1vEvdC517MNFGVy1iNWi8TFDuftrYyUveknXFS9U91H"),
            url              : 0x2::url::new_unsafe_from_bytes(b"https://belaunch.infura-ipfs.io/ipfs/Qmd1vEvdC517MNFGVy1iNWi8TFDuftrYyUveknXFS9U91H"),
            purchased_amount : 0,
            is_claim         : false,
            ref_from         : 0x1::vector::empty<address>(),
            vesting_map      : v1,
            claimed_at       : 0,
        };
        0x2::transfer::transfer<UserInfo<T0, T1>>(v2, v0);
    }

    public entry fun remove_whitelist<T0, T1>(arg0: &FundraiserCap<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.whitelist.is_whitelist, 25);
        assert!(arg1.sale_type == 0, 27);
        arg1.whitelist.is_shutdown = true;
        arg1.whitelist.is_whitelist = false;
    }

    public entry fun set_config(arg0: &mut ListedPools, arg1: GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.treasury_admin_address, 47);
        0x2::dynamic_object_field::add<bool, GlobalConfig>(&mut arg0.id, true, arg1);
    }

    public entry fun set_fee_create_sale(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xbd98eff8cb12fbcb269a334137c00c693d704ce878d8e1fed640acedb235254f, 47);
        arg0.fee_create_sale = arg1;
    }

    public entry fun set_treasury_admin_address(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury_admin_address, 47);
        arg0.treasury_admin_address = arg1;
    }

    public entry fun settle<T0, T1>(arg0: &mut 0x969873132b1f2522aa69228c87df3377f91c7d434799bf2e120c9511a35ffe9::locker::Locks, arg1: &0x2::clock::Clock, arg2: &mut Pool<T0, T1>, arg3: &mut FundraiserCap<T0, T1>, arg4: &mut 0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::factory::Global, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg2.fundraiser == v0, 5);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg2.end_sale_at, 9);
        let v1 = 0;
        let v2 = 0;
        if (arg2.is_affiliate) {
            v2 = 0x2::dynamic_object_field::borrow<bool, Affiliate<T0, T1>>(&mut arg2.id, true).total_rewards;
        };
        let v3 = 100;
        if (arg2.raised_amount < arg2.soft_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.to_sell, 0x2::balance::value<T0>(&arg2.to_sell), arg8), 0x2::tx_context::sender(arg8));
            v1 = arg2.sale_amount;
            v3 = 0;
        } else if (arg2.sale_type == 0) {
            if (arg2.raised_amount >= arg2.soft_cap && arg2.raised_amount <= arg2.hard_cap) {
                let v4 = arg2.raised_amount - v2;
                let v5 = 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(v4, 95, 100);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.raised, 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(v4, 5, 100), arg8), @0xbd98eff8cb12fbcb269a334137c00c693d704ce878d8e1fed640acedb235254f);
                if (arg2.router > 0) {
                    let v6 = 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(v5, arg2.liquidity_percent, 100);
                    let v7 = 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(v4, 100, arg2.hard_cap);
                    v3 = v7;
                    if (arg2.liquidity_percent < 100) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.raised, v5 - v6, arg8), v0);
                    };
                    let v8 = 0x2::balance::value<T0>(&arg2.to_liquidity);
                    let v9 = 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(v8, v7, 100);
                    0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::router::add_liquidity<T1, T0>(arg0, arg1, arg4, 9, arg2.decimals, 0x2::coin::take<T1>(&mut arg2.raised, v6, arg8), 0, 0x2::coin::take<T0>(&mut arg2.to_liquidity, v9, arg8), 0, arg5, arg6, arg7, 1, arg2.liquidity_lock_time, arg8);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.to_liquidity, v8 - v9, arg8), v0);
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.raised, v5, arg8), v0);
                };
                let v10 = arg2.sale_amount - arg2.raised_amount / 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::power_decimals(9 - arg2.decimals) * arg2.sale_rate;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.to_sell, v10, arg8), v0);
                v1 = v10;
                arg2.is_successful = true;
            };
        } else if (arg2.raised_amount >= arg2.soft_cap) {
            let v11 = if (arg2.sale_type == 1) {
                arg2.raised_amount - v2
            } else {
                arg2.soft_cap
            };
            let v12 = 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(v11, 95, 100);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.raised, 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(v11, 5, 100), arg8), @0xbd98eff8cb12fbcb269a334137c00c693d704ce878d8e1fed640acedb235254f);
            if (arg2.router > 0) {
                let v13 = 0x6a296daeb42e7b6a1bc212135aad05733b69c8b671cf74e6c0a42e1cfa9757ba::math::mul_div(v12, arg2.liquidity_percent, 100);
                if (arg2.liquidity_percent < 100) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.raised, v12 - v13, arg8), v0);
                };
                0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::router::add_liquidity<T1, T0>(arg0, arg1, arg4, 9, arg2.decimals, 0x2::coin::take<T1>(&mut arg2.raised, v13, arg8), 0, 0x2::coin::take<T0>(&mut arg2.to_liquidity, 0x2::balance::value<T0>(&arg2.to_liquidity), arg8), 0, arg5, arg6, arg7, 1, arg2.liquidity_lock_time, arg8);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.raised, v12, arg8), v0);
            };
            arg2.is_successful = true;
        };
        arg3.is_settle = true;
        let v14 = WithdrawRaiseFundsEvent{
            fundraiser          : v0,
            raised_amount       : 0x2::balance::value<T1>(&arg2.raised),
            sale_amount         : arg2.sale_amount,
            sale_refunds_amount : v1,
            completed_percent   : v3,
        };
        0x2::event::emit<WithdrawRaiseFundsEvent>(v14);
    }

    public entry fun update_whitelist<T0, T1>(arg0: &FundraiserCap<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<address>(&arg2), 25);
        assert!(arg1.sale_type == 0, 27);
        assert!(!arg1.whitelist.is_shutdown, 40);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = WhitelistedUser<T0, T1>{
                id      : 0x2::object::new(arg3),
                account : v1,
            };
            0x2::object_table::add<address, WhitelistedUser<T0, T1>>(&mut arg1.whitelist.list, v1, v2);
            v0 = v0 + 1;
        };
        if (!arg1.whitelist.is_whitelist) {
            arg1.whitelist.is_whitelist = true;
        };
    }

    // decompiled from Move bytecode v6
}

