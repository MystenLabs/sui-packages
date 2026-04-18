module 0x5feea5debebf3cb15fbfd886e7c70b80658346cd92ce747bdec6caffa4d8ee68::pyth_sponsor_rule {
    struct PythSponsorRule has drop {
        dummy_field: bool,
    }

    struct PythSponsor has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Fund {
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun split(arg0: &mut Fund, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < 1) {
            err_insufficient_fund();
        };
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 1), arg1)
    }

    public fun request(arg0: &mut PythSponsor) : Fund {
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < 2) {
            err_insufficient_sponsor_fund();
        };
        Fund{balance: 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 2)}
    }

    fun err_insufficient_fund() {
        abort 1101
    }

    fun err_insufficient_sponsor_fund() {
        abort 1102
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PythSponsor{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<PythSponsor>(v0);
    }

    public fun reimburse<T0>(arg0: &mut PythSponsor, arg1: Fund, arg2: &mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::request::TradingRequest<T0>) {
        let v0 = PythSponsorRule{dummy_field: false};
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::request::add_witness<T0, PythSponsorRule>(arg2, v0);
        let Fund { balance: v1 } = arg1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v1);
    }

    public fun supply(arg0: &mut PythSponsor, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    // decompiled from Move bytecode v7
}

