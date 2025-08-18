module 0xa0ce0a797f267dc15ecfbaa049e63f1ba1560f95a4e65d00f37ccf95d8d4c46a::calculatorr {
    struct Result has copy, drop {
        value: u64,
        operation: vector<u8>,
    }

    public fun divide(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1 != 0, 1);
        let v0 = arg0 / arg1;
        let v1 = Result{
            value     : v0,
            operation : b"divide",
        };
        0x2::event::emit<Result>(v1);
        v0
    }

    public fun minus(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0 >= arg1, 0);
        let v0 = arg0 - arg1;
        let v1 = Result{
            value     : v0,
            operation : b"minus",
        };
        0x2::event::emit<Result>(v1);
        v0
    }

    public fun multiply(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0 * arg1;
        let v1 = Result{
            value     : v0,
            operation : b"multiply",
        };
        0x2::event::emit<Result>(v1);
        v0
    }

    public fun sum(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0 + arg1;
        let v1 = Result{
            value     : v0,
            operation : b"sum",
        };
        0x2::event::emit<Result>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

