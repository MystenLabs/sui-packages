module 0x66f5cfabb58200f099c9a9a0dcd03336362d0849935c76dd7f76b714d50804fd::simple {
    struct SimpleVault has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun add_liquidity(arg0: &mut SimpleVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun get_balance(arg0: &SimpleVault) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleVault{
            id      : 0x2::object::new(arg0),
            balance : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<SimpleVault>(v0);
    }

    public entry fun test_flash(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

