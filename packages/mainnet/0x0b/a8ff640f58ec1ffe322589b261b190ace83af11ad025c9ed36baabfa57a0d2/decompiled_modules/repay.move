module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        refund: u64,
        time: u64,
    }

    public fun repay<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ObligationOwnerCap, arg1: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = repay_coin_refund<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
        };
    }

    public fun repay_coin_refund<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ObligationOwnerCap, arg1: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::handle_repay<T0, T1>(arg1, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::id(arg0), arg2, v0, arg4);
        let v2 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg4),
            market     : 0x1::type_name::get<T0>(),
            obligation : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::id(arg0),
            asset      : 0x1::type_name::get<T1>(),
            amount     : 0x2::coin::value<T1>(&arg2),
            refund     : 0x2::coin::value<T1>(&v1),
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

