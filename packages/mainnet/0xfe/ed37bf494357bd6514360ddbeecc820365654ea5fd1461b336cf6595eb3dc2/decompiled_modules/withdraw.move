module 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::withdraw {
    struct WithdrawEvent has copy, drop {
        redeemer: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        ctokens_remaining: u64,
        burn_asset: 0x1::type_name::TypeName,
        burn_amount: u64,
        time: u64,
    }

    public fun withdraw<T0, T1>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::ObligationOwnerCap, arg3: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_as_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun withdraw_as_coin<T0, T1>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::ObligationOwnerCap, arg3: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::validate_market<T0>(arg0, arg1);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ensure_version_matches(arg0);
        assert!(!0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::has_circuit_break_triggered<T0>(arg1), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let (v1, v2) = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::handle_withdraw<T0, T1>(arg1, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::id(arg2), arg4, arg3, arg5, arg6, v0, arg7);
        let v3 = v1;
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::liquidity_miner::update_obligation_reward_manager<T0, T1>(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::borrow_liquidity_mining_mut<T0>(arg1), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::liquidity_miner::get_deposit_reward_type(), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::id(arg2), v2, arg6);
        let v4 = WithdrawEvent{
            redeemer          : 0x2::tx_context::sender(arg7),
            market            : 0x1::type_name::with_defining_ids<T0>(),
            obligation        : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::id(arg2),
            withdraw_asset    : 0x1::type_name::with_defining_ids<T1>(),
            withdraw_amount   : 0x2::coin::value<T1>(&v3),
            ctokens_remaining : v2,
            burn_asset        : 0x1::type_name::with_defining_ids<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::ctoken::CToken<T0, T1>>(),
            burn_amount       : arg4,
            time              : v0,
        };
        0x2::event::emit<WithdrawEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

