module 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types {
    struct CommitmentParams has copy, drop, store {
        commitment_type: u8,
        reveal_after: u64,
        reveal_before: u64,
        required_bond: u64,
    }

    struct RevealedValue has copy, drop, store {
        value: vector<u8>,
        salt: vector<u8>,
        revealed_at: u64,
    }

    struct AuctionConfig has copy, drop, store {
        min_bid: u64,
        commitment_deadline: u64,
        reveal_deadline: u64,
        bid_bond: u64,
        allow_withdrawal: bool,
    }

    struct BundleParams has copy, drop, store {
        execute_at: u64,
        max_slippage: u64,
        expires_at: u64,
        atomic: bool,
    }

    public fun auction_status_cancelled() : u8 {
        3
    }

    public fun auction_status_complete() : u8 {
        2
    }

    public fun auction_status_open() : u8 {
        0
    }

    public fun auction_status_reveal() : u8 {
        1
    }

    public fun bundle_execute_at(arg0: &BundleParams) : u64 {
        arg0.execute_at
    }

    public fun bundle_expires_at(arg0: &BundleParams) : u64 {
        arg0.expires_at
    }

    public fun bundle_is_atomic(arg0: &BundleParams) : bool {
        arg0.atomic
    }

    public fun bundle_max_slippage(arg0: &BundleParams) : u64 {
        arg0.max_slippage
    }

    public fun bundle_status_executed() : u8 {
        2
    }

    public fun bundle_status_expired() : u8 {
        4
    }

    public fun bundle_status_failed() : u8 {
        3
    }

    public fun bundle_status_pending() : u8 {
        0
    }

    public fun bundle_status_ready() : u8 {
        1
    }

    public fun commitment_type_action() : u8 {
        1
    }

    public fun commitment_type_attestation() : u8 {
        3
    }

    public fun commitment_type_bid() : u8 {
        0
    }

    public fun commitment_type_message() : u8 {
        2
    }

    public fun config_bid_bond(arg0: &AuctionConfig) : u64 {
        arg0.bid_bond
    }

    public fun config_commitment_deadline(arg0: &AuctionConfig) : u64 {
        arg0.commitment_deadline
    }

    public fun config_min_bid(arg0: &AuctionConfig) : u64 {
        arg0.min_bid
    }

    public fun config_reveal_deadline(arg0: &AuctionConfig) : u64 {
        arg0.reveal_deadline
    }

    public fun default_bond_amount() : u64 {
        100000000
    }

    public fun default_reveal_window() : u64 {
        3600000
    }

    public fun is_auction_cancelled(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_auction_complete(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_auction_in_reveal(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_auction_open(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_bundle_executable(arg0: &BundleParams, arg1: u64) : bool {
        arg1 >= arg0.execute_at && arg1 < arg0.expires_at
    }

    public fun is_bundle_executed(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_bundle_expired(arg0: u8) : bool {
        arg0 == 4
    }

    public fun is_bundle_failed(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_bundle_params_expired(arg0: &BundleParams, arg1: u64) : bool {
        arg1 >= arg0.expires_at
    }

    public fun is_bundle_pending(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_bundle_ready(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_commitment_phase(arg0: &AuctionConfig, arg1: u64) : bool {
        arg1 < arg0.commitment_deadline
    }

    public fun is_finalized_phase(arg0: &AuctionConfig, arg1: u64) : bool {
        arg1 >= arg0.reveal_deadline
    }

    public fun is_reveal_phase(arg0: &AuctionConfig, arg1: u64) : bool {
        arg1 >= arg0.commitment_deadline && arg1 < arg0.reveal_deadline
    }

    public fun is_reveal_window_open(arg0: &CommitmentParams, arg1: u64) : bool {
        arg1 >= arg0.reveal_after && arg1 < arg0.reveal_before
    }

    public fun max_allowed_slippage() : u64 {
        1000
    }

    public fun min_commitment_duration() : u64 {
        300000
    }

    public fun new_auction_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : AuctionConfig {
        AuctionConfig{
            min_bid             : arg0,
            commitment_deadline : arg1,
            reveal_deadline     : arg2,
            bid_bond            : arg3,
            allow_withdrawal    : arg4,
        }
    }

    public fun new_bundle_params(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : BundleParams {
        BundleParams{
            execute_at   : arg0,
            max_slippage : arg1,
            expires_at   : arg2,
            atomic       : arg3,
        }
    }

    public fun new_commitment_params(arg0: u8, arg1: u64, arg2: u64, arg3: u64) : CommitmentParams {
        CommitmentParams{
            commitment_type : arg0,
            reveal_after    : arg1,
            reveal_before   : arg2,
            required_bond   : arg3,
        }
    }

    public fun new_revealed_value(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) : RevealedValue {
        RevealedValue{
            value       : arg0,
            salt        : arg1,
            revealed_at : arg2,
        }
    }

    public fun params_commitment_type(arg0: &CommitmentParams) : u8 {
        arg0.commitment_type
    }

    public fun params_required_bond(arg0: &CommitmentParams) : u64 {
        arg0.required_bond
    }

    public fun params_reveal_after(arg0: &CommitmentParams) : u64 {
        arg0.reveal_after
    }

    public fun params_reveal_before(arg0: &CommitmentParams) : u64 {
        arg0.reveal_before
    }

    public fun revealed_value_bytes(arg0: &RevealedValue) : &vector<u8> {
        &arg0.value
    }

    public fun revealed_value_salt(arg0: &RevealedValue) : &vector<u8> {
        &arg0.salt
    }

    // decompiled from Move bytecode v6
}

