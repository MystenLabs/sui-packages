module 0xc46b7e19ec139552b8aea6f9b13cf973abef77f55f432359d38a61870c26e9ca::m452aec9c03f25ef8e6fcba9c {
    public fun f0035ede755321445dc0360a4<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun f08a6c64b256ce40acc6d7ab2<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun f16c7f757bb1f05f3fd8fce4c<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::coin::send_funds<T0>(arg0, arg1);
    }

    public fun f181b0c4f204e33ae28eb7d12<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun f2e2fb3855a921eee54bd2938<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    public fun f390ad972d8321bda80ba8795(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun f439b808c8e4f076d9aab0a3b<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun f83953f6bdbfde67062b62d29(arg0: &0x2::tx_context::TxContext) : address {
        0x2::tx_context::sender(arg0)
    }

    public fun f8cc8b92db3fddba466551c98<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun f933af0ab2e270e1f1f72d580<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    public fun fa70f28141060ae3df8203b09<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun fab8103f6ec5d65890c46bc83<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public fun fc6e90c0ad6745854269202be<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public fun fcd271bb3b28fd96513ec1f6c<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun fcfc3305e29fdcc050dd05702<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::redeem_funds<T0>(arg0, arg1)
    }

    public fun feaacf6db8caecc806c512511<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

