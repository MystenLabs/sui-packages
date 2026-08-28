module 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::vk {
    struct L<phantom T0, phantom T1> {
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        owed: u64,
        receipt: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt,
    }

    public fun e_short_repay() : u64 {
        30
    }

    public fun op<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : L<T0, T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, arg2, true, arg3, 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::lm(arg2), arg4, arg0, arg5);
        let v3 = v2;
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v6 = if (arg2) {
            v4
        } else {
            v5
        };
        L<T0, T1>{
            a       : v0,
            b       : v1,
            owed    : v6,
            receipt : v3,
        }
    }

    public fun qo<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg1, true, 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::lm(arg1), arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0)
    }

    public fun qs<T0, T1>(arg0: &mut 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::p::P, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) {
        0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::p::fd(arg0, qo<T0, T1>(arg1, arg2, 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::p::cy(arg0)));
    }

    public fun ra<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: L<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 30);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), arg0, arg4);
        arg3
    }

    public fun rb<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: L<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 30);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), arg0, arg4);
        arg3
    }

    public fun sa<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&arg2), 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::lm(true), arg3, arg0, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v2, arg2, 0x2::balance::zero<T1>(), arg0, arg4);
        v1
    }

    public fun sb<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&arg2), 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::lm(false), arg3, arg0, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::zero<T0>(), arg2, arg0, arg4);
        v0
    }

    public fun ta<T0, T1>(arg0: L<T0, T1>) : (L<T0, T1>, 0x2::balance::Balance<T0>) {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = L<T0, T1>{
            a       : 0x2::balance::zero<T0>(),
            b       : v1,
            owed    : v2,
            receipt : v3,
        };
        (v4, v0)
    }

    public fun tb<T0, T1>(arg0: L<T0, T1>) : (L<T0, T1>, 0x2::balance::Balance<T1>) {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = L<T0, T1>{
            a       : v0,
            b       : 0x2::balance::zero<T1>(),
            owed    : v2,
            receipt : v3,
        };
        (v4, v1)
    }

    // decompiled from Move bytecode v7
}

