module 0x7019f3e9aff2f4c64cd8d5b364b838e5d8f90284db1a9afbc1d2b5986de5979a::main {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AccessList has key {
        id: 0x2::object::UID,
        receiver: address,
        executor: 0x2::vec_set::VecSet<address>,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::bag::Bag,
        fees: 0x2::bag::Bag,
    }

    struct FlashLoanReceipt {
        amount: u64,
        min_repay: u64,
    }

    public fun access_list_add(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.executor, arg2);
    }

    public fun access_list_remove(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.executor, &arg2);
    }

    public fun change_receiver(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        arg1.receiver = arg2;
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun flash_loan<T0>(arg0: &mut Vault, arg1: &AccessList, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, FlashLoanReceipt) {
        assert!(is_executor_internal(arg1, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1);
        let v2 = 0x2::balance::split<T0>(v1, arg2);
        let v3 = FlashLoanReceipt{
            amount    : arg2,
            min_repay : arg2 + get_fee_amount<T0>(arg0),
        };
        (v2, v3)
    }

    public fun get_fee<T0>(arg0: &Vault) : u64 {
        get_fee_amount<T0>(arg0)
    }

    fun get_fee_amount<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, v0)) {
            *0x2::bag::borrow<0x1::type_name::TypeName, u64>(&arg0.fees, v0)
        } else {
            0
        }
    }

    public fun get_receiver(arg0: &AccessList) : address {
        arg0.receiver
    }

    public fun get_vault_balance<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balance, v0))
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Vault{
            id      : 0x2::object::new(arg0),
            balance : 0x2::bag::new(arg0),
            fees    : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Vault>(v2);
        let v3 = AccessList{
            id       : 0x2::object::new(arg0),
            receiver : v0,
            executor : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<AccessList>(v3);
    }

    public fun is_executor(arg0: &AccessList, arg1: address) : bool {
        is_executor_internal(arg0, arg1)
    }

    fun is_executor_internal(arg0: &AccessList, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.executor, &arg1)
    }

    public fun repay_flash_loan<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: FlashLoanReceipt) {
        let FlashLoanReceipt {
            amount    : _,
            min_repay : v1,
        } = arg2;
        assert!(0x2::balance::value<T0>(&arg1) >= v1, 2);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, 0x1::type_name::get<T0>()), arg1);
    }

    public fun set_fee<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fees, v0)) {
            *0x2::bag::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg1.fees, v0) = arg2;
        } else {
            0x2::bag::add<0x1::type_name::TypeName, u64>(&mut arg1.fees, v0, arg2);
        };
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: &AccessList, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_executor_internal(arg1, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3), arg1.receiver);
    }

    // decompiled from Move bytecode v6
}

