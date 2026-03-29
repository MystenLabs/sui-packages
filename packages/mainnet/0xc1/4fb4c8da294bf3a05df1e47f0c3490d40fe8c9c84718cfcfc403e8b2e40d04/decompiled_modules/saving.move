module 0xc14fb4c8da294bf3a05df1e47f0c3490d40fe8c9c84718cfcfc403e8b2e40d04::saving {
    struct SavingPool<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct SavingDepositReceipt<phantom T0> {
        pool: address,
    }

    struct SavingWithdrawReceipt<phantom T0> {
        req: 0xfcd556e94160069ee5b9a74a0ae74f69ca4a44ba7aefc453508b644f712885ed::account::Request,
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

    public fun withdraw<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0xfcd556e94160069ee5b9a74a0ae74f69ca4a44ba7aefc453508b644f712885ed::account::Request, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::object::UID>, SavingWithdrawReceipt<T0>) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

