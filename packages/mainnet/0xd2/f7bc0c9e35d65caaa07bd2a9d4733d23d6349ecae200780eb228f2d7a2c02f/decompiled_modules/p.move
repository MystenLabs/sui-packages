module 0xd2f7bc0c9e35d65caaa07bd2a9d4733d23d6349ecae200780eb228f2d7a2c02f::p {
    public fun ab<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(arg1, arg3));
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, v0, 0x2::balance::value<T0>(&arg1), arg2, arg3);
        settle<T0>(v1, arg3);
        0x2::coin::into_balance<T1>(v2)
    }

    public fun ba<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::from_balance<T1>(arg1, arg3));
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, v0, 0x2::balance::value<T1>(&arg1), arg2, arg3);
        settle<T1>(v1, arg3);
        0x2::coin::into_balance<T0>(v2)
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    fun settle<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(arg0), 0x2::tx_context::sender(arg1));
        };
    }

    public fun sx<T0>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, 0x2::sui::SUI>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, 0x2::coin::from_balance<0x2::sui::SUI>(arg1, arg3));
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, 0x2::sui::SUI>(arg0, v0, 0x2::balance::value<0x2::sui::SUI>(&arg1), arg2, arg3);
        settle<0x2::sui::SUI>(v1, arg3);
        0x2::coin::into_balance<T0>(v2)
    }

    public fun xs<T0>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, 0x2::sui::SUI>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(arg1, arg3));
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, 0x2::sui::SUI>(arg0, v0, 0x2::balance::value<T0>(&arg1), arg2, arg3);
        settle<T0>(v1, arg3);
        0x2::coin::into_balance<0x2::sui::SUI>(v2)
    }

    // decompiled from Move bytecode v7
}

