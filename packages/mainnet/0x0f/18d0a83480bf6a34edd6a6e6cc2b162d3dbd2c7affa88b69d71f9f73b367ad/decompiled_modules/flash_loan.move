module 0xf18d0a83480bf6a34edd6a6e6cc2b162d3dbd2c7affa88b69d71f9f73b367ad::flash_loan {
    struct FlashLoanReceipt {
        pool_id: address,
        borrowed_amount: u64,
    }

    public fun begin_flash_loan(arg0: address, arg1: u64) : FlashLoanReceipt {
        FlashLoanReceipt{
            pool_id         : arg0,
            borrowed_amount : arg1,
        }
    }

    public fun end_flash_loan(arg0: FlashLoanReceipt) : (address, u64) {
        let FlashLoanReceipt {
            pool_id         : v0,
            borrowed_amount : v1,
        } = arg0;
        (v0, v1)
    }

    public fun validate_repayment(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 >= arg0 + arg0 * arg2 / 10000
    }

    // decompiled from Move bytecode v6
}

