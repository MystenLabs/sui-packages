module 0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::saving {
    struct Resp {
        id: 0x2::object::UID,
    }

    public fun check_deposit_response<T0>(arg0: Resp, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        abort 0
    }

    public fun check_withdraw_response<T0>(arg0: Resp, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        abort 0
    }

    public fun deposit<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Resp {
        abort 0
    }

    public fun withdraw<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::account::Request, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::object::UID>, Resp) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

