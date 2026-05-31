module 0xfdcb941bebbed7090d59321b2b83f0b1b7b51c165615e3f14f36e9177b321f2d::f {
    struct LL<phantom T0> {
        receipt: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashLoanReceipt,
        repay_amount: u64,
    }

    public fun bx<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, LL<T0>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_loan<T0, T1>(arg0, arg1, 0, arg2, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_receipt_debts(&v3);
        let v6 = LL<T0>{
            receipt      : v3,
            repay_amount : v4,
        };
        (v0, v6)
    }

    public fun by<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_loan<T0, T1>(arg0, 0, arg1, arg2, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_receipt_debts(&v3);
        let v6 = LL<T1>{
            receipt      : v3,
            repay_amount : v5,
        };
        (v1, v6)
    }

    public fun rx<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            receipt      : v0,
            repay_amount : v1,
        } = arg2;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_loan<T0, T1>(arg0, v0, 0x2::balance::split<T0>(&mut arg1, v1), 0x2::balance::zero<T1>(), arg3, arg4);
        arg1
    }

    public fun ry<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let LL {
            receipt      : v0,
            repay_amount : v1,
        } = arg2;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_loan<T0, T1>(arg0, v0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg1, v1), arg3, arg4);
        arg1
    }

    // decompiled from Move bytecode v7
}

