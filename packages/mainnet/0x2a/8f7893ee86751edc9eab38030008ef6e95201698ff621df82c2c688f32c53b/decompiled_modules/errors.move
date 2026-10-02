module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors {
    public fun account_margin_bound() : u64 {
        910
    }

    public fun auth_order_mismatch() : u64 {
        611
    }

    public fun auth_state_mismatch() : u64 {
        612
    }

    public fun auth_window() : u64 {
        613
    }

    public fun bad_auth_bytes() : u64 {
        614
    }

    public fun bad_order_bytes() : u64 {
        512
    }

    public fun bad_signature() : u64 {
        513
    }

    public fun below_initial_margin() : u64 {
        911
    }

    public fun bond_mismatch() : u64 {
        1104
    }

    public fun borrow_cap_exceeded() : u64 {
        904
    }

    public fun challenge_window_closed() : u64 {
        1102
    }

    public fun challenge_window_open() : u64 {
        1103
    }

    public fun confidence_too_wide() : u64 {
        804
    }

    public fun convert_duplicate_step() : u64 {
        1208
    }

    public fun convert_incomplete() : u64 {
        1207
    }

    public fun debt_outstanding() : u64 {
        912
    }

    public fun duplicate_member() : u64 {
        1203
    }

    public fun epoch_mismatch() : u64 {
        206
    }

    public fun fee_cap_exceeded() : u64 {
        618
    }

    public fun floor_not_increased() : u64 {
        510
    }

    public fun group_already_decided() : u64 {
        1205
    }

    public fun group_not_decided() : u64 {
        1206
    }

    public fun group_not_sealed() : u64 {
        1201
    }

    public fun group_sealed() : u64 {
        1200
    }

    public fun insufficient_collateral() : u64 {
        400
    }

    public fun insufficient_liquidation_payment() : u64 {
        1002
    }

    public fun insufficient_pool_liquidity() : u64 {
        901
    }

    public fun insufficient_position() : u64 {
        405
    }

    public fun insufficient_shares() : u64 {
        903
    }

    public fun invalid_eta() : u64 {
        606
    }

    public fun invalid_margin_params() : u64 {
        914
    }

    public fun invalid_mark_params() : u64 {
        921
    }

    public fun invalid_market_params() : u64 {
        301
    }

    public fun invalid_market_times() : u64 {
        302
    }

    public fun invalid_matcher_key() : u64 {
        200
    }

    public fun invalid_order_price() : u64 {
        518
    }

    public fun invalid_outcome() : u64 {
        1107
    }

    public fun invalid_pause_flag() : u64 {
        202
    }

    public fun invalid_policy() : u64 {
        604
    }

    public fun invalid_pool_params() : u64 {
        905
    }

    public fun invalid_price() : u64 {
        805
    }

    public fun invalid_quantity() : u64 {
        402
    }

    public fun invalid_too_early() : u64 {
        801
    }

    public fun limit_violated() : u64 {
        617
    }

    public fun liquidation_window_closed() : u64 {
        1001
    }

    public fun margin_already_bound() : u64 {
        908
    }

    public fun margin_binding_mismatch() : u64 {
        909
    }

    public fun mark_frozen() : u64 {
        915
    }

    public fun mark_not_registered() : u64 {
        922
    }

    public fun mark_price_out_of_domain() : u64 {
        918
    }

    public fun mark_stale() : u64 {
        919
    }

    public fun mark_step_too_large() : u64 {
        917
    }

    public fun mark_too_soon() : u64 {
        916
    }

    public fun mark_wrong_market() : u64 {
        920
    }

    public fun market_closing() : u64 {
        307
    }

    public fun market_exists() : u64 {
        300
    }

    public fun market_not_active() : u64 {
        303
    }

    public fun market_not_cancellable() : u64 {
        304
    }

    public fun market_not_open() : u64 {
        306
    }

    public fun market_not_resolved() : u64 {
        310
    }

    public fun market_terminal() : u64 {
        305
    }

    public fun market_window_expired() : u64 {
        623
    }

    public fun matcher_disabled() : u64 {
        203
    }

    public fun matcher_key_reused() : u64 {
        201
    }

    public fun max_debt_exceeded() : u64 {
        913
    }

    public fun nonce_below_floor() : u64 {
        509
    }

    public fun nonce_conflict() : u64 {
        508
    }

    public fun not_group_member() : u64 {
        1202
    }

    public fun not_liquidatable() : u64 {
        1000
    }

    public fun open_interest_exceeded() : u64 {
        403
    }

    public fun oracle_kind_mismatch() : u64 {
        1106
    }

    public fun order_cancelled() : u64 {
        621
    }

    public fun order_epoch_mismatch() : u64 {
        507
    }

    public fun order_expired() : u64 {
        622
    }

    public fun order_pair_mismatch() : u64 {
        517
    }

    public fun overfill() : u64 {
        620
    }

    public fun overflow() : u64 {
        700
    }

    public fun paused() : u64 {
        205
    }

    public fun pool_insolvent() : u64 {
        907
    }

    public fun pool_paused() : u64 {
        900
    }

    public fun position_limit_exceeded() : u64 {
        404
    }

    public fun position_mismatch() : u64 {
        923
    }

    public fun price_not_crossing() : u64 {
        616
    }

    public fun price_out_of_window() : u64 {
        803
    }

    public fun proposal_exists() : u64 {
        601
    }

    public fun proposal_not_found() : u64 {
        602
    }

    public fun propose_too_early() : u64 {
        1101
    }

    public fun propose_too_late() : u64 {
        1108
    }

    public fun prune_not_allowed() : u64 {
        511
    }

    public fun quota_decrease_pending() : u64 {
        1303
    }

    public fun quota_insufficient_collateral() : u64 {
        1301
    }

    public fun quota_insufficient_locked() : u64 {
        1302
    }

    public fun quota_no_pending() : u64 {
        1304
    }

    public fun quota_timelock_active() : u64 {
        1305
    }

    public fun quota_zero_amount() : u64 {
        1300
    }

    public fun repay_exceeds_debt() : u64 {
        906
    }

    public fun resolve_too_early() : u64 {
        800
    }

    public fun resolver_already_bound() : u64 {
        1109
    }

    public fun resolver_invalidate_blocked() : u64 {
        1110
    }

    public fun resolver_market_mismatch() : u64 {
        1105
    }

    public fun resolver_phase() : u64 {
        1100
    }

    public fun self_trade() : u64 {
        619
    }

    public fun session_key_exists() : u64 {
        501
    }

    public fun session_key_expired() : u64 {
        504
    }

    public fun session_key_invalid() : u64 {
        500
    }

    public fun session_key_not_found() : u64 {
        502
    }

    public fun session_key_revoked() : u64 {
        503
    }

    public fun session_lifetime_exceeded() : u64 {
        505
    }

    public fun session_notional_exceeded() : u64 {
        506
    }

    public fun settlement_window_closed() : u64 {
        308
    }

    public fun settlement_window_open() : u64 {
        309
    }

    public fun timelock_not_elapsed() : u64 {
        603
    }

    public fun too_few_members() : u64 {
        1209
    }

    public fun unauthorized() : u64 {
        100
    }

    public fun unsupported_order_type() : u64 {
        516
    }

    public fun unsupported_order_version() : u64 {
        515
    }

    public fun winner_not_member() : u64 {
        1204
    }

    public fun wrong_domain() : u64 {
        514
    }

    public fun wrong_feed() : u64 {
        802
    }

    public fun wrong_package() : u64 {
        102
    }

    public fun wrong_protocol() : u64 {
        101
    }

    public fun wrong_route() : u64 {
        610
    }

    public fun wrong_vault() : u64 {
        605
    }

    public fun zero_amount() : u64 {
        401
    }

    public fun zero_quote() : u64 {
        615
    }

    public fun zero_shares() : u64 {
        902
    }

    // decompiled from Move bytecode v7
}

