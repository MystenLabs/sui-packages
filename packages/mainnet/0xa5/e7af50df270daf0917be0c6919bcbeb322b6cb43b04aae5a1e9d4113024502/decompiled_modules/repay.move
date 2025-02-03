module 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public entry fun repay<T0>(arg0: &0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::version::Version, arg1: &mut 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::obligation::Obligation, arg2: &mut 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::version::assert_current_version(arg0);
        assert!(0x3149de4d4ded1b76032449d6188219e284ac2d1c6656b02e549f36ae79dfa6f6::whitelist::is_address_allowed(0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::market::uid(arg2), 0x2::tx_context::sender(arg5)), 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::error::whitelist_error());
        assert!(0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::obligation::repay_locked(arg1) == false, 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::error::obligation_locked());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::get<T0>();
        0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::market::accrue_all_interests(arg2, v0);
        0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, _) = 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::obligation::debt(arg1, v1);
        let v4 = 0x2::math::min(v2, 0x2::coin::value<T0>(&arg3));
        0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::market::handle_repay<T0>(arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v4, arg5)));
        0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::market::handle_inflow<T0>(arg2, v4, v0);
        0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::obligation::decrease_debt(arg1, v1, v4);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v5 = RepayEvent{
            repayer    : 0x2::tx_context::sender(arg5),
            obligation : 0x2::object::id<0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::obligation::Obligation>(arg1),
            asset      : v1,
            amount     : v4,
            time       : v0,
        };
        0x2::event::emit<RepayEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

