module 0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::settle {
    struct Paid has copy, drop {
        coin: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun checked_return<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 1);
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 2);
        arg0
    }

    public fun pay_to_recipient<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        let v1 = Paid{
            coin      : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
            recipient : arg1,
        };
        0x2::event::emit<Paid>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun settle_to_recipient<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::guard::require_min_profit<T0>(&arg0, arg2);
        pay_to_recipient<T0>(arg0, arg1, arg3);
    }

    public fun settle_with_config<T0>(arg0: &0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::config::assert_active(arg0);
        settle_to_recipient<T0>(arg1, 0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::config::recipient(arg0), arg2, arg3);
    }

    public fun sweep_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        pay_to_recipient<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

