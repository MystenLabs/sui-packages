module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::claims {
    struct ClaimEvidence has copy, drop, store {
        blob_id: 0x2::object::ID,
        seal_id: 0x1::string::String,
    }

    struct Claim has copy, drop, store {
        cover_id: u64,
        amount: u64,
        evidence: ClaimEvidence,
        payout_redemption_period_sec: u64,
        payout_redeemed: bool,
        deposit_retrieved: bool,
    }

    struct Assessment has copy, drop, store {
        voting_end_sec: u64,
        cooldown_period_sec: u64,
        accept_votes: u64,
        deny_votes: u64,
        voters: vector<address>,
    }

    struct ClaimsVault has key {
        id: 0x2::object::UID,
        next_claim_id: u64,
        claims: 0x2::table::Table<u64, Claim>,
        assessments: 0x2::table::Table<u64, Assessment>,
        last_claim_on_cover: 0x2::table::Table<u64, u64>,
        next_fast_track_id: u64,
        fast_tracks: 0x2::table::Table<u64, FastTrack>,
    }

    struct FastTrack has drop, store {
        protocol_id: vector<u8>,
        merkle_root: vector<u8>,
        published_at_sec: u64,
        challenge_period_sec: u64,
        vetoed: bool,
    }

    struct SubmitClaimEvent has copy, drop {
        sender: address,
        claim_id: u64,
        cover_id: u64,
        protocol_id: vector<u8>,
        requested_amount: u64,
        evidence_blob_id: 0x2::object::ID,
    }

    struct CastVoteEvent has copy, drop {
        sender: address,
        claim_id: u64,
        vote_accept: bool,
    }

    struct RedeemClaimPayoutEvent has copy, drop {
        sender: address,
        claim_id: u64,
        cover_id: u64,
        amount: u64,
    }

    struct RetrieveDepositEvent has copy, drop {
        sender: address,
        claim_id: u64,
        deposit_amount: u64,
    }

    struct PublishFastTrackEvent has copy, drop {
        fast_track_id: u64,
        protocol_id: vector<u8>,
        merkle_root: vector<u8>,
        published_at_sec: u64,
        challenge_period_sec: u64,
    }

    struct RedeemFastTrackEvent has copy, drop {
        sender: address,
        fast_track_id: u64,
        cover_id: u64,
        amount: u64,
    }

    fun assessment_accept_votes(arg0: &Assessment) : u64 {
        arg0.accept_votes
    }

    fun assessment_cooldown_period_sec(arg0: &Assessment) : u64 {
        arg0.cooldown_period_sec
    }

    fun assessment_deny_votes(arg0: &Assessment) : u64 {
        arg0.deny_votes
    }

    fun assessment_mut_accept_votes(arg0: &mut Assessment) : &mut u64 {
        &mut arg0.accept_votes
    }

    fun assessment_mut_deny_votes(arg0: &mut Assessment) : &mut u64 {
        &mut arg0.deny_votes
    }

    fun assessment_mut_voters(arg0: &mut Assessment) : &mut vector<address> {
        &mut arg0.voters
    }

    fun assessment_outcome(arg0: &Assessment, arg1: u64, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::Allowlist, arg3: vector<u8>) : u8 {
        if (arg1 <= assessment_voting_end_sec(arg0) + assessment_cooldown_period_sec(arg0)) {
            return 0
        };
        let v0 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::assessor_count(arg2, arg3);
        if (v0 > 0 && 0x1::vector::length<address>(assessment_voters(arg0)) >= v0) {
            if (assessment_accept_votes(arg0) > assessment_deny_votes(arg0)) {
                return 1
            };
            if (assessment_deny_votes(arg0) > assessment_accept_votes(arg0)) {
                return 2
            };
            return 3
        };
        if (assessment_accept_votes(arg0) > assessment_deny_votes(arg0)) {
            return 1
        };
        if (assessment_deny_votes(arg0) > assessment_accept_votes(arg0)) {
            return 2
        };
        3
    }

    fun assessment_voters(arg0: &Assessment) : &vector<address> {
        &arg0.voters
    }

    fun assessment_voting_end_sec(arg0: &Assessment) : u64 {
        arg0.voting_end_sec
    }

    entry fun cast_vote(arg0: &mut ClaimsVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverVault, arg3: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::Allowlist, arg4: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claims_paused(arg4)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_claims_paused();
        };
        if (!0x2::table::contains<u64, Claim>(&arg0.claims, arg5)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_claim_id();
        };
        let v0 = claim_cover_id(0x2::table::borrow<u64, Claim>(&arg0.claims, arg5));
        if (!0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_contains_cover(arg2, v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_cover_not_found();
        };
        let v1 = 0x2::table::borrow_mut<u64, Assessment>(&mut arg0.assessments, arg5);
        if (0x2::clock::timestamp_ms(arg7) / 1000 >= assessment_voting_end_sec(v1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_voting_period_ended();
        };
        let v2 = 0x2::tx_context::sender(arg8);
        if (!0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::contains(arg3, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_protocol_id(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_borrow_cover(arg2, v0)), v2)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_assessor();
        };
        if (voter_has_voted(v1, v2)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_already_voted();
        };
        let v3 = assessment_mut_voters(v1);
        0x1::vector::push_back<address>(v3, v2);
        if (arg6) {
            let v4 = assessment_accept_votes(v1) + 1;
            *assessment_mut_accept_votes(v1) = v4;
        } else {
            let v5 = assessment_deny_votes(v1) + 1;
            *assessment_mut_deny_votes(v1) = v5;
        };
        let v6 = CastVoteEvent{
            sender      : v2,
            claim_id    : arg5,
            vote_accept : arg6,
        };
        0x2::event::emit<CastVoteEvent>(v6);
    }

    public fun claim_amount(arg0: &Claim) : u64 {
        arg0.amount
    }

    public fun claim_cover_id(arg0: &Claim) : u64 {
        arg0.cover_id
    }

    public fun claim_deposit_retrieved(arg0: &Claim) : bool {
        arg0.deposit_retrieved
    }

    fun claim_evidence_new(arg0: 0x2::object::ID, arg1: 0x1::string::String) : ClaimEvidence {
        ClaimEvidence{
            blob_id : arg0,
            seal_id : arg1,
        }
    }

    public fun claim_payout_redeemed(arg0: &Claim) : bool {
        arg0.payout_redeemed
    }

    fun claim_payout_redemption_period_sec(arg0: &Claim) : u64 {
        arg0.payout_redemption_period_sec
    }

    public fun get_assessment(arg0: &ClaimsVault, arg1: u64) : 0x1::option::Option<Assessment> {
        if (0x2::table::contains<u64, Assessment>(&arg0.assessments, arg1)) {
            0x1::option::some<Assessment>(*0x2::table::borrow<u64, Assessment>(&arg0.assessments, arg1))
        } else {
            0x1::option::none<Assessment>()
        }
    }

    public fun get_claim(arg0: &ClaimsVault, arg1: u64) : 0x1::option::Option<Claim> {
        if (0x2::table::contains<u64, Claim>(&arg0.claims, arg1)) {
            0x1::option::some<Claim>(*0x2::table::borrow<u64, Claim>(&arg0.claims, arg1))
        } else {
            0x1::option::none<Claim>()
        }
    }

    public fun get_claim_outcome(arg0: &ClaimsVault, arg1: u64, arg2: u64, arg3: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverVault, arg4: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::Allowlist) : u8 {
        if (!0x2::table::contains<u64, Assessment>(&arg0.assessments, arg1)) {
            return 0
        };
        let v0 = claim_cover_id(0x2::table::borrow<u64, Claim>(&arg0.claims, arg1));
        if (!0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_contains_cover(arg3, v0)) {
            return 0
        };
        assessment_outcome(0x2::table::borrow<u64, Assessment>(&arg0.assessments, arg1), arg2, arg4, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_protocol_id(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_borrow_cover(arg3, v0)))
    }

    public fun get_last_claim_on_cover(arg0: &ClaimsVault, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, u64>(&arg0.last_claim_on_cover, arg1)) {
            return 0
        };
        *0x2::table::borrow<u64, u64>(&arg0.last_claim_on_cover, arg1)
    }

    public fun has_assessor_voted(arg0: &ClaimsVault, arg1: u64, arg2: address) : bool {
        if (!0x2::table::contains<u64, Assessment>(&arg0.assessments, arg1)) {
            return false
        };
        voter_has_voted(0x2::table::borrow<u64, Assessment>(&arg0.assessments, arg1), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimsVault{
            id                  : 0x2::object::new(arg0),
            next_claim_id       : 1,
            claims              : 0x2::table::new<u64, Claim>(arg0),
            assessments         : 0x2::table::new<u64, Assessment>(arg0),
            last_claim_on_cover : 0x2::table::new<u64, u64>(arg0),
            next_fast_track_id  : 1,
            fast_tracks         : 0x2::table::new<u64, FastTrack>(arg0),
        };
        0x2::transfer::share_object<ClaimsVault>(v0);
    }

    fun is_claim_redeemable(arg0: &Claim, arg1: &Assessment, arg2: u64, arg3: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::Allowlist, arg4: vector<u8>) : bool {
        if (assessment_outcome(arg1, arg2, arg3, arg4) != 1) {
            return false
        };
        if (claim_payout_redeemed(arg0)) {
            return false
        };
        arg2 < assessment_voting_end_sec(arg1) + assessment_cooldown_period_sec(arg1) + claim_payout_redemption_period_sec(arg0)
    }

    public fun next_claim_id(arg0: &ClaimsVault) : u64 {
        arg0.next_claim_id
    }

    entry fun publish_fast_track_root(arg0: &mut ClaimsVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::Allowlist, arg3: 0x1::string::String, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        let v0 = *0x1::string::as_bytes(&arg3);
        if (!0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::contains(arg2, v0, 0x2::tx_context::sender(arg7))) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_assessor();
        };
        let v1 = arg0.next_fast_track_id;
        arg0.next_fast_track_id = v1 + 1;
        let v2 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v3 = FastTrack{
            protocol_id          : v0,
            merkle_root          : arg4,
            published_at_sec     : v2,
            challenge_period_sec : arg5,
            vetoed               : false,
        };
        0x2::table::add<u64, FastTrack>(&mut arg0.fast_tracks, v1, v3);
        let v4 = PublishFastTrackEvent{
            fast_track_id        : v1,
            protocol_id          : v0,
            merkle_root          : arg4,
            published_at_sec     : v2,
            challenge_period_sec : arg5,
        };
        0x2::event::emit<PublishFastTrackEvent>(v4);
    }

    public fun redeem_claim_payout(arg0: &mut ClaimsVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverVault, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::CapitalPool, arg4: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg5: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool::StakingRegistry, arg6: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg7: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::Allowlist, arg8: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverReceipt, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI> {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claims_paused(arg6)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_claims_paused();
        };
        if (!0x2::table::contains<u64, Claim>(&arg0.claims, arg9)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_claim_id();
        };
        let v0 = 0x2::table::borrow_mut<u64, Claim>(&mut arg0.claims, arg9);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_receipt_cover_id(arg8) != claim_cover_id(v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_not_cover_owner();
        };
        let v1 = claim_cover_id(v0);
        if (!is_claim_redeemable(v0, 0x2::table::borrow<u64, Assessment>(&arg0.assessments, arg9), 0x2::clock::timestamp_ms(arg10) / 1000, arg7, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_protocol_id(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_borrow_cover(arg2, v1)))) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_claim_not_redeemable();
        };
        v0.payout_redeemed = true;
        v0.deposit_retrieved = true;
        let v2 = claim_amount(v0);
        let v3 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_protocol_id(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_borrow_cover(arg2, v1));
        let (v4, _, _, _) = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::get_protocol_status(arg4, v3);
        let v8 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool::get_pool_total_eva(arg5, v3);
        let v9 = if (v4 == 0) {
            0
        } else {
            let v10 = (v2 as u128) * (v8 as u128) / (v4 as u128);
            if (v10 > (v8 as u128)) {
                v8
            } else {
                (v10 as u64)
            }
        };
        if (v9 > 0) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::burn_eva_balance(arg3, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool::remove_eva_for_claim(arg5, v3, v9, arg4));
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::burn_cover_for_claim(arg2, v1, v2, arg4);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::calculate_and_update_mcr(arg4);
        let v11 = RedeemClaimPayoutEvent{
            sender   : 0x2::tx_context::sender(arg11),
            claim_id : arg9,
            cover_id : v1,
            amount   : v2,
        };
        0x2::event::emit<RedeemClaimPayoutEvent>(v11);
        0x2::coin::from_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::send_claim_payout(arg3, v2, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claim_deposit_mist(arg6), arg10), arg11)
    }

    public fun redeem_fast_track_payout(arg0: &mut ClaimsVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverVault, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::CapitalPool, arg4: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg5: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool::StakingRegistry, arg6: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg7: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverReceipt, arg8: u64, arg9: u64, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI> {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claims_paused(arg6)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_claims_paused();
        };
        if (!0x2::table::contains<u64, FastTrack>(&arg0.fast_tracks, arg8)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_claim_id();
        };
        let v0 = 0x2::table::borrow<u64, FastTrack>(&arg0.fast_tracks, arg8);
        if (v0.vetoed) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_claims_paused();
        };
        if (0x2::clock::timestamp_ms(arg11) / 1000 < v0.published_at_sec + v0.challenge_period_sec) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_voting_period_ended();
        };
        let v1 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_receipt_cover_id(arg7);
        let v2 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_protocol_id(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_borrow_cover(arg2, v1));
        if (v2 != v0.protocol_id) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_amount();
        };
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x2::tx_context::sender(arg12);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg9));
        if (!0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::merkle_proof::verify(&arg10, &v0.merkle_root, 0x2::hash::keccak256(&v3))) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_assessor();
        };
        if (0x2::table::contains<u64, u64>(&arg0.last_claim_on_cover, v1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_payout_can_still_be_redeemed();
        };
        0x2::table::add<u64, u64>(&mut arg0.last_claim_on_cover, v1, arg8);
        let (v5, _, _, _) = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::get_protocol_status(arg4, v2);
        let v9 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool::get_pool_total_eva(arg5, v2);
        let v10 = if (v5 == 0) {
            0
        } else {
            let v11 = (arg9 as u128) * (v9 as u128) / (v5 as u128);
            if (v11 > (v9 as u128)) {
                v9
            } else {
                (v11 as u64)
            }
        };
        if (v10 > 0) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::burn_eva_balance(arg3, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool::remove_eva_for_claim(arg5, v2, v10, arg4));
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::burn_cover_for_claim(arg2, v1, arg9, arg4);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::calculate_and_update_mcr(arg4);
        let v12 = RedeemFastTrackEvent{
            sender        : 0x2::tx_context::sender(arg12),
            fast_track_id : arg8,
            cover_id      : v1,
            amount        : arg9,
        };
        0x2::event::emit<RedeemFastTrackEvent>(v12);
        0x2::coin::from_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::send_claim_payout(arg3, arg9, 0, arg11), arg12)
    }

    public fun retrieve_deposit(arg0: &mut ClaimsVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverVault, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::CapitalPool, arg4: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg5: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::Allowlist, arg6: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverReceipt, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI> {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claims_paused(arg4)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_claims_paused();
        };
        if (!0x2::table::contains<u64, Claim>(&arg0.claims, arg7)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_claim_id();
        };
        let v0 = 0x2::table::borrow_mut<u64, Claim>(&mut arg0.claims, arg7);
        let v1 = claim_cover_id(v0);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_receipt_cover_id(arg6) != v1) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_not_cover_owner();
        };
        if (assessment_outcome(0x2::table::borrow<u64, Assessment>(&arg0.assessments, arg7), 0x2::clock::timestamp_ms(arg8) / 1000, arg5, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_protocol_id(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_borrow_cover(arg2, v1))) != 3) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_claim_not_a_draw();
        };
        if (claim_deposit_retrieved(v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_deposit_already_retrieved();
        };
        v0.deposit_retrieved = true;
        let v2 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claim_deposit_mist(arg4);
        let v3 = RetrieveDepositEvent{
            sender         : 0x2::tx_context::sender(arg9),
            claim_id       : arg7,
            deposit_amount : v2,
        };
        0x2::event::emit<RetrieveDepositEvent>(v3);
        0x2::coin::from_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::send_claim_payout(arg3, 0, v2, arg8), arg9)
    }

    entry fun submit_claim(arg0: &mut ClaimsVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverVault, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::CapitalPool, arg4: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg5: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg6: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist::Allowlist, arg7: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::CoverReceipt, arg8: u64, arg9: 0x2::object::ID, arg10: 0x1::string::String, arg11: 0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claims_paused(arg5)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_claims_paused();
        };
        let v0 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_receipt_cover_id(arg7);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_receipt_amount(arg7) < arg8) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_covered_amount_exceeded();
        };
        let v1 = 0x2::clock::timestamp_ms(arg12);
        let v2 = v1 / 1000;
        if (!0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_contains_cover(arg2, v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_cover_not_found();
        };
        let v3 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::vault_borrow_cover(arg2, v0);
        if (v1 <= 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_start_at(v3)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_cant_buy_cover_and_claim_in_same_block();
        };
        if (arg8 > 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_remaining_capacity(v3)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_covered_amount_exceeded();
        };
        if (v1 >= 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_expire_at(v3)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_grace_period_passed();
        };
        if (0x2::coin::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&arg11) != 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claim_deposit_mist(arg5)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_assessment_deposit_not_exact();
        };
        if (0x2::table::contains<u64, u64>(&arg0.last_claim_on_cover, v0)) {
            let v4 = *0x2::table::borrow<u64, u64>(&arg0.last_claim_on_cover, v0);
            let v5 = 0x2::table::borrow<u64, Assessment>(&arg0.assessments, v4);
            let v6 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_protocol_id(v3);
            if (assessment_outcome(v5, v2, arg6, v6) == 0) {
                0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_claim_is_being_assessed();
            };
            if (is_claim_redeemable(0x2::table::borrow<u64, Claim>(&arg0.claims, v4), v5, v2, arg6, v6)) {
                0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_payout_can_still_be_redeemed();
            };
        };
        let v7 = arg0.next_claim_id;
        arg0.next_claim_id = v7 + 1;
        let v8 = Claim{
            cover_id                     : v0,
            amount                       : arg8,
            evidence                     : claim_evidence_new(arg9, arg10),
            payout_redemption_period_sec : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claim_payout_redemption_period_sec(arg5),
            payout_redeemed              : false,
            deposit_retrieved            : false,
        };
        0x2::table::add<u64, Claim>(&mut arg0.claims, v7, v8);
        let v9 = Assessment{
            voting_end_sec      : v2 + 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claim_voting_period_sec(arg5),
            cooldown_period_sec : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::claim_cooldown_period_sec(arg5),
            accept_votes        : 0,
            deny_votes          : 0,
            voters              : 0x1::vector::empty<address>(),
        };
        0x2::table::add<u64, Assessment>(&mut arg0.assessments, v7, v9);
        0x2::table::add<u64, u64>(&mut arg0.last_claim_on_cover, v0, v7);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::add_reserve(arg3, 0x2::coin::into_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(arg11));
        let v10 = SubmitClaimEvent{
            sender           : 0x2::tx_context::sender(arg13),
            claim_id         : v7,
            cover_id         : v0,
            protocol_id      : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover::cover_protocol_id(v3),
            requested_amount : arg8,
            evidence_blob_id : arg9,
        };
        0x2::event::emit<SubmitClaimEvent>(v10);
    }

    entry fun undo_vote(arg0: &mut ClaimsVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64, arg4: address, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (!0x2::table::contains<u64, Claim>(&arg0.claims, arg3)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_claim_id();
        };
        let v0 = 0x2::table::borrow_mut<u64, Assessment>(&mut arg0.assessments, arg3);
        if (0x2::clock::timestamp_ms(arg6) / 1000 >= assessment_voting_end_sec(v0) + assessment_cooldown_period_sec(v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_voting_period_ended();
        };
        if (!voter_has_voted(v0, arg4)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_not_voted();
        };
        if (arg5) {
            if (assessment_accept_votes(v0) > 0) {
                let v1 = assessment_accept_votes(v0) - 1;
                let v2 = assessment_mut_accept_votes(v0);
                *v2 = v1;
            };
        } else if (assessment_deny_votes(v0) > 0) {
            let v3 = assessment_deny_votes(v0) - 1;
            let v4 = assessment_mut_deny_votes(v0);
            *v4 = v3;
        };
        let v5 = 0;
        let v6 = 0x1::vector::length<address>(assessment_voters(v0));
        let v7 = assessment_mut_voters(v0);
        while (v5 < v6) {
            if (*0x1::vector::borrow<address>(v7, v5) == arg4) {
                0x1::vector::remove<address>(v7, v5);
                break
            };
            v5 = v5 + 1;
        };
    }

    entry fun veto_fast_track(arg0: &mut ClaimsVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (!0x2::table::contains<u64, FastTrack>(&arg0.fast_tracks, arg3)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_claim_id();
        };
        0x2::table::borrow_mut<u64, FastTrack>(&mut arg0.fast_tracks, arg3).vetoed = true;
    }

    fun voter_has_voted(arg0: &Assessment, arg1: address) : bool {
        let v0 = assessment_voters(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg1) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

