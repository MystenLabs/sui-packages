module 0xa9f3f2005414ec86fd658ad921602b30b9c7f5a7e8d439b80a4f2329d15a868c::bank {
    struct Bank has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
        debt: u64,
        collateral: u64,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    public fun borrow(arg0: &mut Account, arg1: &mut 0xa9f3f2005414ec86fd658ad921602b30b9c7f5a7e8d439b80a4f2329d15a868c::dollar::CapWrapper, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa9f3f2005414ec86fd658ad921602b30b9c7f5a7e8d439b80a4f2329d15a868c::dollar::DOLLAR> {
        assert!((((arg0.collateral as u128) * 140 / 100) as u64) >= arg0.debt + arg2, 1);
        arg0.debt = arg0.debt + arg2;
        0xa9f3f2005414ec86fd658ad921602b30b9c7f5a7e8d439b80a4f2329d15a868c::dollar::mint(arg1, arg2, arg3)
    }

    public fun balance(arg0: &Bank) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun admin_balance(arg0: &Bank) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.admin_balance)
    }

    public fun claim(arg0: &OwnerCap, arg1: &mut Bank, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.admin_balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.admin_balance), arg2)
    }

    public fun collateral(arg0: &Account) : u64 {
        arg0.collateral
    }

    public fun debt(arg0: &Account) : u64 {
        arg0.debt
    }

    public fun deposit(arg0: &mut Bank, arg1: &mut Account, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = v0 - (((v0 as u128) * 500 / 10000) as u64);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0 - v1, arg3)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.collateral = arg1.collateral + v1;
    }

    public fun destroy_empty_account(arg0: Account) {
        let Account {
            id         : v0,
            debt       : _,
            collateral : v2,
        } = arg0;
        assert!(v2 == 0, 2);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id            : 0x2::object::new(arg0),
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            admin_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun new_account(arg0: &mut 0x2::tx_context::TxContext) : Account {
        Account{
            id         : 0x2::object::new(arg0),
            debt       : 0,
            collateral : 0,
        }
    }

    public fun repay(arg0: &mut Account, arg1: &mut 0xa9f3f2005414ec86fd658ad921602b30b9c7f5a7e8d439b80a4f2329d15a868c::dollar::CapWrapper, arg2: 0x2::coin::Coin<0xa9f3f2005414ec86fd658ad921602b30b9c7f5a7e8d439b80a4f2329d15a868c::dollar::DOLLAR>) {
        arg0.debt = arg0.debt - 0xa9f3f2005414ec86fd658ad921602b30b9c7f5a7e8d439b80a4f2329d15a868c::dollar::burn(arg1, arg2);
    }

    public fun withdraw(arg0: &mut Bank, arg1: &mut Account, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.debt == 0, 3);
        assert!(arg1.collateral >= arg2, 0);
        arg1.collateral = arg1.collateral - arg2;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

