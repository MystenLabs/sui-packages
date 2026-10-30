module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::rewards {
    struct Stake has drop, store {
        amount: u64,
        since_day: u64,
        last_paid_day: u64,
    }

    struct RewardVault<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
        staked: 0x2::balance::Balance<T0>,
        stakes: 0x2::table::Table<address, Stake>,
        day: u64,
        eligible: u64,
        pending: u64,
        income_today: u64,
        prev_day: u64,
        prev_eligible: u64,
        prev_budget: u64,
        prev_paid: u64,
    }

    struct RewarderCap has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Paid has copy, drop {
        day: u64,
        holder: address,
        amount: u64,
    }

    public fun create<T0>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardVault<T0>{
            id            : 0x2::object::new(arg2),
            funds         : 0x2::balance::zero<T0>(),
            staked        : 0x2::balance::zero<T0>(),
            stakes        : 0x2::table::new<address, Stake>(arg2),
            day           : 0x2::clock::timestamp_ms(arg1) / 86400000,
            eligible      : 0,
            pending       : 0,
            income_today  : 0,
            prev_day      : 0,
            prev_eligible : 0,
            prev_budget   : 0,
            prev_paid     : 0,
        };
        let v1 = RewarderCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<RewardVault<T0>>(&v0),
        };
        0x2::transfer::transfer<RewarderCap>(v1, @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
        0x2::transfer::share_object<RewardVault<T0>>(v0);
    }

    public fun distribute<T0, T1>(arg0: &RewarderCap, arg1: &mut RewardVault<T0>, arg2: &mut 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg5: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::assert_live(arg4, arg5);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::sample<T1, T0>(arg2, arg3, arg7, arg8);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::assert_priced(arg2, arg7);
        assert!(arg0.vault == 0x2::object::id<RewardVault<T0>>(arg1), 504);
        roll<T0>(arg1, arg7);
        let v0 = arg1.prev_day;
        let v1 = 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::soos_for(arg2, 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::sales_room(arg2, arg7));
        let v2 = 0;
        0x1::vector::reverse<address>(&mut arg6);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg6)) {
            let v4 = 0x1::vector::pop_back<address>(&mut arg6);
            if (0x2::table::contains<address, Stake>(&arg1.stakes, v4) && arg1.prev_eligible > 0) {
                let v5 = 0x2::table::borrow_mut<address, Stake>(&mut arg1.stakes, v4);
                let v6 = if (v5.amount >= 1000000000) {
                    if (v5.since_day < v0) {
                        v5.last_paid_day != v0 + 1
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v6) {
                    let v7 = (((arg1.prev_budget as u128) * (v5.amount as u128) / (arg1.prev_eligible as u128)) as u64);
                    let v8 = v7;
                    if (v7 > v1) {
                        v8 = v1;
                    };
                    v1 = v1 - v8;
                    v2 = v2 + v7;
                    v5.last_paid_day = v0 + 1;
                    if (v7 > 0) {
                        assert!(arg1.prev_paid + v7 <= arg1.prev_budget, 502);
                        arg1.prev_paid = arg1.prev_paid + v7;
                        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.funds, v7), arg8), v4);
                        let v9 = Paid{
                            day    : v0,
                            holder : v4,
                            amount : v7,
                        };
                        0x2::event::emit<Paid>(v9);
                    };
                };
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(arg6);
        if (v2 > 0) {
            0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::record_sale(arg2, 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::usdc_value(arg2, v2), arg7);
        };
    }

    public fun eligible<T0>(arg0: &RewardVault<T0>) : u64 {
        arg0.eligible
    }

    public fun funds<T0>(arg0: &RewardVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun min_hold() : u64 {
        1000000000
    }

    public fun post_income<T0>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut RewardVault<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        roll<T0>(arg1, arg3);
        arg1.income_today = arg2;
    }

    public fun prev_budget<T0>(arg0: &RewardVault<T0>) : u64 {
        arg0.prev_budget
    }

    fun remove_weight<T0>(arg0: &mut RewardVault<T0>, arg1: &Stake) {
        if (arg1.amount < 1000000000) {
            return
        };
        if (arg1.since_day < arg0.day) {
            arg0.eligible = arg0.eligible - arg1.amount;
        } else {
            arg0.pending = arg0.pending - arg1.amount;
        };
    }

    fun roll<T0>(arg0: &mut RewardVault<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 86400000;
        if (v0 == arg0.day) {
            return
        };
        let v1 = (((arg0.eligible as u128) * 800 / 10000 / 365) as u64);
        let v2 = if (arg0.income_today < 53000000000) {
            arg0.income_today
        } else {
            53000000000
        };
        let v3 = v2;
        if (v1 < v2) {
            v3 = v1;
        };
        arg0.prev_day = arg0.day;
        arg0.prev_eligible = arg0.eligible;
        arg0.prev_budget = v3;
        arg0.prev_paid = 0;
        arg0.eligible = arg0.eligible + arg0.pending;
        arg0.pending = 0;
        arg0.income_today = 0;
        arg0.day = v0;
    }

    public fun stake<T0>(arg0: &mut RewardVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        roll<T0>(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg1));
        let v1 = if (0x2::table::contains<address, Stake>(&arg0.stakes, v0)) {
            0x2::table::remove<address, Stake>(&mut arg0.stakes, v0)
        } else {
            Stake{amount: 0, since_day: 0, last_paid_day: 0}
        };
        let v2 = v1;
        remove_weight<T0>(arg0, &v2);
        v2.amount = v2.amount + 0x2::coin::value<T0>(&arg1);
        v2.since_day = arg0.day;
        if (v2.amount >= 1000000000) {
            arg0.pending = arg0.pending + v2.amount;
        };
        0x2::table::add<address, Stake>(&mut arg0.stakes, v0, v2);
    }

    public fun top_up<T0>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut RewardVault<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg2) <= 371000000000, 500);
        0x2::balance::join<T0>(&mut arg1.funds, 0x2::coin::into_balance<T0>(arg2));
        assert!(0x2::balance::value<T0>(&arg1.funds) <= 742000000000, 501);
    }

    public fun unstake<T0>(arg0: &mut RewardVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        roll<T0>(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Stake>(&arg0.stakes, v0), 505);
        let v1 = 0x2::table::remove<address, Stake>(&mut arg0.stakes, v0);
        remove_weight<T0>(arg0, &v1);
        v1.amount = v1.amount - arg1;
        v1.since_day = arg0.day;
        if (v1.amount >= 1000000000) {
            arg0.pending = arg0.pending + v1.amount;
        };
        if (v1.amount > 0 || v1.last_paid_day > 0) {
            0x2::table::add<address, Stake>(&mut arg0.stakes, v0, v1);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked, arg1), arg3)
    }

    // decompiled from Move bytecode v7
}

