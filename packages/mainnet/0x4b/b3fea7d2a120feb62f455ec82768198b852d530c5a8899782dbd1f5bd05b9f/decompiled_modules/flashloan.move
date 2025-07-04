module 0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::flashloan {
    struct FlashloanExecuted has copy, drop {
        pool_id: address,
        borrower: address,
        amount: u64,
        fee: u64,
        timestamp: u64,
    }

    struct FlashloanRepaid has copy, drop {
        pool_id: address,
        borrower: address,
        amount: u64,
        fee: u64,
        profit: u64,
        timestamp: u64,
    }

    struct FlashloanReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        amount: u64,
        fee: u64,
        borrower: address,
    }

    struct FlashloanPool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee_rate_bps: u64,
        total_borrowed: u64,
        total_fees_collected: u64,
        admin: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun flashloan<T0>(arg0: &mut FlashloanPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashloanReceipt<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 1);
        assert!(arg1 > 0, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg1 * arg0.fee_rate_bps / 10000;
        let v2 = FlashloanReceipt<T0>{
            id       : 0x2::object::new(arg2),
            pool_id  : 0x2::object::uid_to_address(&arg0.id),
            amount   : arg1,
            fee      : v1,
            borrower : v0,
        };
        arg0.total_borrowed = arg0.total_borrowed + arg1;
        let v3 = FlashloanExecuted{
            pool_id   : 0x2::object::uid_to_address(&arg0.id),
            borrower  : v0,
            amount    : arg1,
            fee       : v1,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<FlashloanExecuted>(v3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), v2)
    }

    public fun add_liquidity<T0>(arg0: &mut FlashloanPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : (FlashloanPool<T0>, AdminCap) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = FlashloanPool<T0>{
            id                   : 0x2::object::new(arg1),
            balance              : 0x2::coin::into_balance<T0>(arg0),
            fee_rate_bps         : 3,
            total_borrowed       : 0,
            total_fees_collected : 0,
            admin                : 0x2::tx_context::sender(arg1),
        };
        (v1, v0)
    }

    public fun pool_balance<T0>(arg0: &FlashloanPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun pool_fee_rate<T0>(arg0: &FlashloanPool<T0>) : u64 {
        arg0.fee_rate_bps
    }

    public fun pool_total_borrowed<T0>(arg0: &FlashloanPool<T0>) : u64 {
        arg0.total_borrowed
    }

    public fun pool_total_fees<T0>(arg0: &FlashloanPool<T0>) : u64 {
        arg0.total_fees_collected
    }

    public fun receipt_amount<T0>(arg0: &FlashloanReceipt<T0>) : u64 {
        arg0.amount
    }

    public fun receipt_borrower<T0>(arg0: &FlashloanReceipt<T0>) : address {
        arg0.borrower
    }

    public fun receipt_fee<T0>(arg0: &FlashloanReceipt<T0>) : u64 {
        arg0.fee
    }

    public fun repay_flashloan<T0>(arg0: &mut FlashloanPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashloanReceipt<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let FlashloanReceipt {
            id       : v0,
            pool_id  : _,
            amount   : v2,
            fee      : v3,
            borrower : v4,
        } = arg2;
        assert!(v4 == 0x2::tx_context::sender(arg3), 3);
        let v5 = 0x2::coin::value<T0>(&arg1);
        let v6 = v2 + v3;
        assert!(v5 >= v6, 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_fees_collected = arg0.total_fees_collected + v3;
        let v7 = if (v5 > v6) {
            v5 - v6
        } else {
            0
        };
        let v8 = FlashloanRepaid{
            pool_id   : 0x2::object::uid_to_address(&arg0.id),
            borrower  : v4,
            amount    : v2,
            fee       : v3,
            profit    : v7,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<FlashloanRepaid>(v8);
        0x2::object::delete(v0);
    }

    public fun update_fee_rate<T0>(arg0: &mut FlashloanPool<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 5);
        arg0.fee_rate_bps = arg2;
    }

    public fun withdraw_fees<T0>(arg0: &mut FlashloanPool<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 <= arg0.total_fees_collected, 1);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 1);
        arg0.total_fees_collected = arg0.total_fees_collected - arg2;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

