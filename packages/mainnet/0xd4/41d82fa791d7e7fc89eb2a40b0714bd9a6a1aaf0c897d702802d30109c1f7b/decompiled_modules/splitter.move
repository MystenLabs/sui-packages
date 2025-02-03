module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::splitter {
    public fun split_the_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (arg1) {
            (0x2::coin::split<T0>(&mut arg0, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v0, 40, 100), arg2), 0x2::coin::split<T0>(&mut arg0, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v0, 30, 100), arg2), arg0, 0x2::coin::split<T0>(&mut arg0, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v0, 20, 100), arg2))
        } else {
            (0x2::coin::split<T0>(&mut arg0, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v0, 50, 100), arg2), 0x2::coin::split<T0>(&mut arg0, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v0, 40, 100), arg2), arg0, 0x2::coin::zero<T0>(arg2))
        }
    }

    // decompiled from Move bytecode v6
}

