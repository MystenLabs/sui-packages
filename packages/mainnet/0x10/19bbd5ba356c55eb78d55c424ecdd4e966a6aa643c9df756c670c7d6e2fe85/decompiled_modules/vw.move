module 0x1019bbd5ba356c55eb78d55c424ecdd4e966a6aa643c9df756c670c7d6e2fe85::vw {
    public fun qo<T0, T1, T2: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::quote_swap<T0, T1, T2>(arg0, arg2, arg1);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v0)
    }

    public fun qs<T0, T1, T2: drop>(arg0: &mut 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::p::P, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>, arg2: bool) {
        0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::p::fd(arg0, qo<T0, T1, T2>(arg1, arg2, 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::p::cy(arg0)));
    }

    public fun sa<T0, T1, T2: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg1, arg2);
        let v1 = 0x2::coin::zero<T1>(arg2);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T0, T1, T2>(arg0, &mut v0, &mut v1, true, 0x2::balance::value<T0>(&arg1), 0, arg2);
        0x2::coin::destroy_zero<T0>(v0);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun sb<T0, T1, T2: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        let v1 = 0x2::coin::from_balance<T1>(arg1, arg2);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T0, T1, T2>(arg0, &mut v0, &mut v1, false, 0x2::balance::value<T1>(&arg1), 0, arg2);
        0x2::coin::destroy_zero<T1>(v1);
        0x2::coin::into_balance<T0>(v0)
    }

    // decompiled from Move bytecode v7
}

