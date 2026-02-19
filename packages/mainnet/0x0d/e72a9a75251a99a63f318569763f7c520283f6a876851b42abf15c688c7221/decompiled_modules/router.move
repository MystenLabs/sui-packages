module 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::router {
    public fun swap_buy<T0, T1>(arg0: &mut 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::pool::LiquidityPool<T0>, arg1: &0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let (v1, v2) = 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::pool::swap_buy<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut v0, arg4), arg5, arg7);
        let v3 = v2;
        0x2::balance::join<T1>(&mut v3, v0);
        let v4 = 0x2::tx_context::sender(arg7);
        if (0x1::option::is_some<address>(&arg6)) {
            v4 = *0x1::option::borrow<address>(&arg6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg7), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg7), v4);
    }

    public fun swap_sell<T0, T1>(arg0: &mut 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::pool::LiquidityPool<T0>, arg1: &0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let (v1, v2) = 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::pool::swap_sell<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), arg5, arg7);
        let v3 = v1;
        0x2::balance::join<T0>(&mut v3, v0);
        let v4 = 0x2::tx_context::sender(arg7);
        if (0x1::option::is_some<address>(&arg6)) {
            v4 = *0x1::option::borrow<address>(&arg6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg7), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg7), v4);
    }

    // decompiled from Move bytecode v6
}

