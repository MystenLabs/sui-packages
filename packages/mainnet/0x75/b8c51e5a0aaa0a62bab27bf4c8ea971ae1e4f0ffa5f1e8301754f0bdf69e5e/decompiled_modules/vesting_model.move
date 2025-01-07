module 0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::vesting_model {
    struct VestingModel has copy, drop, store {
        cliff: u64,
        vesting_period: u64,
    }

    public fun calc_vested_amount(arg0: &VestingModel, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000 - arg2;
        if (v0 <= arg0.cliff) {
            return 0
        };
        let v1 = v0 - arg0.cliff;
        if (v1 >= arg0.vesting_period) {
            return arg1
        };
        mul_div(arg1, v1, arg0.vesting_period)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun new(arg0: u64, arg1: u64) : VestingModel {
        VestingModel{
            cliff          : arg0,
            vesting_period : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

