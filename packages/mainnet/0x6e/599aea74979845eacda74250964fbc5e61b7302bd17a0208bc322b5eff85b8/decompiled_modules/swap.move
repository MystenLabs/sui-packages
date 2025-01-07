module 0x6e599aea74979845eacda74250964fbc5e61b7302bd17a0208bc322b5eff85b8::swap {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::coin::Coin<T0>,
        coin_b: 0x2::coin::Coin<T1>,
    }

    public fun create<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id     : 0x2::object::new(arg2),
            coin_a : arg0,
            coin_b : arg1,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun swap_a_for_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(&mut arg0.coin_a, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(0x2::coin::balance_mut<T1>(&mut arg0.coin_b), 0x2::coin::value<T0>(&arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun swap_b_for_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T1>(&mut arg0.coin_b, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(&mut arg0.coin_a), 0x2::coin::value<T1>(&arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

