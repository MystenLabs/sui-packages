module 0x77eaf5068b6b075d0595f8a6e2e1cd6947810832202c82e2b2aa061466f590b2::m53059350fa083f7fd05825e8 {
    public fun f120ecfd14f565ebf00ad2c77<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public fun f165ae6c3323473b0d1ce65f2<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun f2b9177787548ec71905b5896<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::coin::send_funds<T0>(arg0, arg1);
    }

    public fun f3165cbe8465e7e4099063ce0<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun f3893715f1e039c797b78b444<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::redeem_funds<T0>(arg0, arg1)
    }

    public fun f402f4dc7deffbed5da132f7a(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun f56f4d6c72dc520c5a8860155<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun f5f07d596bc4c83ce54a82d90<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun f69ebe4903a51935d9795ff0a<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun f7de43cd591faaefddcf71dcb<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public fun fae857fdca8c235bd3e3830c8<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun fca5be6785a051cef1e453ade<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    public fun fccfe2ff7a5b6152f6b613e09<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun fce1cd141a538b59de3c0f464(arg0: &0x2::tx_context::TxContext) : address {
        0x2::tx_context::sender(arg0)
    }

    public fun fddc68f031605ff06e76f760b<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    public fun ff5b3bb5a5b0042842ae5dba1<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

