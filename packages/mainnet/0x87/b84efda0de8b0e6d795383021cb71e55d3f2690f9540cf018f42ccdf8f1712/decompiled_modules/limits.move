module 0x87b84efda0de8b0e6d795383021cb71e55d3f2690f9540cf018f42ccdf8f1712::limits {
    struct EpochSpend has store {
        epoch: u32,
        wal: u64,
        sui: u64,
    }

    public(friend) fun charge(arg0: &mut EpochSpend, arg1: u32, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        if (arg1 != arg0.epoch) {
            arg0.epoch = arg1;
            arg0.wal = 0;
            arg0.sui = 0;
        };
        arg0.wal = arg0.wal + arg2;
        arg0.sui = arg0.sui + arg3;
        assert!(arg0.wal <= arg4 && arg0.sui <= arg5, 0);
    }

    public(friend) fun epoch(arg0: &EpochSpend) : u32 {
        arg0.epoch
    }

    public(friend) fun new() : EpochSpend {
        EpochSpend{
            epoch : 0,
            wal   : 0,
            sui   : 0,
        }
    }

    public(friend) fun renewable(arg0: bool, arg1: u32, arg2: u32, arg3: u32) : bool {
        if (arg0) {
            if (arg1 > arg2) {
                arg1 - arg2 <= arg3
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun sui(arg0: &EpochSpend) : u64 {
        arg0.sui
    }

    public(friend) fun tip_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 + arg2 * 0x1::u64::div_ceil(arg0, 1024)
    }

    public(friend) fun wal(arg0: &EpochSpend) : u64 {
        arg0.wal
    }

    // decompiled from Move bytecode v7
}

