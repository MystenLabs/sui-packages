module 0xec9b8d0c570dbdfa5fc680482dfd535a7ace60390656e50a2d222627cd73ed0e::arbitrage {
    struct ArbVault has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SwapDone has copy, drop {
        amount_in: u64,
        amount_out: u64,
    }

    public entry fun deposit(arg0: &mut ArbVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArbVault{
            id  : 0x2::object::new(arg0),
            sui : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<ArbVault>(v0);
    }

    public entry fun swap_and_profit(arg0: &mut ArbVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg1, 0);
        let v0 = arg1 * 1147 / 10000;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg1 + v0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v0), arg2), 0x2::tx_context::sender(arg2));
        let v1 = SwapDone{
            amount_in  : arg1,
            amount_out : v0,
        };
        0x2::event::emit<SwapDone>(v1);
    }

    public entry fun withdraw_all(arg0: &mut ArbVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

