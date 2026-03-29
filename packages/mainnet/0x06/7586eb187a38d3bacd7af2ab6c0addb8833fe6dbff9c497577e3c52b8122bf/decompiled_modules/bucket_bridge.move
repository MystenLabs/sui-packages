module 0x67586eb187a38d3bacd7af2ab6c0addb8833fe6dbff9c497577e3c52b8122bf::bucket_bridge {
    public fun check_deposit<T0>(arg0: 0x5c732e6553a026fd3f571e3261dc64e36d976da30cd0fb59e3d0dff0661f39cd::saving::DepositResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        0x5c732e6553a026fd3f571e3261dc64e36d976da30cd0fb59e3d0dff0661f39cd::saving::check_deposit_response<T0>(arg0, arg1, arg2);
    }

    public fun check_withdraw<T0>(arg0: 0x5c732e6553a026fd3f571e3261dc64e36d976da30cd0fb59e3d0dff0661f39cd::saving::WithdrawResponse, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::object::UID) {
        0x5c732e6553a026fd3f571e3261dc64e36d976da30cd0fb59e3d0dff0661f39cd::saving::check_withdraw_response<T0>(arg0, arg1, arg2);
    }

    public fun deposit_to_bucket<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: address, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x5c732e6553a026fd3f571e3261dc64e36d976da30cd0fb59e3d0dff0661f39cd::saving::DepositResponse {
        0x5c732e6553a026fd3f571e3261dc64e36d976da30cd0fb59e3d0dff0661f39cd::saving::deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun withdraw_from_bucket<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x5c732e6553a026fd3f571e3261dc64e36d976da30cd0fb59e3d0dff0661f39cd::framework::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::object::UID>, 0x5c732e6553a026fd3f571e3261dc64e36d976da30cd0fb59e3d0dff0661f39cd::saving::WithdrawResponse) {
        0x5c732e6553a026fd3f571e3261dc64e36d976da30cd0fb59e3d0dff0661f39cd::saving::withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

