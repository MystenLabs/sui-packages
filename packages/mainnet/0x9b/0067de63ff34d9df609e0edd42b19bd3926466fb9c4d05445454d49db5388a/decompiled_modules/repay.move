module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::Version, arg1: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg2: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg3: 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::is_paused(arg2), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::market_paused_error());
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::zero_amount_error());
        assert!(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::repay_locked(arg1) == false, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>();
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::accrue_all_interests(arg2, v0);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _) = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::no_debt_error());
        let v4 = 0x2::math::min(v2, 0x2::coin::value<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&arg3));
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::handle_repay<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&mut arg3, v4, arg5), arg5);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::handle_inflow<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(arg2, v4, v0);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

