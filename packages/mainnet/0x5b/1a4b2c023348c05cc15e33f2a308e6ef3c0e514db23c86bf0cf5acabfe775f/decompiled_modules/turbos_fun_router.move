module 0x5b1a4b2c023348c05cc15e33f2a308e6ef3c0e514db23c86bf0cf5acabfe775f::turbos_fun_router {
    public fun swap<T0>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_sui_to_token<T0>(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_token_to_sui<T0>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    public fun swap_sui_to_token<T0>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<0x2::sui::SUI>(arg0, arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), 0, 0, true, arg2, arg4);
        let v4 = v3;
        let v5 = v2;
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v4));
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        if (v6 > 0) {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v5);
        };
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<0x2::sui::SUI, T0>(arg0, b"turbos_fun", 0x2::object::id<0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration>(arg1), v1 - v6, 0x2::coin::value<T0>(&v4), 0);
    }

    public fun swap_token_to_sui<T0>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg4), 0, 0, true, arg2, arg4);
        let v4 = v3;
        let v5 = v2;
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
        let v6 = 0x2::coin::value<T0>(&v4);
        if (v6 > 0) {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v4));
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<T0, 0x2::sui::SUI>(arg0, b"turbos_fun", 0x2::object::id<0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration>(arg1), v1 - v6, 0x2::coin::value<0x2::sui::SUI>(&v5), 0);
    }

    // decompiled from Move bytecode v6
}

