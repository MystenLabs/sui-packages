module 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::unlock_schedule {
    struct VeScaUnlockSchedule has store {
        locked_sca_amount: u64,
        schedule: vector<u64>,
        refreshed_at: u64,
        schedule_pointer: u64,
    }

    struct LockHistorySnapshot has copy, drop {
        locked_sca_amount: u64,
        locked_duration: u64,
    }

    public(friend) fun add_future_unlock_amount(arg0: &mut VeScaUnlockSchedule, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg0.refreshed_at == 0x2::clock::timestamp_ms(arg3) / 1000, 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::error_code::should_refresh_first());
        let v0 = nearest_unlock_amount_mut(arg0, arg2);
        *v0 = *v0 + arg1;
        arg0.locked_sca_amount = arg0.locked_sca_amount + arg1;
    }

    fun calculate_lock_history_snapshots(arg0: &VeScaUnlockSchedule, arg1: &0x2::clock::Clock) : vector<LockHistorySnapshot> {
        let v0 = 0x1::vector::empty<LockHistorySnapshot>();
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v2 = arg0.refreshed_at;
        let v3 = arg0.locked_sca_amount;
        while (v2 != v1) {
            v2 = 0x1::u64::min(v2 + 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::constants::unlock_round_duration() - v2 % 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::constants::unlock_round_duration(), v1);
            let v4 = LockHistorySnapshot{
                locked_sca_amount : v3,
                locked_duration   : v2 - v2,
            };
            0x1::vector::push_back<LockHistorySnapshot>(&mut v0, v4);
            if (v2 != v1) {
                v3 = v3 - nearest_unlock_amount(arg0, v2);
            };
        };
        v0
    }

    public(friend) fun extend_lock_period(arg0: &mut VeScaUnlockSchedule, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.refreshed_at == 0x2::clock::timestamp_ms(arg4) / 1000, 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::error_code::should_refresh_first());
        let v0 = nearest_unlock_amount_mut(arg0, arg2);
        *v0 = *v0 - arg1;
        let v1 = nearest_unlock_amount_mut(arg0, arg3);
        *v1 = *v1 + arg1;
    }

    fun nearest_unlock_amount(arg0: &VeScaUnlockSchedule, arg1: u64) : u64 {
        let v0 = rounds_passed_since_last_refresh(arg0, arg1) - 1;
        if (v0 < 0x1::vector::length<u64>(&arg0.schedule)) {
            *0x1::vector::borrow<u64>(&arg0.schedule, (arg0.schedule_pointer + v0) % 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::constants::max_lock_rounds())
        } else {
            0
        }
    }

    fun nearest_unlock_amount_mut(arg0: &mut VeScaUnlockSchedule, arg1: u64) : &mut u64 {
        0x1::vector::borrow_mut<u64>(&mut arg0.schedule, (arg0.schedule_pointer + rounds_passed_since_last_refresh(arg0, arg1) - 1) % 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::constants::max_lock_rounds())
    }

    public(friend) fun new() : VeScaUnlockSchedule {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::constants::max_lock_rounds()) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        VeScaUnlockSchedule{
            locked_sca_amount : 0,
            schedule          : v0,
            refreshed_at      : 0,
            schedule_pointer  : 0,
        }
    }

    fun refresh_unlock_schedule(arg0: &mut VeScaUnlockSchedule, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = 0;
        while (v1 < rounds_passed_since_last_refresh(arg0, v0)) {
            let v2 = arg0.schedule_pointer;
            arg0.locked_sca_amount = arg0.locked_sca_amount - *0x1::vector::borrow<u64>(&arg0.schedule, v2);
            arg0.schedule_pointer = (arg0.schedule_pointer + 1) % 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::constants::max_lock_rounds();
            *0x1::vector::borrow_mut<u64>(&mut arg0.schedule, v2) = 0;
            v1 = v1 + 1;
        };
        arg0.refreshed_at = v0;
    }

    public(friend) fun refresh_unlock_schedule_and_return_history_lock_snapshots(arg0: &mut VeScaUnlockSchedule, arg1: &0x2::clock::Clock) : vector<LockHistorySnapshot> {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (arg0.refreshed_at == 0) {
            arg0.refreshed_at = v0;
        };
        if (arg0.refreshed_at == v0) {
            return 0x1::vector::empty<LockHistorySnapshot>()
        };
        let v1 = calculate_lock_history_snapshots(arg0, arg1);
        refresh_unlock_schedule(arg0, arg1);
        v1
    }

    public fun refreshed_at(arg0: &VeScaUnlockSchedule) : u64 {
        arg0.refreshed_at
    }

    fun rounds_passed_since_last_refresh(arg0: &VeScaUnlockSchedule, arg1: u64) : u64 {
        arg1 / 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::constants::unlock_round_duration() - arg0.refreshed_at / 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::constants::unlock_round_duration()
    }

    public fun snapshot_locked_duration(arg0: &LockHistorySnapshot) : u64 {
        arg0.locked_duration
    }

    public fun snapshot_locked_sca_amount(arg0: &LockHistorySnapshot) : u64 {
        arg0.locked_sca_amount
    }

    // decompiled from Move bytecode v6
}

