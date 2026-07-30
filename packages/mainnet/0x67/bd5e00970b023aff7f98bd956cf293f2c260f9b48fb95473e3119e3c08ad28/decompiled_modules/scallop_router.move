module 0x67bd5e00970b023aff7f98bd956cf293f2c260f9b48fb95473e3119e3c08ad28::scallop_router {
    public fun repay_flash_loan_with_bounds<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&arg2) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&arg2);
        assert!(v0 <= arg4, 13906834307487498243);
        assert!(0x2::coin::value<T0>(arg3) >= v0 + arg5, 13906834311782334465);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg1, 0x2::coin::split<T0>(arg3, v0, arg6), arg2, arg6);
    }

    // decompiled from Move bytecode v7
}

