module 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::farm {
    struct FarmKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Farm<phantom T0> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        funder: address,
        staked: 0x2::balance::Balance<T0>,
        rewards: 0x2::balance::Balance<T0>,
        unemitted: u64,
        rate: u256,
        period_ms: u64,
        end_ms: u64,
        last_ms: u64,
        acc: u256,
        total_weight: u128,
        min_lock_days: u64,
        max_lock_days: u64,
        max_boost_bps: u64,
        funded: u64,
        claimed: u64,
        stakers: u64,
        due: vector<u64>,
        checkpoints: 0x2::table::Table<u64, Checkpoint>,
        retired: bool,
    }

    struct Checkpoint has store {
        drop: u128,
        acc: u256,
        passed: bool,
        open: u64,
    }

    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        amount: u64,
        weight: u128,
        lock_days: u64,
        lock_end_ms: u64,
        acc_entry: u256,
        boosted: bool,
    }

    struct FarmCreated has copy, drop {
        farm_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        previous: 0x1::option::Option<0x2::object::ID>,
        funder: address,
        rewards: u64,
        period_ms: u64,
        min_lock_days: u64,
        max_lock_days: u64,
        max_boost_bps: u64,
    }

    struct FarmRetired has copy, drop {
        farm_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        successor: 0x2::object::ID,
    }

    struct RewardsAdded has copy, drop {
        farm_id: 0x2::object::ID,
        from: address,
        amount: u64,
        end_ms: u64,
    }

    struct FarmStaked has copy, drop {
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        weight: u128,
        lock_days: u64,
        lock_end_ms: u64,
    }

    struct FarmClaimed has copy, drop {
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct FarmUnstaked has copy, drop {
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    public fun acc<T0>(arg0: &Farm<T0>) : u256 {
        arg0.acc
    }

    public fun add_rewards<T0>(arg0: &mut Farm<T0>, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(!arg0.retired, 409);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 403);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(advance<T0>(arg0, v1), 407);
        assert!(arg0.unemitted > 0, 410);
        let v2 = arg0.rate;
        arg0.unemitted = arg0.unemitted + v0;
        arg0.funded = arg0.funded + v0;
        0x2::balance::join<T0>(&mut arg0.rewards, 0x2::coin::into_balance<T0>(arg2));
        let v3 = (arg0.unemitted as u256) * 18446744073709551616;
        let v4 = v3 / (arg0.period_ms as u256);
        let v5 = if (v2 > v4) {
            v2
        } else {
            v4
        };
        arg0.rate = v5;
        arg0.end_ms = v1 + ((v3 / arg0.rate) as u64);
        let v6 = RewardsAdded{
            farm_id : 0x2::object::id<Farm<T0>>(arg0),
            from    : 0x2::tx_context::sender(arg4),
            amount  : v0,
            end_ms  : arg0.end_ms,
        };
        0x2::event::emit<RewardsAdded>(v6);
    }

    fun advance<T0>(arg0: &mut Farm<T0>, arg1: u64) : bool {
        let v0 = 0;
        while (!0x1::vector::is_empty<u64>(&arg0.due) && *0x1::vector::borrow<u64>(&arg0.due, 0) <= arg1) {
            if (v0 == 200) {
                return false
            };
            v0 = v0 + 1;
            let v1 = &mut arg0.due;
            let v2 = heap_pop(v1);
            emit_to<T0>(arg0, v2);
            let v3 = 0x2::table::borrow_mut<u64, Checkpoint>(&mut arg0.checkpoints, v2);
            arg0.total_weight = arg0.total_weight - v3.drop;
            v3.acc = arg0.acc;
            v3.passed = true;
        };
        emit_to<T0>(arg0, arg1);
        true
    }

    fun ceil_day(arg0: u64) : u64 {
        let v0 = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::farm_day_ms();
        (arg0 + v0 - 1) / v0 * v0
    }

    public fun checkpoint<T0>(arg0: &mut Farm<T0>, arg1: &0x2::clock::Clock) : bool {
        advance<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun checkpoint_counts<T0>(arg0: &Farm<T0>) : (u64, u64) {
        (0x1::vector::length<u64>(&arg0.due), 0x2::table::length<u64, Checkpoint>(&arg0.checkpoints))
    }

    public fun claim<T0>(arg0: &mut Farm<T0>, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: &mut Position<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(arg2.farm_id == 0x2::object::id<Farm<T0>>(arg0), 404);
        advance<T0>(arg0, 0x2::clock::timestamp_ms(arg3));
        let v0 = settle<T0>(arg0, arg2);
        pay_reward<T0>(arg0, 0x2::object::id<Position<T0>>(arg2), v0, 0x2::tx_context::sender(arg4));
    }

    public fun claimed<T0>(arg0: &Farm<T0>) : u64 {
        arg0.claimed
    }

    public fun create<T0, T1>(arg0: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg8) == 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::creator_fee_recipient<T0, T1>(arg0), 400);
        create_internal<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg2), arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7), arg8)
    }

    public(friend) fun create_internal<T0, T1>(arg0: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        open<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x2::object::ID>(), arg6, arg7)
    }

    public fun curve_id<T0>(arg0: &Farm<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    fun earned<T0>(arg0: &Farm<T0>, arg1: &Position<T0>) : u64 {
        let v0 = if (arg1.boosted && arg1.lock_end_ms <= arg0.last_ms) {
            let v1 = 0x2::table::borrow<u64, Checkpoint>(&arg0.checkpoints, arg1.lock_end_ms).acc;
            (arg1.weight as u256) * (v1 - arg1.acc_entry) + (arg1.amount as u256) * (arg0.acc - v1)
        } else if (arg1.boosted) {
            (arg1.weight as u256) * (arg0.acc - arg1.acc_entry)
        } else {
            (arg1.amount as u256) * (arg0.acc - arg1.acc_entry)
        };
        ((v0 / 18446744073709551616) as u64)
    }

    fun emit_to<T0>(arg0: &mut Farm<T0>, arg1: u64) {
        let v0 = arg0.last_ms;
        if (arg1 <= v0) {
            return
        };
        arg0.last_ms = arg1;
        if (arg0.unemitted == 0) {
            return
        };
        if (arg0.total_weight == 0) {
            if (v0 < arg0.end_ms) {
                arg0.end_ms = arg0.end_ms + arg1 - v0;
            };
            return
        };
        let v1 = if (arg1 < arg0.end_ms) {
            arg1
        } else {
            arg0.end_ms
        };
        if (v1 <= v0) {
            return
        };
        let v2 = if (v1 == arg0.end_ms) {
            arg0.unemitted
        } else {
            let v3 = arg0.rate * ((v1 - v0) as u256) / 18446744073709551616;
            if (v3 > (arg0.unemitted as u256)) {
                arg0.unemitted
            } else {
                (v3 as u64)
            }
        };
        arg0.unemitted = arg0.unemitted - v2;
        arg0.acc = arg0.acc + (v2 as u256) * 18446744073709551616 / (arg0.total_weight as u256);
    }

    public fun end_ms<T0>(arg0: &Farm<T0>) : u64 {
        arg0.end_ms
    }

    public fun farm_of<T0, T1>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::uid<T0, T1>(arg0);
        let v1 = FarmKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FarmKey>(v0, v1)) {
            let v3 = FarmKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<FarmKey, 0x2::object::ID>(v0, v3))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun funded<T0>(arg0: &Farm<T0>) : u64 {
        arg0.funded
    }

    public fun funder<T0>(arg0: &Farm<T0>) : address {
        arg0.funder
    }

    fun heap_pop(arg0: &mut vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        0x1::vector::swap<u64>(arg0, 0, v0 - 1);
        let v1 = v0 - 1;
        let v2 = 0;
        let v3 = v2;
        loop {
            let v4 = 2 * v3 + 1;
            if (v4 >= v1) {
                break
            };
            let v5 = v4 + 1;
            let v6 = if (v5 < v1 && *0x1::vector::borrow<u64>(arg0, v5) < *0x1::vector::borrow<u64>(arg0, v4)) {
                v5
            } else {
                v4
            };
            if (*0x1::vector::borrow<u64>(arg0, v2) <= *0x1::vector::borrow<u64>(arg0, v6)) {
                break
            };
            0x1::vector::swap<u64>(arg0, v2, v6);
            v3 = v6;
        };
        0x1::vector::pop_back<u64>(arg0)
    }

    fun heap_push(arg0: &mut vector<u64>, arg1: u64) {
        0x1::vector::push_back<u64>(arg0, arg1);
        let v0 = 0x1::vector::length<u64>(arg0) - 1;
        while (v0 > 0) {
            v0 = (v0 - 1) / 2;
            if (*0x1::vector::borrow<u64>(arg0, v0) <= *0x1::vector::borrow<u64>(arg0, v0)) {
                break
            };
            0x1::vector::swap<u64>(arg0, v0, v0);
        };
    }

    public fun is_retired<T0>(arg0: &Farm<T0>) : bool {
        arg0.retired
    }

    public fun lock_range<T0>(arg0: &Farm<T0>) : (u64, u64, u64) {
        (arg0.min_lock_days, arg0.max_lock_days, arg0.max_boost_bps)
    }

    public fun multiplier_bps<T0>(arg0: &Farm<T0>, arg1: u64) : u64 {
        if (arg0.max_lock_days == arg0.min_lock_days) {
            return 10000
        };
        10000 + (arg0.max_boost_bps - 10000) * (arg1 - arg0.min_lock_days) / (arg0.max_lock_days - arg0.min_lock_days)
    }

    fun open<T0, T1>(arg0: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(valid_params(arg2, arg3, arg4, arg5), 402);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 403);
        let v1 = 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg0);
        let v2 = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::uid_mut<T0, T1>(arg0);
        let v3 = FarmKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<FarmKey>(v2, v3), 401);
        let v4 = arg2 * 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::farm_day_ms();
        let v5 = Farm<T0>{
            id            : 0x2::object::new(arg8),
            curve_id      : v1,
            funder        : 0x2::tx_context::sender(arg8),
            staked        : 0x2::balance::zero<T0>(),
            rewards       : arg1,
            unemitted     : v0,
            rate          : (v0 as u256) * 18446744073709551616 / (v4 as u256),
            period_ms     : v4,
            end_ms        : arg7 + v4,
            last_ms       : arg7,
            acc           : 0,
            total_weight  : 0,
            min_lock_days : arg3,
            max_lock_days : arg4,
            max_boost_bps : arg5,
            funded        : v0,
            claimed       : 0,
            stakers       : 0,
            due           : vector[],
            checkpoints   : 0x2::table::new<u64, Checkpoint>(arg8),
            retired       : false,
        };
        let v6 = 0x2::object::id<Farm<T0>>(&v5);
        let v7 = FarmKey{dummy_field: false};
        0x2::dynamic_field::add<FarmKey, 0x2::object::ID>(v2, v7, v6);
        let v8 = FarmCreated{
            farm_id       : v6,
            curve_id      : v1,
            previous      : arg6,
            funder        : 0x2::tx_context::sender(arg8),
            rewards       : v0,
            period_ms     : v4,
            min_lock_days : arg3,
            max_lock_days : arg4,
            max_boost_bps : arg5,
        };
        0x2::event::emit<FarmCreated>(v8);
        0x2::transfer::share_object<Farm<T0>>(v5);
        v6
    }

    fun pay_reward<T0>(arg0: &mut Farm<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: address) {
        if (arg2 == 0) {
            return
        };
        arg0.claimed = arg0.claimed + arg2;
        0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0.rewards, arg2), arg3);
        let v0 = FarmClaimed{
            farm_id     : 0x2::object::id<Farm<T0>>(arg0),
            position_id : arg1,
            owner       : arg3,
            amount      : arg2,
        };
        0x2::event::emit<FarmClaimed>(v0);
    }

    public fun pending<T0>(arg0: &Farm<T0>, arg1: &Position<T0>, arg2: u64) : u64 {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0>>(arg0), 404);
        let v0 = arg0.due;
        let v1 = arg0.acc;
        let v2 = arg0.total_weight;
        let v3 = arg0.last_ms;
        let v4 = arg0.end_ms;
        let v5 = arg0.unemitted;
        let v6 = 0x1::option::none<u256>();
        if (arg1.boosted && 0x2::table::borrow<u64, Checkpoint>(&arg0.checkpoints, arg1.lock_end_ms).passed) {
            v6 = 0x1::option::some<u256>(0x2::table::borrow<u64, Checkpoint>(&arg0.checkpoints, arg1.lock_end_ms).acc);
        };
        let v7 = false;
        let v8 = 0;
        while (!v7) {
            let v9 = !0x1::vector::is_empty<u64>(&v0) && *0x1::vector::borrow<u64>(&v0, 0) <= arg2;
            if (v9 && v8 == 200) {
                break
            };
            let (v10, v11) = if (v9) {
                v8 = v8 + 1;
                let v12 = &mut v0;
                (heap_pop(v12), true)
            } else {
                (arg2, false)
            };
            if (v10 > v3) {
                let v13 = v3;
                v3 = v10;
                if (v5 > 0) {
                    if (v2 == 0) {
                        if (v13 < v4) {
                            v4 = v4 + v10 - v13;
                        };
                    } else {
                        let v14 = if (v10 < v4) {
                            v10
                        } else {
                            v4
                        };
                        if (v14 > v13) {
                            let v15;
                            let v16 = if (v14 == v4) {
                                v5
                            } else {
                                let v17 = arg0.rate * ((v14 - v13) as u256) / 18446744073709551616;
                                if (v17 > (v5 as u256)) {
                                    v15 = v5;
                                } else {
                                    v15 = (v17 as u64);
                                };
                                v15
                            };
                            v5 = v5 - v16;
                            v1 = v1 + (v15 as u256) * 18446744073709551616 / (v2 as u256);
                        };
                    };
                };
            };
            if (v11) {
                v2 = v2 - 0x2::table::borrow<u64, Checkpoint>(&arg0.checkpoints, v10).drop;
                if (v10 == arg1.lock_end_ms && arg1.boosted) {
                    v6 = 0x1::option::some<u256>(v1);
                    continue
                } else {
                    continue
                };
            };
            v7 = true;
        };
        let v18 = if (arg1.boosted && 0x1::option::is_some<u256>(&v6)) {
            let v19 = 0x1::option::destroy_some<u256>(v6);
            (arg1.weight as u256) * (v19 - arg1.acc_entry) + (arg1.amount as u256) * (v1 - v19)
        } else if (arg1.boosted) {
            (arg1.weight as u256) * (v1 - arg1.acc_entry)
        } else {
            (arg1.amount as u256) * (v1 - arg1.acc_entry)
        };
        ((v18 / 18446744073709551616) as u64)
    }

    public fun period_ms<T0>(arg0: &Farm<T0>) : u64 {
        arg0.period_ms
    }

    public fun position_amount<T0>(arg0: &Position<T0>) : u64 {
        arg0.amount
    }

    public fun position_farm<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        arg0.farm_id
    }

    public fun position_lock<T0>(arg0: &Position<T0>) : (u64, u64) {
        (arg0.lock_days, arg0.lock_end_ms)
    }

    public fun position_weight<T0>(arg0: &Position<T0>) : u128 {
        arg0.weight
    }

    public fun replace<T0, T1>(arg0: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: &mut Farm<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg9) == 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::creator_fee_recipient<T0, T1>(arg0), 400);
        replace_internal<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T0>(arg3), arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8), arg9)
    }

    public(friend) fun replace_internal<T0, T1>(arg0: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg1: &mut Farm<T0>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg0);
        let v1 = 0x2::object::id<Farm<T0>>(arg1);
        assert!(arg1.curve_id == v0 && farm_of<T0, T1>(arg0) == 0x1::option::some<0x2::object::ID>(v1), 404);
        assert!(advance<T0>(arg1, arg7), 407);
        assert!(arg1.unemitted == 0, 408);
        let v2 = FarmKey{dummy_field: false};
        0x2::dynamic_field::remove<FarmKey, 0x2::object::ID>(0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::uid_mut<T0, T1>(arg0), v2);
        let v3 = open<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, 0x1::option::some<0x2::object::ID>(v1), arg7, arg8);
        arg1.retired = true;
        let v4 = FarmRetired{
            farm_id   : v1,
            curve_id  : v0,
            successor : v3,
        };
        0x2::event::emit<FarmRetired>(v4);
        v3
    }

    public fun reward_balance<T0>(arg0: &Farm<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rewards)
    }

    fun settle<T0>(arg0: &mut Farm<T0>, arg1: &mut Position<T0>) : u64 {
        arg1.acc_entry = arg0.acc;
        if (arg1.boosted && arg1.lock_end_ms <= arg0.last_ms) {
            arg1.boosted = false;
            let v0 = 0x2::table::borrow_mut<u64, Checkpoint>(&mut arg0.checkpoints, arg1.lock_end_ms);
            v0.open = v0.open - 1;
            if (v0.open == 0) {
                let Checkpoint {
                    drop   : _,
                    acc    : _,
                    passed : _,
                    open   : _,
                } = 0x2::table::remove<u64, Checkpoint>(&mut arg0.checkpoints, arg1.lock_end_ms);
            };
        };
        earned<T0>(arg0, arg1)
    }

    public fun stake<T0>(arg0: &mut Farm<T0>, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Position<T0> {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(!arg0.retired, 409);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 403);
        assert!(arg3 >= arg0.min_lock_days && arg3 <= arg0.max_lock_days, 406);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(advance<T0>(arg0, v1), 407);
        let v2 = (v0 as u128) * (multiplier_bps<T0>(arg0, arg3) as u128) / (10000 as u128);
        let v3 = ceil_day(v1 + arg3 * 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::farm_day_ms());
        let v4 = v2 > (v0 as u128);
        if (v4) {
            if (0x2::table::contains<u64, Checkpoint>(&arg0.checkpoints, v3)) {
                let v5 = 0x2::table::borrow_mut<u64, Checkpoint>(&mut arg0.checkpoints, v3);
                v5.drop = v5.drop + v2 - (v0 as u128);
                v5.open = v5.open + 1;
            } else {
                let v6 = Checkpoint{
                    drop   : v2 - (v0 as u128),
                    acc    : 0,
                    passed : false,
                    open   : 1,
                };
                0x2::table::add<u64, Checkpoint>(&mut arg0.checkpoints, v3, v6);
                let v7 = &mut arg0.due;
                heap_push(v7, v3);
            };
        };
        arg0.total_weight = arg0.total_weight + v2;
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg2));
        arg0.stakers = arg0.stakers + 1;
        let v8 = Position<T0>{
            id          : 0x2::object::new(arg5),
            farm_id     : 0x2::object::id<Farm<T0>>(arg0),
            amount      : v0,
            weight      : v2,
            lock_days   : arg3,
            lock_end_ms : v3,
            acc_entry   : arg0.acc,
            boosted     : v4,
        };
        let v9 = FarmStaked{
            farm_id     : 0x2::object::id<Farm<T0>>(arg0),
            position_id : 0x2::object::id<Position<T0>>(&v8),
            owner       : 0x2::tx_context::sender(arg5),
            amount      : v0,
            weight      : v2,
            lock_days   : arg3,
            lock_end_ms : v3,
        };
        0x2::event::emit<FarmStaked>(v9);
        v8
    }

    public fun stakers<T0>(arg0: &Farm<T0>) : u64 {
        arg0.stakers
    }

    public fun total_staked<T0>(arg0: &Farm<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.staked)
    }

    public fun total_weight<T0>(arg0: &Farm<T0>) : u128 {
        arg0.total_weight
    }

    public fun unemitted<T0>(arg0: &Farm<T0>) : u64 {
        arg0.unemitted
    }

    public fun unstake<T0>(arg0: &mut Farm<T0>, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: Position<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(arg2.farm_id == 0x2::object::id<Farm<T0>>(arg0), 404);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg2.lock_end_ms, 405);
        assert!(advance<T0>(arg0, v0), 407);
        let v1 = &mut arg2;
        let v2 = settle<T0>(arg0, v1);
        let v3 = 0x2::object::id<Position<T0>>(&arg2);
        pay_reward<T0>(arg0, v3, v2, 0x2::tx_context::sender(arg4));
        let Position {
            id          : v4,
            farm_id     : _,
            amount      : v6,
            weight      : _,
            lock_days   : _,
            lock_end_ms : _,
            acc_entry   : _,
            boosted     : _,
        } = arg2;
        0x2::object::delete(v4);
        arg0.total_weight = arg0.total_weight - (v6 as u128);
        arg0.stakers = arg0.stakers - 1;
        let v12 = FarmUnstaked{
            farm_id     : 0x2::object::id<Farm<T0>>(arg0),
            position_id : v3,
            owner       : 0x2::tx_context::sender(arg4),
            amount      : v6,
        };
        0x2::event::emit<FarmUnstaked>(v12);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked, v6), arg4)
    }

    public fun valid_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg0 >= 3) {
            if (arg0 <= 1461) {
                if (arg1 >= 3) {
                    if (arg1 <= arg2) {
                        if (arg2 <= 1461) {
                            if (arg3 >= 10000) {
                                arg3 <= 40000
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

