module 0x3f2acaa391de809ef9c2686cc16bf484c530da43be3291d718250504dfe2b7e0::real_atomic_arbitrage {
    struct FlashLoanReceipt {
        amount_borrowed: u64,
        amount_to_repay: u64,
        pool_id: address,
    }

    struct AtomicArbitrageExecuted has copy, drop {
        trader: address,
        amount_borrowed: u64,
        profit: u64,
        pool_a: address,
        pool_b: address,
        timestamp: u64,
        gas_used: u64,
    }

    public fun check_arbitrage_opportunity(arg0: address, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (bool, u64) {
        let v0 = arg2 * 997 / 1000 * 1005 / 1000;
        let v1 = arg2 + arg2 * 3 / 1000;
        if (v0 > v1) {
            (true, v0 - v1)
        } else {
            (false, 0)
        }
    }

    fun execute_arbitrage_swaps(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 * 997 / 1000 * 1005 / 1000;
        assert!(v1 >= v0 + arg3, 5);
        if (v1 > v0) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        };
        (arg0, v1 - v0)
    }

    public entry fun execute_real_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 4);
        assert!(arg4 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let (v2, v3) = flash_borrow_sui(arg1, arg3, arg6);
        let v4 = v3;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, v2);
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        let (v5, _) = execute_arbitrage_swaps(arg0, arg1, arg2, arg4, arg6);
        let v7 = v5;
        let v8 = v4.amount_to_repay;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v7) >= v8, 3);
        repay_flash_loan(0x2::coin::split<0x2::sui::SUI>(&mut v7, v8, arg6), v4);
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&v7);
        assert!(v9 >= v1 + arg4, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v0);
        let v10 = AtomicArbitrageExecuted{
            trader          : v0,
            amount_borrowed : arg3,
            profit          : v9 - v1,
            pool_a          : arg1,
            pool_b          : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg5),
            gas_used        : 0,
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v10);
    }

    public entry fun execute_simple_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 > 0, 4);
        assert!(arg1 > 0, 1);
        let v2 = v1 * 997 / 1000 * 1005 / 1000;
        assert!(v2 >= v1 + arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        let v3 = AtomicArbitrageExecuted{
            trader          : v0,
            amount_borrowed : 0,
            profit          : v2 - v1,
            pool_a          : @0x1,
            pool_b          : @0x2,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
            gas_used        : 0,
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v3);
    }

    fun flash_borrow_sui(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, FlashLoanReceipt) {
        let v0 = FlashLoanReceipt{
            amount_borrowed : arg1,
            amount_to_repay : arg1 + arg1 * 3 / 1000,
            pool_id         : arg0,
        };
        (0x2::coin::zero<0x2::sui::SUI>(arg2), v0)
    }

    fun repay_flash_loan(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: FlashLoanReceipt) {
        let FlashLoanReceipt {
            amount_borrowed : _,
            amount_to_repay : v1,
            pool_id         : _,
        } = arg1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
    }

    // decompiled from Move bytecode v6
}

