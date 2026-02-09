module 0xd3ef5bdef036832da33326ec38978de36e789e52be001060afa0a81c6787bc8d::ad_campaigns {
    struct AdCampaign has store, key {
        id: 0x2::object::UID,
        advertiser: address,
        title: vector<u8>,
        description: vector<u8>,
        target_url: vector<u8>,
        placements: vector<vector<u8>>,
        bid: u64,
        total_budget: u64,
        remaining_budget: u64,
        status: u8,
        start_at: u64,
        end_at: u64,
        created_at: u64,
        impression_count: u64,
        user_zones: vector<vector<u8>>,
        content_zones: vector<vector<u8>>,
        planet: 0x1::option::Option<u8>,
        escrow_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct CampaignCreated has copy, drop {
        campaign_id: 0x2::object::ID,
        advertiser: address,
        title: vector<u8>,
        bid: u64,
        total_budget: u64,
    }

    struct CampaignUpdated has copy, drop {
        campaign_id: 0x2::object::ID,
        title: vector<u8>,
        description: vector<u8>,
        target_url: vector<u8>,
    }

    struct CampaignStatusChanged has copy, drop {
        campaign_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
    }

    struct ImpressionRecorded has copy, drop {
        campaign_id: 0x2::object::ID,
        cost: u64,
        remaining_budget: u64,
    }

    struct CampaignCancelled has copy, drop {
        campaign_id: 0x2::object::ID,
        refund_amount: u64,
    }

    public fun cancel_campaign(arg0: &mut AdCampaign, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.advertiser, 1);
        assert!(arg0.status != 2, 10);
        arg0.status = 2;
        arg0.remaining_budget = 0;
        let v0 = CampaignStatusChanged{
            campaign_id : 0x2::object::uid_to_inner(&arg0.id),
            old_status  : arg0.status,
            new_status  : 2,
        };
        0x2::event::emit<CampaignStatusChanged>(v0);
        let v1 = CampaignCancelled{
            campaign_id   : 0x2::object::uid_to_inner(&arg0.id),
            refund_amount : arg0.remaining_budget,
        };
        0x2::event::emit<CampaignCancelled>(v1);
    }

    public fun create_campaign(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: 0x1::option::Option<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 6);
        assert!(arg5 > 0, 5);
        assert!(arg7 > arg6, 7);
        let v1 = 0x2::clock::timestamp_ms(arg12);
        assert!(arg7 > v1, 7);
        let v2 = 0x2::tx_context::sender(arg13);
        let v3 = 0x2::object::new(arg13);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = AdCampaign{
            id               : v3,
            advertiser       : v2,
            title            : arg1,
            description      : arg2,
            target_url       : arg3,
            placements       : arg4,
            bid              : arg5,
            total_budget     : v0,
            remaining_budget : v0,
            status           : 0,
            start_at         : arg6,
            end_at           : arg7,
            created_at       : v1,
            impression_count : 0,
            user_zones       : arg8,
            content_zones    : arg9,
            planet           : arg10,
            escrow_id        : 0x1::option::some<0x2::object::ID>(0xd3ef5bdef036832da33326ec38978de36e789e52be001060afa0a81c6787bc8d::ad_payments::create_escrow(v4, arg0, arg11, arg12, arg13)),
        };
        let v6 = CampaignCreated{
            campaign_id  : v4,
            advertiser   : v2,
            title        : arg1,
            bid          : arg5,
            total_budget : v0,
        };
        0x2::event::emit<CampaignCreated>(v6);
        0x2::transfer::share_object<AdCampaign>(v5);
    }

    public entry fun create_campaign_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: 0x1::option::Option<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        create_campaign(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun deduct_impression_cost(arg0: &mut AdCampaign, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.status != 0) {
            return false
        };
        if (v0 < arg0.start_at || v0 > arg0.end_at) {
            if (v0 > arg0.end_at) {
                arg0.status = 3;
            };
            return false
        };
        if (arg0.remaining_budget < arg0.bid) {
            arg0.status = 4;
            return false
        };
        arg0.remaining_budget = arg0.remaining_budget - arg0.bid;
        arg0.impression_count = arg0.impression_count + 1;
        if (arg0.remaining_budget < arg0.bid) {
            arg0.status = 4;
        };
        let v1 = ImpressionRecorded{
            campaign_id      : 0x2::object::uid_to_inner(&arg0.id),
            cost             : arg0.bid,
            remaining_budget : arg0.remaining_budget,
        };
        0x2::event::emit<ImpressionRecorded>(v1);
        true
    }

    public fun get_advertiser(arg0: &AdCampaign) : address {
        arg0.advertiser
    }

    public fun get_bid(arg0: &AdCampaign) : u64 {
        arg0.bid
    }

    public fun get_content_zones(arg0: &AdCampaign) : vector<vector<u8>> {
        arg0.content_zones
    }

    public fun get_escrow_id(arg0: &AdCampaign) : 0x1::option::Option<0x2::object::ID> {
        arg0.escrow_id
    }

    public fun get_impression_count(arg0: &AdCampaign) : u64 {
        arg0.impression_count
    }

    public fun get_planet(arg0: &AdCampaign) : 0x1::option::Option<u8> {
        arg0.planet
    }

    public fun get_remaining_budget(arg0: &AdCampaign) : u64 {
        arg0.remaining_budget
    }

    public fun get_status(arg0: &AdCampaign) : u8 {
        arg0.status
    }

    public fun get_user_zones(arg0: &AdCampaign) : vector<vector<u8>> {
        arg0.user_zones
    }

    public fun is_active_with_budget(arg0: &AdCampaign, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.status == 0) {
            if (v0 >= arg0.start_at) {
                if (v0 <= arg0.end_at) {
                    arg0.remaining_budget >= arg0.bid
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun pause_campaign(arg0: &mut AdCampaign, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.advertiser, 1);
        assert!(arg0.status == 0, 8);
        arg0.status = 1;
        let v0 = CampaignStatusChanged{
            campaign_id : 0x2::object::uid_to_inner(&arg0.id),
            old_status  : arg0.status,
            new_status  : 1,
        };
        0x2::event::emit<CampaignStatusChanged>(v0);
    }

    public entry fun record_impression_with_escrow(arg0: &mut AdCampaign, arg1: &mut 0xd3ef5bdef036832da33326ec38978de36e789e52be001060afa0a81c6787bc8d::ad_payments::CampaignEscrow, arg2: &mut 0xd3ef5bdef036832da33326ec38978de36e789e52be001060afa0a81c6787bc8d::ad_payments::RevenuePool, arg3: &0xd3ef5bdef036832da33326ec38978de36e789e52be001060afa0a81c6787bc8d::ad_payments::AdminCap, arg4: &0x2::clock::Clock) : bool {
        let v0 = deduct_impression_cost(arg0, arg4);
        if (!v0) {
            return false
        };
        0xd3ef5bdef036832da33326ec38978de36e789e52be001060afa0a81c6787bc8d::ad_payments::withdraw_for_impression(arg1, arg0.bid, arg2, arg3)
    }

    public fun resume_campaign(arg0: &mut AdCampaign, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.advertiser, 1);
        assert!(arg0.status == 1, 9);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.end_at, 7);
        assert!(arg0.remaining_budget >= arg0.bid, 4);
        arg0.status = 0;
        let v0 = CampaignStatusChanged{
            campaign_id : 0x2::object::uid_to_inner(&arg0.id),
            old_status  : arg0.status,
            new_status  : 0,
        };
        0x2::event::emit<CampaignStatusChanged>(v0);
    }

    public fun update_campaign(arg0: &mut AdCampaign, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.advertiser, 1);
        assert!(arg0.status != 2, 10);
        arg0.title = arg1;
        arg0.description = arg2;
        arg0.target_url = arg3;
        let v0 = CampaignUpdated{
            campaign_id : 0x2::object::uid_to_inner(&arg0.id),
            title       : arg1,
            description : arg2,
            target_url  : arg3,
        };
        0x2::event::emit<CampaignUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

