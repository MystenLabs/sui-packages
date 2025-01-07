module 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::periphery {
    public fun buy_to<T0>(arg0: &0x2::clock::Clock, arg1: &0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::listing::CoinTypeWhitelist, arg2: &0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::oracle::Oracle, arg3: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::game_status::GameStatus, arg4: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::profile_manager::ProfileManager, arg5: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::trove_manager::TroveManager, arg6: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::final::FinalPool, arg7: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::lootbox::LootboxPool, arg8: &mut 0x2::coin::Coin<T0>, arg9: u64, arg10: 0x1::option::Option<address>, arg11: address, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13);
        while (!0x1::vector::is_empty<0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::Ticket<T0>>(&v0)) {
            0x2::transfer::public_transfer<0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::Ticket<T0>>(0x1::vector::pop_back<0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::Ticket<T0>>(&mut v0), arg12);
        };
        0x1::vector::destroy_empty<0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::Ticket<T0>>(v0);
    }

    public fun claim_all_and_buy_to<T0>(arg0: &0x2::clock::Clock, arg1: &0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::listing::CoinTypeWhitelist, arg2: &0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::oracle::Oracle, arg3: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::game_status::GameStatus, arg4: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::profile_manager::ProfileManager, arg5: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::trove_manager::TroveManager, arg6: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::final::FinalPool, arg7: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::lootbox::LootboxPool, arg8: 0x1::option::Option<address>, arg9: address, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::trove_manager::get_trove_value<T0>(arg5, 0x2::tx_context::sender(arg11)) / 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::math::mul_and_div(0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::oracle::ticket_price<T0>(arg2, arg0, 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::game_status::start_time(arg3)), 7, 10);
        if (v0 > 0) {
            let v1 = 0x2::coin::zero<T0>(arg11);
            let v2 = 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &mut v1, v0, arg8, arg9, arg11);
            0x2::coin::destroy_zero<T0>(v1);
            while (!0x1::vector::is_empty<0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::Ticket<T0>>(&v2)) {
                0x2::transfer::public_transfer<0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::Ticket<T0>>(0x1::vector::pop_back<0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::Ticket<T0>>(&mut v2), arg10);
            };
            0x1::vector::destroy_empty<0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::ticket::Ticket<T0>>(v2);
        };
    }

    public fun claim_all_to<T0>(arg0: &mut 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::trove_manager::TroveManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::trove_manager::take_all_from_trove<T0>(arg0, arg2);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

