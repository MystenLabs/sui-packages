module 0x22efa0a355d6ace17503e34c010366c12a542407a35a7da0be9c3e1e175f0ceb::ido {
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
        one_buy: bool,
        order_book: u64,
        list: 0x2::object_table::ObjectTable<address, WhitelistedUser<T0, T1>>,
    }

    struct WhitelistedUser<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        account: address,
        is_buy: bool,
        order_book: u64,
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

    struct TreasuryEmergency<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        tsemy: 0x2::balance::Balance<T1>,
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

    public entry fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        if (arg0.sale_type == 0) {
            assert!(arg0.raised_amount + arg3 <= arg0.hard_cap, 19);
        };
        if (arg4 == 0) {
            assert!(arg0.start_sale_at < v0, 21);
            assert!(arg0.end_sale_at > v0, 10);
            assert!(arg3 > 0, 6);
            assert!(0x2::balance::value<T0>(&arg0.to_sell) > 0, 16);
            assert!(arg3 >= arg0.sale_minum_amount, 20);
            assert!(arg3 <= arg0.sale_max_amount, 28);
            assert!(0x2::coin::value<T1>(&arg2) >= arg3, 39);
            if (arg0.sale_type == 0 && arg0.whitelist.is_whitelist && !arg0.whitelist.is_shutdown) {
                assert!(0x2::object_table::contains<address, WhitelistedUser<T0, T1>>(&arg0.whitelist.list, v1), 26);
                if (arg0.whitelist.one_buy) {
                    assert!(!0x2::object_table::borrow_mut<address, WhitelistedUser<T0, T1>>(&mut arg0.whitelist.list, v1).is_buy, 48);
                };
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
                    id               : 0x2::object::new(arg5),
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
            0x2::balance::join<T1>(&mut 0x2::dynamic_object_field::borrow_mut<u64, TreasuryEmergency<T0, T1>>(&mut arg0.id, 1).tsemy, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, arg3, arg5)));
            if (0x2::coin::value<T1>(&arg2) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v1);
            } else {
                0x2::coin::destroy_zero<T1>(arg2);
            };
            if (arg0.sale_type == 0 && arg0.whitelist.is_whitelist && !arg0.whitelist.is_shutdown) {
                if (arg0.whitelist.one_buy) {
                    0x2::object_table::borrow_mut<address, WhitelistedUser<T0, T1>>(&mut arg0.whitelist.list, v1).is_buy = true;
                };
            };
            arg0.raised_amount = arg0.raised_amount + arg3;
            let v5 = BuyEvent{
                user      : v1,
                purchased : arg3,
            };
            0x2::event::emit<BuyEvent>(v5);
        } else {
            assert!(0x2::object_table::contains<address, WhitelistedUser<T0, T1>>(&arg0.whitelist.list, v1), 26);
            assert!(0x2::object_table::borrow_mut<address, WhitelistedUser<T0, T1>>(&mut arg0.whitelist.list, v1).order_book > 0, 26);
            if (!0x2::object_table::contains<address, UserInfo<T0, T1>>(&arg0.buyers, v1)) {
                let v6 = VestingMap{
                    total_amount          : 0,
                    released_amount       : 0,
                    vesting_start         : arg0.end_sale_at + arg0.lock_duration,
                    last_completed_period : arg0.end_sale_at + arg0.lock_duration + arg0.vesting.lock_after_tge,
                    tge_status            : true,
                };
                let v7 = UserInfo<T0, T1>{
                    id               : 0x2::object::new(arg5),
                    account          : v1,
                    purchased_amount : arg3,
                    is_claim         : false,
                    ref_from         : 0x1::vector::empty<address>(),
                    vesting_map      : v6,
                    claimed_at       : 0,
                };
                0x2::object_table::add<address, UserInfo<T0, T1>>(&mut arg0.buyers, v1, v7);
                arg0.contributors = arg0.contributors + 1;
            } else {
                let v8 = 0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v1);
                if (v8.purchased_amount == 0) {
                    arg0.contributors = arg0.contributors + 1;
                };
                v8.purchased_amount = v8.purchased_amount + arg3;
            };
            arg0.raised_amount = arg0.raised_amount + arg3;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v1);
            let v9 = BuyEvent{
                user      : v1,
                purchased : arg3,
            };
            0x2::event::emit<BuyEvent>(v9);
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
        let v3 = 0x2::dynamic_object_field::borrow_mut<u64, TreasuryEmergency<T0, T1>>(&mut arg0.id, 1);
        if (arg0.raised_amount < arg0.soft_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v3.tsemy, v1.purchased_amount, arg2), v0);
            v1.is_claim = true;
            v1.claimed_at = v2;
            0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v0).is_claim = true;
            let v4 = ClaimEvent{
                user      : v0,
                claimCoin : 0,
            };
            0x2::event::emit<ClaimEvent>(v4);
        } else if (arg0.raised_amount >= arg0.soft_cap && arg0.raised_amount <= arg0.hard_cap) {
            let v5 = 0x22efa0a355d6ace17503e34c010366c12a542407a35a7da0be9c3e1e175f0ceb::math::mul_div(v1.purchased_amount, arg0.sale_rate, 1000);
            v1.vesting_map.total_amount = v5;
            let v6 = if (arg0.vesting.using_vesting) {
                assert!(v1.vesting_map.released_amount < v1.vesting_map.total_amount, 42);
                let v7 = arg0.vesting.tge_percent;
                let v8 = arg0.vesting.period_duration;
                assert!(v2 > v1.vesting_map.vesting_start, 37);
                if (v7 > 0 && v1.vesting_map.tge_status) {
                    let v9 = 0x22efa0a355d6ace17503e34c010366c12a542407a35a7da0be9c3e1e175f0ceb::math::mul_div(v1.vesting_map.total_amount, v7, 100);
                    v1.vesting_map.released_amount = v1.vesting_map.released_amount + v9;
                    v1.vesting_map.tge_status = false;
                    v9
                } else {
                    let v10 = calculate_total_vesting_time(v1.vesting_map.last_completed_period, v8, v2);
                    assert!(v10 > 0, 38);
                    let v11 = v1.vesting_map.last_completed_period + v10 * v8 * 86400000;
                    assert!(v2 > v11, 37);
                    let v12 = 0x22efa0a355d6ace17503e34c010366c12a542407a35a7da0be9c3e1e175f0ceb::math::mul_div(v1.vesting_map.total_amount, arg0.vesting.cycle_percent, 10000) * v10;
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
        let v1 = arg7 == 0 && arg23 > 0 && arg22 > 0;
        let v2 = Whitelist<T0, T1>{
            id           : 0x2::object::new(arg25),
            is_whitelist : false,
            is_shutdown  : false,
            one_buy      : false,
            order_book   : 0,
            list         : 0x2::object_table::new<address, WhitelistedUser<T0, T1>>(arg25),
        };
        let v3 = VestingSchedule{
            using_vesting   : v1,
            tge_percent     : arg21,
            lock_after_tge  : arg17,
            period_duration : arg22,
            cycle_percent   : arg23,
        };
        let v4 = Pool<T0, T1>{
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
            whitelist         : v2,
            vesting           : v3,
            is_successful     : false,
            is_settled        : false,
        };
        let v5 = TreasuryEmergency<T0, T1>{
            id    : 0x2::object::new(arg25),
            tsemy : 0x2::balance::zero<T1>(),
        };
        0x2::dynamic_object_field::add<u64, TreasuryEmergency<T0, T1>>(&mut v4.id, 1, v5);
        0x2::balance::join<T0>(&mut v4.to_sell, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg19), arg8));
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.lists, 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg4));
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        let v6 = InitializePoolEvent{
            fundraiser  : v0,
            sale_amount : arg8,
        };
        0x2::event::emit<InitializePoolEvent>(v6);
    }

    public entry fun emergency_withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::object_table::contains<address, UserInfo<T0, T1>>(&arg0.buyers, v0), 18);
        let v1 = 0x2::object_table::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.buyers, v0);
        assert!(v1.purchased_amount > 0, 18);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.end_sale_at - 600000, 10);
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut 0x2::dynamic_object_field::borrow_mut<u64, TreasuryEmergency<T0, T1>>(&mut arg0.id, 1).tsemy, v1.purchased_amount - v1.purchased_amount * 0 / 100, arg2), v2);
        arg0.raised_amount = arg0.raised_amount - v1.purchased_amount;
        arg0.contributors = arg0.contributors - 1;
        v1.is_claim = true;
        v1.purchased_amount = 0;
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
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, TreasuryEmergency<T0, T1>>(&mut arg1.id, 1);
        let v3 = 0x2::balance::value<T1>(&v2.tsemy);
        let v4 = 100;
        if (arg1.raised_amount < arg1.soft_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.to_sell, 0x2::balance::value<T0>(&arg1.to_sell), arg2), 0x2::tx_context::sender(arg2));
            v1 = arg1.sale_amount;
            v4 = 0;
        } else if (arg1.raised_amount >= arg1.soft_cap && arg1.raised_amount <= arg1.hard_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v2.tsemy, v3, arg2), v0);
            let v5 = arg1.sale_amount - 0x22efa0a355d6ace17503e34c010366c12a542407a35a7da0be9c3e1e175f0ceb::math::mul_div(arg1.raised_amount, arg1.sale_rate, 1000);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.to_sell, v5, arg2), v0);
            v1 = v5;
            arg1.is_successful = true;
        };
        arg1.is_settled = true;
        let v6 = WithdrawRaiseFundsEvent{
            fundraiser          : v0,
            raised_amount       : v3,
            sale_amount         : arg1.sale_amount,
            sale_refunds_amount : v1,
            completed_percent   : v4,
        };
        0x2::event::emit<WithdrawRaiseFundsEvent>(v6);
    }

    public entry fun update_whitelist<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<address>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fundraiser == 0x2::tx_context::sender(arg4), 5);
        assert!(!0x1::vector::is_empty<address>(&arg1), 25);
        assert!(arg0.sale_type == 0, 27);
        if (arg3 > 1) {
            assert!(!arg0.whitelist.is_shutdown, 40);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            assert!(!0x2::object_table::contains<address, WhitelistedUser<T0, T1>>(&arg0.whitelist.list, v1), 49);
            let v2 = WhitelistedUser<T0, T1>{
                id         : 0x2::object::new(arg4),
                account    : v1,
                is_buy     : false,
                order_book : arg3,
            };
            0x2::object_table::add<address, WhitelistedUser<T0, T1>>(&mut arg0.whitelist.list, v1, v2);
            v0 = v0 + 1;
        };
        if (arg2) {
            arg0.whitelist.one_buy = true;
        };
        if (arg3 > 1) {
            arg0.whitelist.order_book = arg3;
        } else if (!arg0.whitelist.is_whitelist) {
            arg0.whitelist.is_whitelist = true;
        };
    }

    // decompiled from Move bytecode v6
}

