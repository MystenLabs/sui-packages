module 0x866ae703737cc34c68df98fabc43d262eee510a3a023f9d899a26e2f406b7af4::bucket_bridge {
    public fun check_deposit<T0>(arg0: 0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::saving::DepositResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::saving::check_deposit_response<T0>(arg0, arg1, arg2);
    }

    public fun check_withdraw<T0>(arg0: 0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::saving::WithdrawResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::saving::check_withdraw_response<T0>(arg0, arg1, arg2);
    }

    public fun deposit_to_bucket<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::saving::DepositResponse {
        0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::saving::deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun withdraw_from_bucket<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::framework::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::object::UID>, 0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::saving::WithdrawResponse) {
        0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::saving::withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

