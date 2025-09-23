module 0xe20d78d45470572cad1d825c75e73b07fd70736877b3da17ee95c57cad2768aa::simple_flash_loan {
    struct FlashLoanPool<phantom T0> has key {
        id: 0x2::object::UID,
        reserves: 0x2::balance::Balance<T0>,
        fee_rate: u64,
    }

    struct FlashLoanReceipt<phantom T0> {
        amount: u64,
        fee: u64,
    }

    struct FlashLoanExecuted has copy, drop {
        borrower: address,
        amount: u64,
        fee: u64,
    }

    public fun borrow<T0>(arg0: &mut FlashLoanPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.reserves) >= arg1, 0);
        let v0 = FlashLoanReceipt<T0>{
            amount : arg1,
            fee    : arg1 * arg0.fee_rate / 10000,
        };
        (0x2::coin::take<T0>(&mut arg0.reserves, arg1, arg2), v0)
    }

    public fun add_liquidity<T0>(arg0: &mut FlashLoanPool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.reserves, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashLoanPool<T0>{
            id       : 0x2::object::new(arg2),
            reserves : 0x2::coin::into_balance<T0>(arg0),
            fee_rate : arg1,
        };
        0x2::transfer::share_object<FlashLoanPool<T0>>(v0);
    }

    public fun get_fee_rate<T0>(arg0: &FlashLoanPool<T0>) : u64 {
        arg0.fee_rate
    }

    public fun get_pool_balance<T0>(arg0: &FlashLoanPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserves)
    }

    public fun repay<T0>(arg0: &mut FlashLoanPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>, arg3: &0x2::tx_context::TxContext) {
        let FlashLoanReceipt {
            amount : v0,
            fee    : v1,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v0 + v1, 1);
        0x2::balance::join<T0>(&mut arg0.reserves, 0x2::coin::into_balance<T0>(arg1));
        let v2 = FlashLoanExecuted{
            borrower : 0x2::tx_context::sender(arg3),
            amount   : v0,
            fee      : v1,
        };
        0x2::event::emit<FlashLoanExecuted>(v2);
    }

    // decompiled from Move bytecode v6
}

