module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::flash_loan {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct FlashLoanAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Receipt<phantom T0> {
        borrowed_amount: u64,
    }

    public fun flash_loan<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        if (arg1 > 0x2::balance::value<T0>(&arg0.balance)) {
            abort 0
        };
        let v0 = 0x2::balance::split<T0>(&mut arg0.balance, arg1);
        let v1 = Receipt<T0>{borrowed_amount: 0x2::balance::value<T0>(&v0)};
        (0x2::coin::from_balance<T0>(v0, arg2), v1)
    }

    public fun add_coin<T0>(arg0: &mut Pool<T0>, arg1: &FlashLoanAdminCap, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashLoanAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FlashLoanAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_pool<T0>(arg0: &FlashLoanAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun repay_flash_loan<T0>(arg0: &mut Pool<T0>, arg1: Receipt<T0>, arg2: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg2) != arg1.borrowed_amount) {
            abort 1
        };
        let Receipt {  } = arg1;
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    // decompiled from Move bytecode v6
}

