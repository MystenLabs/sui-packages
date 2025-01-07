module 0x203d3735b1a3955ce7ced94660c8801f371ad75315989139a979017605a88b4::wsuia {
    struct WrappedCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun unwrap<T0>(arg0: &mut WrappedCoin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance), arg2), arg1);
    }

    public entry fun wrap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappedCoin<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(arg0));
        0x2::transfer::public_transfer<WrappedCoin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

