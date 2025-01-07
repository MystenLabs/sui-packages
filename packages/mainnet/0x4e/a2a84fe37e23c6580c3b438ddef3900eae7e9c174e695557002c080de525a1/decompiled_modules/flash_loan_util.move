module 0x4ea2a84fe37e23c6580c3b438ddef3900eae7e9c174e695557002c080de525a1::flash_loan_util {
    public fun calc_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 6 / 10000
    }

    // decompiled from Move bytecode v6
}

