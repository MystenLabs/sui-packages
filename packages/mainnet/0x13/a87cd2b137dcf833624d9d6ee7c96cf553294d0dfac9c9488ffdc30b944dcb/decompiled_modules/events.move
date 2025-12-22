module 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::events {
    struct CampaignCreated has copy, drop {
        campaign_id: 0x2::object::ID,
        creator: address,
        token_type: vector<u8>,
        goal: u64,
        deadline_ms: u64,
        metadata_ref: vector<u8>,
        timestamp_ms: u64,
    }

    struct ContributionMade has copy, drop {
        campaign_id: 0x2::object::ID,
        backer: address,
        amount: u64,
        token_type: vector<u8>,
        timestamp_ms: u64,
    }

    struct CampaignFinalized has copy, drop {
        campaign_id: 0x2::object::ID,
        status: u8,
        raised: u64,
        goal: u64,
        timestamp_ms: u64,
    }

    struct FundsWithdrawn has copy, drop {
        campaign_id: 0x2::object::ID,
        creator: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct RefundClaimed has copy, drop {
        campaign_id: 0x2::object::ID,
        backer: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct DonorPositionCreated has copy, drop {
        position_id: 0x2::object::ID,
        campaign_id: 0x2::object::ID,
        owner: address,
        initial_amount: u64,
        timestamp_ms: u64,
    }

    struct DonorPositionUpdated has copy, drop {
        position_id: 0x2::object::ID,
        campaign_id: 0x2::object::ID,
        owner: address,
        new_amount: u64,
        timestamp_ms: u64,
    }

    public fun emit_campaign_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64) {
        let v0 = CampaignCreated{
            campaign_id  : arg0,
            creator      : arg1,
            token_type   : arg2,
            goal         : arg3,
            deadline_ms  : arg4,
            metadata_ref : arg5,
            timestamp_ms : arg6,
        };
        0x2::event::emit<CampaignCreated>(v0);
    }

    public fun emit_campaign_finalized(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = CampaignFinalized{
            campaign_id  : arg0,
            status       : arg1,
            raised       : arg2,
            goal         : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<CampaignFinalized>(v0);
    }

    public fun emit_contribution_made(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u64) {
        let v0 = ContributionMade{
            campaign_id  : arg0,
            backer       : arg1,
            amount       : arg2,
            token_type   : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<ContributionMade>(v0);
    }

    public fun emit_donor_position_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = DonorPositionCreated{
            position_id    : arg0,
            campaign_id    : arg1,
            owner          : arg2,
            initial_amount : arg3,
            timestamp_ms   : arg4,
        };
        0x2::event::emit<DonorPositionCreated>(v0);
    }

    public fun emit_donor_position_updated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = DonorPositionUpdated{
            position_id  : arg0,
            campaign_id  : arg1,
            owner        : arg2,
            new_amount   : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<DonorPositionUpdated>(v0);
    }

    public fun emit_funds_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = FundsWithdrawn{
            campaign_id  : arg0,
            creator      : arg1,
            amount       : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<FundsWithdrawn>(v0);
    }

    public fun emit_refund_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RefundClaimed{
            campaign_id  : arg0,
            backer       : arg1,
            amount       : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<RefundClaimed>(v0);
    }

    // decompiled from Move bytecode v6
}

