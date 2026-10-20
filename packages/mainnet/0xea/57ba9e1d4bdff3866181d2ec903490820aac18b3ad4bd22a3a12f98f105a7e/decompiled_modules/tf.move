module 0xea57ba9e1d4bdff3866181d2ec903490820aac18b3ad4bd22a3a12f98f105a7e::tf {
    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg3);
        let (v0, v1) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(arg1, arg3), 0x2::balance::value<0x2::sui::SUI>(&arg1), 0, true, arg2, arg3);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        0x2::coin::into_balance<T0>(v1)
    }

    public fun xs<T0>(arg0: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg3);
        let (v0, v1) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3), 0x2::balance::value<T0>(&arg1), 0, true, arg2, arg3);
        0x2::coin::destroy_zero<T0>(v1);
        0x2::coin::into_balance<0x2::sui::SUI>(v0)
    }

    // decompiled from Move bytecode v7
}

