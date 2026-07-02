module 0x3a56f433ac9a0d9a1d0d41f8695aa40fcc8a9c4160dbe8fe480d17a5b10402b3::flash {
    struct FlashLender<phantom T0> has key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<T0>,
        fee_bps: u64,
    }

    struct FlashReceipt {
        lender: 0x2::object::ID,
        amount: u64,
        fee: u64,
    }

    struct LenderCreated has copy, drop {
        lender: 0x2::object::ID,
        fee_bps: u64,
        reserve: u64,
    }

    struct LoanBorrowed has copy, drop {
        lender: 0x2::object::ID,
        amount: u64,
        fee: u64,
    }

    struct LoanRepaid has copy, drop {
        lender: 0x2::object::ID,
        amount: u64,
        fee: u64,
        change: u64,
    }

    public fun borrow<T0>(arg0: &mut FlashLender<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashReceipt) {
        let v0 = fee_amount(arg1, arg0.fee_bps);
        let v1 = 0x2::object::id<FlashLender<T0>>(arg0);
        let v2 = LoanBorrowed{
            lender : v1,
            amount : arg1,
            fee    : v0,
        };
        0x2::event::emit<LoanBorrowed>(v2);
        let v3 = FlashReceipt{
            lender : v1,
            amount : arg1,
            fee    : v0,
        };
        (0x2::coin::take<T0>(&mut arg0.reserve, arg1, arg2), v3)
    }

    public fun create_lender<T0>(arg0: &0x3a56f433ac9a0d9a1d0d41f8695aa40fcc8a9c4160dbe8fe480d17a5b10402b3::admin::AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 10000, 3);
        let v0 = FlashLender<T0>{
            id      : 0x2::object::new(arg3),
            reserve : 0x2::coin::into_balance<T0>(arg1),
            fee_bps : arg2,
        };
        let v1 = LenderCreated{
            lender  : 0x2::object::id<FlashLender<T0>>(&v0),
            fee_bps : arg2,
            reserve : 0x2::balance::value<T0>(&v0.reserve),
        };
        0x2::event::emit<LenderCreated>(v1);
        0x2::transfer::share_object<FlashLender<T0>>(v0);
    }

    public fun fee_amount(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
    }

    public fun fee_denom() : u64 {
        10000
    }

    public fun fund<T0>(arg0: &0x3a56f433ac9a0d9a1d0d41f8695aa40fcc8a9c4160dbe8fe480d17a5b10402b3::admin::AdminCap, arg1: &mut FlashLender<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.reserve, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun lender_fee_bps<T0>(arg0: &FlashLender<T0>) : u64 {
        arg0.fee_bps
    }

    public fun receipt_amount(arg0: &FlashReceipt) : u64 {
        arg0.amount
    }

    public fun receipt_fee(arg0: &FlashReceipt) : u64 {
        arg0.fee
    }

    public fun receipt_lender(arg0: &FlashReceipt) : 0x2::object::ID {
        arg0.lender
    }

    public fun receipt_total(arg0: &FlashReceipt) : u64 {
        arg0.amount + arg0.fee
    }

    public fun repay<T0>(arg0: &mut FlashLender<T0>, arg1: FlashReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let FlashReceipt {
            lender : v0,
            amount : v1,
            fee    : v2,
        } = arg1;
        assert!(0x2::object::id<FlashLender<T0>>(arg0) == v0, 2);
        let v3 = v1 + v2;
        assert!(0x2::coin::value<T0>(&arg2) >= v3, 1);
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v3, arg3)));
        let v4 = LoanRepaid{
            lender : v0,
            amount : v1,
            fee    : v2,
            change : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<LoanRepaid>(v4);
        arg2
    }

    public fun reserve_value<T0>(arg0: &FlashLender<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve)
    }

    // decompiled from Move bytecode v7
}

