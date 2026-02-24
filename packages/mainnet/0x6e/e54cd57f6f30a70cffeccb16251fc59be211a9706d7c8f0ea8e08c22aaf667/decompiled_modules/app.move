module 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::app {
    struct PurchaseStorageTierEvent has copy, drop {
        owner: address,
        current_epoch: u32,
        timestamp_ms: u64,
        prev_period: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Period,
        current_period: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Period,
        prev_tier: 0x1::option::Option<u8>,
        current_tier: u8,
        prev_storage_limit: u64,
        current_storage_limit: u64,
        payment: u64,
    }

    struct MembershipSubscribeEvent has copy, drop {
        owner: address,
        member: address,
        level: u8,
        extended_time_ms: u64,
        expired_at: u64,
        monthly_subscription_fee: u64,
    }

    struct DeleteArticleEvent has copy, drop {
        article_id: 0x2::object::ID,
        owner: address,
        current_epoch: u32,
        timestamp_ms: u64,
    }

    struct UpdateArticleSubscriptionLevelEvent has copy, drop {
        article_id: 0x2::object::ID,
        owner: address,
        prev_level: 0x1::option::Option<u8>,
        new_level: 0x1::option::Option<u8>,
    }

    struct DonateEvent has copy, drop {
        recipient: address,
        value: u64,
        message: 0x1::string::String,
    }

    struct ReferralEvent has copy, drop {
        value: u64,
        referrer: address,
    }

    struct ReferralEarningEvent has copy, drop {
        referrer: address,
        referee: address,
        value: u64,
    }

    struct App has drop {
        dummy_field: bool,
    }

    struct PublishReceipt {
        studio_id: 0x2::object::ID,
        work_id: 0x2::object::ID,
    }

    public fun allocate_storage_and_register_blob(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg4: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg5: u256, arg6: u256, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg10);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::assert_owner(arg4, arg10);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_studio_time_validity(arg1, arg9);
        let (v0, v1) = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::borrow_wal_treasury_with_storage_space(arg3, arg4, arg9);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::add_storage_space_accumulated_budget(arg3, arg4, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::wal_treasury(arg3) - 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::wal_treasury(arg3), v1);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg2, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::allocate_storage_from_treasury(arg3, arg4, arg2, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2), 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::month_duration_in_walrus_epoch(), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::encoding::encoded_blob_length(arg7, arg8, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::n_shards(arg2)), arg10), arg5, arg6, arg7, arg8, true, v0, arg10)
    }

    public fun allocate_storage_and_register_blob_with_payment(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg4: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg5: u256, arg6: u256, arg7: u64, arg8: u8, arg9: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg11);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::assert_owner(arg4, arg11);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_studio_time_validity(arg1, arg10);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg2, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::allocate_storage_from_treasury(arg3, arg4, arg2, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2), 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::month_duration_in_walrus_epoch(), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::encoding::encoded_blob_length(arg7, arg8, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::n_shards(arg2)), arg11), arg5, arg6, arg7, arg8, true, arg9, arg11)
    }

    public fun burn_article(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_manager(arg0, 0x2::tx_context::sender(arg6));
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::burn_article(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun burn_or_keep_positive_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun calculate_refund_amount(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg1: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier, arg2: u64) : u64 {
        (((0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_price(arg1) as u128) * (((0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::end_at(arg0) - arg2) / 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::day_in_milliesecond()) as u128) / ((0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_duration_days(arg1) as u64) as u128)) as u64)
    }

    public fun certify_article_blob(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::object::ID, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        let v0 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::blobs_mut(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::asset_of_mut<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article>(arg1, arg3));
        assert!(arg4 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0), 109);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::certify_blob(arg2, 0x1::vector::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0, arg4), arg5, arg6, arg7);
    }

    fun check_storage_capacity(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier) {
        let v0 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::storage_used(arg0);
        let v1 = 0;
        while (v1 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::max_epochs_ahead(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::future_accounting(arg1))) {
            let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1) + v1;
            if (0x2::vec_map::contains<u32, u64>(&v0, &v2)) {
                assert!(*0x2::vec_map::get<u32, u64>(&v0, &v2) <= 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_storage_limit(arg2), 103);
                v1 = v1 + 1;
            } else {
                break
            };
        };
    }

    public fun delete_article(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg6);
        let v0 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::asset_of_mut<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article>(arg1, arg4);
        assert!(!0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::is_expired(v0, arg3), 107);
        assert!(!0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::deleted(v0), 108);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::delete_article(v0, arg2);
        let v1 = DeleteArticleEvent{
            article_id    : arg4,
            owner         : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg1),
            current_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<DeleteArticleEvent>(v1);
    }

    public fun donate<T0>(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::treasury::Treasury, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_allowed_stablecoins<T0>(arg0);
        assert!(0x1::string::length(&arg3) <= 150, 112);
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x2::coin::split<T0>(&mut arg4, (((v0 as u128) * (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::platform_fee_bps(arg0) as u128) / (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::fee_scaling() as u128)) as u64), arg6);
        let v2 = &mut v1;
        handle_referral<T0>(arg0, arg1, v2, arg5, arg6);
        let v3 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg1);
        let v4 = DonateEvent{
            recipient : v3,
            value     : v0,
            message   : arg3,
        };
        0x2::event::emit<DonateEvent>(v4);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::add_earnings(arg1, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::donation_earning_key(), v0);
        0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::treasury::supply_treasury<T0>(arg2, 0x2::coin::into_balance<T0>(v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v3);
    }

    public fun finalize_publish_article(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: PublishReceipt, arg3: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article, arg4: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg4);
        let PublishReceipt {
            studio_id : v0,
            work_id   : v1,
        } = arg2;
        assert!(v0 == 0x2::object::id<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio>(arg1), 111);
        assert!(v1 == 0x2::object::id<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article>(&arg3), 110);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::add_asset<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article>(arg1, arg0, arg3, arg4);
    }

    fun handle_new_or_expired_purchase(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg2: u8, arg3: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier, arg4: u64) : u64 {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::update_start_at(arg0, arg4);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::update_end_at(arg0, arg4 + 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_duration(arg3));
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::update_tier(arg1, arg2);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_price(arg3)
    }

    fun handle_referral<T0>(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::referral::is_referral_exists(arg1)) {
            let v0 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::referral::referral_mut(arg1);
            if (0x2::clock::timestamp_ms(arg3) < 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::referral::expired_at(v0) && 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::total_earning(arg1) < 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::referral::max_cap(arg0)) {
                let v1 = 0x2::coin::value<T0>(arg2);
                let v2 = 0x1::u64::min(v1, (((v1 as u128) * (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::referral::share_percentage_bps(arg0) as u128) / (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::platform_fee_bps(arg0) as u128)) as u64));
                if (v2 > 0) {
                    let v3 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::referral::referrer(v0);
                    let v4 = ReferralEarningEvent{
                        referrer : v3,
                        referee  : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg1),
                        value    : v2,
                    };
                    0x2::event::emit<ReferralEarningEvent>(v4);
                    0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::referral::add_referrer_earning(v0, v2);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, v2, arg4), v3);
                };
            };
        };
    }

    fun handle_tier_change(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg2: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg3: u8, arg4: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier, arg5: u8, arg6: u64) : u64 {
        let v0 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_plan(arg2);
        let v1 = calculate_refund_amount(arg0, *0x2::vec_map::get<u8, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier>(&v0, &arg5), arg6);
        update_tier_and_timing(arg0, arg1, arg3, arg4, arg6);
        let v2 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_price(arg4);
        if (v2 >= v1) {
            v2 - v1
        } else {
            0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::add_credits(arg1, v1 - v2);
            0
        }
    }

    fun handle_tier_downgrade(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg2: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg3: u8, arg4: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier, arg5: u8, arg6: u64) : u64 {
        handle_tier_change(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun handle_tier_renewal(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg1: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier) : u64 {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::update_end_at(arg0, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::end_at(arg0) + 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_duration(arg1));
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_price(arg1)
    }

    fun handle_tier_upgrade(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg2: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg3: u8, arg4: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier, arg5: u8, arg6: u64) : u64 {
        handle_tier_change(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun payout<T0>(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::treasury::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        assert!(0x2::coin::value<T0>(&arg2) >= 100, 101);
        0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::treasury::supply_treasury<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 100, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg3);
    }

    public fun purchase_storage_tier<T0>(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::treasury::Treasury, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg5: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg6: u8, arg7: &mut 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_allowed_stablecoins<T0>(arg0);
        let v0 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_plan(arg4);
        assert!(0x2::vec_map::contains<u8, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier>(&v0, &arg6), 102);
        let v1 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::period(arg1);
        let v2 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier(arg5);
        let v3 = if (0x1::option::is_none<u8>(&v2)) {
            0
        } else {
            let v4 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_plan(arg4);
            0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_storage_limit(*0x2::vec_map::get<u8, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier>(&v4, 0x1::option::borrow<u8>(&v2)))
        };
        let v5 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_plan(arg4);
        let v6 = *0x2::vec_map::get<u8, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier>(&v5, &arg6);
        let v7 = if (!0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::is_in_valid_period(arg1, arg8)) {
            handle_new_or_expired_purchase(arg1, arg5, arg6, v6, 0x2::clock::timestamp_ms(arg8))
        } else {
            let v8 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier(arg5);
            if (0x1::option::is_some<u8>(&v8)) {
                let v9 = 0x1::option::extract<u8>(&mut v8);
                if (arg6 == v9) {
                    handle_tier_renewal(arg1, v6)
                } else if (arg6 > v9) {
                    handle_tier_upgrade(arg1, arg5, arg4, arg6, v6, v9, 0x2::clock::timestamp_ms(arg8))
                } else {
                    check_storage_capacity(arg5, arg3, v6);
                    handle_tier_downgrade(arg1, arg5, arg4, arg6, v6, v9, 0x2::clock::timestamp_ms(arg8))
                }
            } else {
                handle_new_or_expired_purchase(arg1, arg5, arg6, v6, 0x2::clock::timestamp_ms(arg8))
            }
        };
        let v10 = v7;
        let v11 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::credits(arg5);
        if (v11 > 0 && v7 > 0) {
            let v12 = 0x1::u64::min(v7, v11);
            0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::subtract_credits(arg5, v12);
            v10 = v7 - v12;
        };
        assert!(0x2::coin::value<T0>(arg7) >= v10, 101);
        if (v10 > 0) {
            0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::treasury::supply_treasury<T0>(arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg7, v10, arg9)));
        };
        let v13 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_plan(arg4);
        let v14 = PurchaseStorageTierEvent{
            owner                 : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg1),
            current_epoch         : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3),
            timestamp_ms          : 0x2::clock::timestamp_ms(arg8),
            prev_period           : v1,
            current_period        : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::period(arg1),
            prev_tier             : v2,
            current_tier          : arg6,
            prev_storage_limit    : v3,
            current_storage_limit : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_storage_limit(*0x2::vec_map::get<u8, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier>(&v13, &arg6)),
            payment               : 0x2::coin::value<T0>(arg7) - 0x2::coin::value<T0>(arg7),
        };
        0x2::event::emit<PurchaseStorageTierEvent>(v14);
    }

    public fun renew_article_with_storage_treasury(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg4: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_studio_time_validity(arg1, arg6);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::renew_article_with_storage_treasury(arg1, arg2, arg4, arg3, arg5, arg7);
    }

    public fun renew_article_with_wal_payment(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::object::ID, arg4: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &0x2::clock::Clock) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_studio_time_validity(arg1, arg5);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::renew_article_with_wal_payment(arg1, arg2, arg3, arg4);
    }

    public fun set_monthly_subscription_fee(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg4);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_exceed_max_subscription_level(arg0, arg2);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::update_monthly_subscription_fee(arg1, arg2, arg3);
    }

    public fun setup_file_key(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg3);
        assert!(0x1::option::is_none<vector<u8>>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::encrypted_file_key(arg1)), 105);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::update_encrypted_file_key(arg1, arg2);
    }

    public fun start_publish_article(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg4: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg5: 0x1::option::Option<u8>, arg6: vector<u256>, arg7: vector<u256>, arg8: vector<u64>, arg9: u8, arg10: vector<0x1::ascii::String>, arg11: vector<u64>, arg12: vector<0x1::ascii::String>, arg13: vector<u64>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article, PublishReceipt) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg15);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_studio_time_validity(arg1, arg14);
        assert!(0x1::option::is_some<vector<u8>>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::encrypted_file_key(arg1)), 106);
        if (0x1::option::is_some<u8>(&arg5)) {
            0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_subscription_level_setup(arg1, *0x1::option::borrow<u8>(&arg5));
        };
        let v0 = 0x1::vector::length<u256>(&arg6);
        assert!(v0 != 0, 113);
        assert!(v0 == 0x1::vector::length<u256>(&arg7) && v0 == 0x1::vector::length<u64>(&arg8), 114);
        let v1 = 0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = allocate_storage_and_register_blob(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u256>(&arg6, v2), *0x1::vector::borrow<u256>(&arg7, v2), *0x1::vector::borrow<u64>(&arg8, v2), arg9, arg14, arg15);
            0x1::vector::push_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::publish_article(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg1), v1, arg5, 0x2::vec_set::from_keys<0x1::ascii::String>(arg10), arg11, arg12, arg13, arg14, arg15);
        let v5 = PublishReceipt{
            studio_id : 0x2::object::id<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio>(arg1),
            work_id   : 0x2::object::id<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article>(&v4),
        };
        (v4, v5)
    }

    public fun start_publish_article_with_wal_payment(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTreasury, arg4: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg5: 0x1::option::Option<u8>, arg6: vector<u256>, arg7: vector<u256>, arg8: vector<u64>, arg9: u8, arg10: vector<0x1::ascii::String>, arg11: vector<u64>, arg12: vector<0x1::ascii::String>, arg13: vector<u64>, arg14: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article, PublishReceipt) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg16);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_studio_time_validity(arg1, arg15);
        assert!(0x1::option::is_some<vector<u8>>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::encrypted_file_key(arg1)), 106);
        if (0x1::option::is_some<u8>(&arg5)) {
            0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_subscription_level_setup(arg1, *0x1::option::borrow<u8>(&arg5));
        };
        let v0 = 0x1::vector::length<u256>(&arg6);
        assert!(v0 != 0, 113);
        assert!(v0 == 0x1::vector::length<u256>(&arg7) && v0 == 0x1::vector::length<u64>(&arg8), 114);
        let v1 = 0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = allocate_storage_and_register_blob_with_payment(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u256>(&arg6, v2), *0x1::vector::borrow<u256>(&arg7, v2), *0x1::vector::borrow<u64>(&arg8, v2), arg9, arg14, arg15, arg16);
            0x1::vector::push_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::publish_article(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg1), v1, arg5, 0x2::vec_set::from_keys<0x1::ascii::String>(arg10), arg11, arg12, arg13, arg15, arg16);
        let v5 = PublishReceipt{
            studio_id : 0x2::object::id<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio>(arg1),
            work_id   : 0x2::object::id<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article>(&v4),
        };
        (v4, v5)
    }

    public fun subscribe_to_studio<T0>(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg1: &mut 0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::treasury::Treasury, arg2: u8, arg3: &mut 0x2::coin::Coin<T0>, arg4: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg4);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg4);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_allowed_stablecoins<T0>(arg4);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_subscription_level_setup(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 != 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg0), 104);
        let v1 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::monthly_subscription_fee(arg0);
        let v2 = *0x2::vec_map::get<u8, u64>(&v1, &arg2);
        assert!(0x2::coin::value<T0>(arg3) >= v2, 101);
        let v3 = 0x2::coin::value<T0>(arg3) / v2;
        let v4 = 0x2::coin::split<T0>(arg3, v3 * v2, arg6);
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = 0x2::coin::split<T0>(&mut v4, (((0x2::coin::value<T0>(&v4) as u128) * (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::platform_fee_bps(arg4) as u128) / (0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::fee_scaling() as u128)) as u64), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg0));
        let v7 = 2592000000 * v3;
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::add_earnings(arg0, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::membership_subscription_earning_key(), v5);
        let v8 = MembershipSubscribeEvent{
            owner                    : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg0),
            member                   : v0,
            level                    : arg2,
            extended_time_ms         : v7,
            expired_at               : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::add_membership(arg0, v0, arg2, v7, arg5),
            monthly_subscription_fee : v5,
        };
        0x2::event::emit<MembershipSubscribeEvent>(v8);
        let v9 = &mut v6;
        handle_referral<T0>(arg4, arg0, v9, arg5, arg6);
        0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::treasury::supply_treasury<T0>(arg1, 0x2::coin::into_balance<T0>(v6));
    }

    public fun update_article_subscription_level(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::object::ID, arg4: 0x1::option::Option<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_studio_time_validity(arg1, arg5);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg6);
        let v0 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::asset_of_mut<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::Article>(arg1, arg3);
        assert!(!0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::is_expired(v0, arg2), 107);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::update_article_subscription_level(v0, arg4);
        let v1 = UpdateArticleSubscriptionLevelEvent{
            article_id : arg3,
            owner      : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::owner(arg1),
            prev_level : 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::article::subscription_level(v0),
            new_level  : arg4,
        };
        0x2::event::emit<UpdateArticleSubscriptionLevelEvent>(v1);
    }

    public fun update_file_key(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::assert_owner(arg1, arg3);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::update_encrypted_file_key(arg1, arg2);
    }

    fun update_tier_and_timing(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::Studio, arg1: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace, arg2: u8, arg3: 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageTier, arg4: u64) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::update_tier(arg1, arg2);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::update_start_at(arg0, arg4);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio::update_end_at(arg0, arg4 + 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::tier_duration(arg3));
    }

    // decompiled from Move bytecode v6
}

