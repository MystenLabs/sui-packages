module 0x18c5488e5f943681eca3a51738e1b8e295d998ab3d37729291bc54d231ba2739::flash_loan_arbitrage {
    struct FlashLoanReceipt<phantom T0> {
        loan_amount: u64,
        fee_amount: u64,
        lender_id: 0x2::object::ID,
    }

    struct FlashLender<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
        fee_bps: u64,
        admin: address,
    }

    struct LPToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct FlashLoanTaken has copy, drop {
        loan_amount: u64,
        fee_amount: u64,
        borrower: address,
        timestamp: u64,
    }

    struct FlashLoanRepaid has copy, drop {
        loan_amount: u64,
        fee_amount: u64,
        borrower: address,
        timestamp: u64,
    }

    public fun add_liquidity<T0>(arg0: &mut FlashLender<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun borrow_flash_loan<T0>(arg0: &mut FlashLender<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        assert!(arg1 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.pool) >= arg1, 1);
        let v0 = arg1 * arg0.fee_bps / 10000;
        let v1 = FlashLoanReceipt<T0>{
            loan_amount : arg1,
            fee_amount  : v0,
            lender_id   : 0x2::object::id<FlashLender<T0>>(arg0),
        };
        let v2 = FlashLoanTaken{
            loan_amount : arg1,
            fee_amount  : v0,
            borrower    : 0x2::tx_context::sender(arg3),
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FlashLoanTaken>(v2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, arg1), arg3), v1)
    }

    public fun create_flash_lender<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FlashLender<T0> {
        FlashLender<T0>{
            id      : 0x2::object::new(arg2),
            pool    : 0x2::coin::into_balance<T0>(arg0),
            fee_bps : arg1,
            admin   : 0x2::tx_context::sender(arg2),
        }
    }

    public entry fun execute_arbitrage_with_flash_loan<T0>(arg0: &mut FlashLender<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = borrow_flash_loan<T0>(arg0, arg1, arg2, arg3);
        let v2 = execute_dex_arbitrage<T0>(v0, arg3);
        repay_flash_loan<T0>(arg0, v2, v1, arg2, arg3);
    }

    fun execute_dex_arbitrage<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0
    }

    public fun fee_rate<T0>(arg0: &FlashLender<T0>) : u64 {
        arg0.fee_bps
    }

    public fun pool_balance<T0>(arg0: &FlashLender<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun remove_liquidity<T0>(arg0: &mut FlashLender<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        assert!(0x2::balance::value<T0>(&arg0.pool) >= arg1, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, arg1), arg2)
    }

    public fun repay_flash_loan<T0>(arg0: &mut FlashLender<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let FlashLoanReceipt {
            loan_amount : v0,
            fee_amount  : v1,
            lender_id   : v2,
        } = arg2;
        assert!(v2 == 0x2::object::id<FlashLender<T0>>(arg0), 2);
        assert!(0x2::coin::value<T0>(&arg1) >= v0 + v1, 2);
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg1));
        let v3 = FlashLoanRepaid{
            loan_amount : v0,
            fee_amount  : v1,
            borrower    : 0x2::tx_context::sender(arg4),
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FlashLoanRepaid>(v3);
    }

    // decompiled from Move bytecode v6
}

