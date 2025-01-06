module 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault_interface {
    struct ScallopVaultParams<phantom T0, phantom T1> {
        vault: 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::ScallopVault<T0, T1>,
        market: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market,
        scallop_version: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version,
        clock: 0x2::clock::Clock,
    }

    public fun total_assets<T0, T1>(arg0: &mut ScallopVaultParams<T0, T1>) : u64 {
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::total_assets<T0, T1>(&arg0.vault, &mut arg0.market, &arg0.scallop_version, &arg0.clock)
    }

    public fun admin_deposit<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::ScallopVault<T0, T1>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_reserve::VaultReserve<T0, T1>, arg5: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::session_flow::SessionFlow<T0, T1>, arg6: &0x2::clock::Clock, arg7: &0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::version::assert_current_version(arg7);
        deposit<T0, T1>(arg1, arg4, arg2, arg3, 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::session_flow::value<T0, T1>(arg5), arg6, arg8);
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_helpers::admin_deposit_session_helper<T0, T1>(arg5);
    }

    public fun admin_withdraw<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::ScallopVault<T0, T1>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_reserve::VaultReserve<T0, T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::version::Version, arg8: &mut 0x2::tx_context::TxContext) : 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::session_flow::SessionFlow<T0, T1> {
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::version::assert_current_version(arg7);
        withdraw<T0, T1>(arg1, arg4, arg2, arg3, arg5, arg6, arg8);
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_helpers::admin_withdrawal_session_helper<T0, T1>(arg5)
    }

    fun deposit<T0, T1>(arg0: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::ScallopVault<T0, T1>, arg1: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_reserve::VaultReserve<T0, T1>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::deposits_open<T0, T1>(arg0), 9223372419106865153);
        assert!(0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_reserve::value<T0, T1>(arg1) == arg4, 9223372423401963523);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg3, arg2, 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_reserve::withdraw<T0, T1>(arg1, arg6), arg5, arg6);
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::deposit_scoin<T0, T1>(arg0, v0);
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::events::scallop_deposit(0x2::object::id_address<0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::ScallopVault<T0, T1>>(arg0), arg4, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0));
    }

    public fun public_deposit<T0, T1>(arg0: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::ScallopVault<T0, T1>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_reserve::VaultReserve<T0, T1>, arg4: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::session_flow::SessionFlow<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::version::assert_current_version(arg6);
        deposit<T0, T1>(arg0, arg3, arg1, arg2, 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::session_flow::value<T0, T1>(arg4), arg5, arg7);
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_helpers::public_deposit_session_helper<T0, T1>(arg4);
    }

    public fun public_withdraw<T0, T1>(arg0: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::ScallopVault<T0, T1>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_reserve::VaultReserve<T0, T1>, arg4: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::session_flow::SessionFlow<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::version::assert_current_version(arg6);
        withdraw<T0, T1>(arg0, arg3, arg1, arg2, 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::session_flow::value<T0, T1>(arg4), arg5, arg7);
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_helpers::public_withdrawal_session_helper<T0, T1>(arg4);
    }

    fun withdraw<T0, T1>(arg0: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::ScallopVault<T0, T1>, arg1: &mut 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_reserve::VaultReserve<T0, T1>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::withdraw_scoin<T0, T1>(arg0, 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::convert_coin_to_scoin(arg3, arg2, 0x1::type_name::get<T0>(), arg5, arg4), arg6);
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::events::scallop_withdraw(0x2::object::id_address<0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::scallop_vault::ScallopVault<T0, T1>>(arg0), arg4, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0));
        0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::vault_reserve::deposit<T0, T1>(arg1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg2, v0, arg5, arg6));
    }

    // decompiled from Move bytecode v6
}

