module 0x6b5f5c2b020cfe94c925813ff3467bbf3a8d46d8b7776decc266198a93e0b89f::u {
    public fun a3k<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : bool {
        0x2::balance::value<T0>(arg0) >= arg1
    }

    public fun b7m(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun c6s<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(arg0) > 1) {
            0x2::coin::join<T0>(arg0, 0x2::coin::split<T0>(arg0, 1, arg1));
        };
    }

    public fun c8j<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::destroy_zero<T0>(arg0);
        0x2::coin::join<T1>(arg2, 0x2::coin::from_balance<T1>(arg1, arg3));
    }

    public fun d7e<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun e8m(arg0: &0x2::object::UID) : address {
        0x2::object::uid_to_address(arg0)
    }

    public fun f3w(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg3), 0x2::coin::split<0x2::sui::SUI>(arg0, arg2, arg3))
    }

    public fun f5j<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun g8k<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public fun h7x<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun j6t<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun j9b<T0>() {
        0x2::balance::destroy_zero<T0>(0x2::balance::zero<T0>());
    }

    public fun k3m<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public fun l0v(arg0: address) : address {
        let v0 = 0x2::object::id_from_address(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun m4n<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun n2p<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::balance::destroy_zero<T0>(arg0);
        0x2::coin::from_balance<T1>(arg1, arg2)
    }

    public fun p8f<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    public fun q2w<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun r1e<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun s2f<T0, T1>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>())
    }

    public fun t4k<T0>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        (v0, 0x2::balance::value<T0>(&v0))
    }

    public fun v3d<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::join<T0>(arg0, arg1);
        0x2::coin::join<T0>(arg0, arg2);
        0x2::coin::split<T0>(arg0, arg3, arg4)
    }

    public fun w1q<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(arg0) > 2) {
            0x2::coin::join<T0>(arg0, 0x2::coin::split<T0>(arg0, 1, arg1));
            0x2::coin::join<T0>(arg0, 0x2::coin::split<T0>(arg0, 1, arg1));
        };
    }

    public fun w8s<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun x9a<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg2));
        (v0, 0x2::balance::value<T0>(&v0))
    }

    // decompiled from Move bytecode v6
}

