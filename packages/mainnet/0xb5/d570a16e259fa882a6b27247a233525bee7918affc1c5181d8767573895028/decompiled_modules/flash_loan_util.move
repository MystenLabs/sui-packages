module 0xb5d570a16e259fa882a6b27247a233525bee7918affc1c5181d8767573895028::flash_loan_util {
    public fun calc_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 6 / 10000
    }

    // decompiled from Move bytecode v6
}

