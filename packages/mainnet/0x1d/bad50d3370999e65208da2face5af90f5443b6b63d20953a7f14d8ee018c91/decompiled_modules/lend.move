module 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::lend {
    struct Lender has store, key {
        id: 0x2::object::UID,
        fee_bps: u64,
        xup_reserve: u64,
    }

    struct FlashLoan has store {
        principal: u64,
        fee_bps: u64,
        closed: bool,
    }

    public fun new(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Lender {
        Lender{
            id          : 0x2::object::new(arg2),
            fee_bps     : arg0,
            xup_reserve : arg1,
        }
    }

    public fun assert_authorized(arg0: &0x2::tx_context::TxContext) {
    }

    public fun deposit(arg0: &mut Lender, arg1: u64) {
        arg0.xup_reserve = arg0.xup_reserve + arg1;
    }

    public fun fee_bps() : u64 {
        10
    }

    public fun flash_borrow(arg0: &mut Lender, arg1: u64) : FlashLoan {
        assert!(arg1 <= arg0.xup_reserve, 2);
        arg0.xup_reserve = arg0.xup_reserve - arg1;
        FlashLoan{
            principal : arg1,
            fee_bps   : arg0.fee_bps,
            closed    : false,
        }
    }

    public fun flash_repay(arg0: &mut Lender, arg1: FlashLoan, arg2: u64) {
        assert!(!arg1.closed, 3);
        let FlashLoan {
            principal : v0,
            fee_bps   : _,
            closed    : _,
        } = arg1;
        assert!(arg2 >= v0 + v0 * 10 / 10000, 1);
        arg0.xup_reserve = arg0.xup_reserve + arg2;
    }

    public fun principal(arg0: &FlashLoan) : u64 {
        arg0.principal
    }

    public fun repayment_due(arg0: &FlashLoan) : u64 {
        arg0.principal + arg0.principal * arg0.fee_bps / 10000
    }

    public fun reserve(arg0: &Lender) : u64 {
        arg0.xup_reserve
    }

    // decompiled from Move bytecode v7
}

