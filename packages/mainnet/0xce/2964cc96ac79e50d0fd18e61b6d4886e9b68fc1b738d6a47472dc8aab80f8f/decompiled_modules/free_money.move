module 0xce2964cc96ac79e50d0fd18e61b6d4886e9b68fc1b738d6a47472dc8aab80f8f::free_money {
    struct FreeMoney has copy, drop, store {
        dummy_field: bool,
    }

    public fun win_money<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, FreeMoney>>();
        0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, FreeMoney>>(&mut v0, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::bet_result<T0, FreeMoney>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg2), 0, 0x1::option::none<u64>(), 0x2::coin::value<T0>(&arg1), 0, 0));
        let v1 = FreeMoney{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, FreeMoney>(arg0, v1, arg1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, FreeMoney>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::none<0x1::string::String>(), v0);
    }

    // decompiled from Move bytecode v6
}

