module 0xb0df5f84e3496f3911359081ce23adced0b82395c9bf413589b3bb2d9eb0a3d9::tipping {
    struct TipEvent has copy, drop {
        sender: address,
        recipient: address,
        tip_amount: u64,
        fee_amount: u64,
        total_paid: u64,
        coin_type: 0x1::string::String,
        timestamp: u64,
    }

    public fun calculate_fee(arg0: u64) : (u64, u64) {
        let v0 = arg0 * 150 / 10000;
        (v0, arg0 + v0)
    }

    public fun tip<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 > 0, 2);
        let v1 = arg1 * 150 / 10000;
        let v2 = arg1 + v1;
        assert!(0x2::coin::value<T0>(&arg0) >= v2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v1, arg3), @0x488109f7eca123dd3ae34e1127b2bbe0080cddaa9ecac52c1159f50a7e9cc5d3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        let v3 = TipEvent{
            sender     : v0,
            recipient  : arg2,
            tip_amount : arg1,
            fee_amount : v1,
            total_paid : v2,
            coin_type  : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())),
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<TipEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

