module 0x728dd361396569539b662e8a1a61fedb8b457129f38e4b95b564f766e1cd2a78::flash_loan_arbitrage {
    struct FlashLender<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        admin: address,
    }

    struct FlashLoanReceipt<phantom T0> {
        pool_id: address,
        loan_amount: u64,
        fee_amount: u64,
        timestamp: u64,
    }

    struct FlashLoanBorrowed<phantom T0> has copy, drop {
        pool_id: address,
        borrower: address,
        amount: u64,
        fee: u64,
        timestamp: u64,
    }

    struct FlashLoanRepaid<phantom T0> has copy, drop {
        pool_id: address,
        borrower: address,
        loan_amount: u64,
        fee_amount: u64,
        timestamp: u64,
    }

    public entry fun add_liquidity<T0>(arg0: &mut FlashLender<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun admin<T0>(arg0: &FlashLender<T0>) : address {
        arg0.admin
    }

    public fun borrow_flash_loan<T0>(arg0: &mut FlashLender<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 1);
        let v0 = arg1 * 10 / 10000;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = FlashLoanReceipt<T0>{
            pool_id     : 0x2::object::uid_to_address(&arg0.id),
            loan_amount : arg1,
            fee_amount  : v0,
            timestamp   : v1,
        };
        let v3 = FlashLoanBorrowed<T0>{
            pool_id   : 0x2::object::uid_to_address(&arg0.id),
            borrower  : 0x2::tx_context::sender(arg3),
            amount    : arg1,
            fee       : v0,
            timestamp : v1,
        };
        0x2::event::emit<FlashLoanBorrowed<T0>>(v3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), v2)
    }

    public fun calculate_fee<T0>(arg0: u64) : u64 {
        arg0 * 10 / 10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashLender<0x2::sui::SUI>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FlashLender<0x2::sui::SUI>>(v0);
    }

    public fun pool_balance<T0>(arg0: &FlashLender<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun pool_id<T0>(arg0: &FlashLender<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun receipt_info<T0>(arg0: &FlashLoanReceipt<T0>) : (address, u64, u64, u64) {
        (arg0.pool_id, arg0.loan_amount, arg0.fee_amount, arg0.timestamp)
    }

    public entry fun remove_liquidity<T0>(arg0: &mut FlashLender<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), arg0.admin);
    }

    public fun repay_flash_loan<T0>(arg0: &mut FlashLender<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.pool_id == 0x2::object::uid_to_address(&arg0.id), 4);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2.loan_amount + arg2.fee_amount, 2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = FlashLoanRepaid<T0>{
            pool_id     : arg2.pool_id,
            borrower    : 0x2::tx_context::sender(arg4),
            loan_amount : arg2.loan_amount,
            fee_amount  : arg2.fee_amount,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FlashLoanRepaid<T0>>(v0);
        let FlashLoanReceipt {
            pool_id     : _,
            loan_amount : _,
            fee_amount  : _,
            timestamp   : _,
        } = arg2;
    }

    // decompiled from Move bytecode v6
}

