module 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::bucket_bridge {
    public fun check_deposit<T0>(arg0: 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::DepositResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::check_deposit_response<T0>(arg0, arg1, arg2);
    }

    public fun check_withdraw<T0>(arg0: 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::WithdrawResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::check_withdraw_response<T0>(arg0, arg1, arg2);
    }

    public fun deposit_to_bucket<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::DepositResponse {
        abort 57005
    }

    public fun deposit_to_bucket_v2<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::DepositResponse {
        0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun withdraw_from_bucket<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::framework::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::object::UID>, 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::WithdrawResponse) {
        abort 57005
    }

    public fun withdraw_from_bucket_v2<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::framework::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::WithdrawResponse) {
        0x64e3ff500089d041c65029f0a7100bd20459b03ed10d18c777a732f67c0fe278::saving::withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

