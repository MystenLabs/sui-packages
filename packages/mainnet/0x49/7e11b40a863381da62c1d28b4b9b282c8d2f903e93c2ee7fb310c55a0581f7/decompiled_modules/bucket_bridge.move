module 0x497e11b40a863381da62c1d28b4b9b282c8d2f903e93c2ee7fb310c55a0581f7::bucket_bridge {
    public fun check_deposit<T0>(arg0: 0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::DepositResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::check_deposit_response<T0>(arg0, arg1, arg2);
    }

    public fun check_withdraw<T0>(arg0: 0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::WithdrawResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::check_withdraw_response<T0>(arg0, arg1, arg2);
    }

    public fun deposit_to_bucket<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::DepositResponse {
        abort 57005
    }

    public fun deposit_to_bucket_v2<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::DepositResponse {
        0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun withdraw_from_bucket<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::framework::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::object::UID>, 0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::WithdrawResponse) {
        abort 57005
    }

    public fun withdraw_from_bucket_v2<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::framework::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::WithdrawResponse) {
        0xfcf8e050c7b7dc1d672e12147526c2186802cb94584b6777abc6de84306a7ffa::saving::withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

