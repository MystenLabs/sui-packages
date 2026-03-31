module 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::version::Version, arg1: &mut 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation, arg2: &mut 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::Market, arg3: 0x2::coin::Coin<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::is_paused(arg2), 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::error::market_paused_error());
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::error::zero_amount_error());
        assert!(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::repay_locked(arg1) == false, 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>();
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::accrue_all_interests(arg2, v0);
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _, v4) = 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::error::no_debt_error());
        let v5 = 0x2::math::min(v2, 0x2::coin::value<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(&arg3));
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::handle_repay<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(&mut arg3, v5, arg5), v4, arg5);
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::handle_inflow<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(arg2, v5, v0);
        if (v4 > 0) {
            0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::decrease_debt_interest(arg1, v1, 0x2::math::min(v4, v5));
        };
        0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::decrease_debt(arg1, v1, v5);
        if (0x2::coin::value<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v6 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v5,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

