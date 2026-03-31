module 0x76461099680301600fbca9f30a0a88f7f637d877c47e87d2a879f939dda8da52::arb {
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id  : 0x2::object::new(arg0),
            sui : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public entry fun ping(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

