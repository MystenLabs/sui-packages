module 0xd783b78546f388f7859088e1a63858f87c7ae7d2a0cc06e2266e37d8df408cbb::arbitrage {
    struct Vault has key {
        id: 0x2::object::UID,
        bal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Pool has key {
        id: 0x2::object::UID,
    }

    struct ProfitEvent has copy, drop {
        amount_in: u64,
        amount_out: u64,
        profit: u64,
    }

    public fun create_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id  : 0x2::object::new(arg1),
            bal : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun execute(arg0: &mut Vault, arg1: &mut Pool, arg2: &mut Pool, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.bal) >= arg4, 0);
        let v0 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.bal, arg4, arg5);
        let v1 = arg4 * 500 / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bal, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1, arg5), 0x2::tx_context::sender(arg5));
        let v2 = ProfitEvent{
            amount_in  : arg4,
            amount_out : arg4 + v1,
            profit     : v1,
        };
        0x2::event::emit<ProfitEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

