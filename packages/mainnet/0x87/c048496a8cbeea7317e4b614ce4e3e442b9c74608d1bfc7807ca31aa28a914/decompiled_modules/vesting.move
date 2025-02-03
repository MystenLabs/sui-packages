module 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting {
    struct VestingConfig has store {
        start_ts: u64,
        cliff_ts: u64,
        end_ts: u64,
    }

    struct VestingData has store {
        released: u64,
        notional: u64,
    }

    public fun current_stake(arg0: &VestingData) : u64 {
        arg0.notional - arg0.released
    }

    public fun default_config(arg0: &0x2::clock::Clock) : VestingConfig {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        VestingConfig{
            start_ts : v0,
            cliff_ts : v0 + 172800000,
            end_ts   : v0 + 172800000 + 1209600000,
        }
    }

    public fun duration(arg0: &VestingConfig) : u64 {
        arg0.end_ts - arg0.start_ts
    }

    public fun notional(arg0: &VestingData) : u64 {
        arg0.notional
    }

    public(friend) fun release(arg0: &mut VestingData, arg1: u64) {
        arg0.released = arg0.released + arg1;
    }

    public fun released(arg0: &VestingData) : u64 {
        arg0.released
    }

    public fun to_release(arg0: &VestingData, arg1: &VestingConfig, arg2: u64) : u64 {
        total_vested(arg0, arg1, arg2) - arg0.released
    }

    public fun total_vested(arg0: &VestingData, arg1: &VestingConfig, arg2: u64) : u64 {
        if (arg2 < arg1.cliff_ts) {
            return 0
        };
        if (arg2 > arg1.end_ts) {
            return arg0.notional
        };
        arg0.notional * (arg2 - arg1.start_ts) / duration(arg1)
    }

    // decompiled from Move bytecode v6
}

