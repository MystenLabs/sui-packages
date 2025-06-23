module 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::flow_x_clmm_protocol {
    public(friend) fun swap<T0, T1>(arg0: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::dex_utils::check_amounts<T0, T1>(&arg1, &arg2);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::balance::join<T1>(&mut v1, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::swap_router::swap_exact_x_to_y<T0, T1>(arg0, arg1, 4295048016, arg3, arg4, arg5));
            0x2::coin::destroy_zero<T1>(arg2);
        } else {
            0x2::balance::join<T0>(&mut v0, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::swap_router::swap_exact_y_to_x<T0, T1>(arg0, arg2, 79226673515401279992447579055, arg3, arg4, arg5));
            0x2::coin::destroy_zero<T0>(arg1);
        };
        (0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::from_balance<T1>(v1, arg5))
    }

    public(friend) fun get_required_coin_amount<T0>(arg0: &0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64) : u64 {
        let (_, v1, _, _) = 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::swap_math::compute_swap_step(0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::pool::sqrt_price_current<T0, 0x2::sui::SUI>(arg0), 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::pool::sqrt_price_current<T0, 0x2::sui::SUI>(arg0), 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::pool::liquidity<T0, 0x2::sui::SUI>(arg0), arg1, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::pool::swap_fee_rate<T0, 0x2::sui::SUI>(arg0), false);
        v1
    }

    // decompiled from Move bytecode v6
}

