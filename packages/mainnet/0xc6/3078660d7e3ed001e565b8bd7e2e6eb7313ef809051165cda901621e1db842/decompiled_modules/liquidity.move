module 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::liquidity {
    public(friend) fun supply<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::holder<T0>(arg0);
        let (_, v2, _, _, _, _, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_supply_data<T0>(arg2, v0);
        let (v9, v10, v11, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user::operate<T0>(arg2, arg1, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::borrow_liquidity_cap<T0>(arg0), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::positive(0x2::balance::value<T0>(&arg3)), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::none(), arg3, @0x0, @0x0, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::skip(), arg4, arg5);
        0x2::balance::destroy_zero<T0>(v9);
        0x2::balance::destroy_zero<T0>(v10);
        let (_, v14, _, _, _, _, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_supply_data<T0>(arg2, v0);
        (0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs::to_assets(v14 - v2, v11, false), v11)
    }

    public(friend) fun withdraw<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user::operate<T0>(arg2, arg1, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::borrow_liquidity_cap<T0>(arg0), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::negative(arg3), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::none(), 0x2::balance::zero<T0>(), @0x0, @0x0, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::skip(), arg4, arg5);
        0x2::balance::destroy_zero<T0>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

