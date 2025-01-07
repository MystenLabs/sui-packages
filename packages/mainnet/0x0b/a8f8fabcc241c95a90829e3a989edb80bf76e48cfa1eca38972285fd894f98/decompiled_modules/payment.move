module 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment {
    public fun merge_and_split(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) > arg1, 0);
        (0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg2), v0)
    }

    public fun take_from<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut v0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

