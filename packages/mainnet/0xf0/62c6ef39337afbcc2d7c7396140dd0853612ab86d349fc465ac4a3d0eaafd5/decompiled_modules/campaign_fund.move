module 0xf062c6ef39337afbcc2d7c7396140dd0853612ab86d349fc465ac4a3d0eaafd5::campaign_fund {
    struct AffiliateHistory has store {
        company_name: 0x1::string::String,
        campaign_url: 0x1::string::String,
        clicks: u64,
        earnings: u64,
    }

    struct CampaignConfig has key {
        id: 0x2::object::UID,
        minimum_coins_limit: u64,
        platform_fees_percent: u64,
    }

    struct Fan has store, key {
        id: 0x2::object::UID,
        donated: u64,
        message: 0x1::string::String,
        wallet_address: address,
        timestamp: u64,
    }

    struct Campaign has key {
        id: 0x2::object::UID,
        share_id: 0x2::object::ID,
        company_name: 0x1::string::String,
        category: 0x1::string::String,
        original_url: 0x1::string::String,
        total_clicks: u64,
        remaining_clicks: u64,
        cost_per_click: u64,
        budget: u64,
        distribute_funds: 0x2::balance::Balance<0x2::sui::SUI>,
        wallet_address: address,
        fees_wallet_address: address,
        status: u64,
        start_date: u64,
        end_date: u64,
        supporters: vector<Fan>,
        timestamp: u64,
        affiliates: 0x2::vec_map::VecMap<0x2::object::ID, Affiliate>,
    }

    struct Affiliate has store, key {
        id: 0x2::object::UID,
        click_counts: u64,
        earnings: u64,
        campaign_url: 0x1::string::String,
        wallet_address: address,
        timestamp: u64,
    }

    struct AffiliateProfile has key {
        id: 0x2::object::UID,
        share_id: 0x2::object::ID,
        participated_campagins_count: u64,
        total_clicks: u64,
        total_earnings: u64,
        history: 0x2::vec_map::VecMap<0x2::object::ID, AffiliateHistory>,
        timestamp: u64,
    }

    struct Reciept has key {
        id: 0x2::object::UID,
        company_name: 0x1::string::String,
        budget: u64,
        timestamp: u64,
    }

    public fun campaign_config(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CampaignConfig{
            id                    : 0x2::object::new(arg2),
            minimum_coins_limit   : arg0,
            platform_fees_percent : arg1,
        };
        0x2::transfer::share_object<CampaignConfig>(v0);
    }

    public fun collect_fees(arg0: &mut CampaignConfig, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2 * arg0.platform_fees_percent / 100, arg3), @0xcf927346c3b6d1d26586d6ab9508710dc0b7656ebe19ff8d56be4b5d8bcbbc59);
    }

    public entry fun create_affiliate_campaign(arg0: &mut Campaign, arg1: vector<u8>, arg2: &mut AffiliateProfile, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 1);
        let v0 = Affiliate{
            id             : 0x2::object::new(arg4),
            click_counts   : 0,
            earnings       : 0,
            campaign_url   : 0x1::string::utf8(arg1),
            wallet_address : arg3,
            timestamp      : get_epoch_seconds(arg4),
        };
        0x2::vec_map::insert<0x2::object::ID, Affiliate>(&mut arg0.affiliates, arg2.share_id, v0);
    }

    public fun create_affiliate_profile(arg0: &mut Campaign, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, AffiliateHistory>();
        let v1 = AffiliateHistory{
            company_name : arg0.company_name,
            campaign_url : 0x1::string::utf8(arg1),
            clicks       : 0,
            earnings     : 0,
        };
        0x2::vec_map::insert<0x2::object::ID, AffiliateHistory>(&mut v0, arg0.share_id, v1);
        let v2 = 0x2::object::new(arg2);
        let v3 = AffiliateProfile{
            id                           : v2,
            share_id                     : 0x2::object::uid_to_inner(&v2),
            participated_campagins_count : 1,
            total_clicks                 : 0,
            total_earnings               : 0,
            history                      : v0,
            timestamp                    : get_epoch_seconds(arg2),
        };
        0x2::transfer::transfer<AffiliateProfile>(v3, @0xcf927346c3b6d1d26586d6ab9508710dc0b7656ebe19ff8d56be4b5d8bcbbc59);
    }

    public entry fun create_campaign(arg0: &mut CampaignConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg4);
        assert!(arg5 >= arg0.minimum_coins_limit, 0);
        assert!(arg5 >= arg6, 0);
        assert!(arg8 >= arg7, 0);
        let v1 = arg5 / arg6;
        collect_fees(arg0, arg4, arg5, arg11);
        let v2 = 0x2::object::new(arg11);
        let v3 = Campaign{
            id                  : v2,
            share_id            : 0x2::object::uid_to_inner(&v2),
            company_name        : 0x1::string::utf8(arg1),
            category            : 0x1::string::utf8(arg2),
            original_url        : 0x1::string::utf8(arg3),
            total_clicks        : v1,
            remaining_clicks    : v1,
            cost_per_click      : arg6,
            budget              : arg5,
            distribute_funds    : 0x2::balance::split<0x2::sui::SUI>(v0, arg5),
            wallet_address      : arg10,
            fees_wallet_address : @0xcf927346c3b6d1d26586d6ab9508710dc0b7656ebe19ff8d56be4b5d8bcbbc59,
            status              : arg9,
            start_date          : arg7,
            end_date            : arg8,
            supporters          : 0x1::vector::empty<Fan>(),
            timestamp           : get_epoch_seconds(arg11),
            affiliates          : 0x2::vec_map::empty<0x2::object::ID, Affiliate>(),
        };
        let v4 = Reciept{
            id           : 0x2::object::new(arg11),
            company_name : 0x1::string::utf8(arg1),
            budget       : arg5,
            timestamp    : get_epoch_seconds(arg11),
        };
        0x2::transfer::share_object<Campaign>(v3);
        0x2::transfer::transfer<Reciept>(v4, 0x2::tx_context::sender(arg11));
    }

    public fun end_campaign(arg0: &mut Campaign, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(get_epoch_seconds(arg1) >= arg0.end_date, 0);
        assert!(0x2::tx_context::sender(arg1) == @0xcf927346c3b6d1d26586d6ab9508710dc0b7656ebe19ff8d56be4b5d8bcbbc59, 1);
        arg0.status = 3;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.distribute_funds);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.distribute_funds, v0, arg1), arg0.wallet_address);
    }

    public fun get_epoch_seconds(arg0: &0x2::tx_context::TxContext) : u64 {
        0x2::tx_context::epoch_timestamp_ms(arg0) / 1000
    }

    fun increment_affiliate_profile(arg0: &0x2::object::ID, arg1: u64, arg2: &mut AffiliateProfile) {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, AffiliateHistory>(&mut arg2.history, arg0);
        v0.clicks = v0.clicks + 1;
        v0.earnings = v0.earnings + arg1;
        arg2.total_clicks = arg2.total_clicks + 1;
        arg2.total_earnings = arg2.total_earnings + arg1;
    }

    public fun update_affiliate_profile(arg0: &mut Campaign, arg1: vector<u8>, arg2: &mut AffiliateProfile) {
        let v0 = AffiliateHistory{
            company_name : arg0.company_name,
            campaign_url : 0x1::string::utf8(arg1),
            clicks       : 0,
            earnings     : 0,
        };
        0x2::vec_map::insert<0x2::object::ID, AffiliateHistory>(&mut arg2.history, arg0.share_id, v0);
        arg2.participated_campagins_count = arg2.participated_campagins_count + 1;
    }

    public fun update_affiliate_via_campaign(arg0: &mut Campaign, arg1: &mut AffiliateProfile, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.distribute_funds) >= arg0.cost_per_click, 0);
        assert!(@0xcf927346c3b6d1d26586d6ab9508710dc0b7656ebe19ff8d56be4b5d8bcbbc59 == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Affiliate>(&mut arg0.affiliates, &arg1.share_id);
        v0.click_counts = v0.click_counts + 1;
        v0.earnings = v0.earnings + arg0.cost_per_click;
        arg0.remaining_clicks = arg0.remaining_clicks - 1;
        let v1 = arg0.cost_per_click;
        increment_affiliate_profile(&arg0.share_id, v1, arg1);
        withdraw_amount(arg0, v1, v0.wallet_address, arg2);
    }

    public fun update_campaign_pool(arg0: &mut CampaignConfig, arg1: &mut Campaign, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 2, 1);
        let v0 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg4), arg3);
        collect_fees(arg0, arg4, arg3, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.distribute_funds, v0);
        arg1.budget = arg1.budget + arg3;
        arg1.total_clicks = arg1.total_clicks + arg3 / arg1.cost_per_click;
        arg1.remaining_clicks = arg1.remaining_clicks + arg3 / arg1.cost_per_click;
        let v1 = Fan{
            id             : 0x2::object::new(arg5),
            donated        : arg3,
            message        : 0x1::string::utf8(arg2),
            wallet_address : 0x2::tx_context::sender(arg5),
            timestamp      : get_epoch_seconds(arg5),
        };
        0x1::vector::push_back<Fan>(&mut arg1.supporters, v1);
    }

    fun withdraw_amount(arg0: &mut Campaign, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.distribute_funds, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

