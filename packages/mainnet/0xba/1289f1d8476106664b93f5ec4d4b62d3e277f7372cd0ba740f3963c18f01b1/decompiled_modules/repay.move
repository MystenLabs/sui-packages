module 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::Version, arg1: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg2: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg3: 0x2::coin::Coin<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::is_paused(arg2), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::market_paused_error());
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::zero_amount_error());
        assert!(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::repay_locked(arg1) == false, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>();
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::accrue_all_interests(arg2, v0);
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _) = 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::error::no_debt_error());
        let v4 = 0x2::math::min(v2, 0x2::coin::value<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(&arg3));
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::handle_repay<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(&mut arg3, v4, arg5), arg5);
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::handle_inflow<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(arg2, v4, v0);
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf028af390aef73ad70f8bbbeb380321933a0c8a4fc8b405706d669862a762d88::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

