module 0xb91b08c864e925f76bb7b172b1712dc664e39bbe2d913fcca2d667cdc831e9a::fund {
    struct CampaignMetadata has store {
        title: 0x1::string::String,
        description: 0x1::string::String,
        start_time: u64,
        end_time: u64,
    }

    struct Campaign has key {
        id: 0x2::object::UID,
        owner: address,
        goal: u64,
        deadline: u64,
        allow_refund: bool,
        metadata: CampaignMetadata,
        total_contributed: u64,
        contributors: 0x2::table::Table<address, u64>,
        refunded_contributors: 0x2::table::Table<address, bool>,
        is_paused: bool,
        is_withdrawn: bool,
        emergency_refund: bool,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CampaignCreated has copy, drop {
        campaign_id: address,
        owner: address,
        goal: u64,
        deadline: u64,
        allow_refund: bool,
    }

    struct ContributionMade has copy, drop {
        campaign_id: address,
        contributor: address,
        amount: u64,
        total_contributed: u64,
    }

    struct FundsWithdrawn has copy, drop {
        campaign_id: address,
        owner: address,
        amount: u64,
    }

    struct RefundClaimed has copy, drop {
        campaign_id: address,
        contributor: address,
        amount: u64,
    }

    struct CampaignPaused has copy, drop {
        campaign_id: address,
        paused: bool,
    }

    struct EmergencyRefundTriggered has copy, drop {
        campaign_id: address,
        reason: 0x1::string::String,
        total_refunded: u64,
    }

    public entry fun claim_refund(arg0: &mut Campaign, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (0x2::clock::timestamp_ms(arg1) >= arg0.deadline) {
            if (arg0.total_contributed < arg0.goal) {
                arg0.allow_refund
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1 || arg0.emergency_refund, 7);
        assert!(0x2::table::contains<address, u64>(&arg0.contributors, v0), 8);
        assert!(!0x2::table::contains<address, bool>(&arg0.refunded_contributors, v0), 9);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.contributors, v0);
        0x2::table::add<address, bool>(&mut arg0.refunded_contributors, v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v2), arg2), v0);
        let v3 = RefundClaimed{
            campaign_id : 0x2::object::id_address<Campaign>(arg0),
            contributor : v0,
            amount      : v2,
        };
        0x2::event::emit<RefundClaimed>(v3);
    }

    public entry fun contribute(arg0: &mut Campaign, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!arg0.is_paused, 1);
        assert!(!arg0.emergency_refund, 7);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline, 2);
        assert!(arg2 > 0, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 10);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg4)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        arg0.total_contributed = arg0.total_contributed + arg2;
        if (0x2::table::contains<address, u64>(&arg0.contributors, v0)) {
            0x2::table::add<address, u64>(&mut arg0.contributors, v0, 0x2::table::remove<address, u64>(&mut arg0.contributors, v0) + arg2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributors, v0, arg2);
        };
        let v1 = ContributionMade{
            campaign_id       : 0x2::object::id_address<Campaign>(arg0),
            contributor       : v0,
            amount            : arg2,
            total_contributed : arg0.total_contributed,
        };
        0x2::event::emit<ContributionMade>(v1);
    }

    public entry fun emergency_refund_all(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.is_paused = true;
        arg0.is_withdrawn = true;
        arg0.emergency_refund = true;
        let v0 = EmergencyRefundTriggered{
            campaign_id    : 0x2::object::id_address<Campaign>(arg0),
            reason         : arg1,
            total_refunded : 0x2::balance::value<0x2::sui::SUI>(&arg0.funds),
        };
        0x2::event::emit<EmergencyRefundTriggered>(v0);
    }

    public fun get_campaign_info(arg0: &Campaign) : (address, u64, u64, bool, u64, bool, bool, bool, u64) {
        (arg0.owner, arg0.goal, arg0.deadline, arg0.allow_refund, arg0.total_contributed, arg0.is_paused, arg0.is_withdrawn, arg0.emergency_refund, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds))
    }

    public fun get_campaign_metadata(arg0: &Campaign) : (0x1::string::String, 0x1::string::String, u64, u64) {
        (arg0.metadata.title, arg0.metadata.description, arg0.metadata.start_time, arg0.metadata.end_time)
    }

    public fun get_campaign_progress(arg0: &Campaign) : u64 {
        if (arg0.goal == 0) {
            0
        } else {
            arg0.total_contributed * 100 / arg0.goal
        }
    }

    public fun get_user_contribution(arg0: &Campaign, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.contributors, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.contributors, arg1)
        } else {
            0
        }
    }

    public entry fun init_campaign(arg0: u64, arg1: u64, arg2: bool, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg1 > v0, 2);
        let v1 = CampaignMetadata{
            title       : arg3,
            description : arg4,
            start_time  : v0,
            end_time    : arg1,
        };
        let v2 = Campaign{
            id                    : 0x2::object::new(arg6),
            owner                 : 0x2::tx_context::sender(arg6),
            goal                  : arg0,
            deadline              : arg1,
            allow_refund          : arg2,
            metadata              : v1,
            total_contributed     : 0,
            contributors          : 0x2::table::new<address, u64>(arg6),
            refunded_contributors : 0x2::table::new<address, bool>(arg6),
            is_paused             : false,
            is_withdrawn          : false,
            emergency_refund      : false,
            funds                 : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v3 = CampaignCreated{
            campaign_id  : 0x2::object::id_address<Campaign>(&v2),
            owner        : 0x2::tx_context::sender(arg6),
            goal         : arg0,
            deadline     : arg1,
            allow_refund : arg2,
        };
        0x2::event::emit<CampaignCreated>(v3);
        0x2::transfer::share_object<Campaign>(v2);
    }

    public fun is_campaign_failed(arg0: &Campaign, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.deadline && arg0.total_contributed < arg0.goal
    }

    public fun is_campaign_successful(arg0: &Campaign, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.deadline && arg0.total_contributed >= arg0.goal
    }

    public fun is_user_refunded(arg0: &Campaign, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.refunded_contributors, arg1)
    }

    public entry fun pause_campaign(arg0: &mut Campaign, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.is_paused = true;
        let v0 = CampaignPaused{
            campaign_id : 0x2::object::id_address<Campaign>(arg0),
            paused      : true,
        };
        0x2::event::emit<CampaignPaused>(v0);
    }

    public entry fun resume_campaign(arg0: &mut Campaign, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        assert!(arg0.is_paused, 11);
        arg0.is_paused = false;
        let v0 = CampaignPaused{
            campaign_id : 0x2::object::id_address<Campaign>(arg0),
            paused      : false,
        };
        0x2::event::emit<CampaignPaused>(v0);
    }

    public entry fun withdraw(arg0: &mut Campaign, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline, 3);
        assert!(arg0.total_contributed >= arg0.goal, 4);
        assert!(!arg0.is_withdrawn, 6);
        assert!(!arg0.emergency_refund, 7);
        arg0.is_withdrawn = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.funds), arg2), arg0.owner);
        let v0 = FundsWithdrawn{
            campaign_id : 0x2::object::id_address<Campaign>(arg0),
            owner       : arg0.owner,
            amount      : 0x2::balance::value<0x2::sui::SUI>(&arg0.funds),
        };
        0x2::event::emit<FundsWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

