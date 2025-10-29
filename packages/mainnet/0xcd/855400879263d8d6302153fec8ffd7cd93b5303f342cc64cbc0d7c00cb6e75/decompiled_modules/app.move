module 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::app {
    struct App has drop {
        dummy_field: bool,
    }

    struct PurchaseStorageTier has copy, drop {
        owner: address,
        current_epoch: u32,
        timestamp_ms: u64,
        prev_period: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Period,
        current_period: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Period,
        prev_tier: 0x1::option::Option<u8>,
        current_tier: u8,
        prev_storage_limit: u64,
        current_storage_limit: u64,
        payment: u64,
    }

    struct PublishReceipt {
        owner: address,
        work_id: 0x2::object::ID,
    }

    public fun allocate_storage_and_register_blob(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTreasury, arg4: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg5: u256, arg6: u256, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg10);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::assert_owner(arg4, arg10);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_studio_time_validity(arg1, arg9);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg2, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::allocate_storage_from_treasury(arg3, arg4, arg2, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2), 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::month_duration_in_walrus_epoch(), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::encoding::encoded_blob_length(arg7, arg8, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::n_shards(arg2)), arg10), arg5, arg6, arg7, arg8, true, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::wal_treasury_mut(arg3), arg10)
    }

    public fun article_blob_add_metadata(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: 0x2::object::ID, arg3: u64, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata, arg5: &0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg5);
        let v0 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::blobs_mut(0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::asset_of_mut<0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article>(arg1, arg2));
        assert!(arg3 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0), 107);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::add_metadata(0x1::vector::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0, arg3), arg4);
    }

    public fun article_blob_insert_or_update_metadata_pair(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg6);
        let v0 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::blobs_mut(0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::asset_of_mut<0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article>(arg1, arg2));
        assert!(arg3 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0), 107);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::insert_or_update_metadata_pair(0x1::vector::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0, arg3), arg4, arg5);
    }

    public fun article_blob_remove_metadata(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg5);
        let v0 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::blobs_mut(0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::asset_of_mut<0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article>(arg1, arg2));
        assert!(arg3 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0), 107);
        let (_, _) = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::remove_metadata_pair(0x1::vector::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0, arg3), &arg4);
    }

    public fun burn_article_by_admin(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::burn_article(arg2, arg3, arg4, arg5);
    }

    fun calculate_refund_amount(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg1: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier, arg2: u64) : u64 {
        (((0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_price(arg1) as u128) * (((0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::end_at(arg0) - arg2) / 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::day_in_milliesecond()) as u128) / ((0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_duration_days(arg1) as u64) as u128)) as u64)
    }

    public fun certify_article_blob(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::object::ID, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        let v0 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::blobs_mut(0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::asset_of_mut<0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article>(arg1, arg3));
        assert!(arg4 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0), 107);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::certify_blob(arg2, 0x1::vector::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v0, arg4), arg5, arg6, arg7);
    }

    fun check_storage_capacity(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier) {
        let v0 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::storage_used(arg0);
        let v1 = 0;
        while (v1 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::max_epochs_ahead(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::future_accounting(arg1))) {
            let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1) + v1;
            if (0x2::vec_map::contains<u32, u64>(&v0, &v2)) {
                assert!(*0x2::vec_map::get<u32, u64>(&v0, &v2) <= 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_storage_limit(arg2), 103);
                v1 = v1 + 1;
            } else {
                break
            };
        };
    }

    public fun claim<T0, T1>(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::donation::Donation, arg3: &0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::IdentityManager<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg4);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_allowed_stablecoins<T1>(arg0);
        let v0 = App{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::donation::take_all_by_identifier<T1>(arg2, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::identifier_by_address_with_whitelist<T0, App>(arg3, v0, 0x2::tx_context::sender(arg4))), arg4), 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::owner(arg1));
    }

    public fun delete_article(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTreasury, arg3: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg7);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::assert_owner(arg3, arg7);
        assert!(!0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::is_expired(0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::asset_of<0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article>(arg1, arg5), arg4), 106);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::delete_article(arg1, arg3, arg2, arg4, arg5, arg6, arg7);
    }

    public fun donate<T0>(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::donation::Donation, arg2: 0x1::ascii::String, arg3: &mut 0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::treasury::Treasury, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_allowed_stablecoins<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg4);
        } else {
            0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::treasury::supply_treasury<T0>(arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, (((v0 as u128) * (0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::platform_fee_bps(arg0) as u128) / (0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::fee_scaling() as u128)) as u64), arg5)));
            0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::donation::donate<T0>(arg1, arg2, arg4, arg5);
        };
    }

    public fun finalize_publish_article(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: PublishReceipt, arg3: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article, arg4: &0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg4);
        let PublishReceipt {
            owner   : v0,
            work_id : v1,
        } = arg2;
        assert!(v0 == 0x2::tx_context::sender(arg4), 109);
        assert!(v1 == 0x2::object::id<0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article>(&arg3), 108);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::add_asset<0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article>(arg1, arg0, arg3, arg4);
    }

    fun handle_new_or_expired_purchase(arg0: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg2: u8, arg3: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier, arg4: u64) : u64 {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::update_start_at(arg0, arg4);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::update_end_at(arg0, arg4 + 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_duration(arg3));
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::update_tier(arg1, arg2);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_price(arg3)
    }

    fun handle_tier_change(arg0: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg2: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTreasury, arg3: u8, arg4: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier, arg5: u8, arg6: u64) : u64 {
        let v0 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_plan(arg2);
        let v1 = calculate_refund_amount(arg0, *0x2::vec_map::get<u8, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier>(&v0, &arg5), arg6);
        update_tier_and_timing(arg0, arg1, arg3, arg4, arg6);
        let v2 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_price(arg4);
        if (v2 >= v1) {
            v2 - v1
        } else {
            0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::add_credits(arg1, v1 - v2);
            0
        }
    }

    fun handle_tier_downgrade(arg0: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg2: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTreasury, arg3: u8, arg4: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier, arg5: u8, arg6: u64) : u64 {
        handle_tier_change(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun handle_tier_renewal(arg0: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg1: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier) : u64 {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::update_end_at(arg0, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::end_at(arg0) + 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_duration(arg1));
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_price(arg1)
    }

    fun handle_tier_upgrade(arg0: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg2: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTreasury, arg3: u8, arg4: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier, arg5: u8, arg6: u64) : u64 {
        handle_tier_change(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun publish_article(arg0: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg1: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg2: vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: vector<bool>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg1);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg0, arg9);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_studio_time_validity(arg0, arg8);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::publish_article(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun publish_article_v1(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTreasury, arg4: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg5: u256, arg6: u256, arg7: u64, arg8: u8, arg9: vector<0x1::ascii::String>, arg10: vector<u64>, arg11: vector<0x1::ascii::String>, arg12: vector<u64>, arg13: vector<bool>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg15);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_studio_time_validity(arg1, arg14);
        let v0 = allocate_storage_and_register_blob(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg14, arg15);
        let v1 = 0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>();
        0x1::vector::push_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v1, v0);
        (0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v0), 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::publish_article(arg1, arg0, v1, arg9, arg10, arg11, arg12, arg13, arg14, arg15))
    }

    public fun purchase_storage_tier<T0>(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: &mut 0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::treasury::Treasury, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTreasury, arg5: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg6: u8, arg7: &mut 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_allowed_stablecoins<T0>(arg0);
        let v0 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_plan(arg4);
        assert!(0x2::vec_map::contains<u8, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier>(&v0, &arg6), 102);
        let v1 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::period(arg1);
        let v2 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier(arg5);
        let v3 = if (0x1::option::is_none<u8>(&v2)) {
            0
        } else {
            let v4 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_plan(arg4);
            0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_storage_limit(*0x2::vec_map::get<u8, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier>(&v4, 0x1::option::borrow<u8>(&v2)))
        };
        let v5 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_plan(arg4);
        let v6 = *0x2::vec_map::get<u8, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier>(&v5, &arg6);
        let v7 = if (!0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::is_in_valid_period(arg1, arg8)) {
            handle_new_or_expired_purchase(arg1, arg5, arg6, v6, 0x2::clock::timestamp_ms(arg8))
        } else {
            let v8 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier(arg5);
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
        let v11 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::credits(arg5);
        if (v11 > 0 && v7 > 0) {
            let v12 = 0x1::u64::min(v7, v11);
            0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::subtract_credits(arg5, v12);
            v10 = v7 - v12;
        };
        assert!(0x2::coin::value<T0>(arg7) >= v10, 101);
        if (v10 > 0) {
            0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::treasury::supply_treasury<T0>(arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg7, v10, arg9)));
        };
        let v13 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_plan(arg4);
        let v14 = PurchaseStorageTier{
            owner                 : 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::owner(arg1),
            current_epoch         : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3),
            timestamp_ms          : 0x2::clock::timestamp_ms(arg8),
            prev_period           : v1,
            current_period        : 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::period(arg1),
            prev_tier             : v2,
            current_tier          : arg6,
            prev_storage_limit    : v3,
            current_storage_limit : 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_storage_limit(*0x2::vec_map::get<u8, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier>(&v13, &arg6)),
            payment               : 0x2::coin::value<T0>(arg7) - 0x2::coin::value<T0>(arg7),
        };
        0x2::event::emit<PurchaseStorageTier>(v14);
    }

    public fun renew_article_with_storage_treasury(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTreasury, arg4: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_studio_time_validity(arg1, arg6);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::renew_article_with_storage_treasury(arg1, arg2, arg4, arg3, arg5, arg7);
    }

    public fun renew_article_with_wal_payment(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::object::ID, arg4: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &0x2::clock::Clock) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_studio_time_validity(arg1, arg5);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::renew_article_with_wal_payment(arg1, arg2, arg3, arg4);
    }

    public fun set_monthly_subscription_fee(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: 0x1::option::Option<u64>, arg3: &0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg3);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::update_monthly_subscription_fee(arg1, arg2);
    }

    public fun start_publish_article(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTreasury, arg4: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg5: u256, arg6: u256, arg7: u64, arg8: u8, arg9: vector<0x1::ascii::String>, arg10: vector<u64>, arg11: vector<0x1::ascii::String>, arg12: vector<u64>, arg13: vector<bool>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article, PublishReceipt) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_owner(arg1, arg15);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_studio_time_validity(arg1, arg14);
        let v0 = allocate_storage_and_register_blob(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg14, arg15);
        let v1 = 0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>();
        0x1::vector::push_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v1, v0);
        let v2 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::publish_article_v1(v1, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v3 = PublishReceipt{
            owner   : 0x2::tx_context::sender(arg15),
            work_id : 0x2::object::id<0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::article::Article>(&v2),
        };
        (v2, v3)
    }

    public fun subscribe_to_studio<T0>(arg0: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg1: &mut 0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::treasury::Treasury, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg3);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::assert_content_is_accessible(arg0);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_allowed_stablecoins<T0>(arg3);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::owner(arg0), 104);
        let v1 = 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::monthly_subscription_fee(arg0);
        let v2 = *0x1::option::borrow<u64>(&v1);
        assert!(0x2::coin::value<T0>(arg2) >= v2, 101);
        let v3 = 0x2::coin::value<T0>(arg2) / v2;
        let v4 = 0x2::coin::split<T0>(arg2, v3 * v2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::owner(arg0));
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::add_membership(arg0, v0, 2592000000 * v3, arg4);
        0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::treasury::supply_treasury<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, (((0x2::coin::value<T0>(&v4) as u128) * (0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::platform_fee_bps(arg3) as u128) / (0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::fee_scaling() as u128)) as u64), arg5)));
    }

    fun update_tier_and_timing(arg0: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg1: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace, arg2: u8, arg3: 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageTier, arg4: u64) {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::update_tier(arg1, arg2);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::update_start_at(arg0, arg4);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::update_end_at(arg0, arg4 + 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::tier_duration(arg3));
    }

    // decompiled from Move bytecode v6
}

