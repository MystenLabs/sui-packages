module 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools {
    public(friend) fun destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public(friend) fun join<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) : 0x2::coin::Coin<T0> {
        0x2::coin::join<T0>(&mut arg0, arg1);
        arg0
    }

    public(friend) fun coin_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public(friend) fun coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public(friend) fun get_coin_vec<T0>(arg0: 0x2::coin::Coin<T0>) : vector<0x2::coin::Coin<T0>> {
        0x1::vector::singleton<0x2::coin::Coin<T0>>(arg0)
    }

    public(friend) fun get_deadline(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) + 10000
    }

    public(friend) fun get_sender(arg0: &0x2::tx_context::TxContext) : address {
        0x2::tx_context::sender(arg0)
    }

    public(friend) fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public(friend) fun zero_balance<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

