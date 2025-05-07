module 0x9b1398e542c72df0448054e98d59406468edb3379e2f35e12829e903a13fec51::crowdfunding {
    struct Campaign has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        goal_amount: u64,
        deadline: u64,
        category: 0x1::string::String,
        raised: 0x2::balance::Balance<0x2::sui::SUI>,
        is_active: bool,
        backer_count: u64,
    }

    struct CampaignOwnerCap has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
    }

    struct DonationReceipt has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        donor: address,
        amount: u64,
        timestamp: u64,
        is_anonymous: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        campaigns: vector<0x2::object::ID>,
        campaigns_by_category: 0x2::table::Table<0x1::string::String, vector<0x2::object::ID>>,
    }

    struct CampaignCreated has copy, drop {
        campaign_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        goal_amount: u64,
        deadline: u64,
    }

    struct DonationReceived has copy, drop {
        campaign_id: 0x2::object::ID,
        donor: address,
        amount: u64,
        is_anonymous: bool,
    }

    struct FundsWithdrawn has copy, drop {
        campaign_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    public entry fun create_campaign(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut Registry, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 2);
        assert!(arg4 > 0x2::tx_context::epoch(arg7), 1);
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = Campaign{
            id           : v0,
            name         : arg0,
            description  : arg1,
            image_url    : arg2,
            creator      : v2,
            goal_amount  : arg3,
            deadline     : arg4,
            category     : arg5,
            raised       : 0x2::balance::zero<0x2::sui::SUI>(),
            is_active    : true,
            backer_count : 0,
        };
        let v4 = CampaignOwnerCap{
            id          : 0x2::object::new(arg7),
            campaign_id : v1,
        };
        0x2::transfer::transfer<CampaignOwnerCap>(v4, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg6.campaigns, v1);
        if (!0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(&arg6.campaigns_by_category, arg5)) {
            0x2::table::add<0x1::string::String, vector<0x2::object::ID>>(&mut arg6.campaigns_by_category, arg5, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg6.campaigns_by_category, arg5), v1);
        let v5 = CampaignCreated{
            campaign_id : v1,
            creator     : v2,
            name        : arg0,
            goal_amount : arg3,
            deadline    : arg4,
        };
        0x2::event::emit<CampaignCreated>(v5);
        0x2::transfer::share_object<Campaign>(v3);
    }

    public entry fun donate(arg0: &mut Campaign, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 6);
        assert!(0x2::tx_context::epoch(arg3) <= arg0.deadline, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.raised, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.backer_count = arg0.backer_count + 1;
        let v2 = DonationReceipt{
            id           : 0x2::object::new(arg3),
            campaign_id  : 0x2::object::id<Campaign>(arg0),
            donor        : v0,
            amount       : v1,
            timestamp    : 0x2::tx_context::epoch(arg3),
            is_anonymous : arg2,
        };
        0x2::transfer::transfer<DonationReceipt>(v2, v0);
        let v3 = DonationReceived{
            campaign_id  : 0x2::object::id<Campaign>(arg0),
            donor        : v0,
            amount       : v1,
            is_anonymous : arg2,
        };
        0x2::event::emit<DonationReceived>(v3);
    }

    public fun get_all_campaigns(arg0: &Registry) : vector<0x2::object::ID> {
        arg0.campaigns
    }

    public fun get_campaign_details(arg0: &Campaign) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, u64, u64, 0x1::string::String, u64, bool, u64) {
        (arg0.name, arg0.description, arg0.image_url, arg0.creator, arg0.goal_amount, arg0.deadline, arg0.category, 0x2::balance::value<0x2::sui::SUI>(&arg0.raised), arg0.is_active, arg0.backer_count)
    }

    public fun get_campaigns_by_category(arg0: &Registry, arg1: 0x1::string::String) : vector<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(&arg0.campaigns_by_category, arg1)) {
            *0x2::table::borrow<0x1::string::String, vector<0x2::object::ID>>(&arg0.campaigns_by_category, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_donation_receipt_details(arg0: &DonationReceipt) : (0x2::object::ID, address, u64, u64, bool) {
        (arg0.campaign_id, arg0.donor, arg0.amount, arg0.timestamp, arg0.is_anonymous)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                    : 0x2::object::new(arg0),
            campaigns             : 0x1::vector::empty<0x2::object::ID>(),
            campaigns_by_category : 0x2::table::new<0x1::string::String, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_campaign_ended(arg0: &Campaign, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) > arg0.deadline
    }

    public fun is_goal_reached(arg0: &Campaign) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.raised) >= arg0.goal_amount
    }

    public entry fun withdraw_funds(arg0: &mut Campaign, arg1: &CampaignOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.campaign_id == 0x2::object::id<Campaign>(arg0), 5);
        assert!(0x2::tx_context::epoch(arg2) > arg0.deadline, 3);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.raised);
        assert!(v0 >= arg0.goal_amount, 4);
        arg0.is_active = false;
        let v1 = FundsWithdrawn{
            campaign_id : 0x2::object::id<Campaign>(arg0),
            amount      : v0,
            recipient   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FundsWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.raised, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

