module 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::donations {
    struct DonationReceived has copy, drop {
        campaign_id: 0x2::object::ID,
        donor: address,
        coin_type_canonical: 0x1::string::String,
        coin_symbol: 0x1::string::String,
        amount_raw: u64,
        amount_usd_micro: u64,
        platform_amount_raw: u64,
        recipient_amount_raw: u64,
        platform_amount_usd_micro: u64,
        recipient_amount_usd_micro: u64,
        platform_bps: u16,
        platform_address: address,
        recipient_address: address,
        timestamp_ms: u64,
    }

    struct DonationAwardOutcome has copy, drop {
        usd_micro: u64,
        minted_levels: vector<u8>,
    }

    public(friend) fun donate<T0>(arg0: &mut 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::Campaign, arg1: &mut 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign_stats::CampaignStats, arg2: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::TokenRegistry, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        precheck<T0>(arg0, arg2, arg3);
        assert!(0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign_stats::id(arg1) == 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::stats_id(arg0), 8);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::coin::value<T0>(&arg4);
        let v2 = quote_usd_micro<T0>(arg2, arg3, v1, arg5, arg7);
        assert!(v2 >= arg6, 7);
        let v3 = (((v2 as u128) * (0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::payout_platform_bps(arg0) as u128) / (10000 as u128)) as u64);
        let (v4, v5) = split_and_transfer<T0>(arg0, arg4, arg8);
        0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign_stats::add_donation<T0>(arg1, (v1 as u128), v2);
        0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::lock_parameters_if_unlocked(arg0, arg3);
        emit_donation_received_event<T0>(arg0, arg2, v0, v1, v2, v4, v5, v3, v2 - v3, arg3);
        v2
    }

    public fun donate_and_award<T0>(arg0: &mut 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::Campaign, arg1: &mut 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign_stats::CampaignStats, arg2: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::TokenRegistry, arg3: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::badge_rewards::BadgeConfig, arg4: &0x2::clock::Clock, arg5: &mut 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::Profile, arg6: 0x2::coin::Coin<T0>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: &mut 0x2::tx_context::TxContext) : DonationAwardOutcome {
        assert!(0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::owner(arg5) == 0x2::tx_context::sender(arg10), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::not_profile_owner_error_code());
        let v0 = donate<T0>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10);
        0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::add_contribution(arg5, v0);
        DonationAwardOutcome{
            usd_micro     : v0,
            minted_levels : 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::badge_rewards::maybe_award_badges(arg5, arg3, 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::total_usd_micro(arg5), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::total_donations_count(arg5), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::total_usd_micro(arg5), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::total_donations_count(arg5), arg4, arg10),
        }
    }

    public fun donate_and_award_first_time<T0>(arg0: &mut 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::Campaign, arg1: &mut 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign_stats::CampaignStats, arg2: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::TokenRegistry, arg3: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::badge_rewards::BadgeConfig, arg4: &mut 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::ProfilesRegistry, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: &mut 0x2::tx_context::TxContext) : DonationAwardOutcome {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(!0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::exists(arg4, v0), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::profile_exists_error_code());
        let v1 = 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::create_for(arg4, v0, arg5, arg10);
        let v2 = donate<T0>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9, arg10);
        0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::add_contribution(&mut v1, v2);
        0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::transfer_to(v1, v0);
        DonationAwardOutcome{
            usd_micro     : v2,
            minted_levels : 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::badge_rewards::maybe_award_badges(&mut v1, arg3, 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::total_usd_micro(&v1), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::total_donations_count(&v1), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::total_usd_micro(&v1), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::profiles::total_donations_count(&v1), arg5, arg10),
        }
    }

    public fun effective_max_age_ms<T0>(arg0: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::TokenRegistry, arg1: 0x1::option::Option<u64>) : u64 {
        0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::require_enabled<T0>(arg0);
        if (!0x1::option::is_some<u64>(&arg1)) {
            0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::max_age_ms<T0>(arg0)
        } else {
            let v1 = 0x1::option::destroy_some<u64>(arg1);
            if (v1 == 0) {
                0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::max_age_ms<T0>(arg0)
            } else {
                0x1::u64::min(0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::max_age_ms<T0>(arg0), v1)
            }
        }
    }

    public(friend) fun emit_donation_received_event<T0>(arg0: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::Campaign, arg1: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::TokenRegistry, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) {
        0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::require_enabled<T0>(arg1);
        assert!(arg3 == arg5 + arg6, 6);
        assert!(arg4 == arg7 + arg8, 6);
        let v0 = DonationReceived{
            campaign_id                : 0x2::object::id<0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::Campaign>(arg0),
            donor                      : arg2,
            coin_type_canonical        : 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::coin_type_canonical<T0>(),
            coin_symbol                : 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::symbol<T0>(arg1),
            amount_raw                 : arg3,
            amount_usd_micro           : arg4,
            platform_amount_raw        : arg5,
            recipient_amount_raw       : arg6,
            platform_amount_usd_micro  : arg7,
            recipient_amount_usd_micro : arg8,
            platform_bps               : 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::payout_platform_bps(arg0),
            platform_address           : 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::payout_platform_address(arg0),
            recipient_address          : 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::payout_recipient_address(arg0),
            timestamp_ms               : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<DonationReceived>(v0);
    }

    public fun outcome_minted_levels(arg0: &DonationAwardOutcome) : &vector<u8> {
        &arg0.minted_levels
    }

    public fun outcome_usd_micro(arg0: &DonationAwardOutcome) : u64 {
        arg0.usd_micro
    }

    public fun precheck<T0>(arg0: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::Campaign, arg1: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::TokenRegistry, arg2: &0x2::clock::Clock) {
        0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::assert_not_deleted(arg0);
        assert!(0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::is_active(arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::start_date(arg0), 2);
        assert!(v0 <= 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::end_date(arg0), 2);
        assert!(0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::contains<T0>(arg1), 3);
        assert!(0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::is_enabled<T0>(arg1), 3);
    }

    public fun quote_usd_micro<T0>(arg0: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::TokenRegistry, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x1::option::Option<u64>) : u64 {
        assert!(0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::contains<T0>(arg0), 5);
        assert!(0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::is_enabled<T0>(arg0), 3);
        0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::price_oracle::quote_usd<T0>((arg2 as u128), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::decimals<T0>(arg0), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::token_registry::pyth_feed_id<T0>(arg0), arg3, arg1, effective_max_age_ms<T0>(arg0, arg4))
    }

    public fun split_and_transfer<T0>(arg0: &0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::Campaign, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = (((v0 as u128) * (0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::payout_platform_bps(arg0) as u128) / (10000 as u128)) as u64);
        if (v1 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::payout_recipient_address(arg0));
            return (0, v0 - v1)
        };
        if (v1 == v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::payout_platform_address(arg0));
            return (v1, 0)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1, arg2), 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::payout_platform_address(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::payout_recipient_address(arg0));
        (v1, v0 - v1)
    }

    public(friend) fun unpack_donation_received(arg0: &DonationReceived) : (0x2::object::ID, address, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u16, address, address, u64) {
        (arg0.campaign_id, arg0.donor, arg0.coin_type_canonical, arg0.coin_symbol, arg0.amount_raw, arg0.amount_usd_micro, arg0.platform_amount_raw, arg0.recipient_amount_raw, arg0.platform_amount_usd_micro, arg0.recipient_amount_usd_micro, arg0.platform_bps, arg0.platform_address, arg0.recipient_address, arg0.timestamp_ms)
    }

    // decompiled from Move bytecode v6
}

