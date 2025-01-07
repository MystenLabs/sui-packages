module 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::scallop {
    struct ScallopStakeProof<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun check_exist_stake_proof<T0, T1, T2>(arg0: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>) : bool {
        let v0 = ScallopStakeProof<T2>{dummy_field: false};
        0x2::bag::contains<ScallopStakeProof<T2>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets<T0, T1>(arg0), v0)
    }

    public fun close<T0, T1, T2>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_withdraw_time<T0, T1>(arg0, arg3);
        if (check_exist_stake_proof<T0, T1, T2>(arg0)) {
            let v0 = ScallopStakeProof<T2>{dummy_field: false};
            0x2::balance::join<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T2>(arg0)), 0x2::coin::into_balance<T2>(withdraw_<T2>(0x2::bag::remove<ScallopStakeProof<T2>, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v0), arg1, arg2, arg3, arg4)));
        };
    }

    public fun deposit<T0, T1, T2>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AdminCap<T1>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_locked_period<T0, T1>(arg0, arg5);
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, T2>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, T2>(arg0);
        };
        let v0 = 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T2>(arg0)), arg2), arg6);
        if (check_exist_stake_proof<T0, T1, T2>(arg0)) {
            let v1 = ScallopStakeProof<T2>{dummy_field: false};
            0x2::coin::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>(0x2::bag::borrow_mut<ScallopStakeProof<T2>, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v1), deposit_<T2>(v0, arg3, arg4, arg5, arg6));
        } else {
            let v2 = ScallopStakeProof<T2>{dummy_field: false};
            0x2::bag::add<ScallopStakeProof<T2>, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v2, deposit_<T2>(v0, arg3, arg4, arg5, arg6));
        };
    }

    fun deposit_<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, arg0, arg3, arg4)
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AdminCap<T1>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_locked_period<T0, T1>(arg0, arg5);
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, T2>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, T2>(arg0);
        };
        let v0 = ScallopStakeProof<T2>{dummy_field: false};
        let v1 = 0x2::coin::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>(0x2::bag::borrow_mut<ScallopStakeProof<T2>, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T2>>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v0), arg2, arg6);
        0x2::balance::join<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<T2>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, T2>(arg0)), 0x2::coin::into_balance<T2>(withdraw_<T2>(v1, arg3, arg4, arg5, arg6)));
    }

    fun withdraw_<T0>(arg0: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, arg0, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

