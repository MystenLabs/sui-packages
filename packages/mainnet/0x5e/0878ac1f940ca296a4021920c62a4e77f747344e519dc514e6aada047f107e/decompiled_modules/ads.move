module 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::ads {
    struct AdRegistry has key {
        id: 0x2::object::UID,
        active_campaign_ids: vector<0x2::object::ID>,
        total_campaigns_submitted: u64,
        total_campaigns_approved: u64,
        advertiser_records: 0x2::table::Table<address, AdvertiserRecord>,
    }

    struct AdvertiserRecord has drop, store {
        rejection_count: u8,
        ban_until_epoch: u64,
        is_permanently_banned: bool,
    }

    struct AdCampaign has key {
        id: 0x2::object::UID,
        advertiser: address,
        title: 0x1::string::String,
        content_blob_id: 0x1::string::String,
        target_url: 0x1::string::String,
        category: u8,
        daily_budget: u64,
        days_total: u8,
        days_remaining: u8,
        status: u8,
        escrowed: 0x2::balance::Balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>,
        created_at: u64,
        approved_at: u64,
        last_release_epoch: u64,
    }

    struct AdSubmitted has copy, drop {
        campaign_id: 0x2::object::ID,
        advertiser: address,
        category: u8,
        daily_budget: u64,
        days_total: u8,
        total_escrowed: u64,
    }

    struct AdApproved has copy, drop {
        campaign_id: 0x2::object::ID,
        advertiser: address,
        epoch: u64,
    }

    struct AdRejected has copy, drop {
        campaign_id: 0x2::object::ID,
        advertiser: address,
        capy_refunded: u64,
        rejection_count: u8,
    }

    struct AdCancelled has copy, drop {
        campaign_id: 0x2::object::ID,
        advertiser: address,
        capy_refunded: u64,
        days_remaining: u8,
    }

    struct DailyBudgetReleased has copy, drop {
        campaign_id: 0x2::object::ID,
        amount_released: u64,
        days_remaining: u8,
        epoch: u64,
    }

    struct AdCompleted has copy, drop {
        campaign_id: 0x2::object::ID,
        advertiser: address,
    }

    struct AdvertiserBanned has copy, drop {
        advertiser: address,
        is_permanent: bool,
        ban_until_epoch: u64,
    }

    public fun active_campaign_count(arg0: &AdRegistry) : u64 {
        (0x1::vector::length<0x2::object::ID>(&arg0.active_campaign_ids) as u64)
    }

    public fun advertiser_rejection_count(arg0: &AdRegistry, arg1: address) : u8 {
        if (0x2::table::contains<address, AdvertiserRecord>(&arg0.advertiser_records, arg1)) {
            0x2::table::borrow<address, AdvertiserRecord>(&arg0.advertiser_records, arg1).rejection_count
        } else {
            0
        }
    }

    public fun approve_ad(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut AdRegistry, arg2: &mut AdCampaign, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 6);
        arg2.status = 1;
        arg2.approved_at = 0x2::tx_context::epoch(arg3);
        arg2.last_release_epoch = 0x2::tx_context::epoch(arg3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.active_campaign_ids, 0x2::object::id<AdCampaign>(arg2));
        arg1.total_campaigns_approved = arg1.total_campaigns_approved + 1;
        let v0 = AdApproved{
            campaign_id : 0x2::object::id<AdCampaign>(arg2),
            advertiser  : arg2.advertiser,
            epoch       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<AdApproved>(v0);
    }

    public fun ban_advertiser(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut AdRegistry, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        ensure_advertiser_record(arg1, arg2);
        let v0 = 0x2::table::borrow_mut<address, AdvertiserRecord>(&mut arg1.advertiser_records, arg2);
        if (arg3) {
            v0.is_permanently_banned = true;
            v0.ban_until_epoch = 18446744073709551615;
        } else {
            v0.ban_until_epoch = 0x2::tx_context::epoch(arg4) + 30;
        };
        let v1 = AdvertiserBanned{
            advertiser      : arg2,
            is_permanent    : arg3,
            ban_until_epoch : v0.ban_until_epoch,
        };
        0x2::event::emit<AdvertiserBanned>(v1);
    }

    public fun campaign_advertiser(arg0: &AdCampaign) : address {
        arg0.advertiser
    }

    public fun campaign_approved_at(arg0: &AdCampaign) : u64 {
        arg0.approved_at
    }

    public fun campaign_blob_id(arg0: &AdCampaign) : &0x1::string::String {
        &arg0.content_blob_id
    }

    public fun campaign_category(arg0: &AdCampaign) : u8 {
        arg0.category
    }

    public fun campaign_created_at(arg0: &AdCampaign) : u64 {
        arg0.created_at
    }

    public fun campaign_daily_budget(arg0: &AdCampaign) : u64 {
        arg0.daily_budget
    }

    public fun campaign_days_remaining(arg0: &AdCampaign) : u8 {
        arg0.days_remaining
    }

    public fun campaign_days_total(arg0: &AdCampaign) : u8 {
        arg0.days_total
    }

    public fun campaign_escrowed(arg0: &AdCampaign) : u64 {
        0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg0.escrowed)
    }

    public fun campaign_status(arg0: &AdCampaign) : u8 {
        arg0.status
    }

    public fun campaign_target_url(arg0: &AdCampaign) : &0x1::string::String {
        &arg0.target_url
    }

    public fun campaign_title(arg0: &AdCampaign) : &0x1::string::String {
        &arg0.title
    }

    public fun cancel_ad(arg0: &mut AdRegistry, arg1: &mut AdCampaign, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.advertiser == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1.status == 0 || arg1.status == 1, 7);
        let v0 = arg1.daily_budget * (arg1.days_remaining as u64);
        arg1.status = 4;
        remove_from_active(arg0, 0x2::object::id<AdCampaign>(arg1));
        let v1 = AdCancelled{
            campaign_id    : 0x2::object::id<AdCampaign>(arg1),
            advertiser     : 0x2::tx_context::sender(arg2),
            capy_refunded  : v0,
            days_remaining : arg1.days_remaining,
        };
        0x2::event::emit<AdCancelled>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>>(0x2::coin::from_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(0x2::balance::split<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg1.escrowed, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    fun check_not_banned(arg0: &AdRegistry, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, AdvertiserRecord>(&arg0.advertiser_records, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow<address, AdvertiserRecord>(&arg0.advertiser_records, arg1);
        assert!(!v0.is_permanently_banned, 5);
        if (v0.ban_until_epoch > 0) {
            assert!(arg2 >= v0.ban_until_epoch, 5);
        };
    }

    fun ensure_advertiser_record(arg0: &mut AdRegistry, arg1: address) {
        if (!0x2::table::contains<address, AdvertiserRecord>(&arg0.advertiser_records, arg1)) {
            let v0 = AdvertiserRecord{
                rejection_count       : 0,
                ban_until_epoch       : 0,
                is_permanently_banned : false,
            };
            0x2::table::add<address, AdvertiserRecord>(&mut arg0.advertiser_records, arg1, v0);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdRegistry{
            id                        : 0x2::object::new(arg0),
            active_campaign_ids       : 0x1::vector::empty<0x2::object::ID>(),
            total_campaigns_submitted : 0,
            total_campaigns_approved  : 0,
            advertiser_records        : 0x2::table::new<address, AdvertiserRecord>(arg0),
        };
        0x2::transfer::share_object<AdRegistry>(v0);
    }

    public fun is_active(arg0: &AdCampaign) : bool {
        arg0.status == 1
    }

    public fun is_advertiser_banned(arg0: &AdRegistry, arg1: address, arg2: u64) : bool {
        if (!0x2::table::contains<address, AdvertiserRecord>(&arg0.advertiser_records, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, AdvertiserRecord>(&arg0.advertiser_records, arg1);
        if (v0.is_permanently_banned) {
            return true
        };
        if (v0.ban_until_epoch > 0 && arg2 < v0.ban_until_epoch) {
            return true
        };
        false
    }

    public fun is_pending(arg0: &AdCampaign) : bool {
        arg0.status == 0
    }

    public fun lift_ban(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut AdRegistry, arg2: address) {
        if (0x2::table::contains<address, AdvertiserRecord>(&arg1.advertiser_records, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, AdvertiserRecord>(&mut arg1.advertiser_records, arg2);
            v0.is_permanently_banned = false;
            v0.ban_until_epoch = 0;
        };
    }

    public fun reject_ad(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut AdRegistry, arg2: &mut AdCampaign, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 6);
        let v0 = arg2.advertiser;
        let v1 = 0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg2.escrowed);
        arg2.status = 2;
        ensure_advertiser_record(arg1, v0);
        let v2 = 0x2::table::borrow_mut<address, AdvertiserRecord>(&mut arg1.advertiser_records, v0);
        v2.rejection_count = v2.rejection_count + 1;
        let v3 = v2.rejection_count;
        if (v3 >= 3) {
            v2.is_permanently_banned = true;
            v2.ban_until_epoch = 18446744073709551615;
            let v4 = AdvertiserBanned{
                advertiser      : v0,
                is_permanent    : true,
                ban_until_epoch : v2.ban_until_epoch,
            };
            0x2::event::emit<AdvertiserBanned>(v4);
        } else if (v3 >= 2) {
            v2.ban_until_epoch = 0x2::tx_context::epoch(arg3) + 30;
            let v5 = AdvertiserBanned{
                advertiser      : v0,
                is_permanent    : false,
                ban_until_epoch : v2.ban_until_epoch,
            };
            0x2::event::emit<AdvertiserBanned>(v5);
        };
        let v6 = AdRejected{
            campaign_id     : 0x2::object::id<AdCampaign>(arg2),
            advertiser      : v0,
            capy_refunded   : v1,
            rejection_count : v3,
        };
        0x2::event::emit<AdRejected>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>>(0x2::coin::from_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(0x2::balance::split<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg2.escrowed, v1), arg3), v0);
    }

    public fun release_daily_budget(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut AdRegistry, arg2: &mut AdCampaign, arg3: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::Treasury, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.status == 1, 7);
        assert!(0x2::tx_context::epoch(arg4) > arg2.last_release_epoch, 8);
        let v0 = 0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg2.escrowed);
        let v1 = if (arg2.daily_budget <= v0) {
            arg2.daily_budget
        } else {
            v0
        };
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::recycle_ad_revenue(arg3, 0x2::balance::split<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg2.escrowed, v1));
        arg2.days_remaining = arg2.days_remaining - 1;
        arg2.last_release_epoch = 0x2::tx_context::epoch(arg4);
        let v2 = DailyBudgetReleased{
            campaign_id     : 0x2::object::id<AdCampaign>(arg2),
            amount_released : v1,
            days_remaining  : arg2.days_remaining,
            epoch           : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<DailyBudgetReleased>(v2);
        if (arg2.days_remaining == 0) {
            arg2.status = 3;
            remove_from_active(arg1, 0x2::object::id<AdCampaign>(arg2));
            let v3 = AdCompleted{
                campaign_id : 0x2::object::id<AdCampaign>(arg2),
                advertiser  : arg2.advertiser,
            };
            0x2::event::emit<AdCompleted>(v3);
        };
    }

    fun remove_from_active(arg0: &mut AdRegistry, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.active_campaign_ids)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.active_campaign_ids, v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(&mut arg0.active_campaign_ids, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun submit_ad(arg0: &mut AdRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u8, arg7: 0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        check_not_banned(arg0, v0, 0x2::tx_context::epoch(arg8));
        assert!(arg5 >= 500000000000 && arg5 <= 100000000000000, 2);
        assert!(arg6 >= 1 && arg6 <= 5, 3);
        assert!(arg4 < 14, 4);
        let v1 = arg5 * (arg6 as u64);
        assert!(0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg7) == v1, 9);
        let v2 = AdCampaign{
            id                 : 0x2::object::new(arg8),
            advertiser         : v0,
            title              : 0x1::string::utf8(arg1),
            content_blob_id    : 0x1::string::utf8(arg2),
            target_url         : 0x1::string::utf8(arg3),
            category           : arg4,
            daily_budget       : arg5,
            days_total         : arg6,
            days_remaining     : arg6,
            status             : 0,
            escrowed           : 0x2::coin::into_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(arg7),
            created_at         : 0x2::tx_context::epoch(arg8),
            approved_at        : 0,
            last_release_epoch : 0,
        };
        arg0.total_campaigns_submitted = arg0.total_campaigns_submitted + 1;
        let v3 = AdSubmitted{
            campaign_id    : 0x2::object::id<AdCampaign>(&v2),
            advertiser     : v0,
            category       : arg4,
            daily_budget   : arg5,
            days_total     : arg6,
            total_escrowed : v1,
        };
        0x2::event::emit<AdSubmitted>(v3);
        0x2::transfer::share_object<AdCampaign>(v2);
    }

    public fun total_approved(arg0: &AdRegistry) : u64 {
        arg0.total_campaigns_approved
    }

    public fun total_submitted(arg0: &AdRegistry) : u64 {
        arg0.total_campaigns_submitted
    }

    // decompiled from Move bytecode v6
}

