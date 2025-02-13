module 0x827c551eb57326f9fec6cd96eb735149cafee24fcc48fa5deead0bc4a416a1a::dust_converter {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        treasuryBalance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun collectFee(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasuryBalance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, 0x2::balance::value<0x2::sui::SUI>(&v0) * 5 / 100));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id              : 0x2::object::new(arg0),
            treasuryBalance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

