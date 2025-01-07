module 0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::commission {
    struct Commission has drop {
        partner: address,
        commission_bps: u64,
    }

    public fun commission_bps(arg0: &Commission) : u64 {
        arg0.commission_bps
    }

    public fun new(arg0: address, arg1: u64) : Commission {
        Commission{
            partner        : arg0,
            commission_bps : arg1,
        }
    }

    public fun partner(arg0: &Commission) : address {
        arg0.partner
    }

    public fun take_commision<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::config::Config, arg2: &Commission, arg3: &mut 0x2::tx_context::TxContext) : (address, u64, u64) {
        assert!(arg2.commission_bps <= 0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::config::max_commission_bps(arg1), 0);
        let v0 = 0x2::coin::value<T0>(arg0) * arg2.commission_bps / 10000;
        let v1 = v0 * 0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::config::protocol_fee_bps(arg1) / 10000;
        let v2 = v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v1, arg3), 0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::config::protocol_fee_account(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v2, arg3), arg2.partner);
        (arg2.partner, v1, v2)
    }

    // decompiled from Move bytecode v6
}

