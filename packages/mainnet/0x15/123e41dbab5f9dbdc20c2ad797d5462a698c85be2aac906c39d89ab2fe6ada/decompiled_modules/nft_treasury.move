module 0x15123e41dbab5f9dbdc20c2ad797d5462a698c85be2aac906c39d89ab2fe6ada::nft_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        allowances: 0x2::table::Table<address, u64>,
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun allowance(arg0: &Treasury, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.allowances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.allowances, arg1)
        } else {
            0
        }
    }

    public fun deposit(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id         : 0x2::object::new(arg0),
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            allowances : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun set_allowance(arg0: &mut Treasury, arg1: address, arg2: u64) {
        0x2::table::add<address, u64>(&mut arg0.allowances, arg1, arg2);
    }

    public entry fun withdraw_allowance(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.allowances, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.allowances, v0);
        assert!(*v1 >= arg1, 1);
        *v1 = *v1 - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

