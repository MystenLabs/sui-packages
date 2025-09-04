module 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_batch {
    struct StakingBatch has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>,
        start_ms: u64,
        unlock_ms: u64,
        cooldown_end_ms: u64,
        voting_until_ms: u64,
        last_vote: 0x1::option::Option<0x1::string::String>,
    }

    struct STAKING_BATCH has drop {
        dummy_field: bool,
    }

    struct EventNew has copy, drop {
        batch_id: address,
        balance: u64,
        start_ms: u64,
        unlock_ms: u64,
    }

    struct EventLock has copy, drop {
        batch_id: address,
        balance: u64,
        start_ms: u64,
        old_unlock_ms: u64,
        new_unlock_ms: u64,
    }

    struct EventRequestUnstake has copy, drop {
        batch_id: address,
        balance: u64,
        cooldown_end_ms: u64,
    }

    struct EventUnstake has copy, drop {
        batch_id: address,
        balance: u64,
    }

    public fun balance(arg0: &StakingBatch) : u64 {
        0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.balance)
    }

    public fun new(arg0: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::StakingConfig, arg1: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::Stats, arg2: 0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : StakingBatch {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = new_internal(arg0, arg1, v0, arg2, 0x2::clock::timestamp_ms(arg4), arg3, arg4, arg5);
        let v2 = EventNew{
            batch_id  : 0x2::object::uid_to_address(&v1.id),
            balance   : 0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&v1.balance),
            start_ms  : v1.start_ms,
            unlock_ms : v1.unlock_ms,
        };
        0x2::event::emit<EventNew>(v2);
        v1
    }

    public fun admin_new(arg0: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_admin::StakingAdminCap, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::StakingConfig, arg2: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::Stats, arg3: 0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<StakingBatch>(new_internal(arg1, arg2, arg6, arg3, arg5, arg4, arg7, arg8), arg6);
    }

    public fun cooldown_end_ms(arg0: &StakingBatch) : u64 {
        arg0.cooldown_end_ms
    }

    fun init(arg0: STAKING_BATCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<STAKING_BATCH>(arg0, arg1);
    }

    public fun is_cooldown_over(arg0: &StakingBatch, arg1: &0x2::clock::Clock) : bool {
        is_cooldown_requested(arg0) && 0x2::clock::timestamp_ms(arg1) >= arg0.cooldown_end_ms
    }

    public fun is_cooldown_requested(arg0: &StakingBatch) : bool {
        arg0.cooldown_end_ms > 0
    }

    public fun is_locked(arg0: &StakingBatch, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.unlock_ms
    }

    public fun is_unlocked(arg0: &StakingBatch, arg1: &0x2::clock::Clock) : bool {
        !is_locked(arg0, arg1)
    }

    public fun is_voting(arg0: &StakingBatch, arg1: &0x2::clock::Clock) : bool {
        arg0.voting_until_ms > 0 && 0x2::clock::timestamp_ms(arg1) < arg0.voting_until_ms
    }

    public fun keep(arg0: StakingBatch, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<StakingBatch>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun last_vote(arg0: &StakingBatch) : 0x1::option::Option<0x1::string::String> {
        arg0.last_vote
    }

    public fun lock(arg0: &mut StakingBatch, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::StakingConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(!is_voting(arg0, arg3), 108);
        assert!(!is_cooldown_requested(arg0), 105);
        assert!(arg2 <= 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::max_lock_months(arg1), 100);
        let v0 = arg0.unlock_ms;
        assert!(arg2 > (v0 - arg0.start_ms) / 2592000000, 101);
        let v1 = arg0.start_ms + arg2 * 2592000000;
        assert!(v1 > 0x2::clock::timestamp_ms(arg3), 102);
        arg0.unlock_ms = v1;
        let v2 = EventLock{
            batch_id      : 0x2::object::uid_to_address(&arg0.id),
            balance       : 0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.balance),
            start_ms      : arg0.start_ms,
            old_unlock_ms : v0,
            new_unlock_ms : v1,
        };
        0x2::event::emit<EventLock>(v2);
    }

    fun new_internal(arg0: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::StakingConfig, arg1: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::Stats, arg2: address, arg3: 0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : StakingBatch {
        assert!(0x2::coin::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg3) >= 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::min_balance(arg0), 103);
        assert!(arg5 <= 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::max_lock_months(arg0), 100);
        assert!(arg4 <= 0x2::clock::timestamp_ms(arg6), 111);
        let v0 = 0x2::coin::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg3);
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::add_tvl(arg1, v0);
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::add_user_tvl(arg1, arg2, v0, arg7);
        StakingBatch{
            id              : 0x2::object::new(arg7),
            balance         : 0x2::coin::into_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(arg3),
            start_ms        : arg4,
            unlock_ms       : arg4 + arg5 * 2592000000,
            cooldown_end_ms : 0,
            voting_until_ms : 0,
            last_vote       : 0x1::option::none<0x1::string::String>(),
        }
    }

    public fun power(arg0: &StakingBatch, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::StakingConfig, arg2: &0x2::clock::Clock) : u64 {
        let v0 = (0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.balance) as u128);
        let v1 = v0;
        let v2 = 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::max_lock_months(arg1);
        let v3 = if (is_locked(arg0, arg2)) {
            let v4 = (arg0.unlock_ms - arg0.start_ms) / 2592000000;
            if (v4 >= v2) {
                return ((v0 * (0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::max_boost_bps(arg1) as u128) / 10000) as u64)
            };
            v4
        } else {
            let v5 = (0x2::clock::timestamp_ms(arg2) - arg0.start_ms) / 2592000000;
            let v3 = v5;
            if (v5 >= v2) {
                v3 = v2 - 1;
            };
            v3
        };
        let v6 = 0;
        while (v6 < v3) {
            let v7 = v1 * (0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::monthly_boost_bps(arg1) as u128);
            v1 = v7 / 10000;
            v6 = v6 + 1;
        };
        (v1 as u64)
    }

    public fun request_unstake(arg0: &mut StakingBatch, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::StakingConfig, arg2: &0x2::clock::Clock) {
        assert!(!is_voting(arg0, arg2), 108);
        assert!(!is_locked(arg0, arg2), 104);
        assert!(!is_cooldown_requested(arg0), 105);
        let v0 = 0x2::clock::timestamp_ms(arg2) + 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config::cooldown_ms(arg1);
        arg0.cooldown_end_ms = v0;
        let v1 = EventRequestUnstake{
            batch_id        : 0x2::object::uid_to_address(&arg0.id),
            balance         : 0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg0.balance),
            cooldown_end_ms : v0,
        };
        0x2::event::emit<EventRequestUnstake>(v1);
    }

    public(friend) fun set_last_vote(arg0: &mut StakingBatch, arg1: 0x1::string::String) {
        arg0.last_vote = 0x1::option::some<0x1::string::String>(arg1);
    }

    public(friend) fun set_voting_until_ms(arg0: &mut StakingBatch, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg2), 109);
        assert!(arg1 > arg0.voting_until_ms, 110);
        arg0.voting_until_ms = arg1;
    }

    public fun start_ms(arg0: &StakingBatch) : u64 {
        arg0.start_ms
    }

    public fun unlock_ms(arg0: &StakingBatch) : u64 {
        arg0.unlock_ms
    }

    public fun unstake(arg0: StakingBatch, arg1: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::Stats, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS> {
        assert!(!is_voting(&arg0, arg2), 108);
        assert!(!is_locked(&arg0, arg2), 104);
        assert!(is_cooldown_requested(&arg0), 106);
        assert!(is_cooldown_over(&arg0, arg2), 107);
        let StakingBatch {
            id              : v0,
            balance         : v1,
            start_ms        : _,
            unlock_ms       : _,
            cooldown_end_ms : _,
            voting_until_ms : _,
            last_vote       : _,
        } = arg0;
        let v7 = v1;
        let v8 = v0;
        0x2::object::delete(v8);
        let v9 = 0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&v7);
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::sub_tvl(arg1, v9);
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::stats::sub_user_tvl(arg1, 0x2::tx_context::sender(arg3), v9);
        let v10 = EventUnstake{
            batch_id : 0x2::object::uid_to_address(&v8),
            balance  : v9,
        };
        0x2::event::emit<EventUnstake>(v10);
        v7
    }

    public fun voting_until_ms(arg0: &StakingBatch) : u64 {
        arg0.voting_until_ms
    }

    // decompiled from Move bytecode v6
}

