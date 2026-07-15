module 0x926a68c5fd70fb4a0bbd0253d0b35b25b7bb24965b78f2a717b69fbadff4c978::bridge {
    struct BridgeAuth has drop {
        dummy_field: bool,
    }

    struct BridgeInitiated has copy, drop {
        sender: address,
        amount: u64,
        destination_domain: u32,
        mint_recipient: address,
        coin_type: 0x1::ascii::String,
    }

    public fun prepare_deposit_for_burn<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: &0x2::tx_context::TxContext) : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::DepositForBurnTicket<T0, BridgeAuth> {
        let v0 = BridgeInitiated{
            sender             : 0x2::tx_context::sender(arg3),
            amount             : 0x2::coin::value<T0>(&arg0),
            destination_domain : arg1,
            mint_recipient     : arg2,
            coin_type          : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<BridgeInitiated>(v0);
        let v1 = BridgeAuth{dummy_field: false};
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_ticket<T0, BridgeAuth>(v1, arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

