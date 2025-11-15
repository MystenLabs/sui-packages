module 0xf6732b63a5f76d5a8ea70bfc4aaf47be700168d8a62ec74be7b6ccaf77639bc4::tipping {
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
        let v1 = v0 * 150 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v1, arg2), @0x242524d0967f2a7b6d8302e64472bb14be1f2d6d5550451ae0e52c13ee7a9c52);
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

