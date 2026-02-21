module 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::events {
    struct CampaignCreated has copy, drop {
        campaign_id: 0x2::object::ID,
        creator: address,
        goal_amount: u64,
        deadline: u64,
    }

    struct FundReleased has copy, drop {
        campaign_id: 0x2::object::ID,
        amount: u64,
        creator: address,
    }

    struct Refunded has copy, drop {
        campaign_id: 0x2::object::ID,
        amount: u64,
        backer: address,
    }

    struct ContributionMade has copy, drop {
        campaign_id: 0x2::object::ID,
        contributor: address,
        amount: u64,
    }

    struct CampaignStatusChanged has copy, drop {
        campaign_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
    }

    public fun emit_campaign_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = CampaignCreated{
            campaign_id : arg0,
            creator     : arg1,
            goal_amount : arg2,
            deadline    : arg3,
        };
        0x2::event::emit<CampaignCreated>(v0);
    }

    public fun emit_campaign_status_changed(arg0: 0x2::object::ID, arg1: u8, arg2: u8) {
        let v0 = CampaignStatusChanged{
            campaign_id : arg0,
            old_status  : arg1,
            new_status  : arg2,
        };
        0x2::event::emit<CampaignStatusChanged>(v0);
    }

    public fun emit_contribution_made(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ContributionMade{
            campaign_id : arg0,
            contributor : arg1,
            amount      : arg2,
        };
        0x2::event::emit<ContributionMade>(v0);
    }

    public fun emit_fund_released(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = FundReleased{
            campaign_id : arg0,
            amount      : arg1,
            creator     : arg2,
        };
        0x2::event::emit<FundReleased>(v0);
    }

    public fun emit_refunded(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = Refunded{
            campaign_id : arg0,
            amount      : arg1,
            backer      : arg2,
        };
        0x2::event::emit<Refunded>(v0);
    }

    // decompiled from Move bytecode v6
}

