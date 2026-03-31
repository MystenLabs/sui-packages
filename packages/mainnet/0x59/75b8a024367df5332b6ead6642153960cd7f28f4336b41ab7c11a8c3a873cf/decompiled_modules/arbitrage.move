module 0x5975b8a024367df5332b6ead6642153960cd7f28f4336b41ab7c11a8c3a873cf::arbitrage {
    struct ArbitrageExecuted has copy, drop {
        amount_in: u64,
        amount_out: u64,
        profit: u64,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        sui: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public fun balance(arg0: &Vault) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.sui)
    }

    public entry fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui, arg1);
    }

    public entry fun flash_borrow(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0.sui) >= arg1, 0);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui, arg1, arg2));
        let v0 = ArbitrageExecuted{
            amount_in  : arg1,
            amount_out : arg1,
            profit     : 0,
        };
        0x2::event::emit<ArbitrageExecuted>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id  : 0x2::object::new(arg0),
            sui : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    // decompiled from Move bytecode v6
}

