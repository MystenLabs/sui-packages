module 0x85cc4462032963be96776fa90a64fd5a799457f37d83e7e41b4bf506ca6b3c65::flash_loan_util {
    public fun calc_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 6 / 10000
    }

    // decompiled from Move bytecode v6
}

