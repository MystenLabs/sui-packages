module 0xefa5a960edc06a9af09d019357b6e5481109a6e353453d8fbc8d989c83a8e2fa::flashloan {
    struct Pool<phantom T0: store, phantom T1: store> has key {
        id: 0x2::object::UID,
        base_balance: 0x2::balance::Balance<T0>,
        quote_balance: 0x2::balance::Balance<T1>,
    }

    struct DepositReceipt<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        pool_id: 0x2::object::ID,
    }

    struct FlashLoan {
        pool_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
    }

    struct FlashLoanEvent has copy, drop {
        borrower: address,
        base_amount: u64,
        quote_amount: u64,
    }

    struct DepositEvent has copy, drop {
        depositor: address,
        amount: u64,
        asset_type: vector<u8>,
    }

    public fun base_balance<T0: store, T1: store>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.base_balance)
    }

    public fun borrow_flashloan_base<T0: store, T1: store>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan) {
        assert!(0x2::balance::value<T0>(&arg0.base_balance) >= arg1, 0);
        let v0 = FlashLoan{
            pool_id      : 0x2::object::uid_to_inner(&arg0.id),
            base_amount  : arg1,
            quote_amount : 0,
        };
        let v1 = FlashLoanEvent{
            borrower     : 0x2::tx_context::sender(arg2),
            base_amount  : arg1,
            quote_amount : 0,
        };
        0x2::event::emit<FlashLoanEvent>(v1);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.base_balance, arg1), arg2), v0)
    }

    public fun borrow_flashloan_quote<T0: store, T1: store>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoan) {
        assert!(0x2::balance::value<T1>(&arg0.quote_balance) >= arg1, 1);
        let v0 = FlashLoan{
            pool_id      : 0x2::object::uid_to_inner(&arg0.id),
            base_amount  : 0,
            quote_amount : arg1,
        };
        let v1 = FlashLoanEvent{
            borrower     : 0x2::tx_context::sender(arg2),
            base_amount  : 0,
            quote_amount : arg1,
        };
        0x2::event::emit<FlashLoanEvent>(v1);
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_balance, arg1), arg2), v0)
    }

    public entry fun deposit_base<T0: store, T1: store>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.base_balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = DepositReceipt<T0>{
            id      : 0x2::object::new(arg2),
            amount  : v0,
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::transfer::transfer<DepositReceipt<T0>>(v1, 0x2::tx_context::sender(arg2));
        let v2 = DepositEvent{
            depositor  : 0x2::tx_context::sender(arg2),
            amount     : v0,
            asset_type : b"BaseAsset",
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public entry fun deposit_quote<T0: store, T1: store>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut arg0.quote_balance, 0x2::coin::into_balance<T1>(arg1));
        let v1 = DepositReceipt<T1>{
            id      : 0x2::object::new(arg2),
            amount  : v0,
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::transfer::transfer<DepositReceipt<T1>>(v1, 0x2::tx_context::sender(arg2));
        let v2 = DepositEvent{
            depositor  : 0x2::tx_context::sender(arg2),
            amount     : v0,
            asset_type : b"QuoteAsset",
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public entry fun init_pool<T0: store, T1: store>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id            : 0x2::object::new(arg2),
            base_balance  : 0x2::coin::into_balance<T0>(arg0),
            quote_balance : 0x2::coin::into_balance<T1>(arg1),
        };
        0x2::transfer::transfer<Pool<T0, T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun quote_balance<T0: store, T1: store>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_balance)
    }

    public fun return_flashloan_base<T0: store, T1: store>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoan) {
        let FlashLoan {
            pool_id      : v0,
            base_amount  : v1,
            quote_amount : v2,
        } = arg2;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 2);
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 3);
        assert!(v2 == 0, 3);
        0x2::balance::join<T0>(&mut arg0.base_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun return_flashloan_quote<T0: store, T1: store>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: FlashLoan) {
        let FlashLoan {
            pool_id      : v0,
            base_amount  : v1,
            quote_amount : v2,
        } = arg2;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 2);
        assert!(0x2::coin::value<T1>(&arg1) >= v2, 3);
        assert!(v1 == 0, 3);
        0x2::balance::join<T1>(&mut arg0.quote_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun withdraw_base<T0: store, T1: store>(arg0: &mut Pool<T0, T1>, arg1: DepositReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let DepositReceipt {
            id      : v0,
            amount  : v1,
            pool_id : v2,
        } = arg1;
        assert!(v2 == 0x2::object::uid_to_inner(&arg0.id), 2);
        assert!(0x2::balance::value<T0>(&arg0.base_balance) >= v1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.base_balance, v1), arg2), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
    }

    public entry fun withdraw_quote<T0: store, T1: store>(arg0: &mut Pool<T0, T1>, arg1: DepositReceipt<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let DepositReceipt {
            id      : v0,
            amount  : v1,
            pool_id : v2,
        } = arg1;
        assert!(v2 == 0x2::object::uid_to_inner(&arg0.id), 2);
        assert!(0x2::balance::value<T1>(&arg0.quote_balance) >= v1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_balance, v1), arg2), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

