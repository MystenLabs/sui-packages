module 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::liquidity {
    public(friend) fun supply<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::holder<T0>(arg0);
        let (_, v2, _, _, _, _, _, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_user_supply_data<T0>(arg2, v0);
        let (v9, v10, v11, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user::operate<T0>(arg2, arg1, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::borrow_liquidity_cap<T0>(arg0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::positive(0x2::balance::value<T0>(&arg3)), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::none(), arg3, @0x0, @0x0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::skip(), arg4, arg5);
        0x2::balance::destroy_zero<T0>(v9);
        0x2::balance::destroy_zero<T0>(v10);
        let (_, v14, _, _, _, _, _, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_user_supply_data<T0>(arg2, v0);
        (0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_calcs::to_assets(v14 - v2, v11, false), v11)
    }

    public(friend) fun withdraw<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, _, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user::operate<T0>(arg2, arg1, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::borrow_liquidity_cap<T0>(arg0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::negative(arg3), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::none(), 0x2::balance::zero<T0>(), @0x0, @0x0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::skip(), arg4, arg5);
        0x2::balance::destroy_zero<T0>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

