module 0xbafd431cc9362367d02dc2752216782a265216af069d70a7679de5f38c0d62ca::time_locked_balance {
    struct TimeLockedBalance<phantom T0> has store {
        locked_balance: 0x2::balance::Balance<T0>,
        unlock_start_ts_sec: u64,
        unlock_per_second: u64,
        unlocked_balance: 0x2::balance::Balance<T0>,
        final_unlock_ts_sec: u64,
        previous_unlock_at: u64,
    }

    public fun destroy_empty<T0>(arg0: TimeLockedBalance<T0>) {
        let TimeLockedBalance {
            locked_balance      : v0,
            unlock_start_ts_sec : _,
            unlock_per_second   : _,
            unlocked_balance    : v3,
            final_unlock_ts_sec : _,
            previous_unlock_at  : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T0>(v3);
    }

    fun calc_final_unlock_ts_sec(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            0
        } else {
            arg0 + arg1 / arg2
        }
    }

    public fun change_unlock_per_second<T0>(arg0: &mut TimeLockedBalance<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        unlock<T0>(arg0, arg2);
        arg0.unlock_per_second = arg1;
        arg0.final_unlock_ts_sec = calc_final_unlock_ts_sec(0x2::math::max(arg0.unlock_start_ts_sec, timestamp_sec(arg2)), 0x2::balance::value<T0>(&arg0.locked_balance), arg1);
    }

    public fun change_unlock_start_ts_sec<T0>(arg0: &mut TimeLockedBalance<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        unlock<T0>(arg0, arg2);
        let v0 = 0x2::math::max(arg1, timestamp_sec(arg2));
        arg0.unlock_start_ts_sec = v0;
        arg0.final_unlock_ts_sec = calc_final_unlock_ts_sec(v0, 0x2::balance::value<T0>(&arg0.locked_balance), arg0.unlock_per_second);
    }

    public fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64) : TimeLockedBalance<T0> {
        TimeLockedBalance<T0>{
            locked_balance      : arg0,
            unlock_start_ts_sec : arg1,
            unlock_per_second   : arg2,
            unlocked_balance    : 0x2::balance::zero<T0>(),
            final_unlock_ts_sec : calc_final_unlock_ts_sec(arg1, 0x2::balance::value<T0>(&arg0), arg2),
            previous_unlock_at  : 0,
        }
    }

    public fun extraneous_locked_amount<T0>(arg0: &TimeLockedBalance<T0>) : u64 {
        if (arg0.unlock_per_second == 0) {
            0x2::balance::value<T0>(&arg0.locked_balance)
        } else {
            0x2::balance::value<T0>(&arg0.locked_balance) % arg0.unlock_per_second
        }
    }

    public fun final_unlock_ts_sec<T0>(arg0: &TimeLockedBalance<T0>) : u64 {
        arg0.final_unlock_ts_sec
    }

    public fun get_values<T0>(arg0: &TimeLockedBalance<T0>) : (u64, u64, u64) {
        (arg0.unlock_start_ts_sec, arg0.unlock_per_second, arg0.final_unlock_ts_sec)
    }

    public fun max_withdrawable<T0>(arg0: &TimeLockedBalance<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x2::balance::value<T0>(&arg0.unlocked_balance) + unlockable_amount<T0>(arg0, arg1)
    }

    public fun remaining_unlock<T0>(arg0: &TimeLockedBalance<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::math::max(arg0.unlock_start_ts_sec, timestamp_sec(arg1));
        if (v0 >= arg0.final_unlock_ts_sec) {
            return 0
        };
        (arg0.final_unlock_ts_sec - v0) * arg0.unlock_per_second
    }

    public fun skim_extraneous_balance<T0>(arg0: &mut TimeLockedBalance<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.locked_balance, extraneous_locked_amount<T0>(arg0))
    }

    fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun top_up<T0>(arg0: &mut TimeLockedBalance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        unlock<T0>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.locked_balance, arg1);
        arg0.final_unlock_ts_sec = calc_final_unlock_ts_sec(0x2::math::max(arg0.unlock_start_ts_sec, timestamp_sec(arg2)), 0x2::balance::value<T0>(&arg0.locked_balance), arg0.unlock_per_second);
    }

    fun unlock<T0>(arg0: &mut TimeLockedBalance<T0>, arg1: &0x2::clock::Clock) {
        let v0 = timestamp_sec(arg1);
        if (arg0.previous_unlock_at == v0) {
            return
        };
        0x2::balance::join<T0>(&mut arg0.unlocked_balance, 0x2::balance::split<T0>(&mut arg0.locked_balance, unlockable_amount<T0>(arg0, arg1)));
        arg0.previous_unlock_at = v0;
    }

    public fun unlock_per_second<T0>(arg0: &TimeLockedBalance<T0>) : u64 {
        arg0.unlock_per_second
    }

    public fun unlock_start_ts_sec<T0>(arg0: &TimeLockedBalance<T0>) : u64 {
        arg0.unlock_start_ts_sec
    }

    fun unlockable_amount<T0>(arg0: &TimeLockedBalance<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.unlock_per_second == 0) {
            return 0
        };
        let v0 = timestamp_sec(arg1);
        if (v0 <= arg0.unlock_start_ts_sec) {
            return 0
        };
        0x2::balance::value<T0>(&arg0.locked_balance) / arg0.unlock_per_second * arg0.unlock_per_second - (arg0.final_unlock_ts_sec - 0x2::math::min(arg0.final_unlock_ts_sec, v0)) * arg0.unlock_per_second
    }

    public fun withdraw<T0>(arg0: &mut TimeLockedBalance<T0>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        unlock<T0>(arg0, arg2);
        0x2::balance::split<T0>(&mut arg0.unlocked_balance, arg1)
    }

    public fun withdraw_all<T0>(arg0: &mut TimeLockedBalance<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        unlock<T0>(arg0, arg1);
        0x2::balance::split<T0>(&mut arg0.unlocked_balance, 0x2::balance::value<T0>(&arg0.unlocked_balance))
    }

    // decompiled from Move bytecode v6
}

