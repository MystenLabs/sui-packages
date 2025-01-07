module 0x2ec5e10ab58553ab0d04c5bb7936dff394e4905a3c590d689d1372ea8d49f145::assets {
    struct AccountData<phantom T0> has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<T0>,
    }

    struct TokenNameEvent has copy, drop {
        coin_type_myyyyyy: 0x1::type_name::TypeName,
        name: 0x1::ascii::String,
    }

    public entry fun empty<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountData<T0>{
            id   : 0x2::object::new(arg0),
            coin : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::transfer<AccountData<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun accept_payment<T0>(arg0: &mut AccountData<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : u64 {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        0x1::debug::print<0x2::coin::Coin<T0>>(&v0);
        let v1 = 0x2::coin::into_balance<T0>(v0);
        0x1::debug::print<0x2::balance::Balance<T0>>(&v1);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = TokenNameEvent{
            coin_type_myyyyyy : v2,
            name              : *0x1::type_name::borrow_string(&v2),
        };
        0x2::event::emit<TokenNameEvent>(v3);
        0x2::balance::join<T0>(&mut arg0.coin, v1)
    }

    public entry fun transfer_account<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = TokenNameEvent{
            coin_type_myyyyyy : v0,
            name              : *0x1::type_name::borrow_string(&v0),
        };
        0x2::event::emit<TokenNameEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

