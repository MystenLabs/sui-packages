module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error {
    public fun already_voted_code() : u64 {
        60012
    }

    public fun assessment_deposit_not_exact_code() : u64 {
        60007
    }

    public fun cant_buy_cover_and_claim_in_same_block_code() : u64 {
        50004
    }

    public fun claim_is_being_assessed_code() : u64 {
        60002
    }

    public fun claim_not_a_draw_code() : u64 {
        60009
    }

    public fun claim_not_redeemable_code() : u64 {
        60001
    }

    public fun claims_paused_code() : u64 {
        60014
    }

    public fun cover_not_found_code() : u64 {
        50003
    }

    public fun covered_amount_exceeded_code() : u64 {
        60004
    }

    public fun deposit_already_retrieved_code() : u64 {
        60008
    }

    public fun duplicate_allowlist_code() : u64 {
        60102
    }

    public(friend) fun err_already_voted() {
        abort 60012
    }

    public(friend) fun err_assessment_deposit_not_exact() {
        abort 60007
    }

    public(friend) fun err_cant_buy_cover_and_claim_in_same_block() {
        abort 50004
    }

    public(friend) fun err_claim_is_being_assessed() {
        abort 60002
    }

    public(friend) fun err_claim_not_a_draw() {
        abort 60009
    }

    public(friend) fun err_claim_not_redeemable() {
        abort 60001
    }

    public(friend) fun err_claims_paused() {
        abort 60014
    }

    public(friend) fun err_cover_not_found() {
        abort 50003
    }

    public(friend) fun err_cover_not_yet_expired() {
        abort 50002
    }

    public(friend) fun err_covered_amount_exceeded() {
        abort 60004
    }

    public(friend) fun err_deposit_already_retrieved() {
        abort 60008
    }

    public(friend) fun err_duplicate_allowlist() {
        abort 60102
    }

    public(friend) fun err_grace_period_passed() {
        abort 60006
    }

    public(friend) fun err_group_already_exists() {
        abort 20005
    }

    public(friend) fun err_group_not_found() {
        abort 20000
    }

    public(friend) fun err_insufficient_capacity() {
        abort 50005
    }

    public(friend) fun err_insufficient_capital() {
        abort 30000
    }

    public(friend) fun err_insufficient_payment() {
        abort 50000
    }

    public(friend) fun err_insufficient_tranche_shares() {
        abort 40003
    }

    public(friend) fun err_invalid_amount() {
        abort 20004
    }

    public(friend) fun err_invalid_assessor() {
        abort 60013
    }

    public(friend) fun err_invalid_cap() {
        abort 60100
    }

    public(friend) fun err_invalid_claim_id() {
        abort 60000
    }

    public(friend) fun err_invalid_correlation_bps() {
        abort 20003
    }

    public(friend) fun err_invalid_exit_fee_bps() {
        abort 10006
    }

    public(friend) fun err_invalid_leverage_factor_bps() {
        abort 10003
    }

    public(friend) fun err_invalid_mcr_floor() {
        abort 10002
    }

    public(friend) fun err_invalid_min_capital_ratio_bps() {
        abort 10007
    }

    public(friend) fun err_invalid_premium_bump_ratio_bps() {
        abort 10009
    }

    public(friend) fun err_invalid_premium_change_per_day_bps() {
        abort 10010
    }

    public(friend) fun err_invalid_price_floor() {
        abort 10000
    }

    public(friend) fun err_invalid_protocol_fee_bps() {
        abort 10008
    }

    public(friend) fun err_invalid_ramm_initial_price() {
        abort 10011
    }

    public(friend) fun err_invalid_scaling_factor() {
        abort 10001
    }

    public(friend) fun err_no_access() {
        abort 60101
    }

    public(friend) fun err_not_cover_owner() {
        abort 60010
    }

    public(friend) fun err_not_voted() {
        abort 70002
    }

    public(friend) fun err_payout_can_still_be_redeemed() {
        abort 60003
    }

    public(friend) fun err_pool_paused() {
        abort 70001
    }

    public(friend) fun err_protocol_already_registered() {
        abort 20001
    }

    public(friend) fun err_protocol_not_found() {
        abort 20002
    }

    public(friend) fun err_protocol_pool_already_exists() {
        abort 40000
    }

    public(friend) fun err_protocol_pool_not_found() {
        abort 40001
    }

    public(friend) fun err_protocol_premium_not_configured() {
        abort 50001
    }

    public(friend) fun err_ramm_not_bootstrapped() {
        abort 30001
    }

    public(friend) fun err_tranche_not_expired() {
        abort 40002
    }

    public(friend) fun err_version_not_allowed() {
        abort 70003
    }

    public(friend) fun err_voting_period_ended() {
        abort 60011
    }

    public(friend) fun err_wrong_version() {
        abort 70000
    }

    public fun grace_period_passed_code() : u64 {
        60006
    }

    public fun invalid_assessor_code() : u64 {
        60013
    }

    public fun invalid_cap_code() : u64 {
        60100
    }

    public fun invalid_claim_id_code() : u64 {
        60000
    }

    public fun no_access_code() : u64 {
        60101
    }

    public fun not_cover_owner_code() : u64 {
        60010
    }

    public fun payout_can_still_be_redeemed_code() : u64 {
        60003
    }

    public fun voting_period_ended_code() : u64 {
        60011
    }

    // decompiled from Move bytecode v6
}

