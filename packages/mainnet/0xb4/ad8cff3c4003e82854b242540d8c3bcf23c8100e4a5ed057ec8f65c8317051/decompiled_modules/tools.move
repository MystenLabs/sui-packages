module 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools {
    public(friend) fun destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
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

