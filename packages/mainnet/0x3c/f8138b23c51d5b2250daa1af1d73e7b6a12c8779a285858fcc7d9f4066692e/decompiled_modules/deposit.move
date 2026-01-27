module 0x3cf8138b23c51d5b2250daa1af1d73e7b6a12c8779a285858fcc7d9f4066692e::deposit {
    struct Bank has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>,
        balances: 0x2::table::Table<address, u64>,
    }

    entry fun deposit(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 1);
        0x2::balance::join<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.pool, 0x2::coin::into_balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(arg1));
        if (0x2::table::contains<address, u64>(&arg0.balances, v1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, v1);
            *v2 = *v2 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.balances, v1, v0);
        };
    }

    public fun get_balance(arg0: &Bank, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id       : 0x2::object::new(arg0),
            pool     : 0x2::balance::zero<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(),
            balances : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Bank>(v0);
    }

    entry fun withdraw(arg0: &mut Bank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.balances, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, v0);
        assert!(*v1 >= arg1, 0);
        *v1 = *v1 - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>>(0x2::coin::from_balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(0x2::balance::split<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.pool, arg1), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

