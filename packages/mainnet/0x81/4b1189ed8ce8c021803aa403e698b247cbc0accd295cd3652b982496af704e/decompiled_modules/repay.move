module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::Version, arg1: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg2: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg3: 0x2::coin::Coin<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::is_paused(arg2), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::market_paused_error());
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::zero_amount_error());
        assert!(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::repay_locked(arg1) == false, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>();
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::accrue_all_interests(arg2, v0);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _) = 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::no_debt_error());
        let v4 = 0x2::math::min(v2, 0x2::coin::value<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(&arg3));
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::handle_repay<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(&mut arg3, v4, arg5), arg5);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::handle_inflow<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(arg2, v4, v0);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

