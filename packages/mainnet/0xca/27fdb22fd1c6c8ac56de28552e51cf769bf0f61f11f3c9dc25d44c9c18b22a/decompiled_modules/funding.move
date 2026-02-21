module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::funding {
    struct Campaign has store, key {
        id: 0x2::object::UID,
        creator: address,
        title: vector<u8>,
        goal: u64,
        raised: 0x2::balance::Balance<0x2::sui::SUI>,
        raised_amount: u64,
        deadline: u64,
        closed: bool,
    }

    struct FundingReceipt has store, key {
        id: 0x2::object::UID,
        campaign_id: address,
        backer: address,
        amount: u64,
    }

    struct CampaignCreated has copy, drop {
        campaign_id: address,
        creator: address,
        goal: u64,
        deadline: u64,
    }

    struct Funded has copy, drop {
        campaign_id: address,
        backer: address,
        amount: u64,
    }

    struct CampaignClosed has copy, drop {
        campaign_id: address,
        total_raised: u64,
    }

    entry fun close_campaign(arg0: &mut Campaign, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.closed, 1);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 0);
        assert!(arg0.raised_amount >= arg0.goal, 2);
        arg0.closed = true;
        let v0 = arg0.raised_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.raised, v0), arg1), arg0.creator);
        let v1 = CampaignClosed{
            campaign_id  : 0x2::object::uid_to_address(&arg0.id),
            total_raised : v0,
        };
        0x2::event::emit<CampaignClosed>(v1);
    }

    entry fun create_campaign(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3), 3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Campaign{
            id            : 0x2::object::new(arg4),
            creator       : v0,
            title         : arg0,
            goal          : arg1,
            raised        : 0x2::balance::zero<0x2::sui::SUI>(),
            raised_amount : 0,
            deadline      : arg2,
            closed        : false,
        };
        let v2 = CampaignCreated{
            campaign_id : 0x2::object::uid_to_address(&v1.id),
            creator     : v0,
            goal        : arg1,
            deadline    : arg2,
        };
        0x2::event::emit<CampaignCreated>(v2);
        0x2::transfer::share_object<Campaign>(v1);
    }

    entry fun fund(arg0: &mut Campaign, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.closed, 1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.deadline, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.raised, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.raised_amount = arg0.raised_amount + v0;
        let v2 = 0x2::object::uid_to_address(&arg0.id);
        let v3 = FundingReceipt{
            id          : 0x2::object::new(arg3),
            campaign_id : v2,
            backer      : v1,
            amount      : v0,
        };
        let v4 = Funded{
            campaign_id : v2,
            backer      : v1,
            amount      : v0,
        };
        0x2::event::emit<Funded>(v4);
        0x2::transfer::transfer<FundingReceipt>(v3, v1);
    }

    public fun goal(arg0: &Campaign) : u64 {
        arg0.goal
    }

    public fun is_closed(arg0: &Campaign) : bool {
        arg0.closed
    }

    public fun raised_amount(arg0: &Campaign) : u64 {
        arg0.raised_amount
    }

    // decompiled from Move bytecode v6
}

