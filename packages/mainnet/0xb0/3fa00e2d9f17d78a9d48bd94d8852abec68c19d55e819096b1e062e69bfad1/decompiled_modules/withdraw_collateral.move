module 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::version::Version, arg1: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg2: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::ObligationKey, arg3: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::version::assert_current_version(arg0);
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::uid(arg3), 0x2::tx_context::sender(arg8)), 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::error::whitelist_error());
        assert!(0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::withdraw_collateral_locked(arg1) == false, 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::error::obligation_locked());
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::assert_key_match(arg1, arg2);
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::handle_withdraw_collateral<T0>(arg3, arg5, 0x2::clock::timestamp_ms(arg7) / 1000);
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::error::withdraw_collateral_too_much_error());
        let v0 = 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::withdraw_collateral<T0>(arg1, arg5);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg8),
            obligation      : 0x2::object::id<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg1),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public entry fun withdraw_collateral_entry<T0>(arg0: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::version::Version, arg1: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg2: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::ObligationKey, arg3: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

