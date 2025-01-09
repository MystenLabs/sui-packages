module 0xdadd86d2e514d03fffd0b342eac5941a9f8a7c8cb30cf9d8e17baee97ead1177::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositContract has store, key {
        id: 0x2::object::UID,
        creator: address,
        white_list: vector<address>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun add_to_white_list(arg0: &AdminCap, arg1: &mut DepositContract, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg1.white_list, arg2);
    }

    public fun deposit(arg0: &mut DepositContract, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = DepositContract{
            id         : 0x2::object::new(arg0),
            creator    : v0,
            white_list : 0x1::vector::empty<address>(),
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<DepositContract>(v2);
    }

    public fun remove_from_white_list(arg0: &AdminCap, arg1: &mut DepositContract, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.white_list, &arg2);
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg1.white_list, v1);
    }

    public fun withdraw(arg0: &mut DepositContract, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.white_list, &v0) || v0 == arg0.creator, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2)
    }

    public fun withdraw_all(arg0: &AdminCap, arg1: &mut DepositContract, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg2) == arg1.creator, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

