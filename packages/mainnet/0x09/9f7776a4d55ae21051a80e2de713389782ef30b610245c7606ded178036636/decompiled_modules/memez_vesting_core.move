module 0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting_core {
    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

