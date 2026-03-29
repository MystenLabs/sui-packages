module 0x7050f405f533dca764e18a5e6dde6c1b5486613af396cf1b66ef9348704a2b70::saving {
    struct SavingPool<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct SavingDepositReceipt<phantom T0> {
        pool: address,
    }

    struct SavingWithdrawReceipt<phantom T0> {
        req: 0xe171a82f55fea816a1526336525f0947a58d71507513ef3228420cc5433e216::account::Request,
        pool: address,
    }

    public fun check_deposit_response<T0>(arg0: SavingDepositReceipt<T0>, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        abort 0
    }

    public fun check_withdraw_response<T0>(arg0: SavingWithdrawReceipt<T0>, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        abort 0
    }

    public fun deposit<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : SavingDepositReceipt<T0> {
        abort 0
    }

    public fun total_reserve<T0>(arg0: &SavingPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        abort 0
    }

    public fun withdraw<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0xe171a82f55fea816a1526336525f0947a58d71507513ef3228420cc5433e216::account::Request, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::object::UID>, SavingWithdrawReceipt<T0>) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

