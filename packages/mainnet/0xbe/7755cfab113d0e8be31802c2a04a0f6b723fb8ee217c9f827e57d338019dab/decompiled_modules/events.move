module 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events {
    struct CommitmentMade has copy, drop {
        commitment_id: 0x2::object::ID,
        committer: address,
        commitment_type: u8,
        commitment_hash: vector<u8>,
        reveal_after: u64,
        reveal_before: u64,
        bond_amount: u64,
        committed_at: u64,
    }

    struct CommitmentRevealed has copy, drop {
        commitment_id: 0x2::object::ID,
        committer: address,
        value_hash: vector<u8>,
        revealed_at: u64,
    }

    struct CommitmentExecuted has copy, drop {
        commitment_id: 0x2::object::ID,
        committer: address,
        executed_at: u64,
    }

    struct CommitmentBondForfeited has copy, drop {
        commitment_id: 0x2::object::ID,
        committer: address,
        bond_amount: u64,
        reason: vector<u8>,
        forfeited_at: u64,
    }

    struct CommitmentBondReturned has copy, drop {
        commitment_id: 0x2::object::ID,
        committer: address,
        bond_amount: u64,
        returned_at: u64,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        creator: address,
        item: vector<u8>,
        min_bid: u64,
        commitment_deadline: u64,
        reveal_deadline: u64,
        created_at: u64,
    }

    struct BidCommitted has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        commitment_hash: vector<u8>,
        bond_amount: u64,
        committed_at: u64,
    }

    struct BidRevealed has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        bid_amount: u64,
        revealed_at: u64,
    }

    struct AuctionRevealPhaseStarted has copy, drop {
        auction_id: 0x2::object::ID,
        total_bids: u64,
        started_at: u64,
    }

    struct AuctionFinalized has copy, drop {
        auction_id: 0x2::object::ID,
        winner: 0x1::option::Option<address>,
        winning_bid: 0x1::option::Option<u64>,
        total_bids: u64,
        revealed_bids: u64,
        finalized_at: u64,
    }

    struct AuctionCancelled has copy, drop {
        auction_id: 0x2::object::ID,
        cancelled_by: address,
        reason: vector<u8>,
        cancelled_at: u64,
    }

    struct BidWithdrawn has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        withdrawn_at: u64,
    }

    struct BundleSubmitted has copy, drop {
        bundle_id: 0x2::object::ID,
        submitter: address,
        action_count: u64,
        execute_at: u64,
        bond_amount: u64,
        submitted_at: u64,
    }

    struct BundleDecrypted has copy, drop {
        bundle_id: 0x2::object::ID,
        decrypted_at: u64,
    }

    struct BundleExecuted has copy, drop {
        bundle_id: 0x2::object::ID,
        submitter: address,
        actions_executed: u64,
        total_value: u64,
        executed_at: u64,
    }

    struct BundleExecutionFailed has copy, drop {
        bundle_id: 0x2::object::ID,
        reason: vector<u8>,
        failed_at: u64,
    }

    struct BundleExpired has copy, drop {
        bundle_id: 0x2::object::ID,
        expired_at: u64,
    }

    public fun emit_auction_cancelled(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = AuctionCancelled{
            auction_id   : arg0,
            cancelled_by : arg1,
            reason       : arg2,
            cancelled_at : arg3,
        };
        0x2::event::emit<AuctionCancelled>(v0);
    }

    public fun emit_auction_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = AuctionCreated{
            auction_id          : arg0,
            creator             : arg1,
            item                : arg2,
            min_bid             : arg3,
            commitment_deadline : arg4,
            reveal_deadline     : arg5,
            created_at          : arg6,
        };
        0x2::event::emit<AuctionCreated>(v0);
    }

    public fun emit_auction_finalized(arg0: 0x2::object::ID, arg1: 0x1::option::Option<address>, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = AuctionFinalized{
            auction_id    : arg0,
            winner        : arg1,
            winning_bid   : arg2,
            total_bids    : arg3,
            revealed_bids : arg4,
            finalized_at  : arg5,
        };
        0x2::event::emit<AuctionFinalized>(v0);
    }

    public fun emit_auction_reveal_phase_started(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = AuctionRevealPhaseStarted{
            auction_id : arg0,
            total_bids : arg1,
            started_at : arg2,
        };
        0x2::event::emit<AuctionRevealPhaseStarted>(v0);
    }

    public fun emit_bid_committed(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64) {
        let v0 = BidCommitted{
            auction_id      : arg0,
            bidder          : arg1,
            commitment_hash : arg2,
            bond_amount     : arg3,
            committed_at    : arg4,
        };
        0x2::event::emit<BidCommitted>(v0);
    }

    public fun emit_bid_revealed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = BidRevealed{
            auction_id  : arg0,
            bidder      : arg1,
            bid_amount  : arg2,
            revealed_at : arg3,
        };
        0x2::event::emit<BidRevealed>(v0);
    }

    public fun emit_bid_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = BidWithdrawn{
            auction_id   : arg0,
            bidder       : arg1,
            amount       : arg2,
            withdrawn_at : arg3,
        };
        0x2::event::emit<BidWithdrawn>(v0);
    }

    public fun emit_bundle_decrypted(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = BundleDecrypted{
            bundle_id    : arg0,
            decrypted_at : arg1,
        };
        0x2::event::emit<BundleDecrypted>(v0);
    }

    public fun emit_bundle_executed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BundleExecuted{
            bundle_id        : arg0,
            submitter        : arg1,
            actions_executed : arg2,
            total_value      : arg3,
            executed_at      : arg4,
        };
        0x2::event::emit<BundleExecuted>(v0);
    }

    public fun emit_bundle_execution_failed(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = BundleExecutionFailed{
            bundle_id : arg0,
            reason    : arg1,
            failed_at : arg2,
        };
        0x2::event::emit<BundleExecutionFailed>(v0);
    }

    public fun emit_bundle_expired(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = BundleExpired{
            bundle_id  : arg0,
            expired_at : arg1,
        };
        0x2::event::emit<BundleExpired>(v0);
    }

    public fun emit_bundle_submitted(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = BundleSubmitted{
            bundle_id    : arg0,
            submitter    : arg1,
            action_count : arg2,
            execute_at   : arg3,
            bond_amount  : arg4,
            submitted_at : arg5,
        };
        0x2::event::emit<BundleSubmitted>(v0);
    }

    public fun emit_commitment_bond_forfeited(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u64) {
        let v0 = CommitmentBondForfeited{
            commitment_id : arg0,
            committer     : arg1,
            bond_amount   : arg2,
            reason        : arg3,
            forfeited_at  : arg4,
        };
        0x2::event::emit<CommitmentBondForfeited>(v0);
    }

    public fun emit_commitment_bond_returned(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = CommitmentBondReturned{
            commitment_id : arg0,
            committer     : arg1,
            bond_amount   : arg2,
            returned_at   : arg3,
        };
        0x2::event::emit<CommitmentBondReturned>(v0);
    }

    public fun emit_commitment_executed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = CommitmentExecuted{
            commitment_id : arg0,
            committer     : arg1,
            executed_at   : arg2,
        };
        0x2::event::emit<CommitmentExecuted>(v0);
    }

    public fun emit_commitment_made(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = CommitmentMade{
            commitment_id   : arg0,
            committer       : arg1,
            commitment_type : arg2,
            commitment_hash : arg3,
            reveal_after    : arg4,
            reveal_before   : arg5,
            bond_amount     : arg6,
            committed_at    : arg7,
        };
        0x2::event::emit<CommitmentMade>(v0);
    }

    public fun emit_commitment_revealed(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = CommitmentRevealed{
            commitment_id : arg0,
            committer     : arg1,
            value_hash    : arg2,
            revealed_at   : arg3,
        };
        0x2::event::emit<CommitmentRevealed>(v0);
    }

    // decompiled from Move bytecode v6
}

