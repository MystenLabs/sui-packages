module 0x234f4c9f8b60653cf1ae10512a28d4335f12ef1cfc15a6ec8b665688c53573ca::example {
    struct FlashLender<phantom T0> has key {
        id: 0x2::object::UID,
        to_lend: 0x2::balance::Balance<T0>,
        fee: u64,
    }

    struct Receipt<phantom T0> {
        flash_lender_id: 0x2::object::ID,
        repay_amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        flash_lender_id: 0x2::object::ID,
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::object::new(arg2);
        let v1 = FlashLender<T0>{
            id      : v0,
            to_lend : arg0,
            fee     : arg1,
        };
        0x2::transfer::share_object<FlashLender<T0>>(v1);
        AdminCap{
            id              : 0x2::object::new(arg2),
            flash_lender_id : 0x2::object::uid_to_inner(&v0),
        }
    }

    public fun deposit<T0>(arg0: &mut FlashLender<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::borrow_id<FlashLender<T0>>(arg0) == &arg1.flash_lender_id, 3);
        0x2::coin::put<T0>(&mut arg0.to_lend, arg2);
    }

    public fun fee<T0>(arg0: &FlashLender<T0>) : u64 {
        arg0.fee
    }

    public fun flash_lender_id<T0>(arg0: &Receipt<T0>) : 0x2::object::ID {
        arg0.flash_lender_id
    }

    public fun loan<T0>(arg0: &mut FlashLender<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.to_lend) >= arg1, 0);
        let v0 = Receipt<T0>{
            flash_lender_id : 0x2::object::id<FlashLender<T0>>(arg0),
            repay_amount    : arg1 + arg0.fee,
        };
        (0x2::coin::take<T0>(&mut arg0.to_lend, arg1, arg2), v0)
    }

    public fun max_loan<T0>(arg0: &FlashLender<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.to_lend)
    }

    public fun repay<T0>(arg0: &mut FlashLender<T0>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt<T0>) {
        let Receipt {
            flash_lender_id : v0,
            repay_amount    : v1,
        } = arg2;
        assert!(0x2::object::id<FlashLender<T0>>(arg0) == v0, 2);
        assert!(0x2::coin::value<T0>(&arg1) == v1, 1);
        0x2::coin::put<T0>(&mut arg0.to_lend, arg1);
    }

    public fun repay_amount<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.repay_amount
    }

    public fun update_fee<T0>(arg0: &mut FlashLender<T0>, arg1: &AdminCap, arg2: u64) {
        assert!(0x2::object::borrow_id<FlashLender<T0>>(arg0) == &arg1.flash_lender_id, 3);
        arg0.fee = arg2;
    }

    public fun withdraw<T0>(arg0: &mut FlashLender<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::borrow_id<FlashLender<T0>>(arg0) == &arg1.flash_lender_id, 3);
        assert!(0x2::balance::value<T0>(&arg0.to_lend) >= arg2, 4);
        0x2::coin::take<T0>(&mut arg0.to_lend, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

