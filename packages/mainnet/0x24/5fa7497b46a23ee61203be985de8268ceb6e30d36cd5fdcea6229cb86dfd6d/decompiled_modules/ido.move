module 0x245fa7497b46a23ee61203be985de8268ceb6e30d36cd5fdcea6229cb86dfd6d::ido {
    struct IDO has drop {
        dummy_field: bool,
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

    struct UserInfo<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        account: address,
        purchased_amount: u64,
        is_claim: bool,
        ref_from: vector<address>,
        vesting_map: VestingMap,
        claimed_at: u64,
    }

    struct RaisedFunds<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        raised: 0x2::balance::Balance<T1>,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
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
        router: u64,
        raised_amount: u64,
        to_sell: 0x2::balance::Balance<T0>,
        buyers: 0x2::object_table::ObjectTable<address, UserInfo<T0, T1>>,
        contributors: u64,
        whitelist: Whitelist<T0, T1>,
        vesting: VestingSchedule,
        is_affiliate: bool,
        affiliate: Affiliate<T0, T1>,
        is_successful: bool,
        is_settled: bool,
    }

    struct ListedPools has store, key {
        id: 0x2::object::UID,
        lists: vector<0x2::object::ID>,
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

    public entry fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg6);
        if (arg0.sale_type == 0) {
            assert!(arg0.raised_amount + arg3 <= arg0.hard_cap, 19);
        };
        if (arg5 == 0) {
            assert!(arg0.start_sale_at < v0, 21);
            assert!(arg0.end_sale_at > v0, 10);
            assert!(arg3 > 0, 6);
            assert!(0x2::balance::value<T0>(&arg0.to_sell) > 0, 16);
            assert!(arg3 >= arg0.sale_minum_amount, 20);
            assert!(arg3 <= arg0.sale_max_amount, 28);
            assert!(0x2::coin::value<T1>(&arg2) >= arg3, 39);
            if (arg0.sale_type == 0 && arg0.whitelist.is_whitelist && !arg0.whitelist.is_shutdown) {
                assert!(0x2::object_table::contains<address, WhitelistedUser<T0, T1>>(&arg0.whitelist.list, v1), 26);
            };
            if (!0x2::object_table::contains<address, UserInfo<T0, T1>>(&arg0.buyers, v1)) {
                let v2 = VestingMap{
                    total_amount          : 0,
                    released_amount       : 0,
                    vesting_start         : arg0.end_sale_at + arg0.lock_duration,
                    last_completed_period : arg0.end_sale_at + arg0.lock_duration + arg0.vesting.lock_after_tge,
                    tge_status            : true,
                };
                let v3 = UserInfo<T0, T1>{
                    id               : 0x2::object::new(arg6),
                    account          : v1,
                    purchased_amount : arg3,
                    is_claim         : false,
                    ref_from         : 0x1::vector::empty<address>(),
                    vesting_map      : v2,
                    claimed_at       : 0,
                };
                0x2::object_table::add<address, UserInfo<T0, T1>>(&mut arg0.buyers, v1, v3);
                arg0.contributors = arg0.contributors + 1;
            } else {
                let v4 = 0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v1);
                if (v4.purchased_amount == 0) {
                    arg0.contributors = arg0.contributors + 1;
                };
                v4.purchased_amount = v4.purchased_amount + arg3;
            };
            if (arg0.is_affiliate) {
                if (arg4 != @0x1) {
                    let v5 = arg3 * arg0.affiliate.reward_percent / 100;
                    arg0.affiliate.total_rewards = arg0.affiliate.total_rewards + v5;
                    if (!0x2::object_table::contains<address, Referrer>(&arg0.affiliate.referrers, arg4)) {
                        let v6 = Referrer{
                            id            : 0x2::object::new(arg6),
                            referrer      : arg4,
                            total_rewards : v5,
                            ref_list      : 0x1::vector::empty<address>(),
                            is_claim      : false,
                        };
                        0x1::vector::push_back<address>(&mut v6.ref_list, v1);
                        0x2::object_table::add<address, Referrer>(&mut arg0.affiliate.referrers, arg4, v6);
                        arg0.affiliate.total_ref = arg0.affiliate.total_ref + 1;
                    } else {
                        let v7 = 0x2::object_table::borrow_mut<address, Referrer>(&mut arg0.affiliate.referrers, arg4);
                        v7.total_rewards = v7.total_rewards + v5;
                        0x1::vector::push_back<address>(&mut v7.ref_list, v1);
                    };
                    let v8 = 0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v1);
                    if (!0x2::dynamic_object_field::exists_<address>(&v8.id, arg4)) {
                        let v9 = RefFrom{
                            id        : 0x2::object::new(arg6),
                            referrer  : arg4,
                            total_fee : v5,
                        };
                        0x2::dynamic_object_field::add<address, RefFrom>(&mut v8.id, arg4, v9);
                        0x1::vector::push_back<address>(&mut v8.ref_from, arg4);
                    } else {
                        let v10 = 0x2::dynamic_object_field::borrow_mut<address, RefFrom>(&mut v8.id, arg4);
                        if (v10.total_fee == 0) {
                            0x1::vector::push_back<address>(&mut v8.ref_from, arg4);
                        };
                        v10.total_fee = v10.total_fee + v5;
                    };
                };
            };
            0x2::balance::join<T1>(&mut 0x2::dynamic_object_field::borrow_mut<u64, RaisedFunds<T0, T1>>(&mut arg0.id, 1).raised, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, arg3, arg6)));
            if (0x2::coin::value<T1>(&arg2) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v1);
            } else {
                0x2::coin::destroy_zero<T1>(arg2);
            };
            arg0.raised_amount = arg0.raised_amount + arg3;
            let v11 = BuyEvent{
                user      : v1,
                purchased : arg3,
            };
            0x2::event::emit<BuyEvent>(v11);
        } else {
            assert!(arg0.fundraiser == v1, 17);
            if (!0x2::object_table::contains<address, UserInfo<T0, T1>>(&arg0.buyers, v1)) {
                let v12 = VestingMap{
                    total_amount          : 0,
                    released_amount       : 0,
                    vesting_start         : arg0.end_sale_at + arg0.lock_duration,
                    last_completed_period : arg0.end_sale_at + arg0.lock_duration + arg0.vesting.lock_after_tge,
                    tge_status            : true,
                };
                let v13 = UserInfo<T0, T1>{
                    id               : 0x2::object::new(arg6),
                    account          : v1,
                    purchased_amount : arg3,
                    is_claim         : false,
                    ref_from         : 0x1::vector::empty<address>(),
                    vesting_map      : v12,
                    claimed_at       : 0,
                };
                0x2::object_table::add<address, UserInfo<T0, T1>>(&mut arg0.buyers, v1, v13);
                arg0.contributors = arg0.contributors + 1;
            } else {
                let v14 = 0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v1);
                if (v14.purchased_amount == 0) {
                    arg0.contributors = arg0.contributors + 1;
                };
                v14.purchased_amount = v14.purchased_amount + arg3;
            };
            arg0.raised_amount = arg0.raised_amount + arg3;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v1);
        };
    }

    fun calculate_total_vesting_time(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 > arg0) {
            (arg2 - arg0) / 86400000 / arg1
        } else {
            0
        }
    }

    public entry fun claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::object_table::contains<address, UserInfo<T0, T1>>(&arg0.buyers, v0), 18);
        let v1 = 0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(v2 > arg0.end_sale_at + arg0.lock_duration, 9);
        assert!(v1.purchased_amount > 0, 16);
        assert!(!v1.is_claim, 24);
        let v3 = 0x2::dynamic_object_field::borrow_mut<u64, RaisedFunds<T0, T1>>(&mut arg0.id, 1);
        if (arg0.raised_amount < arg0.soft_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v3.raised, v1.purchased_amount, arg2), v0);
            v1.is_claim = true;
            v1.claimed_at = v2;
            0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v0).is_claim = true;
            let v4 = ClaimEvent{
                user      : v0,
                claimCoin : 0,
            };
            0x2::event::emit<ClaimEvent>(v4);
        } else if (arg0.raised_amount >= arg0.soft_cap && arg0.raised_amount <= arg0.hard_cap) {
            let v5 = 0x245fa7497b46a23ee61203be985de8268ceb6e30d36cd5fdcea6229cb86dfd6d::math::mul_div(v1.purchased_amount, arg0.sale_rate, 1000);
            v1.vesting_map.total_amount = v5;
            let v6 = if (arg0.vesting.using_vesting) {
                assert!(v1.vesting_map.released_amount < v1.vesting_map.total_amount, 42);
                let v7 = arg0.vesting.tge_percent;
                let v8 = arg0.vesting.period_duration;
                assert!(v2 > v1.vesting_map.vesting_start, 37);
                if (v7 > 0 && v1.vesting_map.tge_status) {
                    let v9 = 0x245fa7497b46a23ee61203be985de8268ceb6e30d36cd5fdcea6229cb86dfd6d::math::mul_div(v1.vesting_map.total_amount, v7, 100);
                    v1.vesting_map.released_amount = v1.vesting_map.released_amount + v9;
                    v1.vesting_map.tge_status = false;
                    v9
                } else {
                    let v10 = calculate_total_vesting_time(v1.vesting_map.last_completed_period, v8, v2);
                    assert!(v10 > 0, 38);
                    let v11 = v1.vesting_map.last_completed_period + v10 * v8 * 86400000;
                    assert!(v2 > v11, 37);
                    let v12 = 0x245fa7497b46a23ee61203be985de8268ceb6e30d36cd5fdcea6229cb86dfd6d::math::mul_div(v1.vesting_map.total_amount, arg0.vesting.cycle_percent, 10000) * v10;
                    let v13 = v1.vesting_map.total_amount - v1.vesting_map.released_amount;
                    let v14 = if (v12 >= v13) {
                        v13
                    } else {
                        v12
                    };
                    v1.vesting_map.released_amount = v1.vesting_map.released_amount + v14;
                    v1.vesting_map.last_completed_period = v11;
                    v14
                }
            } else {
                v1.vesting_map.released_amount = v1.vesting_map.total_amount;
                v1.vesting_map.total_amount
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.to_sell, v6, arg2), v0);
            if (v1.vesting_map.released_amount == v1.vesting_map.total_amount) {
                v1.is_claim = true;
                v1.claimed_at = v2;
                0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v0).is_claim = true;
            };
            let v15 = ClaimEvent{
                user      : v0,
                claimCoin : v5,
            };
            0x2::event::emit<ClaimEvent>(v15);
        };
    }

    public entry fun claim_ref_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_affiliate, 30);
        assert!(arg0.is_successful, 32);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_sale_at + arg0.lock_duration, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::object_table::contains<address, Referrer>(&arg0.affiliate.referrers, v0), 31);
        let v1 = 0x2::object_table::borrow_mut<address, Referrer>(&mut arg0.affiliate.referrers, v0);
        assert!(!v1.is_claim, 24);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut 0x2::dynamic_object_field::borrow_mut<u64, RaisedFunds<T0, T1>>(&mut arg0.id, 1).raised, v1.total_rewards, arg2), v0);
        v1.is_claim = true;
    }

    public entry fun create_sale<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut ListedPools, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::coin::Coin<T0>, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 2, 46);
        assert!(arg24 <= 2, 43);
        let v0 = 0x2::tx_context::sender(arg25);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg12, 22);
        assert!(arg13 >= arg12, 2);
        assert!(arg14 > 0, 15);
        assert!(arg5 <= 9, 41);
        assert!(arg20 >= 0 && arg20 <= 10, 36);
        if (arg7 == 0) {
            assert!(arg15 > 0, 3);
            assert!(arg15 >= arg14, 29);
            assert!(arg11 > 0, 15);
            if (arg24 > 0) {
                assert!(arg18 > 0, 15);
            };
        } else {
            assert!(arg24 > 0, 43);
            assert!(arg21 == 0, 44);
            assert!(arg22 == 0, 44);
            assert!(arg23 == 0, 44);
        };
        if (arg7 == 2) {
            assert!(arg11 > 0, 15);
            assert!(arg18 > 0, 15);
            assert!(arg20 == 0, 35);
        };
        assert!(arg8 > 0, 13);
        let v1 = arg20 > 0;
        let v2 = arg7 == 0 && arg23 > 0 && arg22 > 0;
        let v3 = Whitelist<T0, T1>{
            id           : 0x2::object::new(arg25),
            is_whitelist : false,
            is_shutdown  : false,
            list         : 0x2::object_table::new<address, WhitelistedUser<T0, T1>>(arg25),
        };
        let v4 = VestingSchedule{
            using_vesting   : v2,
            tge_percent     : arg21,
            lock_after_tge  : arg17,
            period_duration : arg22,
            cycle_percent   : arg23,
        };
        let v5 = Affiliate<T0, T1>{
            id             : 0x2::object::new(arg25),
            reward_percent : arg20,
            total_rewards  : 0,
            total_ref      : 0,
            referrers      : 0x2::object_table::new<address, Referrer>(arg25),
        };
        let v6 = Pool<T0, T1>{
            id                : 0x2::object::new(arg25),
            name              : 0x1::string::utf8(arg3),
            fundraiser        : v0,
            decimals          : arg5,
            total_supply      : arg6,
            sale_type         : arg7,
            sale_amount       : arg8,
            sale_minum_amount : arg9,
            sale_max_amount   : arg10,
            sale_rate         : arg11,
            start_sale_at     : arg12,
            end_sale_at       : arg13,
            soft_cap          : arg14,
            hard_cap          : arg15,
            lock_duration     : arg16,
            router            : arg24,
            raised_amount     : 0,
            to_sell           : 0x2::balance::zero<T0>(),
            buyers            : 0x2::object_table::new<address, UserInfo<T0, T1>>(arg25),
            contributors      : 0,
            whitelist         : v3,
            vesting           : v4,
            is_affiliate      : v1,
            affiliate         : v5,
            is_successful     : false,
            is_settled        : false,
        };
        let v7 = RaisedFunds<T0, T1>{
            id     : 0x2::object::new(arg25),
            raised : 0x2::balance::zero<T1>(),
        };
        0x2::dynamic_object_field::add<u64, RaisedFunds<T0, T1>>(&mut v6.id, 1, v7);
        0x2::balance::join<T0>(&mut v6.to_sell, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg19), arg8));
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.lists, 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg4));
        0x2::transfer::share_object<Pool<T0, T1>>(v6);
        let v8 = InitializePoolEvent{
            fundraiser  : v0,
            sale_amount : arg8,
        };
        0x2::event::emit<InitializePoolEvent>(v8);
    }

    public entry fun emergency_withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::object_table::contains<address, UserInfo<T0, T1>>(&arg0.buyers, v0), 18);
        let v1 = 0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v0);
        assert!(v1.purchased_amount > 0, 18);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.end_sale_at - 600000, 10);
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut 0x2::dynamic_object_field::borrow_mut<u64, RaisedFunds<T0, T1>>(&mut arg0.id, 1).raised, v1.purchased_amount - v1.purchased_amount * 10 / 100, arg2), v2);
        arg0.raised_amount = arg0.raised_amount - v1.purchased_amount;
        arg0.contributors = arg0.contributors - 1;
        v1.is_claim = true;
        v1.purchased_amount = 0;
        if (arg0.is_affiliate) {
            let v3 = 0;
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(&v1.ref_from)) {
                let v5 = 0x1::vector::pop_back<address>(&mut v1.ref_from);
                let v6 = 0x2::object_table::borrow_mut<address, Referrer>(&mut arg0.affiliate.referrers, v5);
                let v7 = 0x2::dynamic_object_field::borrow_mut<address, RefFrom>(&mut v1.id, v5);
                let v8 = v7.total_fee;
                v3 = v3 + v8;
                v6.total_rewards = v6.total_rewards - v8;
                v7.total_fee = 0;
                if (v6.total_rewards == 0) {
                    arg0.affiliate.total_ref = arg0.affiliate.total_ref - 1;
                };
                v4 = v4 + 1;
            };
            arg0.affiliate.total_rewards = arg0.affiliate.total_rewards - v3;
        };
        0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v2).purchased_amount = 0;
    }

    fun init(arg0: IDO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<IDO>(arg0, arg1);
        let v0 = ListedPools{
            id    : 0x2::object::new(arg1),
            lists : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<ListedPools>(v0);
    }

    public entry fun remove_whitelist<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fundraiser == 0x2::tx_context::sender(arg1), 5);
        assert!(arg0.whitelist.is_whitelist, 25);
        assert!(arg0.sale_type == 0, 27);
        arg0.whitelist.is_shutdown = true;
        arg0.whitelist.is_whitelist = false;
    }

    public entry fun settle<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.fundraiser == v0, 5);
        assert!(!arg1.is_settled, 47);
        assert!(0x2::clock::timestamp_ms(arg0) >= arg1.end_sale_at, 9);
        let v1 = 0;
        let v2 = 0;
        if (arg1.is_affiliate) {
            v2 = 0x2::dynamic_object_field::borrow<bool, Affiliate<T0, T1>>(&mut arg1.id, true).total_rewards;
        };
        let v3 = 0x2::dynamic_object_field::borrow_mut<u64, RaisedFunds<T0, T1>>(&mut arg1.id, 1);
        let v4 = 100;
        if (arg1.raised_amount < arg1.soft_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.to_sell, 0x2::balance::value<T0>(&arg1.to_sell), arg2), 0x2::tx_context::sender(arg2));
            v1 = arg1.sale_amount;
            v4 = 0;
        } else if (arg1.raised_amount >= arg1.soft_cap && arg1.raised_amount <= arg1.hard_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v3.raised, arg1.raised_amount - v2, arg2), v0);
            let v5 = arg1.sale_amount - 0x245fa7497b46a23ee61203be985de8268ceb6e30d36cd5fdcea6229cb86dfd6d::math::mul_div(arg1.raised_amount, arg1.sale_rate, 1000);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.to_sell, v5, arg2), v0);
            v1 = v5;
            arg1.is_successful = true;
        };
        arg1.is_settled = true;
        let v6 = WithdrawRaiseFundsEvent{
            fundraiser          : v0,
            raised_amount       : 0x2::balance::value<T1>(&v3.raised),
            sale_amount         : arg1.sale_amount,
            sale_refunds_amount : v1,
            completed_percent   : v4,
        };
        0x2::event::emit<WithdrawRaiseFundsEvent>(v6);
    }

    public entry fun update_whitelist<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fundraiser == 0x2::tx_context::sender(arg2), 5);
        assert!(!0x1::vector::is_empty<address>(&arg1), 25);
        assert!(arg0.sale_type == 0, 27);
        assert!(!arg0.whitelist.is_shutdown, 40);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            let v2 = WhitelistedUser<T0, T1>{
                id      : 0x2::object::new(arg2),
                account : v1,
            };
            0x2::object_table::add<address, WhitelistedUser<T0, T1>>(&mut arg0.whitelist.list, v1, v2);
            v0 = v0 + 1;
        };
        if (!arg0.whitelist.is_whitelist) {
            arg0.whitelist.is_whitelist = true;
        };
    }

    // decompiled from Move bytecode v6
}

