module 0xd9a3724374cdd71288ae3ebe46c144f08bee39804637fdf04ac84422721df24b::tb {
    public fun a<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg2);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v0, 0x2::coin::value<T0>(&arg2), 0, 4295048017, true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg3, arg0, arg4);
        0xe7e491e54c1227d5106eef4fa97c6f5697005db4517bca88abcc580963cbaed2::vv::tdc<T0>(v2, arg4);
        v1
    }

    public fun b<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg2);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v0, 0x2::coin::value<T1>(&arg2), 0, 79226673515401279992447579054, true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg3, arg0, arg4);
        0xe7e491e54c1227d5106eef4fa97c6f5697005db4517bca88abcc580963cbaed2::vv::tdc<T1>(v2, arg4);
        v1
    }

    // decompiled from Move bytecode v6
}

