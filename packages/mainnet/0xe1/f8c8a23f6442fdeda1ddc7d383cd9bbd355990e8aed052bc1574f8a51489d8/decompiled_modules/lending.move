module 0xe1f8c8a23f6442fdeda1ddc7d383cd9bbd355990e8aed052bc1574f8a51489d8::lending {
    struct Pool has key {
        id: 0x2::object::UID,
        total_liquidity: u64,
        total_borrowed: u64,
    }

    struct Position has key {
        id: 0x2::object::UID,
        owner: address,
        deposited: u64,
        borrowed: u64,
    }

    public fun borrow(arg0: &mut Pool, arg1: &mut Position, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 0);
        arg0.total_liquidity = arg0.total_liquidity - arg3;
        arg0.total_borrowed = arg0.total_borrowed + arg3;
        arg1.borrowed = arg1.borrowed + arg3;
        (0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg4), arg2)
    }

    public fun create_pool(arg0: &mut 0x2::tx_context::TxContext) : Pool {
        Pool{
            id              : 0x2::object::new(arg0),
            total_liquidity : 0,
            total_borrowed  : 0,
        }
    }

    public fun create_position(arg0: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id        : 0x2::object::new(arg0),
            owner     : 0x2::tx_context::sender(arg0),
            deposited : 0,
            borrowed  : 0,
        }
    }

    public fun deposit(arg0: &mut Pool, arg1: &mut Position, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        arg1.deposited = arg1.deposited + v0;
        arg0.total_liquidity = arg0.total_liquidity + v0;
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
    }

    public fun repay(arg0: &mut Pool, arg1: &mut Position, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(arg1.borrowed >= v0, 1);
        arg1.borrowed = arg1.borrowed - v0;
        arg0.total_borrowed = arg0.total_borrowed - v0;
        arg0.total_liquidity = arg0.total_liquidity + v0;
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
    }

    public fun withdraw(arg0: &mut Pool, arg1: &mut Position, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg1.deposited >= arg3, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 3);
        arg1.deposited = arg1.deposited - arg3;
        arg0.total_liquidity = arg0.total_liquidity - arg3;
        (0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg4), arg2)
    }

    // decompiled from Move bytecode v6
}

