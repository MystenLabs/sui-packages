module 0x5896f235f86d4a34e97bf6631e5f0ad641fbd991fb96feeff47e34b4bd800e7d::turbosfun {
    public fun turbos_fun_swap<T0>(arg0: &mut 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::KongBot<0x2::sui::SUI>, arg1: &mut 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::Banana<0x2::sui::SUI>, arg2: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::transfer_bananas<0x2::sui::SUI>(arg0, arg1, arg3, arg6);
        0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy<T0>(arg2, v1, v0, arg4, true, arg5, arg6);
    }

    public fun turbos_fun_swap_sell<T0>(arg0: &mut 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::KongBot<0x2::sui::SUI>, arg1: &mut 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::Banana<0x2::sui::SUI>, arg2: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg2, arg3, arg4, arg5, true, arg6, arg7);
        let (_, v3) = 0x5948a731cdad0245398a434ccc142a9139604c331988fcea3e2239a803b2a75e::kong_bot::transfer_bananas<0x2::sui::SUI>(arg0, arg1, v0, arg7);
        0x5896f235f86d4a34e97bf6631e5f0ad641fbd991fb96feeff47e34b4bd800e7d::utils::transfer_or_destroy_coin<0x2::sui::SUI>(v3, arg7);
        0x5896f235f86d4a34e97bf6631e5f0ad641fbd991fb96feeff47e34b4bd800e7d::utils::transfer_or_destroy_coin<T0>(v1, arg7);
    }

    // decompiled from Move bytecode v6
}

