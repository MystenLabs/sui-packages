module 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types {
    struct GovernanceParams has copy, drop, store {
        decision_threshold: u16,
        emergency_threshold: u16,
        proposal_bond: u64,
        voting_period: u64,
        execution_delay: u64,
    }

    struct TreasuryConfig has copy, drop, store {
        daily_spending_limit: u64,
        single_tx_limit: u64,
        large_tx_threshold: u64,
        auto_distribute: bool,
    }

    struct BlsKeyInfo has copy, drop, store {
        public_key_share: vector<u8>,
        share_index: u64,
        verification_proof: vector<u8>,
    }

    struct Vote has copy, drop, store {
        support: bool,
        weight: u64,
        reason: vector<u8>,
        voted_at: u64,
    }

    public fun basis_points_100() : u16 {
        10000
    }

    public fun bls_public_key_share(arg0: &BlsKeyInfo) : &vector<u8> {
        &arg0.public_key_share
    }

    public fun bls_share_index(arg0: &BlsKeyInfo) : u64 {
        arg0.share_index
    }

    public fun config_daily_limit(arg0: &TreasuryConfig) : u64 {
        arg0.daily_spending_limit
    }

    public fun config_large_tx_threshold(arg0: &TreasuryConfig) : u64 {
        arg0.large_tx_threshold
    }

    public fun config_single_tx_limit(arg0: &TreasuryConfig) : u64 {
        arg0.single_tx_limit
    }

    public fun default_governance_params() : GovernanceParams {
        GovernanceParams{
            decision_threshold  : 5000,
            emergency_threshold : 7500,
            proposal_bond       : 1000000000,
            voting_period       : 86400000,
            execution_delay     : 3600000,
        }
    }

    public fun default_member_weight() : u64 {
        100
    }

    public fun default_treasury_config() : TreasuryConfig {
        TreasuryConfig{
            daily_spending_limit : 100000000000,
            single_tx_limit      : 10000000000,
            large_tx_threshold   : 50000000000,
            auto_distribute      : false,
        }
    }

    public fun is_member_active(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_member_left(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_member_pending(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_member_suspended(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_proposal_active(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_proposal_cancelled(arg0: u8) : bool {
        arg0 == 4
    }

    public fun is_proposal_executed(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_proposal_failed(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_proposal_passed(arg0: u8) : bool {
        arg0 == 1
    }

    public fun max_hive_members() : u64 {
        1000
    }

    public fun member_status_active() : u8 {
        0
    }

    public fun member_status_left() : u8 {
        3
    }

    public fun member_status_pending() : u8 {
        1
    }

    public fun member_status_suspended() : u8 {
        2
    }

    public fun min_decision_threshold() : u16 {
        1000
    }

    public fun min_hive_members() : u64 {
        2
    }

    public fun new_bls_key_info(arg0: vector<u8>, arg1: u64, arg2: vector<u8>) : BlsKeyInfo {
        BlsKeyInfo{
            public_key_share   : arg0,
            share_index        : arg1,
            verification_proof : arg2,
        }
    }

    public fun new_governance_params(arg0: u16, arg1: u16, arg2: u64, arg3: u64, arg4: u64) : GovernanceParams {
        GovernanceParams{
            decision_threshold  : arg0,
            emergency_threshold : arg1,
            proposal_bond       : arg2,
            voting_period       : arg3,
            execution_delay     : arg4,
        }
    }

    public fun new_treasury_config(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : TreasuryConfig {
        TreasuryConfig{
            daily_spending_limit : arg0,
            single_tx_limit      : arg1,
            large_tx_threshold   : arg2,
            auto_distribute      : arg3,
        }
    }

    public fun new_vote(arg0: bool, arg1: u64, arg2: vector<u8>, arg3: u64) : Vote {
        Vote{
            support  : arg0,
            weight   : arg1,
            reason   : arg2,
            voted_at : arg3,
        }
    }

    public fun params_decision_threshold(arg0: &GovernanceParams) : u16 {
        arg0.decision_threshold
    }

    public fun params_emergency_threshold(arg0: &GovernanceParams) : u16 {
        arg0.emergency_threshold
    }

    public fun params_execution_delay(arg0: &GovernanceParams) : u64 {
        arg0.execution_delay
    }

    public fun params_proposal_bond(arg0: &GovernanceParams) : u64 {
        arg0.proposal_bond
    }

    public fun params_voting_period(arg0: &GovernanceParams) : u64 {
        arg0.voting_period
    }

    public fun proposal_status_active() : u8 {
        0
    }

    public fun proposal_status_cancelled() : u8 {
        4
    }

    public fun proposal_status_executed() : u8 {
        3
    }

    public fun proposal_status_failed() : u8 {
        2
    }

    public fun proposal_status_passed() : u8 {
        1
    }

    public fun proposal_type_admit() : u8 {
        2
    }

    public fun proposal_type_emergency() : u8 {
        5
    }

    public fun proposal_type_expel() : u8 {
        3
    }

    public fun proposal_type_parameter() : u8 {
        4
    }

    public fun proposal_type_sign() : u8 {
        1
    }

    public fun proposal_type_spend() : u8 {
        0
    }

    public fun vote_support(arg0: &Vote) : bool {
        arg0.support
    }

    public fun vote_weight(arg0: &Vote) : u64 {
        arg0.weight
    }

    // decompiled from Move bytecode v6
}

