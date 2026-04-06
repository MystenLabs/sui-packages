module 0x4be8797d2d490eef017d9cb669272c058dd904e9d1691a4e50817a468e3acdc4::transfer_token {
    struct TokenTransferredEvent has copy, drop {
        sender: address,
        recipient: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        memo: 0x1::option::Option<vector<u8>>,
    }

    public fun transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::option::Option<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        let v0 = TokenTransferredEvent{
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg1,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg0),
            memo      : arg2,
        };
        0x2::event::emit<TokenTransferredEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

