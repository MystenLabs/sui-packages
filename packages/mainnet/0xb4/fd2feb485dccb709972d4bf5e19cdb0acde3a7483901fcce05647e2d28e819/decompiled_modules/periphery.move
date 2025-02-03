module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::periphery {
    public fun buy_to<T0>(arg0: &0x2::clock::Clock, arg1: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::CoinTypeWhitelist, arg2: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::Oracle, arg3: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::GameStatus, arg4: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::referral_manager::ReferralManager, arg5: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::TroveManager, arg6: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::FinalPool, arg7: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::LootboxPool, arg8: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::leaderboard::Leaderboard, arg9: &mut 0x2::coin::Coin<T0>, arg10: u64, arg11: 0x1::option::Option<address>, arg12: address, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14);
        while (!0x1::vector::is_empty<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::RedEnvelope<T0>>(&v0)) {
            0x2::transfer::public_transfer<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::RedEnvelope<T0>>(0x1::vector::pop_back<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::RedEnvelope<T0>>(&mut v0), arg13);
        };
        0x1::vector::destroy_empty<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::RedEnvelope<T0>>(v0);
    }

    public fun claim_all_and_buy_to<T0>(arg0: &0x2::clock::Clock, arg1: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::CoinTypeWhitelist, arg2: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::Oracle, arg3: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::GameStatus, arg4: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::referral_manager::ReferralManager, arg5: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::TroveManager, arg6: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::FinalPool, arg7: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::LootboxPool, arg8: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::leaderboard::Leaderboard, arg9: 0x1::option::Option<address>, arg10: address, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::get_trove_value<T0>(arg5, 0x2::tx_context::sender(arg12)) / 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::red_envelop_price<T0>(arg2, arg0), 7, 10);
        if (v0 > 0) {
            let v1 = 0x2::coin::zero<T0>(arg12);
            let v2 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, &mut v1, v0, arg9, arg10, arg12);
            0x2::coin::destroy_zero<T0>(v1);
            while (!0x1::vector::is_empty<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::RedEnvelope<T0>>(&v2)) {
                0x2::transfer::public_transfer<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::RedEnvelope<T0>>(0x1::vector::pop_back<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::RedEnvelope<T0>>(&mut v2), arg11);
            };
            0x1::vector::destroy_empty<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope::RedEnvelope<T0>>(v2);
        };
    }

    public fun claim_all_to<T0>(arg0: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::TroveManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::take_all_from_trove<T0>(arg0, arg2);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

