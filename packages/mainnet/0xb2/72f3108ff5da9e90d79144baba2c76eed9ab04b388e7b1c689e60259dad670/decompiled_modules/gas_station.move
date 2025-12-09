module 0xb272f3108ff5da9e90d79144baba2c76eed9ab04b388e7b1c689e60259dad670::gas_station {
    struct GasStation has store, key {
        id: 0x2::object::UID,
        gas: 0x2::balance::Balance<0x2::sui::SUI>,
        manager: vector<address>,
    }

    public fun borrow(arg0: &mut GasStation, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.manager, &v0), 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.gas) >= arg1, 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas, arg1), arg2)
    }

    public fun deposit(arg0: &mut GasStation, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GasStation{
            id      : 0x2::object::new(arg0),
            gas     : 0x2::balance::zero<0x2::sui::SUI>(),
            manager : 0x1::vector::empty<address>(),
        };
        0x1::vector::push_back<address>(&mut v0.manager, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GasStation>(v0);
    }

    // decompiled from Move bytecode v6
}

