module 0xb48b47b9b6a4aad5a83aacf4fc402914ab502762f9c51fd5b09bf0d0bba9d426::m9f50045e26fc81a849635af8 {
    public fun f01750904d4f9ec48530dd1e8<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun f223a10b460b59a96a9d202e3(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun f26a2a79c999c3fc33851f59e<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun f27edd7fcd621b751505f3d69<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public fun f2b35a90991c53f112386ebc4<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun f32436439f1fc0062b6fdb985<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun f56200fbdaf3753812e1173d3<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun f576a16a2b529dcb8da3d8a9d<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::redeem_funds<T0>(arg0, arg1)
    }

    public fun f687d376a28575dd49de475bf<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    public fun f701fc46528d54cb2de5b1ba7<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    public fun f79d8554d11bc54c5595b84a5<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public fun f8c0a53c665c74a1d6a4bacfb<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun f8e6d8df554395bd80019a1e6<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun fc04006a6cf9137937a4bffa5<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::coin::send_funds<T0>(arg0, arg1);
    }

    public fun fed7c6c1e896e9238f805a57c(arg0: &0x2::tx_context::TxContext) : address {
        0x2::tx_context::sender(arg0)
    }

    public fun ff9099f58bf7420be1d7e5236<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    // decompiled from Move bytecode v7
}

