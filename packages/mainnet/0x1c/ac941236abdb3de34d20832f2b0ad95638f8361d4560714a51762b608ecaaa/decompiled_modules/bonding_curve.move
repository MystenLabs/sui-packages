module 0x5e06b1e0398d2cb493e9ae9e085461f64c12aef69fb0d6424e19bb5f125298b::bonding_curve {
    public fun swap<T0>(arg0: &mut 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::SwapContext, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0>(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b2a<T0>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun swap_a2b<T0>(arg0: &mut 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::SwapContext, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg4), v1, 0, true, arg2, arg4);
        0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        if (arg3 == 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::max_amount_in()) {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::transfer_remaining_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3), arg4);
        } else {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        };
    }

    fun swap_b2a<T0>(arg0: &mut 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::SwapContext, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::take_balance<0x2::sui::SUI>(arg0, arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), v1, 0, true, arg2, arg4);
        0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        if (arg3 == 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::max_amount_in()) {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::transfer_remaining_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2), arg4);
        } else {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        };
    }

    // decompiled from Move bytecode v7
}

