module 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::operations {
    public fun begin_protected_shutdown<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) {
        assert_can_begin_protected_shutdown<T0, T1>(arg0, arg1);
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        begin_protected_shutdown_from_checkpoint<T0, T1>(arg0, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_checkpoint<T1>(&v0, arg2, arg3, arg4, arg5, arg6), 0x2::clock::timestamp_ms(arg7));
    }

    fun complete_mint<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::MintPlan<T0>, arg2: u64, arg3: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg4: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>> {
        let (v0, v1, v2, v3, v4) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::complete_mint<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state_mut<T0, T1>(arg0), arg1, arg3, arg5);
        let v5 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::mint_shares<T0, T1>(arg0, v0, arg6);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg4);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::minted<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), arg2, 0x2::coin::value<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>(&v5), v1, v2, v3, v4, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::maintenance_reserve<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0)), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::admin_cash_balance<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::total_share_supply<T0, T1>(arg0), arg4);
        v5
    }

    fun complete_profit_realization<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::ProfitRealizationPlan<T0>, arg2: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::CashLiquidity, arg3: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::CashLiquidity, arg4: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg5: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg6: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg7: u64) {
        let (v0, v1, v2, v3) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::complete_profit_realization<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), arg1, arg5, arg7);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::assert_realization_progress(&arg2, &arg3, &arg4, &arg6, v3);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg6);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::profit_realized<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), v0, v1, v2, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::shortfall(&arg2), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::shortfall(&arg3), arg4, arg6);
    }

    fun complete_rebalance<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::RebalancePlan<T0>, arg2: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint) {
        let (v0, v1, v2, v3, v4) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::complete_rebalance<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), arg1);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg2);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::rebalanced<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), v0, v1, v2, v3, v4, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::maintenance_reserve<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0)), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::admin_cash_balance<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::total_share_supply<T0, T1>(arg0), arg2);
    }

    fun complete_redemption<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T1>(&arg2) == arg3 + arg4, 21);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::retain_admin_cash<T0, T1>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, arg4, arg8)));
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg7);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::redeemed<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::burn_redeemed_shares<T0, T1>(arg0, arg1), arg3, arg5, arg4, arg6, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::maintenance_reserve<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0)), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::admin_cash_balance<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::total_share_supply<T0, T1>(arg0), arg7);
        arg2
    }

    public fun donate<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        let v0 = 0x2::coin::value<T1>(&arg7);
        assert!(v0 > 0, 19);
        synchronize_or_fail<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg8);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::deposit<T1>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0), arg2, arg3, arg7);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::allocate<T1>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0), arg2, arg4, v0);
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let (v2, v3) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_recovery_observation(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v1, arg2, arg3, arg4, arg5, arg6, arg8));
        complete_donation<T0, T1>(arg0, v2, v3, v0, 0x2::clock::timestamp_ms(arg8));
    }

    public fun finalize_shutdown<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_unwinding<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_checkpoint<T1>(&v0, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::recoverable_terminal_cash(&v1);
        let v3 = if (v2 == 0) {
            0x2::coin::zero<T1>(arg8)
        } else {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::withdraw<T1>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0), arg2, arg3, arg4, arg5, arg6, v2, arg7, arg8)
        };
        let v4 = v3;
        let v5 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_checkpoint<T1>(&v0, arg2, arg3, arg4, arg5, arg6);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::assert_terminal_withdrawal_checkpoint(&v1, &v5, 0x2::coin::value<T1>(&v4));
        complete_finalization<T0, T1>(arg0, v5, v4);
    }

    public fun add_partner(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg1: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::RiskAdmin>, arg2: &0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg0);
        let v0 = 0x2::object::id<0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner>(arg2);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::add_partner(arg0, v0);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::partner_added(v0);
    }

    public fun remove_partner(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg1: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::RiskAdmin>, arg2: &0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner, arg3: &0x2::clock::Clock) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg0);
        let v0 = 0x2::object::id<0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner>(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 + 0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::delay_ms();
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::remove_partner(arg0, v0, v1, v2);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::partner_removed(v0, v2);
    }

    public fun fixture_invalid_checkpoint<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: u8) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::fixture_invalid_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)), arg1));
    }

    public fun fixture_old_policy<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::fixture_old_policy(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0))));
    }

    fun apply_post_capture<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg2: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::CheckpointChange) {
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::is_clean(&arg2);
        let (v1, v2, v3) = settle_net_funding<T0, T1>(arg0, &arg2);
        let v4 = *0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        if (v0) {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg1);
        } else {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::checkpoint_drifted<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), arg1);
        };
        if (v0 && v4 != arg1) {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::funding_settled<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::is_cost(&arg2), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::raw_amount(&arg2), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::amount(&arg2), v1, v2, v3, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::maintenance_reserve<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0)), v4, arg1);
        };
    }

    fun assert_can_begin_protected_shutdown<T0, T1>(arg0: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
    }

    fun assert_can_rebaseline<T0, T1>(arg0: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::RiskAdmin>) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
    }

    fun assert_deadline(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 26);
    }

    fun assert_initial_margin<T0>(arg0: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::Issuance<T0>, arg1: u256, arg2: u256, arg3: u256, arg4: u256) {
        let v0 = if (arg1 > 0) {
            if (arg1 <= 1000000000000000000) {
                arg2 <= arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 16);
        assert!(arg3 < 1000000000000000000, 10);
        assert!(arg4 <= 1000000000000000000, 29);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_initial_margin_headroom<T0>(arg0, (0x1::u256::div_ceil(arg1, 100000000000000) as u64), (0x1::u256::div_ceil(arg3, 100000000000000) as u64), (0x1::u256::div_ceil(arg4, 100000000000000) as u64));
    }

    fun assert_initialization_inputs(arg0: u8, arg1: u256, arg2: u64, arg3: u64) {
        assert!(arg0 == 6 && arg1 == 1000000000000, 11);
        assert!(arg2 > 0, 12);
        assert!(arg3 < arg2, 13);
    }

    fun assert_position_imr_unchanged<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: u256) {
        let v0 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::initial_margin_ratio(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, arg1));
        assert_position_imr_unchanged_decoded(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0), v0, arg2);
    }

    fun assert_position_imr_unchanged_decoded(arg0: bool, arg1: u256, arg2: u256) {
        assert!(!arg0 && arg1 == arg2, 16);
    }

    fun assert_rebalance_gas_price<T0>(arg0: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::RebalancePlan<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::is_emergency_rebalance<T0>(arg0) || 0x2::tx_context::gas_price(arg1) <= 0x2::tx_context::reference_gas_price(arg1), 35);
    }

    fun assert_settlement_valuation(arg0: bool, arg1: u256, arg2: bool, arg3: u256, arg4: bool) {
        let v0 = if (arg0) {
            if (arg1 != 0) {
                if (arg3 != 0) {
                    if (!arg2) {
                        !arg4
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 31);
    }

    fun begin_protected_shutdown_from_checkpoint<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg2: u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::classify_preexisting(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)), &arg1);
        assert!(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::is_unchanged(&v0), 30);
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::total_share_supply<T0, T1>(arg0);
        let v2 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::locked_shares<T0, T1>(arg0);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::begin_protected_shutdown<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state_mut<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::base_to_close(&arg1, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::side<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0))), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::lot_size(&arg1), v1, v2, arg2);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg1);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::protected_shutdown_begun<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), arg1, v1, v2);
    }

    fun complete_donation<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg3: u64, arg4: u64) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::assert_allocated_deposit_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)), &arg2, arg3);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::donate<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state_mut<T0, T1>(arg0), arg1, arg3, arg4);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg2);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::donated<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), arg3, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::maintenance_reserve<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0)), arg2);
    }

    fun complete_finalization<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2, v3) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::finalize_shutdown<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state_mut<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::total_share_supply<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::locked_shares<T0, T1>(arg0), v0);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::seal_terminal_cash<T0, T1>(arg0, arg2, v1, v2, v3);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg1);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::shutdown_finalized<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), v0, v1, arg1, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::allocated_collateral(&arg1), v2, v3);
    }

    fun complete_market_unwind<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg2: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg3: u64, arg4: u256) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_unwinding<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        assert!(arg3 > 0 && arg3 <= 16, 31);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg2);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::unwind_progress<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), arg1, arg2, arg3, 0x1::option::some<u256>(arg4));
    }

    fun complete_rebaseline<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::CapturedSnapshot, arg2: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::CapturedSnapshot, arg3: u64) {
        let v0 = *0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::checkpoint(&arg2);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::assert_forced_reduction(&v0, &v1);
        let v2 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::checkpoint(&arg1);
        let v3 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::checkpoint(&arg2);
        let v4 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::classify_change(&v2, &v3, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::collateral_fixed(&arg1));
        assert!(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::is_clean(&v4), 38);
        let (v5, v6) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_recovery_observation(arg2);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), v2);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::checkpoint_rebaselined<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), v0, v2);
        apply_post_capture<T0, T1>(arg0, v6, v4);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_recoverable_position<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), v5, arg3);
    }

    fun complete_settlement_unwind<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg2: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg3: u256) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_unwinding<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::classify_preexisting(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)), &arg1);
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::is_unexpected(&v0);
        let v2 = if (v1) {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::direct_settlement_funding(&arg1, &arg2, arg3)
        } else {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::net_funding(v0, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::direct_settlement_funding(&arg1, &arg2, arg3))
        };
        let v3 = v2;
        assert!(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::is_clean(&v3), 30);
        if (v1) {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::checkpoint_drifted<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), arg1);
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::replace_checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue_mut<T0, T1>(arg0), arg1);
        };
        apply_post_capture<T0, T1>(arg0, arg2, v3);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::unwind_progress<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), arg1, arg2, 0, 0x1::option::none<u256>());
    }

    fun emit_vault_initialized<T0, T1>(arg0: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::PositionSide, arg7: u256) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::vault_initialized<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)), arg1, arg3, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::maintenance_reserve<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0)), arg2, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::locked_shares<T0, T1>(arg0), arg4, arg5, arg6, arg7, *0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)));
    }

    public fun fixture_initialize<T0, T1>(arg0: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::VaultIssuance<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0x2::coin_registry::Currency<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u256, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::AccountSharePolicy) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::issuance<T0, T1>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg7);
        assert_initialization_inputs(0x2::coin_registry::decimals<T1>(arg2), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4)), v1, arg8);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4);
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::priority_taker_fee(v2);
        let v4 = if (0x1::option::is_some<u256>(&v3)) {
            0x1::option::destroy_some<u256>(v3)
        } else {
            0x1::option::destroy_none<u256>(v3);
            0
        };
        assert_initial_margin<T0>(v0, arg9, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(v2), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_haircut(v2), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::ifixed_math::nonnegative_rate(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::taker_fee(v2)) + 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::ifixed_math::nonnegative_rate(v4));
        let (v5, v6, v7, v8) = open_venue_account<T1>(arg3, &arg4, arg11);
        let v9 = v8;
        let v10 = v7;
        let v11 = v5;
        let v12 = &mut v11;
        let v13 = &mut arg4;
        fund_venue_account<T1>(v12, &v10, arg3, v13, arg7, arg9);
        let v14 = arg4;
        arg4 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::seed_position<T0, T1>(v0, &mut v11, &v10, &v9, arg3, v14, arg5, arg6, arg8, arg10, arg11);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settle_position_funding<T1>(&mut arg4, arg6, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::account_number(&v9), arg10);
        let (v15, v16) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_observation(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v9, &v11, arg3, &arg4, arg5, arg6, arg10));
        assert_position_imr_unchanged<T1>(&arg4, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::account_number(&v9), arg9);
        let (v17, v18, v19) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::activate<T0, T1>(arg0, v15, arg8, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::new(v9, v16, v10), 0x2::clock::timestamp_ms(arg10), arg11);
        let v20 = v19;
        let v21 = v17;
        emit_vault_initialized<T0, T1>(&v21, v1, v18, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::equity(&v20), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::base(&v20), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::lot_size(&v20), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::seed_side<T0>(v0), arg9);
        (v21, arg4, v11, v6)
    }

    public fun fixture_rebalance<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        rebalance<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun fixture_rebalance_composable<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        let v0 = &mut arg4;
        let v1 = synchronize_or_fail<T0, T1>(arg0, arg2, arg3, v0, arg5, arg6, arg7);
        let (v2, v3) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_rebalance_plan<T0>(v1, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::live_venue_fee_bps<T1>(&arg4), 0x2::clock::timestamp_ms(arg7));
        let v4 = v2;
        assert_rebalance_gas_price<T0>(&v4, arg8);
        let v5 = if (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::is_increasing<T0>(&v4)) {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::increasing_terms<T0, T1>(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::rebalance_position<T0>(&v4))
        } else {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::reducing_terms<T0, T1>(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::rebalance_position<T0>(&v4))
        };
        let v6 = v5;
        let v7 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let (v8, v9) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::rebalance_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, &v7, &v6, &mut v4, v3, arg7, arg8);
        complete_rebalance<T0, T1>(arg0, v4, v9);
        v8
    }

    public fun fixture_snapshot<T0, T1>(arg0: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>) : (0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, u64, u64, u64) {
        (*0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::total_share_supply<T0, T1>(arg0), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::maintenance_reserve<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0)), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::admin_cash_balance<T0, T1>(arg0))
    }

    public fun fixture_trade<T0, T1>(arg0: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: bool, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        let (v0, _) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::execute_order<T1>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        v0
    }

    fun fund_mint<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint, arg9: &mut 0x2::tx_context::TxContext) : 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::Checkpoint {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::retain_admin_cash<T0, T1>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, arg7, arg9)));
        let v0 = 0x2::coin::value<T1>(&arg6);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::deposit<T1>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0), arg1, arg2, arg6);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::allocate<T1>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0), arg1, arg3, v0);
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let v2 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_checkpoint<T1>(&v1, arg1, arg2, arg3, arg4, arg5);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::assert_allocated_deposit_checkpoint(arg8, &v2, v0);
        v2
    }

    fun fund_venue_account<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u256) {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0, arg1, arg2, arg4);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, arg1, arg0);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, arg1, arg0, 0x2::coin::value<T0>(&arg4));
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, arg1, arg0, arg5);
    }

    public fun initialize<T0, T1>(arg0: 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::VaultIssuance<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0x2::coin_registry::Currency<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u256, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::issuance<T0, T1>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg7);
        assert_initialization_inputs(0x2::coin_registry::decimals<T1>(arg2), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4)), v1, arg8);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4);
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::priority_taker_fee(v2);
        let v4 = if (0x1::option::is_some<u256>(&v3)) {
            0x1::option::destroy_some<u256>(v3)
        } else {
            0x1::option::destroy_none<u256>(v3);
            0
        };
        assert_initial_margin<T0>(v0, arg9, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(v2), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_haircut(v2), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::ifixed_math::nonnegative_rate(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::taker_fee(v2)) + 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::ifixed_math::nonnegative_rate(v4));
        let (v5, v6, v7, v8) = open_venue_account<T1>(arg3, &arg4, arg11);
        let v9 = v8;
        let v10 = v7;
        let v11 = v5;
        let v12 = &mut v11;
        let v13 = &mut arg4;
        fund_venue_account<T1>(v12, &v10, arg3, v13, arg7, arg9);
        let v14 = arg4;
        arg4 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::seed_position<T0, T1>(v0, &mut v11, &v10, &v9, arg3, v14, arg5, arg6, arg8, arg10, arg11);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settle_position_funding<T1>(&mut arg4, arg6, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::account_number(&v9), arg10);
        let (v15, v16) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_observation(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v9, &v11, arg3, &arg4, arg5, arg6, arg10));
        assert_position_imr_unchanged<T1>(&arg4, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::account_number(&v9), arg9);
        let (v17, v18, v19) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::activate<T0, T1>(arg0, v15, arg8, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::new(v9, v16, v10), 0x2::clock::timestamp_ms(arg10), arg11);
        let v20 = v19;
        let v21 = v17;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T1>(v11, v6);
        emit_vault_initialized<T0, T1>(&v21, v1, v18, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::equity(&v20), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::base(&v20), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::lot_size(&v20), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::seed_side<T0>(v0), arg9);
        (v21, arg4)
    }

    public fun mint<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        let v0 = 0x2::coin::value<T1>(&arg7);
        assert!(v0 > 0, 19);
        assert_deadline(0x2::clock::timestamp_ms(arg10), arg9);
        let v1 = &mut arg4;
        let v2 = synchronize_or_fail<T0, T1>(arg0, arg2, arg3, v1, arg5, arg6, arg10);
        let (v3, v4) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_observation(v2);
        let v5 = v4;
        let v6 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::prepare_mint<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), v3, v0, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::total_share_supply<T0, T1>(arg0), arg8, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::live_venue_fee_bps<T1>(&arg4), 0x2::clock::timestamp_ms(arg10));
        let v7 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::increasing_terms<T0, T1>(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::mint_position<T0>(&v6));
        let v8 = &mut arg4;
        let v9 = fund_mint<T0, T1>(arg0, arg2, arg3, v8, arg5, arg6, arg7, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::admin_fee<T0>(&v6), &v5, arg11);
        let v10 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let v11 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::fill_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, &v10, v9, v7, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::base_to_buy<T0>(&v6), arg10, arg11);
        let (v12, v13) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_observation(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v10, arg2, arg3, &v11, arg5, arg6, arg10));
        (complete_mint<T0, T1>(arg0, v6, v0, v12, v13, 0x2::clock::timestamp_ms(arg10), arg11), v11)
    }

    public fun mint_with_partner<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_partner(arg1, 0x2::object::id<0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner>(arg2), 0x2::clock::timestamp_ms(arg11));
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::admin_cash_balance<T0, T1>(arg0);
        let (v1, v2) = mint<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        pay_partner<T0, T1>(arg0, arg2, v0, arg11, arg12);
        (v1, v2)
    }

    public fun needs_rebalance<T0, T1>(arg0: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) : bool {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v0, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::checkpoint(&v1);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_rebalance_readiness<T0>(v1, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::classify_preexisting(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)), &v2), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::live_venue_fee_bps<T1>(arg4), 0x2::clock::timestamp_ms(arg7))
    }

    fun observe<T0, T1>(arg0: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) : (0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::CapturedSnapshot, 0x2::object::ID, u64, u64) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        (0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v0, arg2, arg3, arg4, arg5, arg6, arg7), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::treasury_cap_id<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::total_share_supply<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg7))
    }

    fun open_venue_account<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::AccountSharePolicy, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::Binding) {
        let (v0, v1, v2) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg2);
        let v3 = v0;
        (v3, v1, v2, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::new_binding(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(&v3), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(&v3), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg0), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1)))
    }

    fun pay_partner<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::admin_cash_balance<T0, T1>(arg0) - arg2;
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::take_admin_cash<T0, T1>(arg0, v0);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::retain_admin_cash<T0, T1>(arg0, v1);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::events::partner_fee_paid<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::id<T0, T1>(arg0), 0x2::object::id<0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner>(arg1), v0, 0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::pay<T1>(arg1, &mut v1, arg3, arg4));
    }

    entry fun realize_profit<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        assert!(0x2::tx_context::gas_price(arg8) <= 0x2::tx_context::reference_gas_price(arg8), 35);
        let v0 = &mut arg4;
        let v1 = synchronize_or_fail<T0, T1>(arg0, arg2, arg3, v0, arg5, arg6, arg7);
        let (v2, v3) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_observation(v1);
        let v4 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let v5 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_cash_liquidity<T1>(&v4, arg2, arg3, &arg4, arg5, arg6, arg7);
        let v6 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::prepare_profit_realization<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), v2, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::shortfall(&v5), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::unrealized_profit(&v5), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::live_venue_fee_bps<T1>(&arg4), 0x2::clock::timestamp_ms(arg7));
        let v7 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::realize_profit_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, v3, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::realization_position<T0>(&v6), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::base_to_realize<T0>(&v6), arg7, arg8);
        let (v8, v9) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_observation(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v4, arg2, arg3, &v7, arg5, arg6, arg7));
        complete_profit_realization<T0, T1>(arg0, v6, v5, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_cash_liquidity<T1>(&v4, arg2, arg3, &v7, arg5, arg6, arg7), v3, v8, v9, 0x2::clock::timestamp_ms(arg7));
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v7);
    }

    entry fun rebalance<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        let v0 = &mut arg4;
        let v1 = synchronize_or_fail<T0, T1>(arg0, arg2, arg3, v0, arg5, arg6, arg7);
        let (v2, v3) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_rebalance_plan<T0>(v1, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::live_venue_fee_bps<T1>(&arg4), 0x2::clock::timestamp_ms(arg7));
        let v4 = v2;
        assert_rebalance_gas_price<T0>(&v4, arg8);
        let v5 = if (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::is_increasing<T0>(&v4)) {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::increasing_terms<T0, T1>(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::rebalance_position<T0>(&v4))
        } else {
            0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::reducing_terms<T0, T1>(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::rebalance_position<T0>(&v4))
        };
        let v6 = v5;
        let v7 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let (v8, v9) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::rebalance_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, &v7, &v6, &mut v4, v3, arg7, arg8);
        complete_rebalance<T0, T1>(arg0, v4, v9);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v8);
    }

    public fun rebaseline<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::RiskAdmin>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock) {
        assert_can_rebaseline<T0, T1>(arg0, arg1, arg2);
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::assert_bound_graph<T1>(&v0, arg3, arg4, arg5, arg6, arg7);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::update_funding_when_due<T1>(&v0, arg5, arg6, arg8);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settle_position_funding<T1>(arg5, arg7, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::account_number(&v0), arg8);
        complete_rebaseline<T0, T1>(arg0, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v0, arg3, arg4, arg5, arg6, arg7, arg8), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v0, arg3, arg4, arg5, arg6, arg7, arg8), 0x2::clock::timestamp_ms(arg8));
    }

    public fun redeem<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_active<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        assert!(0x2::coin::value<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>(&arg7) > 0, 19);
        assert_deadline(0x2::clock::timestamp_ms(arg10), arg9);
        let v0 = &mut arg4;
        let v1 = synchronize_or_fail<T0, T1>(arg0, arg2, arg3, v0, arg5, arg6, arg10);
        let (v2, v3) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_observation(v1);
        let v4 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::prepare_redemption<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), v2, 0x2::coin::value<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>(&arg7), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::total_share_supply<T0, T1>(arg0), arg8, 0x2::clock::timestamp_ms(arg10));
        let v5 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let v6 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::fill_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, &v5, v3, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::reducing_terms<T0, T1>(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::redemption_position<T0>(&v4)), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::base_to_sell<T0>(&v4), arg10, arg11);
        let (v7, v8) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::into_observation(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v5, arg2, arg3, &v6, arg5, arg6, arg10));
        let v9 = v8;
        let (v10, v11, v12, v13) = settle_redemption<T0, T1>(arg0, v4, &arg7, v7, 0x2::clock::timestamp_ms(arg10));
        let v14 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_cash_liquidity<T1>(&v5, arg2, arg3, &v6, arg5, arg6, arg10);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::assert_releasable(&v14, v10 + v11);
        let v15 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::withdraw<T1>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0), arg2, arg3, &mut v6, arg5, arg6, v10 + v11, arg10, arg11);
        let v16 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_checkpoint<T1>(&v5, arg2, arg3, &v6, arg5, arg6);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::assert_withdrawal_checkpoint(&v9, &v16, v10 + v11);
        (complete_redemption<T0, T1>(arg0, arg7, v15, v10, v11, v12, v13, v16, arg11), v6)
    }

    public fun redeem_with_partner<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: 0x2::coin::Coin<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_partner(arg1, 0x2::object::id<0xbd185efe5efed1eac3024c1d2925c85bc778b7679e2a3bc9b5682e7048ef5dee::blast_partners::Partner>(arg2), 0x2::clock::timestamp_ms(arg11));
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::admin_cash_balance<T0, T1>(arg0);
        let (v1, v2) = redeem<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        pay_partner<T0, T1>(arg0, arg2, v0, arg11, arg12);
        (v1, v2)
    }

    public fun set_max_order_notional<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::RiskAdmin>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: u64, arg9: &0x2::clock::Clock) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_max_order_notional_update<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0), arg8);
        let (v1, v2, v3) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_order_capacity<T1>(&v0, arg3, arg4, arg5, arg6, arg7, arg9);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::set_max_order_notional<T0, T1>(arg0, arg1, arg2, arg8, v1, v2, v3, 0x2::clock::timestamp_ms(arg9));
    }

    fun settle_net_funding<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::CheckpointChange) : (u64, u64, u64) {
        if (!0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::has_funding(arg1)) {
            return (0, 0, 0)
        };
        let v0 = if (0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::is_cost(arg1)) {
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::funding_cost(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::amount(arg1))
        } else {
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::funding_credit(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::amount(arg1))
        };
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::settle_funding<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state_mut<T0, T1>(arg0), v0)
    }

    fun settle_redemption<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::RedemptionPlan<T0>, arg2: &0x2::coin::Coin<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>, arg3: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg4: u64) : (u64, u64, u64, u64) {
        assert!(0x2::coin::value<0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost::BlastBoost<T0>>(arg2) == 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::redemption_shares<T0>(&arg1), 28);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::complete_redemption<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state_mut<T0, T1>(arg0), arg1, arg3, arg4)
    }

    public fun sync_health<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        synchronize<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun synchronize<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::CapturedSnapshot {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_can_sync<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::update_funding_when_due<T1>(&v0, arg3, arg4, arg6);
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::checkpoint(&v1);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settle_position_funding<T1>(arg3, arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg1), arg6);
        let v3 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture<T1>(&v0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v4 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::checkpoint(&v3);
        let (v5, v6) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::classify_sync_changes(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)), &v2, &v4, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::collateral_fixed(&v1));
        apply_post_capture<T0, T1>(arg0, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::checkpoint(&v3), 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::net_funding(v5, v6));
        v3
    }

    fun synchronize_or_fail<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::CapturedSnapshot {
        let v0 = synchronize<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::checkpoint(&v0);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::assert_unchanged(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::checkpoint(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0)), &v1);
        v0
    }

    entry fun unwind<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_unwinding<T0>(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::state<T0, T1>(arg0));
        assert!(!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T1>(&arg4), 33);
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_market_paused<T1>(&arg4)) {
            let v0 = &mut arg4;
            unwind_settlement<T0, T1>(arg0, arg2, arg3, v0, arg5, arg6);
        } else {
            let v1 = arg4;
            arg4 = unwind_market<T0, T1>(arg0, arg2, arg3, v1, arg5, arg6, arg7, arg8);
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg4);
    }

    fun unwind_market<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        let v0 = &mut arg3;
        let v1 = synchronize<T0, T1>(arg0, arg1, arg2, v0, arg4, arg5, arg6);
        let (v2, v3, v4) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::unwind_terms<T0, T1>(arg0, &v1, 0x2::clock::timestamp_ms(arg6));
        let v5 = v2;
        let v6 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let (v7, v8, v9, v10) = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::orders::close_orders<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &v6, &v5, v4, v3, arg6, arg7);
        complete_market_unwind<T0, T1>(arg0, v4, v8, v9, v10);
        v7
    }

    fun unwind_settlement<T0, T1>(arg0: &mut 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        let v0 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::venue_account::binding(0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::vault::venue<T0, T1>(arg0));
        let v1 = 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_checkpoint<T1>(&v0, arg1, arg2, arg3, arg4, arg5);
        0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::checkpoint::assert_no_orders(&v1);
        let (v2, v3, v4) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settlement_valuation_prices<T1>(arg3);
        assert_settlement_valuation(v2, v3, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v3), v4, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v4));
        let v5 = vector[];
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::close_position_at_settlement_prices<T1>(arg3, arg1, &v5);
        complete_settlement_unwind<T0, T1>(arg0, v1, 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::snapshot::capture_checkpoint<T1>(&v0, arg1, arg2, arg3, arg4, arg5), v4);
    }

    // decompiled from Move bytecode v7
}

