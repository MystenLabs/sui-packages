module 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::withdraw {
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

    public fun withdraw<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg2: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::ObligationOwnerCap, arg3: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xb2122b399c78f3f0f9874bdd34fbdda90d3867ebf8972bda97f85218bf0de67::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_as_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun withdraw_as_coin<T0, T1>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg2: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::ObligationOwnerCap, arg3: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xb2122b399c78f3f0f9874bdd34fbdda90d3867ebf8972bda97f85218bf0de67::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::validate_market<T0>(arg0, arg1);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ensure_version_matches(arg0);
        assert!(!0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::has_circuit_break_triggered<T0>(arg1), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let (v1, v2) = 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::handle_withdraw<T0, T1>(arg1, 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::id(arg2), arg4, arg3, arg5, arg6, v0, arg7);
        let v3 = v1;
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::borrow_liquidity_mining_mut<T0>(arg1), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::liquidity_miner::get_deposit_reward_type(), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::id(arg2), v2, arg6);
        let v4 = WithdrawEvent{
            redeemer          : 0x2::tx_context::sender(arg7),
            market            : 0x1::type_name::with_defining_ids<T0>(),
            obligation        : 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::obligation::id(arg2),
            withdraw_asset    : 0x1::type_name::with_defining_ids<T1>(),
            withdraw_amount   : 0x2::coin::value<T1>(&v3),
            ctokens_remaining : v2,
            burn_asset        : 0x1::type_name::with_defining_ids<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::ctoken::CToken<T0, T1>>(),
            burn_amount       : arg4,
            time              : v0,
        };
        0x2::event::emit<WithdrawEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

