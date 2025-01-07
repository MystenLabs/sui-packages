module 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::range {
    public entry fun play<T0, T1>(arg0: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::Vault<T0, T1>, arg1: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::game_controller::Controller, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= 5 && arg4 <= 95, 1);
        let v0 = 0x2::coin::zero<T0>(arg6);
        0x2::pay::join_vec<T0>(&mut v0, arg2);
        let v1 = arg3 * 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::get_player_fee<T0, T1>(arg0) / 10000;
        assert!(0x2::coin::value<T0>(&v0) >= arg3 + v1, 1);
        assert!(0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::check_pool_amount<T0, T1>(arg0, 0x2::math::divide_and_round_up(arg3 * 0x2::math::divide_and_round_up(1000000, arg4), 10000) - arg3), 1001);
        0x967b27a9015514855cbc4da46657a93b029bbed373fb45d9c214863e4efc6b17::utils::destroy_zero_or_transfer<T0>(v0, arg6);
        0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::take_bet<T0, T1>(arg0, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::collect_player_fee<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v0, arg3 + v1, arg6), arg3, arg6));
        0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::game_controller::new_game(arg1, arg5, 0x2::tx_context::sender(arg6), arg3, arg4, 3, arg6);
    }

    // decompiled from Move bytecode v6
}

