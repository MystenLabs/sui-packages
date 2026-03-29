module 0xd8b0271ad77fc448e092d214662a49bf4ac85fe1c32fef7447b98a7b289c3e76::saving {
    struct SavingPool<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct SavingDepositReceipt<phantom T0> {
        pool: address,
    }

    struct SavingWithdrawReceipt<phantom T0> {
        req: 0x71519fbf0bf99a4257f163566b9ca757a5515d173f1be887014d538842581af7::account::Request,
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

    public fun withdraw<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x71519fbf0bf99a4257f163566b9ca757a5515d173f1be887014d538842581af7::account::Request, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::object::UID>, SavingWithdrawReceipt<T0>) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

