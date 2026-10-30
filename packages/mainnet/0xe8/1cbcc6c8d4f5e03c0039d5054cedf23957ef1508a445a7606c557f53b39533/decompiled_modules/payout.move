module 0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::payout {
    struct Profit has copy, drop {
        coin: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun pay<T0>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v1 = 0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::recipient(arg0);
        let v2 = Profit{
            coin      : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
            recipient : v1,
        };
        0x2::event::emit<Profit>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), v1);
    }

    public fun settle<T0>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_min_profit<T0>(&arg1, arg2);
        pay<T0>(arg0, arg1, arg3);
    }

    public fun sweep<T0>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        pay<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

