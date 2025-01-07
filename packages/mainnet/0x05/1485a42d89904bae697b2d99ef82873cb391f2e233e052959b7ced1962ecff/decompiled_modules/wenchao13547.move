module 0x51485a42d89904bae697b2d99ef82873cb391f2e233e052959b7ced1962ecff::wenchao13547 {
    struct Bank has key {
        id: 0x2::object::UID,
        hiro: 0x2::balance::Balance<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>,
        fct: 0x2::balance::Balance<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_fct(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>) {
        0x2::balance::join<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>(&mut arg0.fct, 0x2::coin::into_balance<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>(arg1));
    }

    public entry fun deposit_hiro(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>) {
        0x2::balance::join<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(&mut arg0.hiro, 0x2::coin::into_balance<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id   : 0x2::object::new(arg0),
            hiro : 0x2::balance::zero<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(),
            fct  : 0x2::balance::zero<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_fct_hiro(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>(&mut arg0.fct, 0x2::coin::into_balance<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>>(0x2::coin::from_balance<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(0x2::balance::split<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(&mut arg0.hiro, 0x2::coin::value<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>(&arg1) * 10 / 100), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_hiro_fct(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(&mut arg0.hiro, 0x2::coin::into_balance<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>>(0x2::coin::from_balance<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>(0x2::balance::split<0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr::RR>(&mut arg0.fct, 0x2::coin::value<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(&arg1) * 100 / 10), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawal_hiro(arg0: &mut Bank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>>(0x2::coin::from_balance<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(0x2::balance::split<0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu::UU>(&mut arg0.hiro, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

