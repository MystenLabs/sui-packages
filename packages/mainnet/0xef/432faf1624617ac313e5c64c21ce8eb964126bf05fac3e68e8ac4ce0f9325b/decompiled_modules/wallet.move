module 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::wallet {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::asserts::must_is_admin(0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::get_sender(arg0));
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::zero_balance<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit_or_destroy<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::destroy_zero<T0>(arg1);
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::coin_to_balance<T0>(arg1));
        };
    }

    public fun withdraw_to_admin<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::asserts::must_is_admin(0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::get_sender(arg2));
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::asserts::must_payout_amount<T0>(&arg0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::coin_from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::admin::get_address());
    }

    // decompiled from Move bytecode v6
}

