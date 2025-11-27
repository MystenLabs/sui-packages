module 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::Version, arg1: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg2: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg3: 0x2::coin::Coin<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::is_paused(arg2), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::market_paused_error());
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::zero_amount_error());
        assert!(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::repay_locked(arg1) == false, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>();
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::accrue_all_interests(arg2, v0);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _, v4) = 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::no_debt_error());
        let v5 = 0x2::math::min(v2, 0x2::coin::value<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(&arg3));
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::handle_repay<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(&mut arg3, v5, arg5), v4, arg5);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::handle_inflow<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(arg2, v5, v0);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::decrease_debt(arg1, v1, v5);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::decrease_debt_interest(arg1, v1, 0x2::math::min(v4, v5));
        if (0x2::coin::value<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v6 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v5,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

