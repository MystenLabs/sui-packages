module 0x2f0e1913cccc839f8abecfb3ad34790aaa722a36afa652a4a286542eab572a0::converter {
    struct Details has key {
        id: 0x2::object::UID,
        lower_sqrt_price: u256,
        upper_sqrt_price: u256,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Details{
            id               : 0x2::object::new(arg0),
            lower_sqrt_price : 18446744073709551616,
            upper_sqrt_price : 18454123878217468680,
        };
        0x2::transfer::share_object<Details>(v0);
    }

    public fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T1>(arg6);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, arg3, arg4, 4295048016, arg5);
        let v4 = v3;
        0x2::coin::join<T1>(&mut v0, 0x2::coin::from_balance<T1>(v2, arg6));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v1, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg6)), 0x2::balance::zero<T1>(), v4);
        (arg2, v0)
    }

    public fun test_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun update_details(arg0: &mut Details, arg1: u256, arg2: u256) {
        arg0.lower_sqrt_price = arg1;
        arg0.upper_sqrt_price = arg2;
    }

    // decompiled from Move bytecode v6
}

