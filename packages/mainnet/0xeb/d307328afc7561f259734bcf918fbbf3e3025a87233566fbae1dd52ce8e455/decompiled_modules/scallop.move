module 0xebd307328afc7561f259734bcf918fbbf3e3025a87233566fbae1dd52ce8e455::scallop {
    struct Receipt<phantom T0> {
        loan: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>,
        principal: u64,
    }

    public fun borrow<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, Receipt<T0>) {
        let v0 = 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::select_input(arg2, arg3, arg4);
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg1, v0, arg5);
        let v3 = Receipt<T0>{
            loan      : v2,
            principal : v0,
        };
        (0x2::coin::into_balance<T0>(v1), 0x2::balance::zero<T0>(), v3)
    }

    public fun repay<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T0>, arg4: Receipt<T0>, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let Receipt {
            loan      : v0,
            principal : v1,
        } = arg4;
        0x2::balance::join<T0>(&mut arg2, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v1), arg6), v0, arg6);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg5), arg2);
    }

    // decompiled from Move bytecode v7
}

