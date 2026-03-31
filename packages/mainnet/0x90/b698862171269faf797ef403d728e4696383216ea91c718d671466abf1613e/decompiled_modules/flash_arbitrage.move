module 0x90b698862171269faf797ef403d728e4696383216ea91c718d671466abf1613e::flash_arbitrage {
    struct Vault has key {
        id: 0x2::object::UID,
        bal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ArbitrageDone has copy, drop {
        amount_in: u64,
        profit: u64,
    }

    public fun bal(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bal)
    }

    public entry fun exec_with_profit(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.bal) >= arg1, 0);
        assert!(arg2 <= 1000, 1);
        let v0 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.bal, arg1, arg3);
        let v1 = arg1 * arg2 / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bal, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1, arg3), 0x2::tx_context::sender(arg3));
        let v2 = ArbitrageDone{
            amount_in : arg1,
            profit    : v1,
        };
        0x2::event::emit<ArbitrageDone>(v2);
    }

    // decompiled from Move bytecode v6
}

