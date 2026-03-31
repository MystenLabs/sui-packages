module 0x9897123e420d85880d4eadd7d20c1adcbfa5609ebf6d3c72658ba1484a509a81::quick {
    struct QuickVault has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ArbDone has copy, drop {
        profit: u64,
    }

    public entry fun deposit(arg0: &mut QuickVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun do_arb(arg0: &mut QuickVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg1, 0);
        let v0 = arg1 * 1147 / 10000;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg1 + v0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v0), arg2), 0x2::tx_context::sender(arg2));
        let v1 = ArbDone{profit: v0};
        0x2::event::emit<ArbDone>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = QuickVault{
            id  : 0x2::object::new(arg0),
            sui : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<QuickVault>(v0);
    }

    public entry fun withdraw_all(arg0: &mut QuickVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

