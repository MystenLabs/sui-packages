module 0x6e6f9780ec224e3042f23d4fcd15dbbf13b147af608a357c02f9e04f7a98ae13::magic {
    struct LL<T0> {
        r: T0,
        a: u64,
    }

    struct P has copy, drop {
        a: u64,
    }

    struct F has copy, drop {
        d: u64,
    }

    public fun xx<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (LL<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = LL<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>>{
            r : v2,
            a : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v2) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v2),
        };
        (v3, 0x2::coin::into_balance<T0>(v0))
    }

    public fun xy<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::balance::Balance<T0>, arg3: LL<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v1), arg4), v0, arg4);
        arg2
    }

    // decompiled from Move bytecode v6
}

