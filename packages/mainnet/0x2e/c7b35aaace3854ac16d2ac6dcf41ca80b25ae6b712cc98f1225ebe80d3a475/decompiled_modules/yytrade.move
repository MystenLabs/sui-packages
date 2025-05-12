module 0x2ec7b35aaace3854ac16d2ac6dcf41ca80b25ae6b712cc98f1225ebe80d3a475::yytrade {
    struct CoinTyps has store, key {
        id: 0x2::object::UID,
        coinType: address,
    }

    public entry fun increment<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinTyps{
            id       : 0x2::object::new(arg0),
            coinType : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<CoinTyps>(v0);
    }

    // decompiled from Move bytecode v6
}

