module 0xec5054d2fb1ade087429cbd832610307813b4a9032f8380d5b71d6968c402038::flash {
    struct Vault has key {
        id: 0x2::object::UID,
        bal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Done has copy, drop {
        amt: u64,
    }

    public fun bal(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bal)
    }

    public entry fun create(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id  : 0x2::object::new(arg1),
            bal : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public entry fun exec(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.bal) >= arg1, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bal, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.bal, arg1, arg2)));
        let v0 = Done{amt: arg1};
        0x2::event::emit<Done>(v0);
    }

    // decompiled from Move bytecode v6
}

