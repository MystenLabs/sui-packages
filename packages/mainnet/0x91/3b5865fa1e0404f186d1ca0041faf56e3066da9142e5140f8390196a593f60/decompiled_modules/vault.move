module 0x913b5865fa1e0404f186d1ca0041faf56e3066da9142e5140f8390196a593f60::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AccessList has key {
        id: 0x2::object::UID,
        executor: 0x2::vec_set::VecSet<address>,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee: u64,
    }

    struct FlashLoanReceipt<phantom T0> {
        amount: u64,
        min_repay: u64,
    }

    public fun access_list_add(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.executor, arg2);
    }

    public fun access_list_remove(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.executor, &arg2);
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
            fee     : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun flash_loan<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        assert!(arg2 <= 1000000000, 3);
        let v1 = FlashLoanReceipt<T0>{
            amount    : arg1,
            min_repay : arg1 + arg2,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg3), v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AccessList{
            id       : 0x2::object::new(arg0),
            executor : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<AccessList>(v1);
    }

    public fun is_executor(arg0: &AccessList, arg1: address) : bool {
        is_executor_internal(arg0, arg1)
    }

    fun is_executor_internal(arg0: &AccessList, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.executor, &arg1)
    }

    public fun repay_flash_loan<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>) {
        let FlashLoanReceipt {
            amount    : v0,
            min_repay : v1,
        } = arg2;
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= v1, 2);
        arg0.fee = arg0.fee + v2 - v0;
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &AccessList, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_executor_internal(arg1, 0x2::tx_context::sender(arg3)), 0);
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

