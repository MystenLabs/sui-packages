module 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::swap_logic {
    public fun calculate_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 2);
        arg2 - (((arg1 as u256) * (arg2 as u256) / ((arg1 as u256) + (arg0 as u256))) as u64)
    }

    public fun calculate_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64);
        if (v0 < arg3) {
            arg3
        } else {
            v0
        }
    }

    // decompiled from Move bytecode v6
}

