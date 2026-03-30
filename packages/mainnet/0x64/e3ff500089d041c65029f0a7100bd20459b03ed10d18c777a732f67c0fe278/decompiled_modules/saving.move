module 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving {
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

    public fun deposit<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : DepositResponse {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, @0x0);
        DepositResponse{dummy: false}
    }

    public fun withdraw<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::framework::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, WithdrawResponse) {
        let v0 = WithdrawResponse{dummy: false};
        (0x2::coin::zero<T0>(arg5), v0)
    }

    // decompiled from Move bytecode v6
}

