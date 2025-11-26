module 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun repay(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::Version, arg1: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg2: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg3: 0x2::coin::Coin<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::is_paused(arg2), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::market_paused_error());
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(&arg3) > 0, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::zero_amount_error());
        assert!(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::repay_locked(arg1) == false, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>();
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::accrue_all_interests(arg2, v0);
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _) = 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::debt(arg1, v1);
        assert!(v2 > 0, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::no_debt_error());
        let v4 = 0x2::math::min(v2, 0x2::coin::value<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(&arg3));
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::handle_repay<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::split<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(&mut arg3, v4, arg5), arg5);
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::handle_inflow<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(arg2, v4, v0);
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

