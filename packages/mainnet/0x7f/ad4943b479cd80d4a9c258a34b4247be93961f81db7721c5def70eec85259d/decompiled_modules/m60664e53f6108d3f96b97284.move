module 0x7fad4943b479cd80d4a9c258a34b4247be93961f81db7721c5def70eec85259d::m60664e53f6108d3f96b97284 {
    public fun f051854399b709c873fc526e2<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::redeem_funds<T0>(arg0, arg1)
    }

    public fun f06848c06dfc8e477d31e31af(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun f09aacc5d22a27c46f1817d6f<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun f142446f555658cad39c29c72<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun f16e67f62b6df489fe419b12c(arg0: &0x2::tx_context::TxContext) : address {
        0x2::tx_context::sender(arg0)
    }

    public fun f1847831f1bbd625e96289576<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun f2244c6cfe60d4e9de06f1e9f<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public fun f6e4eb854d701b1608bd886ef<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun f71d0aab86b33b847bd46ede2<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun f7202fe873c8b745674619c94<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    public fun f86ad46b74becfd97ed31b611<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::coin::send_funds<T0>(arg0, arg1);
    }

    public fun f8a66f8a8691328d54fceaba4<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun fb7b987a9a4d3eec12bdae034<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun fd067791376f0d960c487c365<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    public fun fdd8f704665d4aad1479f363e<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun ff6c922a14ce57c23b64f3e3c<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

