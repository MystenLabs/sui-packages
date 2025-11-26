module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
        collateral_price: 0x1::fixed_point32::FixedPoint32,
        debt_price: 0x1::fixed_point32::FixedPoint32,
        timestamp: u64,
    }

    public fun liquidate<T0>(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::Version, arg1: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg2: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg3: 0x2::coin::Coin<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>, arg4: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::assert_current_version(arg0);
        assert!(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::liquidate_locked(arg1) == false, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::obligation_locked());
        assert!(0x2::coin::value<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::accrue_all_interests(arg2, v1);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::liquidation_evaluator::liquidation_amounts<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::unable_to_liquidate_error());
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::decrease_debt(arg1, 0x1::type_name::get<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(), v2);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, arg7);
        let v5 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::price::get_price(arg5, 0x1::type_name::get<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v5);
        (0x2::coin::from_balance<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::Version, arg1: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg2: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg3: 0x2::coin::Coin<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>, arg4: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

