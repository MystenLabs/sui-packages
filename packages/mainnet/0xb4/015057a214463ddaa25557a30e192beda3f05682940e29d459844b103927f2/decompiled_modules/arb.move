module 0xb4015057a214463ddaa25557a30e192beda3f05682940e29d459844b103927f2::arb {
    public fun flashloan(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<0x2::sui::SUI>(arg0, arg1, v0, v1, arg3);
    }

    public fun get_version(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::current_version::current_version()
    }

    // decompiled from Move bytecode v6
}

