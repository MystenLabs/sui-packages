module 0xb5c8328de6b89e0fbee97bbd408375e58b33c80f567e6249617cb02a3ab7ee4e::flashloan {
    public fun auto_repay_flash_loan<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0x2::coin::Coin<T0>, arg3: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) : &mut 0x2::coin::Coin<T0> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&arg3);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&arg3);
        assert!(0x2::coin::value<T0>(arg2) >= v0 + v1, 0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg1, 0x2::coin::split<T0>(arg2, v0 + v1, arg4), arg3, arg4);
        arg2
    }

    // decompiled from Move bytecode v6
}

