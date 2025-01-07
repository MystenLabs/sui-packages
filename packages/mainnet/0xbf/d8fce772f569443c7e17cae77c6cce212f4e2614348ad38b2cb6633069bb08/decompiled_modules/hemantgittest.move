module 0xbfd8fce772f569443c7e17cae77c6cce212f4e2614348ad38b2cb6633069bb08::hemantgittest {
    struct AccountData<phantom T0> has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<T0>,
    }

    public entry fun accept_payment<T0>(arg0: &mut AccountData<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : u64 {
        0x2::balance::join<T0>(&mut arg0.coin, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)))
    }

    public entry fun entry<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountData<T0>{
            id   : 0x2::object::new(arg0),
            coin : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::transfer<AccountData<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_account<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

