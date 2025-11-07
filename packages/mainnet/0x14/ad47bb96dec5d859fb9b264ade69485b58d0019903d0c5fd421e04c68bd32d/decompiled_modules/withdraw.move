module 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::withdraw {
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

    public fun withdraw<T0, T1>(arg0: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::ObligationOwnerCap, arg2: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_as_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun withdraw_as_coin<T0, T1>(arg0: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::ObligationOwnerCap, arg2: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::ensure_version_matches<T0>(arg0);
        assert!(!0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::has_circuit_break_triggered<T0>(arg0), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2) = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::handle_withdraw<T0, T1>(arg0, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::id(arg1), arg3, arg2, arg4, arg5, v0, arg6);
        let v3 = v1;
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::liquidity_miner::update_obligation_reward_manager<T0, T1>(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::borrow_liquidity_mining_mut<T0>(arg0), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::liquidity_miner::get_deposit_reward_type(), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::id(arg1), v2, arg5);
        let v4 = WithdrawEvent{
            redeemer          : 0x2::tx_context::sender(arg6),
            market            : 0x1::type_name::get<T0>(),
            obligation        : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::id(arg1),
            withdraw_asset    : 0x1::type_name::get<T1>(),
            withdraw_amount   : 0x2::coin::value<T1>(&v3),
            ctokens_remaining : v2,
            burn_asset        : 0x1::type_name::get<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::ctoken::CToken<T0, T1>>(),
            burn_amount       : arg3,
            time              : v0,
        };
        0x2::event::emit<WithdrawEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

