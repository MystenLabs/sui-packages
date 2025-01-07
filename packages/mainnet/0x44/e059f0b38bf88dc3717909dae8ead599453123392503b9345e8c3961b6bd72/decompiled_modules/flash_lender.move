module 0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::flash_lender {
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

    fun check_admin<T0>(arg0: &FlashLender<T0>, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<FlashLender<T0>>(arg0) == &arg1.flash_lender_id, 3);
    }

    public entry fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit<T0>(arg0: &mut FlashLender<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        check_admin<T0>(arg0, arg1);
        0x2::coin::put<T0>(&mut arg0.to_lend, arg2);
    }

    public fun fee<T0>(arg0: &FlashLender<T0>) : u64 {
        arg0.fee
    }

    public fun flash_lender_id<T0>(arg0: &Receipt<T0>) : 0x2::object::ID {
        arg0.flash_lender_id
    }

    public fun loan<T0>(arg0: &mut FlashLender<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        let v0 = &mut arg0.to_lend;
        assert!(0x2::balance::value<T0>(v0) >= arg1, 0);
        let v1 = 0x2::coin::take<T0>(v0, arg1, arg2);
        let v2 = Receipt<T0>{
            flash_lender_id : 0x2::object::id<FlashLender<T0>>(arg0),
            repay_amount    : arg1 + arg0.fee,
        };
        (v1, v2)
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

    public entry fun update_fee<T0>(arg0: &mut FlashLender<T0>, arg1: &AdminCap, arg2: u64) {
        check_admin<T0>(arg0, arg1);
        arg0.fee = arg2;
    }

    public fun withdraw<T0>(arg0: &mut FlashLender<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin<T0>(arg0, arg1);
        let v0 = &mut arg0.to_lend;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 4);
        0x2::coin::take<T0>(v0, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

