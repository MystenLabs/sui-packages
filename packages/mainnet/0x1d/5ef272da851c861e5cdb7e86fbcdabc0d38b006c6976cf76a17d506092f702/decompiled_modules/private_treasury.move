module 0x1d5ef272da851c861e5cdb7e86fbcdabc0d38b006c6976cf76a17d506092f702::private_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        admin: address,
    }

    public entry fun deposit(arg0: &mut Treasury, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg2, 101);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3));
    }

    public fun get_balance(arg0: &Treasury, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 100);
        0x2::coin::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        let v1 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_out(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 100);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 101);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

