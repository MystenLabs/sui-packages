module 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::splitter {
    public fun divide_coin_to<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::divide_into_n<T0>(&mut arg0, 0x1::vector::length<address>(&arg1), arg2);
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v0), 0x1::vector::pop_back<address>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v0);
    }

    public fun split_final_pool<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::balance::value<T0>(arg0);
        (0x2::coin::take<T0>(arg0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::math::mul_and_div(v0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::winner_shares(), 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::final_total_shares()), arg1), 0x2::coin::take<T0>(arg0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::math::mul_and_div(v0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::dev_shares(), 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::final_total_shares()), arg1), 0x2::coin::take<T0>(arg0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::math::mul_and_div(v0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::crew_winner_shares(), 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::final_pool_shares()), arg1), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1))
    }

    public fun split_the_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        (0x2::coin::split<T0>(&mut arg0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::math::mul_and_div(v0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::final_pool_shares(), 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::ticket_total_shares()), arg1), 0x2::coin::split<T0>(&mut arg0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::math::mul_and_div(v0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::lootbox_pool_shares(), 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::ticket_total_shares()), arg1), 0x2::coin::split<T0>(&mut arg0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::math::mul_and_div(v0, 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::direct_senior_shares(), 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config::ticket_total_shares()), arg1), arg0)
    }

    // decompiled from Move bytecode v6
}

