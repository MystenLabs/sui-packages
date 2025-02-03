module 0xf16665ff5a3a5863056d689083060d30781f43858812698050cde8e0f0851f54::vesting {
    struct VestingConfig has store {
        start_ts: u64,
        cliff_ts: u64,
        end_ts: u64,
    }

    struct VestingData has store {
        released: u64,
        notional: u64,
    }

    struct AccountingDfKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun accounting_key() : AccountingDfKey {
        AccountingDfKey{dummy_field: false}
    }

    public fun cliff_ts(arg0: &VestingConfig) : u64 {
        arg0.cliff_ts
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

    public fun destroy_config(arg0: VestingConfig) {
        let VestingConfig {
            start_ts : _,
            cliff_ts : _,
            end_ts   : _,
        } = arg0;
    }

    public fun destroy_vesting_data(arg0: VestingData) {
        let VestingData {
            released : _,
            notional : _,
        } = arg0;
    }

    public fun duration(arg0: &VestingConfig) : u64 {
        arg0.end_ts - arg0.start_ts
    }

    public fun end_ts(arg0: &VestingConfig) : u64 {
        arg0.end_ts
    }

    public fun new_config(arg0: u64, arg1: u64, arg2: u64) : VestingConfig {
        assert!(arg0 <= arg1, 0);
        assert!(arg1 <= arg2, 0);
        VestingConfig{
            start_ts : arg0,
            cliff_ts : arg1,
            end_ts   : arg2,
        }
    }

    public fun new_vesting_data(arg0: u64) : VestingData {
        VestingData{
            released : 0,
            notional : arg0,
        }
    }

    public fun notional(arg0: &VestingData) : u64 {
        arg0.notional
    }

    public(friend) fun notional_mut(arg0: &mut VestingData) : &mut u64 {
        &mut arg0.notional
    }

    public(friend) fun release(arg0: &mut VestingData, arg1: u64) {
        arg0.released = arg0.released + arg1;
    }

    public fun released(arg0: &VestingData) : u64 {
        arg0.released
    }

    public fun start_ts(arg0: &VestingConfig) : u64 {
        arg0.start_ts
    }

    public fun to_release(arg0: &VestingData, arg1: &VestingConfig, arg2: u64) : u64 {
        assert!(arg0.released <= total_vested(arg0, arg1, arg2), 1);
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

