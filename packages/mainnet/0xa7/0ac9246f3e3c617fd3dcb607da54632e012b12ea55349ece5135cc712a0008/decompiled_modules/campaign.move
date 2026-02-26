module 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign {
    struct Campaign has store, key {
        id: 0x2::object::UID,
        creator: address,
        goal_amount: u64,
        raised_amount: u64,
        deadline: u64,
        status: u8,
        created_at: u64,
        title: vector<u8>,
        description: vector<u8>,
        reward_pool: u64,
        reward_per_backer: u64,
    }

    struct CampaignCap has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
    }

    public fun id(arg0: &Campaign) : 0x2::object::ID {
        0x2::object::id<Campaign>(arg0)
    }

    public(friend) fun add_contribution(arg0: &mut Campaign, arg1: u64) {
        assert!(arg0.status == 0, 12);
        assert!(arg1 > 0, 17);
        arg0.raised_amount = arg0.raised_amount + arg1;
    }

    public fun close_campaign(arg0: &mut Campaign, arg1: u64) {
        assert!(arg0.status == 0, 16);
        if (is_deadline_passed(arg0, arg1)) {
            if (is_goal_met(arg0)) {
                arg0.status = 1;
            } else {
                arg0.status = 2;
            };
        };
    }

    public entry fun create_campaign(arg0: address, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 10);
        assert!(arg2 > 0, 11);
        let v0 = Campaign{
            id                : 0x2::object::new(arg7),
            creator           : arg0,
            goal_amount       : arg1,
            raised_amount     : 0,
            deadline          : arg2,
            status            : 0,
            created_at        : 0,
            title             : arg3,
            description       : arg4,
            reward_pool       : arg5,
            reward_per_backer : arg6,
        };
        let v1 = 0x2::object::id<Campaign>(&v0);
        let v2 = CampaignCap{
            id          : 0x2::object::new(arg7),
            campaign_id : v1,
        };
        0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::events::emit_campaign_created(v1, arg0, arg1, arg2);
        0x2::transfer::transfer<Campaign>(v0, arg0);
        0x2::transfer::transfer<CampaignCap>(v2, arg0);
    }

    public fun creator(arg0: &Campaign) : address {
        arg0.creator
    }

    public fun get_campaign_info(arg0: &Campaign) : (address, u64, u64, u64, u8, u64, u64) {
        (arg0.creator, arg0.goal_amount, arg0.raised_amount, arg0.deadline, arg0.status, arg0.reward_pool, arg0.reward_per_backer)
    }

    public fun has_token_rewards(arg0: &Campaign) : bool {
        arg0.reward_pool > 0 && arg0.reward_per_backer > 0
    }

    public fun is_deadline_passed(arg0: &Campaign, arg1: u64) : bool {
        arg1 >= arg0.deadline
    }

    public fun is_goal_met(arg0: &Campaign) : bool {
        arg0.raised_amount >= arg0.goal_amount
    }

    public fun reward_per_backer(arg0: &Campaign) : u64 {
        arg0.reward_per_backer
    }

    public fun reward_pool(arg0: &Campaign) : u64 {
        arg0.reward_pool
    }

    public fun status(arg0: &Campaign) : u8 {
        arg0.status
    }

    public fun transfer_cap_to_creator(arg0: CampaignCap, arg1: address) {
        0x2::transfer::transfer<CampaignCap>(arg0, arg1);
    }

    public fun transfer_to_creator(arg0: Campaign, arg1: address) {
        0x2::transfer::transfer<Campaign>(arg0, arg1);
    }

    public fun update_status(arg0: &mut Campaign, arg1: u8, arg2: &CampaignCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Campaign>(arg0) == arg2.campaign_id, 13);
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 14);
        assert!(arg1 <= 2, 15);
        arg0.status = arg1;
        0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::events::emit_campaign_status_changed(0x2::object::id<Campaign>(arg0), arg0.status, arg1);
    }

    // decompiled from Move bytecode v6
}

