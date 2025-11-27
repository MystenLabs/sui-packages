module 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::Version, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation, arg2: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg3: 0x2::coin::Coin<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::is_paused(arg2), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::market_paused_error());
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::zero_amount_error());
        assert!(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::repay_locked(arg1) == false, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>();
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::accrue_all_interests(arg2, v0);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _, v4) = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::no_debt_error());
        let v5 = 0x2::math::min(v2, 0x2::coin::value<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(&arg3));
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::handle_repay<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(&mut arg3, v5, arg5), v4, arg5);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::handle_inflow<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(arg2, v5, v0);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::decrease_debt(arg1, v1, v5);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::decrease_debt_interest(arg1, v1, 0x2::math::min(v4, v5));
        if (0x2::coin::value<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v6 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v5,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

