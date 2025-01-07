module 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::lock {
    struct LockClaimEvent<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
        round: u64,
        reward: u64,
        sender: address,
    }

    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        scheduled_times: vector<u64>,
        scheduled_rewards: vector<u64>,
        round: u64,
        total_rewards: u64,
        lock_rewards: 0x2::balance::Balance<T0>,
        start_time: u64,
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: vector<u64>, arg2: vector<u64>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Lock<T0>{
            id                : 0x2::object::new(arg6),
            campaign_id       : arg0,
            scheduled_times   : arg1,
            scheduled_rewards : arg2,
            round             : 0,
            total_rewards     : 0x2::balance::value<T0>(&arg3),
            lock_rewards      : arg3,
            start_time        : arg4,
        };
        give_reward<T0>(v0, arg5, arg6);
    }

    public(friend) fun check(arg0: vector<u64>, arg1: vector<u64>) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 1000);
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 1001);
        true
    }

    public fun claim_next_round<T0>(arg0: Lock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        give_reward<T0>(arg0, arg1, arg2);
    }

    fun get_last_applicable_round<T0>(arg0: &Lock<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.scheduled_times) && arg0.start_time + *0x1::vector::borrow<u64>(&arg0.scheduled_times, v0) <= 0x2::clock::timestamp_ms(arg1)) {
            v0 = v0 + 1;
        };
        v0
    }

    fun give_reward<T0>(arg0: Lock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_last_applicable_round<T0>(&arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg0.round, 1001);
        let v2 = arg0.round;
        while (v2 < v0) {
            let v3 = arg0.total_rewards * *0x1::vector::borrow<u64>(&arg0.scheduled_rewards, v2) / 10000;
            let v4 = LockClaimEvent<T0>{
                lock_id : 0x2::object::id<Lock<T0>>(&mut arg0),
                round   : v2,
                reward  : v3,
                sender  : v1,
            };
            0x2::event::emit<LockClaimEvent<T0>>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.lock_rewards, v3), arg2), v1);
            v2 = v2 + 1;
        };
        arg0.round = v0;
        0x2::transfer::public_transfer<Lock<T0>>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

