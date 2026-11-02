module 0x415cce7a682baee1e5c4ab0fe8f8a42f0fca5b38612b431ba2ad415dafe85e5e::merkl_deposit {
    struct DepositEvent has copy, drop {
        ref: vector<u8>,
        amount: u64,
        from: address,
    }

    struct CoinDepositEvent has copy, drop {
        ref: vector<u8>,
        amount: u64,
        from: address,
        coin_type: 0x1::ascii::String,
    }

    public entry fun deposit(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositEvent{
            ref    : arg2,
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            from   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DepositEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0);
    }

    public entry fun deposit_coin<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinDepositEvent{
            ref       : arg2,
            amount    : 0x2::coin::value<T0>(&arg1),
            from      : 0x2::tx_context::sender(arg3),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<CoinDepositEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0);
    }

    // decompiled from Move bytecode v7
}

