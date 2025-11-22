module 0xf9ec0fa8f3588fb5212d3981fce1b0e2c79549bff5503a2eb1e7d59e51f2946b::tipping {
    struct TipEvent has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        fee_amount: u64,
        net_amount: u64,
        coin_type: 0x1::string::String,
        timestamp: u64,
    }

    public fun tip<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = v0 * 150 / 10000;
        assert!(v0 > v1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v1, arg2), @0x488109f7eca123dd3ae34e1127b2bbe0080cddaa9ecac52c1159f50a7e9cc5d3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        let v2 = TipEvent{
            sender     : 0x2::tx_context::sender(arg2),
            recipient  : arg1,
            amount     : v0,
            fee_amount : v1,
            net_amount : v0 - v1,
            coin_type  : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())),
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TipEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

