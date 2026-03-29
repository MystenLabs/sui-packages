module 0x5f2f3ba39b54697812e0baf630d42da6b9704a28cf4d890965beb427407afb12::saving {
    struct WithdrawResponse has drop {
        dummy: bool,
    }

    struct DepositResponse has drop {
        dummy: bool,
    }

    public fun check_deposit_response<T0>(arg0: DepositResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
    }

    public fun check_withdraw_response<T0>(arg0: WithdrawResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
    }

    public fun deposit<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : DepositResponse {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::object::UID>>(arg3, @0x0);
        DepositResponse{dummy: false}
    }

    public fun withdraw<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x5f2f3ba39b54697812e0baf630d42da6b9704a28cf4d890965beb427407afb12::framework::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::object::UID>, WithdrawResponse) {
        let v0 = WithdrawResponse{dummy: false};
        (0x2::coin::zero<0x2::object::UID>(arg5), v0)
    }

    // decompiled from Move bytecode v6
}

