module 0x807dd1660c8c04f6f06b1c4f9abc045f3bfd2d1a46f6092c5e78149e751e2fb3::m82270c25c5be0e8fa466a123 {
    public fun f161c093cd557b9cfd0715a23<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun f2b623714907dec05c9de396b<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public fun f3cb837896809912bb30db068<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public fun f45d3ccf85a4a54548462f1f5<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    public fun f500b2eea8c702d9d94cf0c20(arg0: &0x2::tx_context::TxContext) : address {
        0x2::tx_context::sender(arg0)
    }

    public fun f5418e182540bd6afcd832f4f<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun f5b3482b7af8c42c880105aa8<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun f72f7d88b4ff199ccc2bd2b51<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun f86ce0029f87fa1b9db968052<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun f93e8d0a12f80a0ec240bb3b8<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun fabc3c11eaee7a56534cf6468(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun fdf45822cd73893c3036a50ea<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun fe54e6322b5f57769b9e5b4cc<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::redeem_funds<T0>(arg0, arg1)
    }

    public fun fecf4356232adb56241ca1b10<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun ffd23d0480fb59338c6f6753b<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    public fun ffd88652e043be5d896f2a708<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::coin::send_funds<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

