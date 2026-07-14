module 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events {
    struct ProposalCreated has copy, drop {
        proposal: 0x2::object::ID,
        proposer: address,
        kind: u8,
    }

    struct ProposalApproved has copy, drop {
        proposal: 0x2::object::ID,
        signer: address,
        count: u64,
    }

    struct MintExecuted has copy, drop {
        batch_no: u64,
        total_nft: u64,
    }

    struct Distributed has copy, drop {
        nft: 0x2::object::ID,
        recipient: address,
        denom: u8,
    }

    struct Purchased has copy, drop {
        nft: 0x2::object::ID,
        buyer: address,
        denom: u8,
        price: u64,
    }

    struct Burned has copy, drop {
        nft: 0x2::object::ID,
        depositor: address,
    }

    struct RedemptionDeposited has copy, drop {
        nft: 0x2::object::ID,
        depositor: address,
    }

    struct RedemptionReturned has copy, drop {
        nft: 0x2::object::ID,
        depositor: address,
    }

    struct Paused has copy, drop {
        dummy_field: bool,
    }

    struct Unpaused has copy, drop {
        dummy_field: bool,
    }

    struct Blacklisted has copy, drop {
        addr: address,
    }

    struct Unblacklisted has copy, drop {
        addr: address,
    }

    struct LimitChanged has copy, drop {
        max_per_tx: u64,
        max_per_day: u64,
        max_redeem_per_day: u64,
    }

    struct RateChanged has copy, drop {
        mg_per_token: u64,
    }

    struct RoleChanged has copy, drop {
        kind: u8,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        to: address,
    }

    struct Migrated has copy, drop {
        version: u64,
    }

    struct DisplayFieldSet has copy, drop {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    public(friend) fun blacklisted(arg0: address) {
        let v0 = Blacklisted{addr: arg0};
        0x2::event::emit<Blacklisted>(v0);
    }

    public(friend) fun burned(arg0: 0x2::object::ID, arg1: address) {
        let v0 = Burned{
            nft       : arg0,
            depositor : arg1,
        };
        0x2::event::emit<Burned>(v0);
    }

    public(friend) fun display_field_set(arg0: 0x1::string::String, arg1: 0x1::string::String) {
        let v0 = DisplayFieldSet{
            key   : arg0,
            value : arg1,
        };
        0x2::event::emit<DisplayFieldSet>(v0);
    }

    public(friend) fun distributed(arg0: 0x2::object::ID, arg1: address, arg2: u8) {
        let v0 = Distributed{
            nft       : arg0,
            recipient : arg1,
            denom     : arg2,
        };
        0x2::event::emit<Distributed>(v0);
    }

    public(friend) fun limit_changed(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = LimitChanged{
            max_per_tx         : arg0,
            max_per_day        : arg1,
            max_redeem_per_day : arg2,
        };
        0x2::event::emit<LimitChanged>(v0);
    }

    public(friend) fun migrated(arg0: u64) {
        let v0 = Migrated{version: arg0};
        0x2::event::emit<Migrated>(v0);
    }

    public(friend) fun mint_executed(arg0: u64, arg1: u64) {
        let v0 = MintExecuted{
            batch_no  : arg0,
            total_nft : arg1,
        };
        0x2::event::emit<MintExecuted>(v0);
    }

    public(friend) fun paused() {
        let v0 = Paused{dummy_field: false};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun proposal_approved(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ProposalApproved{
            proposal : arg0,
            signer   : arg1,
            count    : arg2,
        };
        0x2::event::emit<ProposalApproved>(v0);
    }

    public(friend) fun proposal_created(arg0: 0x2::object::ID, arg1: address, arg2: u8) {
        let v0 = ProposalCreated{
            proposal : arg0,
            proposer : arg1,
            kind     : arg2,
        };
        0x2::event::emit<ProposalCreated>(v0);
    }

    public(friend) fun purchased(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64) {
        let v0 = Purchased{
            nft   : arg0,
            buyer : arg1,
            denom : arg2,
            price : arg3,
        };
        0x2::event::emit<Purchased>(v0);
    }

    public(friend) fun rate_changed(arg0: u64) {
        let v0 = RateChanged{mg_per_token: arg0};
        0x2::event::emit<RateChanged>(v0);
    }

    public(friend) fun redemption_deposited(arg0: 0x2::object::ID, arg1: address) {
        let v0 = RedemptionDeposited{
            nft       : arg0,
            depositor : arg1,
        };
        0x2::event::emit<RedemptionDeposited>(v0);
    }

    public(friend) fun redemption_returned(arg0: 0x2::object::ID, arg1: address) {
        let v0 = RedemptionReturned{
            nft       : arg0,
            depositor : arg1,
        };
        0x2::event::emit<RedemptionReturned>(v0);
    }

    public(friend) fun role_changed(arg0: u8) {
        let v0 = RoleChanged{kind: arg0};
        0x2::event::emit<RoleChanged>(v0);
    }

    public(friend) fun treasury_withdrawn(arg0: u64, arg1: address) {
        let v0 = TreasuryWithdrawn{
            amount : arg0,
            to     : arg1,
        };
        0x2::event::emit<TreasuryWithdrawn>(v0);
    }

    public(friend) fun unblacklisted(arg0: address) {
        let v0 = Unblacklisted{addr: arg0};
        0x2::event::emit<Unblacklisted>(v0);
    }

    public(friend) fun unpaused() {
        let v0 = Unpaused{dummy_field: false};
        0x2::event::emit<Unpaused>(v0);
    }

    // decompiled from Move bytecode v7
}

