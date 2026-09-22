module 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::operations {
    fun complete_mint<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::MintPlan<T0>, arg2: u64, arg3: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg4: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>> {
        let (v0, v1, v2, v3, v4) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::complete_mint<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state_mut<T0, T1>(arg0), arg1, arg3, arg5);
        let v5 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::mint_shares<T0, T1>(arg0, v0, arg6);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::replace_checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue_mut<T0, T1>(arg0), arg4);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::minted<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::id<T0, T1>(arg0), arg2, 0x2::coin::value<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(&v5), v1, v2, v3, v4, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::maintenance_reserve<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0)), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::admin_cash_balance<T0, T1>(arg0), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::total_share_supply<T0, T1>(arg0), arg4);
        v5
    }

    fun complete_rebalance<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::RebalancePlan<T0>, arg2: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint) {
        let (v0, v1, v2, v3, v4) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::complete_rebalance<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0), arg1);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::replace_checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue_mut<T0, T1>(arg0), arg2);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::rebalanced<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::id<T0, T1>(arg0), v0, v1, v2, v3, v4, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::maintenance_reserve<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0)), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::admin_cash_balance<T0, T1>(arg0), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::total_share_supply<T0, T1>(arg0), arg2);
    }

    fun complete_redemption<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T1>(&arg2) == arg3 + arg4, 23);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::retain_admin_cash<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg2, arg4, arg8));
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::replace_checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue_mut<T0, T1>(arg0), arg7);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::redeemed<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::id<T0, T1>(arg0), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::burn_redeemed_shares<T0, T1>(arg0, arg1), arg3, arg5, arg4, arg6, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::maintenance_reserve<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0)), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::admin_cash_balance<T0, T1>(arg0), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::total_share_supply<T0, T1>(arg0), arg7);
        arg2
    }

    public fun donate<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_active<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0));
        let v0 = 0x2::coin::value<T1>(&arg7);
        assert!(v0 > 0, 21);
        synchronize_or_fail<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg8);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::deposit<T1>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0), arg2, arg3, arg7);
        let v1 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let (v2, v3) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::into_observation(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture<T1>(&v1, arg2, arg3, arg4, arg5, arg6, arg8));
        complete_donation<T0, T1>(arg0, v2, v3, v0, 0x2::clock::timestamp_ms(arg8));
    }

    public fun finalize_shutdown<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_unwinding<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0));
        let v0 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let v1 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture_checkpoint<T1>(&v0, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::recoverable_terminal_cash(&v1);
        let v3 = if (v2 == 0) {
            0x2::coin::zero<T1>(arg8)
        } else {
            0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::withdraw<T1>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0), arg2, arg3, arg4, arg5, arg6, v2, arg7, arg8)
        };
        let v4 = v3;
        let v5 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture_checkpoint<T1>(&v0, arg2, arg3, arg4, arg5, arg6);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::assert_terminal_withdrawal_checkpoint(&v1, &v5, 0x2::coin::value<T1>(&v4));
        complete_finalization<T0, T1>(arg0, v5, v4);
    }

    public fun needs_rebalance<T0, T1>(arg0: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) : bool {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_active<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0));
        let v0 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let (v1, v2) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::into_observation(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture<T1>(&v0, arg2, arg3, arg4, arg5, arg6, arg7));
        let v3 = v2;
        let v4 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::classify_preexisting(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0)), &v3);
        assert!(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::is_clean(&v4), 32);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::needs_rebalance<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0), v1, 0x2::clock::timestamp_ms(arg7))
    }

    fun apply_post_capture<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg2: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::CheckpointChange) {
        let v0 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::is_clean(&arg2);
        let (v1, v2, v3) = settle_net_funding<T0, T1>(arg0, &arg2);
        let v4 = *0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        if (v0) {
            0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::replace_checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue_mut<T0, T1>(arg0), arg1);
        } else {
            0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::checkpoint_drifted<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::id<T0, T1>(arg0), arg1);
        };
        if (v0 && v4 != arg1) {
            0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::funding_settled<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::id<T0, T1>(arg0), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::is_cost(&arg2), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::raw_amount(&arg2), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::amount(&arg2), v1, v2, v3, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::maintenance_reserve<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0)), v4, arg1);
        };
    }

    fun assert_deadline(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 28);
    }

    fun assert_initialization_inputs(arg0: u8, arg1: u256, arg2: u64, arg3: u64) {
        assert!(arg0 == 6 && arg1 == 1000000000000, 13);
        assert!(arg2 > 0, 14);
        assert!(arg3 < arg2, 15);
    }

    fun assert_position_imr(arg0: u256) {
        assert_position_imr_sign(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0));
    }

    fun assert_position_imr_sign(arg0: bool) {
        assert!(!arg0, 18);
    }

    fun assert_position_imr_unchanged<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: u256) {
        let v0 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::initial_margin_ratio(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, arg1));
        assert_position_imr_unchanged_decoded(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0), v0, arg2);
    }

    fun assert_position_imr_unchanged_decoded(arg0: bool, arg1: u256, arg2: u256) {
        assert!(!arg0 && arg1 == arg2, 18);
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
        assert!(v0, 33);
    }

    fun complete_donation<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg3: u64, arg4: u64) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::assert_deposit_checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0)), &arg2, arg3);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::donate<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state_mut<T0, T1>(arg0), arg1, arg3, arg4);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::replace_checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue_mut<T0, T1>(arg0), arg2);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::donated<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::id<T0, T1>(arg0), arg3, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::maintenance_reserve<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0)), arg2);
    }

    fun complete_finalization<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::finalize_shutdown<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state_mut<T0, T1>(arg0), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::total_share_supply<T0, T1>(arg0), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::locked_shares<T0, T1>(arg0));
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::seal_terminal_cash<T0, T1>(arg0, arg2, v0);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::replace_checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue_mut<T0, T1>(arg0), arg1);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::shutdown_finalized<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::id<T0, T1>(arg0), 0x2::coin::value<T1>(&arg2), v0, arg1, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::allocated_collateral(&arg1));
    }

    fun complete_unwind<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg2: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg3: u64, arg4: 0x1::option::Option<u256>) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_unwinding<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0));
        if (0x1::option::is_none<u256>(&arg4)) {
            assert!(arg3 == 0, 33);
            0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::assert_direct_settlement_checkpoint(&arg1, &arg2);
        } else {
            assert!(arg3 > 0 && arg3 <= 16, 33);
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::replace_checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue_mut<T0, T1>(arg0), arg2);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::unwind_progress<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::id<T0, T1>(arg0), arg1, arg2, arg3, arg4);
    }

    fun emit_vault_initialized<T0, T1>(arg0: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PositionSide, arg7: u256) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::vault_initialized<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::id<T0, T1>(arg0), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0)), arg1, arg3, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::maintenance_reserve<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0)), arg2, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::locked_shares<T0, T1>(arg0), arg4, arg5, arg6, arg7, *0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0)));
    }

    fun fund_mint<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg9: &mut 0x2::tx_context::TxContext) : 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::retain_admin_cash<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg6, arg7, arg9));
        let v0 = 0x2::coin::value<T1>(&arg6);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::deposit<T1>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0), arg1, arg2, arg6);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::allocate<T1>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0), arg1, arg3, v0);
        let v1 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let v2 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture_checkpoint<T1>(&v1, arg1, arg2, arg3, arg4, arg5);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::assert_allocated_deposit_checkpoint(arg8, &v2, v0);
        v2
    }

    fun fund_venue_account<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u256) {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0, arg1, arg2, arg4);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, arg1, arg0);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, arg1, arg0, 0x2::coin::value<T0>(&arg4));
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg3, arg1, arg0, arg5);
    }

    public fun initialize<T0, T1>(arg0: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::VaultIssuance<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x2::coin_registry::Currency<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u256, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1> {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        let v0 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::issuance<T0, T1>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg7);
        assert_initialization_inputs(0x2::coin_registry::decimals<T1>(arg2), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4)), v1, arg8);
        assert_position_imr(arg9);
        let (v2, v3, v4, v5) = open_venue_account<T1>(arg3, &arg4, arg5, arg6, arg11);
        let v6 = v5;
        let v7 = v4;
        let v8 = v2;
        let v9 = &mut v8;
        let v10 = &mut arg4;
        fund_venue_account<T1>(v9, &v7, arg3, v10, arg7, arg9);
        let v11 = arg4;
        arg4 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::seed_position<T0, T1>(v0, &mut v8, &v7, &v6, arg3, v11, arg5, arg6, arg8, arg10, arg11);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settle_position_funding<T1>(&mut arg4, arg6, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::account_number(&v6), arg10);
        let (v12, v13) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::into_observation(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture<T1>(&v6, &v8, arg3, &arg4, arg5, arg6, arg10));
        assert_position_imr_unchanged<T1>(&arg4, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::account_number(&v6), arg9);
        let (v14, v15, v16) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::activate<T0, T1>(arg0, v12, arg8, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::new(v6, v13, v7), 0x2::clock::timestamp_ms(arg10), arg11);
        let v17 = v16;
        let v18 = v14;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T1>(v8, v3);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg4);
        emit_vault_initialized<T0, T1>(&v18, v1, v15, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::equity(&v17), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::base(&v17), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::lot_size(&v17), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::seed_side<T0>(v0), arg9);
        v18
    }

    public fun mint<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>> {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_active<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0));
        let v0 = 0x2::coin::value<T1>(&arg7);
        assert!(v0 > 0, 21);
        assert_deadline(0x2::clock::timestamp_ms(arg10), arg9);
        let v1 = &mut arg4;
        let v2 = synchronize_or_fail<T0, T1>(arg0, arg2, arg3, v1, arg5, arg6, arg10);
        let (v3, v4) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::into_observation(v2);
        let v5 = v4;
        let v6 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::prepare_mint<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0), v3, v0, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::total_share_supply<T0, T1>(arg0), arg8, 0x2::clock::timestamp_ms(arg10));
        let v7 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::increasing_terms<T0, T1>(arg0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::mint_position<T0>(&v6));
        let v8 = &mut arg4;
        let v9 = fund_mint<T0, T1>(arg0, arg2, arg3, v8, arg5, arg6, arg7, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::admin_fee<T0>(&v6), &v5, arg11);
        let v10 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let v11 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::fill_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, &v10, v9, v7, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::base_to_buy<T0>(&v6), arg10, arg11);
        let (v12, v13) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::into_observation(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture<T1>(&v10, arg2, arg3, &v11, arg5, arg6, arg10));
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v11);
        complete_mint<T0, T1>(arg0, v6, v0, v12, v13, 0x2::clock::timestamp_ms(arg10), arg11)
    }

    fun observe<T0, T1>(arg0: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) : (0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::CapturedSnapshot, 0x2::object::ID, u64, u64) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        let v0 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        (0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture<T1>(&v0, arg2, arg3, arg4, arg5, arg6, arg7), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::treasury_cap_id<T0, T1>(arg0), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::total_share_supply<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg7))
    }

    fun open_venue_account<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::AccountSharePolicy, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::Binding) {
        let (v0, v1, v2) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg4);
        let v3 = v0;
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1);
        (v3, v1, v2, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::new_binding(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(&v3), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(&v3), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg0), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1), 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg2), 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg3), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg2, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v4))), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_source_id(v4)))))
    }

    public fun rebalance<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_active<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0));
        let v0 = &mut arg4;
        let v1 = synchronize_or_fail<T0, T1>(arg0, arg2, arg3, v0, arg5, arg6, arg7);
        let (v2, v3) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::into_observation(v1);
        let v4 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::prepare_rebalance<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0), v2, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::live_venue_fee_bps<T1>(&arg4), 0x2::clock::timestamp_ms(arg7));
        let v5 = if (0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::is_increasing<T0>(&v4)) {
            0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::increasing_terms<T0, T1>(arg0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::rebalance_position<T0>(&v4))
        } else {
            0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::reducing_terms<T0, T1>(arg0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::rebalance_position<T0>(&v4))
        };
        let v6 = v5;
        let v7 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let (v8, v9) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::rebalance_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, &v7, &v6, &mut v4, v3, arg7, arg8);
        complete_rebalance<T0, T1>(arg0, v4, v9);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v8);
    }

    public fun redeem<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_active<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0));
        assert!(0x2::coin::value<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(&arg7) > 0, 21);
        assert_deadline(0x2::clock::timestamp_ms(arg10), arg9);
        let v0 = &mut arg4;
        let v1 = synchronize_or_fail<T0, T1>(arg0, arg2, arg3, v0, arg5, arg6, arg10);
        let (v2, v3) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::into_observation(v1);
        let v4 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::prepare_redemption<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0), v2, 0x2::coin::value<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(&arg7), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::total_share_supply<T0, T1>(arg0), arg8, 0x2::clock::timestamp_ms(arg10));
        let v5 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let v6 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::fill_orders<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, &v5, v3, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::reducing_terms<T0, T1>(arg0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::redemption_position<T0>(&v4)), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::base_to_sell<T0>(&v4), arg10, arg11);
        let (v7, v8) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::into_observation(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture<T1>(&v5, arg2, arg3, &v6, arg5, arg6, arg10));
        let v9 = v8;
        let (v10, v11, v12, v13) = settle_redemption<T0, T1>(arg0, v4, &arg7, v7, 0x2::clock::timestamp_ms(arg10));
        let v14 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::withdraw<T1>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0), arg2, arg3, &mut v6, arg5, arg6, v10 + v11, arg10, arg11);
        let v15 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture_checkpoint<T1>(&v5, arg2, arg3, &v6, arg5, arg6);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::assert_withdrawal_checkpoint(&v9, &v15, v10 + v11);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v6);
        complete_redemption<T0, T1>(arg0, arg7, v14, v10, v11, v12, v13, v15, arg11)
    }

    fun settle_net_funding<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::CheckpointChange) : (u64, u64, u64) {
        if (!0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::has_funding(arg1)) {
            return (0, 0, 0)
        };
        let v0 = if (0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::is_cost(arg1)) {
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::funding_cost(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::amount(arg1))
        } else {
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::funding_credit(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::amount(arg1))
        };
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::settle_funding<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state_mut<T0, T1>(arg0), v0)
    }

    fun settle_redemption<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::RedemptionPlan<T0>, arg2: &0x2::coin::Coin<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>, arg3: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg4: u64) : (u64, u64, u64, u64) {
        assert!(0x2::coin::value<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(arg2) == 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::redemption_shares<T0>(&arg1), 30);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::complete_redemption<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state_mut<T0, T1>(arg0), arg1, arg3, arg4)
    }

    public fun sync_health<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        synchronize<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun synchronize<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::CapturedSnapshot {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_can_sync<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0));
        let v0 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::update_funding_when_due<T1>(&v0, arg3, arg4, arg6);
        let v1 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture<T1>(&v0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::checkpoint(&v1);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settle_position_funding<T1>(arg3, arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg1), arg6);
        let v3 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture<T1>(&v0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v4 = *0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let v5 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::checkpoint(&v3);
        let (v6, v7) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::classify_sync_changes(&v4, &v2, &v5, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::collateral_fixed(&v1));
        apply_post_capture<T0, T1>(arg0, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::checkpoint(&v3), 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::net_funding(v6, v7));
        v3
    }

    fun synchronize_or_fail<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::CapturedSnapshot {
        let v0 = synchronize<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::checkpoint(&v0);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::assert_unchanged(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0)), &v1);
        v0
    }

    public fun unwind<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_unwinding<T0>(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::state<T0, T1>(arg0));
        assert!(!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T1>(&arg4), 35);
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_market_paused<T1>(&arg4)) {
            let v0 = &mut arg4;
            unwind_settlement<T0, T1>(arg0, arg2, arg3, v0, arg5, arg6);
        } else {
            let v1 = arg4;
            arg4 = unwind_market<T0, T1>(arg0, arg2, arg3, v1, arg5, arg6, arg7, arg8);
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg4);
    }

    fun unwind_market<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        let v0 = &mut arg3;
        let v1 = synchronize<T0, T1>(arg0, arg1, arg2, v0, arg4, arg5, arg6);
        let (v2, v3, v4) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::unwind_terms<T0, T1>(arg0, &v1, 0x2::clock::timestamp_ms(arg6));
        let v5 = v2;
        let v6 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let (v7, v8, v9, v10) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::orders::close_orders<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &v6, &v5, v4, v3, arg6, arg7);
        complete_unwind<T0, T1>(arg0, v4, v8, v9, 0x1::option::some<u256>(v10));
        v7
    }

    fun unwind_settlement<T0, T1>(arg0: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        let v0 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::binding(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0));
        let v1 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture_checkpoint<T1>(&v0, arg1, arg2, arg3, arg4, arg5);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::assert_no_orders(&v1);
        let (v2, v3, v4) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settlement_valuation_prices<T1>(arg3);
        assert_settlement_valuation(v2, v3, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v3), v4, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v4));
        let v5 = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::classify_preexisting(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::checkpoint(0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault::venue<T0, T1>(arg0)), &v1);
        apply_post_capture<T0, T1>(arg0, v1, v5);
        let v6 = vector[];
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::close_position_at_settlement_prices<T1>(arg3, arg1, &v6);
        complete_unwind<T0, T1>(arg0, v1, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot::capture_checkpoint<T1>(&v0, arg1, arg2, arg3, arg4, arg5), 0, 0x1::option::none<u256>());
    }

    // decompiled from Move bytecode v7
}

