module 0x930c0c8659443a01ffd4594115339c57703d07c4fcdf098a57436fe36dc8b9e3::vault {
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
        min_fee: u64,
    }

    struct FlashLoanReceipt<phantom T0> {
        amount: u64,
        min_repay: u64,
    }

    struct FlashLoanReceiptEvent has copy, drop {
        amount: u64,
        repay_amount: u64,
        diff: u64,
    }

    struct FlashLoanReceiptEventV2<phantom T0> has copy, drop {
        amount: u64,
        repay_amount: u64,
        vault_amount_after: u64,
        diff: u64,
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
            min_fee : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun flash_loan<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        assert!(arg2 <= 1000000000 && arg2 >= arg0.min_fee, 3);
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
        let v3 = &mut arg0.balance;
        0x2::balance::join<T0>(v3, 0x2::coin::into_balance<T0>(arg1));
        let v4 = FlashLoanReceiptEventV2<T0>{
            amount             : v0,
            repay_amount       : v2,
            vault_amount_after : 0x2::balance::value<T0>(v3),
            diff               : v2 - v0,
        };
        0x2::event::emit<FlashLoanReceiptEventV2<T0>>(v4);
    }

    public fun set_min_fee<T0>(arg0: &AccessList, arg1: &mut Vault<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(is_executor_internal(arg0, 0x2::tx_context::sender(arg3)), 0);
        arg1.min_fee = arg2;
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &AccessList, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_executor_internal(arg1, 0x2::tx_context::sender(arg3)), 0);
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

