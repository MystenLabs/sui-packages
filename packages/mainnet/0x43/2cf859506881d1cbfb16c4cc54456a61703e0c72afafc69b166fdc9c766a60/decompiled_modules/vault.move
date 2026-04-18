module 0x432cf859506881d1cbfb16c4cc54456a61703e0c72afafc69b166fdc9c766a60::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun create_with_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::public_transfer<Vault>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun extract(arg0: Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let Vault {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg1), 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v7
}

