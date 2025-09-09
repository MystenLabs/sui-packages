module 0x4e9d6df03ac673389bafd4f6a1941dcc42952d96a01836cf6d5e1ed596a599b::marketplace {
    struct MarketPlaceFeeClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchpadCap has store, key {
        id: 0x2::object::UID,
    }

    struct TraitBidsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TraitBidsPotato {
        id: 0x2::object::ID,
    }

    struct MarketPlace has key {
        id: 0x2::object::UID,
        redeem_fee_disc_cap: 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::RedeemFeeDiscCap,
        gearbox_points_cap: 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxPointsCap,
        config: ConfigInfo,
        available_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        withdrawable_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        user_activity: 0x2::linked_table::LinkedTable<address, UserInfo>,
        active_collections: 0x2::linked_table::LinkedTable<0x1::ascii::String, bool>,
        referrals: 0x2::linked_table::LinkedTable<address, u64>,
        referral_earnings: 0x2::linked_table::LinkedTable<address, u64>,
        referral_pool: 0x2::balance::Balance<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>,
        kiosk_id: 0x2::object::ID,
        escrow_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        pending_claims: 0x2::linked_table::LinkedTable<address, PendingClaims>,
        simulated_yearly_fee: u64,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct ConfigInfo has store {
        is_permissionless: bool,
        new_collection_fee: u64,
        commission_pct: u64,
        ggsui_share_pct: u64,
        max_leverage_allowed: u64,
    }

    struct PendingClaims has store {
        pending_claims: 0x2::linked_table::LinkedTable<0x2::object::ID, PendingClaim>,
    }

    struct PendingClaim has store {
        buyer: address,
        nft_type: 0x1::ascii::String,
        price: u64,
        commission: u64,
        royalty: u64,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        listings: 0x2::linked_table::LinkedTable<0x2::object::ID, ListingInfo>,
        bid_pool_identifiers: vector<0x1::ascii::String>,
        bid_pools: 0x2::linked_table::LinkedTable<0x1::ascii::String, BidPool>,
        bids: 0x2::linked_table::LinkedTable<0x2::object::ID, BidInfo>,
        collection_bids: 0x2::linked_table::LinkedTable<0x1::ascii::String, vector<BidInfo>>,
        trait_bids: 0x2::linked_table::LinkedTable<0x1::ascii::String, vector<TraitBidInfo>>,
        claimable_points: u64,
    }

    struct ListingInfo has drop, store {
        nft_type: 0x1::ascii::String,
        price: u64,
        commission: u64,
        royalty: u64,
        listed_at: u64,
        points: u64,
        last_points_claimed_at: u64,
    }

    struct BidPool has store {
        bid_pool_identifier: 0x1::ascii::String,
        ggsui_balance: 0x2::balance::Balance<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>,
        sui_added: u64,
        sui_bidded: u64,
    }

    struct BidInfo has drop, store {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bid_pool_identifier: 0x1::ascii::String,
        bid_price: u64,
        commission: u64,
        royalty: u64,
        is_collection_bid: bool,
        bid_at: u64,
        points: u64,
        last_points_claimed_at: u64,
    }

    struct TraitBidInfo has drop, store {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bid_pool_identifier: 0x1::ascii::String,
        bid_price: u64,
        commission: u64,
        royalty: u64,
        trait_key1: 0x1::option::Option<0x1::ascii::String>,
        trait_value1: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key2: 0x1::option::Option<0x1::ascii::String>,
        trait_value2: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key3: 0x1::option::Option<0x1::ascii::String>,
        trait_value3: 0x1::option::Option<vector<0x1::ascii::String>>,
        bid_at: u64,
        last_points_claimed_at: u64,
    }

    struct TypeMarket<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        listings: 0x2::linked_table::LinkedTable<0x2::object::ID, Listing<T0>>,
        bids: 0x2::linked_table::LinkedTable<0x2::object::ID, ActiveBids>,
        collection_bids: 0x2::linked_table::LinkedTable<address, vector<ActiveBid>>,
        are_trait_bids_enabled: bool,
        lifetime_volume: u128,
        points_enabled: bool,
        points_multiplier: u64,
        weight: u64,
        avg_sale_price: u64,
        recent_sale_prices: vector<u64>,
        simulated_yearly_fee: u64,
        avg_time_bw_trades: u64,
        recent_trades_times: vector<u64>,
    }

    struct Listing<phantom T0: store + key> has store {
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        royalty: u64,
        commission: u64,
        points: u64,
        last_points_claimed_at: u64,
        listed_at: u64,
    }

    struct ActiveBids has store, key {
        id: 0x2::object::UID,
        bids: 0x2::linked_table::LinkedTable<address, ActiveBid>,
    }

    struct ActiveBid has store, key {
        id: 0x2::object::UID,
        bidder: address,
        bid_price: u64,
        bid_pool_identifier: 0x1::ascii::String,
        bid_at: u64,
        commission: u64,
        royalty: u64,
        points: u64,
        last_points_claimed_at: u64,
    }

    struct ActiveTraitBid has store, key {
        id: 0x2::object::UID,
        bidder: address,
        bid_pool_identifier: 0x1::ascii::String,
        bid_price: u64,
        bid_at: u64,
        trait_key1: 0x1::option::Option<0x1::ascii::String>,
        trait_value1: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key2: 0x1::option::Option<0x1::ascii::String>,
        trait_value2: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key3: 0x1::option::Option<0x1::ascii::String>,
        trait_value3: 0x1::option::Option<vector<0x1::ascii::String>>,
        commission: u64,
        royalty: u64,
        points: u64,
        last_points_claimed_at: u64,
    }

    struct UpdateActiveCollectionsEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        boolean: bool,
    }

    struct DistributeAccumulatedFeeEvent has copy, drop {
        for_ggsui: u64,
        remaining_sui: u64,
    }

    struct UpdateGearBoxMultiplierEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        are_gearbox_points_enabled: bool,
        points_multiplier: u64,
    }

    struct UpdatePermissionlessStatusEvent has copy, drop {
        is_permissionless: bool,
    }

    struct ListEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
        commission: u64,
        royalty: u64,
        total_cost: u64,
        points: u64,
        listed_at: u64,
    }

    struct UnlistEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        seller: address,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        unlisted_at: u64,
    }

    struct MakeBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        buyer: address,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        bid_pool_identifier: 0x1::ascii::String,
        price: u64,
        commission: u64,
        royalty: u64,
        total_cost: u64,
        is_collection_bid: bool,
        bid_at: u64,
        points: u64,
    }

    struct CancelBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bidder: address,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        bid_pool_identifier: 0x1::ascii::String,
        is_collection_bid: bool,
        cancelled_at: u64,
        points: u64,
    }

    struct BuyEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        seller_kiosk: 0x2::object::ID,
        price: u64,
        commission: u64,
    }

    struct AwardPointsEvent has copy, drop {
        user_address: address,
        points_earned: u64,
        add_points: u64,
        referrer_address: 0x1::option::Option<address>,
        referral_points: u64,
        bonus_points: u64,
        total_points: u64,
    }

    struct BidPoolDepositedEvent has copy, drop {
        user: address,
        bid_pool_identifier: 0x1::ascii::String,
        amount: u64,
        staked_ggsui: u64,
        new_ggsui_balance: u64,
    }

    struct BidPoolWithdrawnEvent has copy, drop {
        user: address,
        bid_pool_identifier: 0x1::ascii::String,
        new_balance: u64,
        total_bidded: u64,
    }

    struct BidPoolRemovedEvent has copy, drop {
        user: address,
        bid_pool_identifier: 0x1::ascii::String,
    }

    struct BidPoolUpdatedEvent has copy, drop {
        user: address,
        bid_pool_identifier: 0x1::ascii::String,
        new_balance: u64,
        total_bidded: u64,
    }

    struct ReferralPointsClaimedEvent has copy, drop {
        user_address: address,
        claimable_points: u64,
        referral_points: u64,
        bonus_points: u64,
        total_points: u64,
    }

    struct BidAcceptedEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        is_collection_bid: bool,
        price: u64,
        commission: u64,
        escrow_kiosk: 0x2::object::ID,
    }

    struct NFTClaimedEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        buyer_kiosk: 0x2::object::ID,
        claimed_at: u64,
    }

    struct UpdateTraitBiddingSupportEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        are_trait_bids_enabled: bool,
    }

    public entry fun list<T0: store + key>(arg0: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxChef, arg1: &mut MarketPlace, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBox, arg6: 0x2::object::ID, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"=== LISTING NFT ===");
        0x1::debug::print<0x1::string::String>(&v0);
        validation_check(arg1);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        let v3 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v4 = 0x2::clock::timestamp_ms(arg8);
        validate_collection_exists<T0>(arg1);
        let (v5, v6) = get_royalty_and_commission<T0>(arg2, arg1.config.commission_pct, arg7);
        let v7 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, TypeMarket<T0>>(&arg1.id, v3);
        let v8 = calc_listing_points(arg7, v7.points_enabled, v7.avg_sale_price, v7.weight, v7.points_multiplier);
        if (!0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::is_pre_launch_phase(arg0)) {
            add_to_box_with_referral(v1, arg1, arg5, v8, arg8, arg0);
        };
        let v9 = Listing<T0>{
            seller                 : v1,
            kiosk_id               : v2,
            nft_id                 : arg6,
            cap                    : 0x2::kiosk::list_with_purchase_cap<T0>(arg3, arg4, arg6, arg7, arg9),
            price                  : arg7,
            royalty                : v5,
            commission             : v6,
            points                 : v8,
            last_points_claimed_at : v4,
            listed_at              : v4,
        };
        0x2::linked_table::push_back<0x2::object::ID, Listing<T0>>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg1.id, v3).listings, arg6, v9);
        let v10 = &mut arg1.user_activity;
        ensure_user_activity_exists(v10, v1, arg9);
        let v11 = ListingInfo{
            nft_type               : v3,
            price                  : arg7,
            commission             : v6,
            royalty                : v5,
            listed_at              : v4,
            points                 : v8,
            last_points_claimed_at : v4,
        };
        0x2::linked_table::push_back<0x2::object::ID, ListingInfo>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v1).listings, arg6, v11);
        let v12 = 0x1::string::utf8(b"NFT listed successfully");
        0x1::debug::print<0x1::string::String>(&v12);
        let v13 = ListEvent{
            nft_type   : v3,
            seller     : v1,
            kiosk_id   : v2,
            nft_id     : arg6,
            price      : arg7,
            commission : v6,
            royalty    : v5,
            total_cost : arg7 + v6 + v5,
            points     : v8,
            listed_at  : v4,
        };
        0x2::event::emit<ListEvent>(v13);
    }

    public fun accept_bid<T0: store + key>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::clock::Clock, arg2: &mut MarketPlace, arg3: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: address, arg10: bool, arg11: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg12: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBox, arg13: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxChef, arg14: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        validation_check(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v3 = 0x1::string::utf8(b"=== ACCEPTING BID ===");
        0x1::debug::print<0x1::string::String>(&v3);
        0x1::debug::print<address>(&v1);
        0x1::debug::print<0x2::object::ID>(&arg7);
        0x1::debug::print<0x2::object::ID>(&arg8);
        0x1::debug::print<bool>(&arg10);
        0x1::debug::print<0x1::ascii::String>(&v2);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg2.user_activity, v1), 779);
        let _ = 0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg2.user_activity, v1).listings, arg7);
        let (_, _) = manage_bid_record_for_user(arg2, v2, arg9, false, 0x1::option::some<0x2::object::ID>(arg7), arg10, 0x1::option::none<BidInfo>(), 0x1::option::some<0x2::object::ID>(arg8), arg14);
        let (v7, v8, v9, v10, v11, v12) = manage_bids_for_collection<T0>(arg2, v2, arg9, 0x1::option::some<0x2::object::ID>(arg7), arg10, 0x1::option::none<ActiveBid>(), 0x1::option::some<0x2::object::ID>(arg8), arg14);
        let v13 = v9;
        let v14 = v8;
        let v15 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg2.id, v2);
        if (v15.points_multiplier == 0) {
        };
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v15.listings, arg7), 770);
        let v16 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v15.listings, arg7);
        let (v17, v18, _, _) = destroy_listing<T0>(v16);
        assert!(v18 == 0x2::object::id<0x2::kiosk::Kiosk>(arg5), 778);
        v15.lifetime_volume = v15.lifetime_volume + (v14 as u128);
        let (v21, _, _) = update_collection_metrics<T0>(v15, arg2.simulated_yearly_fee, v14, v13, v0);
        arg2.simulated_yearly_fee = v21;
        0x2::kiosk::return_purchase_cap<T0>(arg5, v17);
        let v24 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg2.user_activity, arg9).bid_pools, v11);
        let v25 = 0x2::balance::zero<0x2::sui::SUI>();
        assert!(0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::get_sui_by_ggsui(arg3, 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v24.ggsui_balance)) >= v14 + v13 + v10, 772);
        0x2::balance::join<0x2::sui::SUI>(&mut v25, 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::request_instant_unstake_disc(&arg2.redeem_fee_disc_cap, arg0, arg3, 0x2::balance::split<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&mut v24.ggsui_balance, 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::get_ggsui_by_sui(arg3, v14 + v13 + v10)), arg14));
        v24.sui_bidded = v24.sui_bidded - v14 + v13 + v10;
        let v26 = BidPoolUpdatedEvent{
            user                : arg9,
            bid_pool_identifier : v11,
            new_balance         : 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v24.ggsui_balance),
            total_bidded        : v24.sui_bidded,
        };
        0x2::event::emit<BidPoolUpdatedEvent>(v26);
        0x2::kiosk::list<T0>(arg5, arg6, arg7, v14);
        let (v27, v28) = 0x2::kiosk::purchase<T0>(arg5, arg7, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v25, v14), arg14));
        let v29 = v28;
        if (v10 > 0 && 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg11)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg11, &mut v29, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v25, v10), arg14));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg11)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg11, &mut v29);
        };
        if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg11)) {
            0x2::kiosk::lock<T0>(arg4, &arg2.escrow_kiosk_cap, arg11, v27);
            if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg11)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v29, arg4);
            };
            add_pending_claim(arg2, arg9, arg7, v2, v14, v13, v10, arg14);
        } else {
            let (v30, v31) = 0x2::kiosk::new(arg14);
            let v32 = v31;
            let v33 = v30;
            0x2::kiosk::lock<T0>(&mut v33, &v32, arg11, v27);
            if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg11)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v29, &v33);
            };
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v33, v32, arg9, arg14);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(&v33, &mut v29);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v33);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v25, v13));
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(v25, v1, arg14);
        let v34 = 0x1::string::utf8(b"Purchase amount:");
        0x1::debug::print<0x1::string::String>(&v34);
        0x1::debug::print<u64>(&v14);
        let v35 = 0x1::string::utf8(b"Commission amount:");
        0x1::debug::print<0x1::string::String>(&v35);
        0x1::debug::print<u64>(&v13);
        if (0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::is_pre_launch_phase(arg13)) {
            0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::add_points_on_sale(&arg2.gearbox_points_cap, arg13, arg9, v7 * (v0 - v12));
            add_to_box_with_referral(v1, arg2, arg12, v16.points * (v0 - v16.last_points_claimed_at), arg1, arg13);
        };
        let v36 = 0x1::string::utf8(b"Bid accepted successfully");
        0x1::debug::print<0x1::string::String>(&v36);
        let v37 = BidAcceptedEvent{
            nft_type          : v2,
            nft_id            : arg7,
            seller            : v1,
            buyer             : arg9,
            is_collection_bid : arg10,
            price             : v14,
            commission        : v13,
            escrow_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
        };
        0x2::event::emit<BidAcceptedEvent>(v37);
        v29
    }

    public fun accept_unlisted_bid<T0: store + key>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::clock::Clock, arg2: &mut MarketPlace, arg3: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: address, arg9: 0x2::object::ID, arg10: bool, arg11: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg12: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBox, arg13: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxChef, arg14: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        validation_check(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::kiosk::has_item_with_type<T0>(arg5, arg7), 778);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg2.user_activity, arg8), 780);
        let (_, _) = manage_bid_record_for_user(arg2, v2, arg8, false, 0x1::option::some<0x2::object::ID>(arg7), arg10, 0x1::option::none<BidInfo>(), 0x1::option::some<0x2::object::ID>(arg9), arg14);
        let (v5, v6, v7, v8, v9, v10) = manage_bids_for_collection<T0>(arg2, v2, arg8, 0x1::option::some<0x2::object::ID>(arg7), arg10, 0x1::option::none<ActiveBid>(), 0x1::option::some<0x2::object::ID>(arg9), arg14);
        let v11 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg2.id, v2);
        v11.lifetime_volume = v11.lifetime_volume + (v6 as u128);
        let (v12, _, _) = update_collection_metrics<T0>(v11, arg2.simulated_yearly_fee, v6, v7, v0);
        arg2.simulated_yearly_fee = v12;
        if (v11.points_multiplier == 0) {
        };
        let v15 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg2.user_activity, arg8).bid_pools, v9);
        let v16 = 0x2::balance::zero<0x2::sui::SUI>();
        assert!(0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::get_sui_by_ggsui(arg3, 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v15.ggsui_balance)) >= v6 + v7 + v8, 772);
        0x2::balance::join<0x2::sui::SUI>(&mut v16, 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::request_instant_unstake_disc(&arg2.redeem_fee_disc_cap, arg0, arg3, 0x2::balance::split<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&mut v15.ggsui_balance, 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::get_ggsui_by_sui(arg3, v6 + v7 + v8)), arg14));
        v15.sui_bidded = v15.sui_bidded - v6 + v7 + v8;
        let v17 = BidPoolUpdatedEvent{
            user                : arg8,
            bid_pool_identifier : v9,
            new_balance         : 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v15.ggsui_balance),
            total_bidded        : v15.sui_bidded,
        };
        0x2::event::emit<BidPoolUpdatedEvent>(v17);
        0x2::kiosk::list<T0>(arg5, arg6, arg7, v6);
        let (v18, v19) = 0x2::kiosk::purchase<T0>(arg5, arg7, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v16, v6), arg14));
        let v20 = v19;
        if (v8 > 0 && 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg11)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg11, &mut v20, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v16, v8), arg14));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg11)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg11, &mut v20);
        };
        if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg11)) {
            0x2::kiosk::lock<T0>(arg4, &arg2.escrow_kiosk_cap, arg11, v18);
            if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg11)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v20, arg4);
            };
            add_pending_claim(arg2, arg8, arg7, v2, v6, v7, v8, arg14);
        } else {
            let (v21, v22) = 0x2::kiosk::new(arg14);
            let v23 = v22;
            let v24 = v21;
            0x2::kiosk::lock<T0>(&mut v24, &v23, arg11, v18);
            if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg11)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v20, &v24);
            };
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v24, v23, arg8, arg14);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(&v24, &mut v20);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v24);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v16, v7));
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(v16, v1, arg14);
        if (0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::is_pre_launch_phase(arg13)) {
            0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::add_points_on_sale(&arg2.gearbox_points_cap, arg13, arg8, v5 * (v0 - v10));
            add_to_box_with_referral(v1, arg2, arg12, v5, arg1, arg13);
        };
        let v25 = BidAcceptedEvent{
            nft_type          : v2,
            nft_id            : arg7,
            seller            : v1,
            buyer             : arg8,
            is_collection_bid : arg10,
            price             : v6,
            commission        : v7,
            escrow_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
        };
        0x2::event::emit<BidAcceptedEvent>(v25);
        v20
    }

    fun add_pending_claim(arg0: &mut MarketPlace, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = PendingClaim{
            buyer      : arg1,
            nft_type   : arg3,
            price      : arg4,
            commission : arg5,
            royalty    : arg6,
        };
        if (0x2::linked_table::contains<address, PendingClaims>(&arg0.pending_claims, arg1)) {
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut 0x2::linked_table::borrow_mut<address, PendingClaims>(&mut arg0.pending_claims, arg1).pending_claims, arg2, v0);
        } else {
            let v1 = PendingClaims{pending_claims: 0x2::linked_table::new<0x2::object::ID, PendingClaim>(arg7)};
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut v1.pending_claims, arg2, v0);
            0x2::linked_table::push_back<address, PendingClaims>(&mut arg0.pending_claims, arg1, v1);
        };
    }

    fun add_to_box_with_referral(arg0: address, arg1: &mut MarketPlace, arg2: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBox, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxChef) {
        if (arg3 == 0) {
            return
        };
        let v0 = 0x1::option::none<address>();
        let v1 = 0;
        let v2 = 0;
        if (0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::has_referrer(arg2)) {
            let v3 = 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::get_referrer(arg2);
            if (0x1::option::is_some<address>(&v3)) {
                0x1::option::fill<address>(&mut v0, *0x1::option::borrow<address>(&v3));
                let v4 = 0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::mul_div_u128((arg3 as u128), (15 as u128), 100);
                v1 = v4;
                v2 = 0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::mul_div_u128((arg3 as u128), (10 as u128), 100);
                if (0x2::linked_table::contains<address, u64>(&arg1.referrals, *0x1::option::borrow<address>(&v0))) {
                    let v5 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg1.referrals, *0x1::option::borrow<address>(&v0));
                    *v5 = *v5 + v4;
                } else {
                    0x2::linked_table::push_back<address, u64>(&mut arg1.referrals, *0x1::option::borrow<address>(&v0), v4);
                };
            };
        };
        let v6 = 0;
        if (0x2::linked_table::contains<address, u64>(&arg1.referrals, arg0)) {
            v6 = *0x2::linked_table::borrow<address, u64>(&arg1.referrals, arg0);
            *0x2::linked_table::borrow_mut<address, u64>(&mut arg1.referrals, arg0) = 0;
        };
        0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::add_to_box(&arg1.gearbox_points_cap, arg4, arg5, arg2, v6 + arg3 + v2);
        let v7 = AwardPointsEvent{
            user_address     : arg0,
            points_earned    : arg3 + v2,
            add_points       : v6,
            referrer_address : v0,
            referral_points  : v1,
            bonus_points     : v2,
            total_points     : arg3 + v2,
        };
        0x2::event::emit<AwardPointsEvent>(v7);
    }

    public fun add_trait_bidding_support<T0: store + key, T1: store + key>(arg0: &mut MarketPlace, arg1: &TraitBidsAdminCap, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg0.id, v0);
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut v1.id, b"trait_bids", arg2);
        v1.are_trait_bids_enabled = true;
        let v2 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : true,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v2);
    }

    public fun buy<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBox, arg7: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxChef, arg8: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, u64) {
        validation_check(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x2::kiosk::owner(arg3);
        let v3 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v4 = 0x1::string::utf8(b"=== BUYING NFT ===");
        0x1::debug::print<0x1::string::String>(&v4);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg1.user_activity, v2), 769);
        let v5 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v2);
        assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v5.listings, arg4), 770);
        0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut v5.listings, arg4);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg1.id, v3);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v6.listings, arg4), 777);
        let v7 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v6.listings, arg4);
        let v8 = v7.price;
        let v9 = v7.commission;
        let v10 = v7.royalty;
        let v11 = v7.points;
        let v12 = v7.last_points_claimed_at;
        let v13 = 0x1::string::utf8(b"NFT price:");
        0x1::debug::print<0x1::string::String>(&v13);
        0x1::debug::print<u64>(&v8);
        let v14 = 0x1::string::utf8(b"Commission:");
        0x1::debug::print<0x1::string::String>(&v14);
        0x1::debug::print<u64>(&v9);
        let v15 = 0x1::string::utf8(b"Royalty:");
        0x1::debug::print<0x1::string::String>(&v15);
        0x1::debug::print<u64>(&v10);
        v6.lifetime_volume = v6.lifetime_volume + (v8 as u128);
        let (v16, _, _) = update_collection_metrics<T0>(v6, arg1.simulated_yearly_fee, v8, v9, v0);
        arg1.simulated_yearly_fee = v16;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v8 + v9 + v10, 772);
        let v19 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v19, v9));
        let (v20, v21, v22, v23) = destroy_listing<T0>(v7);
        assert!(v21 == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 778);
        let (v24, v25) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v20, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v19, v8), arg8));
        let v26 = v25;
        let v27 = v24;
        if (v10 > 0 && 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v26, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v19, v10), arg8));
        };
        if (0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::is_pre_launch_phase(arg7)) {
            0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::add_points_on_sale(&arg1.gearbox_points_cap, arg7, v2, v11 * (v0 - v12));
            add_to_box_with_referral(v1, arg1, arg6, v11 * (v0 - v12), arg0, arg7);
        } else {
            add_to_box_with_referral(v1, arg1, arg6, v11, arg0, arg7);
        };
        let v28 = BuyEvent{
            nft_type     : v3,
            nft_id       : 0x2::object::id<T0>(&v27),
            buyer        : v1,
            seller       : v2,
            seller_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            price        : v22,
            commission   : v23,
        };
        0x2::event::emit<BuyEvent>(v28);
        let v29 = 0x1::string::utf8(b"NFT purchased successfully");
        0x1::debug::print<0x1::string::String>(&v29);
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(v19, v1, arg8);
        (v27, v26, v22 - v23)
    }

    fun calc_bid_points(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        if (!arg1) {
            return 0
        };
        ((((0x4e9d6df03ac673389bafd4f6a1941dcc42952d96a01836cf6d5e1ed596a599b::helpers::integer_sqrt(arg0) * 0x4e9d6df03ac673389bafd4f6a1941dcc42952d96a01836cf6d5e1ed596a599b::helpers::calculate_bid_proximity_multiplier(arg0, arg2) * arg4 / 1000) as u64) * (arg5 - arg6) * 1000 / arg5 * arg3) as u64)
    }

    fun calc_listing_points(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (!arg1) {
            return 0
        };
        ((((0x4e9d6df03ac673389bafd4f6a1941dcc42952d96a01836cf6d5e1ed596a599b::helpers::integer_sqrt(arg0) * 0x4e9d6df03ac673389bafd4f6a1941dcc42952d96a01836cf6d5e1ed596a599b::helpers::calculate_listing_proximity_multiplier(arg0, arg2) * arg4 / 1000) as u64) * arg3) as u64)
    }

    public fun cancel_bid<T0: store + key>(arg0: &mut MarketPlace, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x2::object::ID, arg3: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBox, arg4: &0x2::clock::Clock, arg5: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxChef, arg6: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = !0x1::option::is_some<0x2::object::ID>(&arg1);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = 0x1::string::utf8(b"=== CANCELING BID ===");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<address>(&v0);
        0x1::debug::print<0x1::option::Option<0x2::object::ID>>(&arg1);
        0x1::debug::print<0x2::object::ID>(&arg2);
        0x1::debug::print<bool>(&v2);
        0x1::debug::print<0x1::ascii::String>(&v1);
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v1), 774);
        let (v5, v6, v7, v8, v9, _) = manage_bids_for_collection<T0>(arg0, v1, v0, arg1, v2, 0x1::option::none<ActiveBid>(), 0x1::option::some<0x2::object::ID>(arg2), arg6);
        let v11 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0).bid_pools, v9);
        v11.sui_bidded = v11.sui_bidded - v6 + v7 + v8;
        let v12 = BidPoolUpdatedEvent{
            user                : v0,
            bid_pool_identifier : v9,
            new_balance         : v11.sui_bidded,
            total_bidded        : v11.sui_bidded,
        };
        0x2::event::emit<BidPoolUpdatedEvent>(v12);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 769);
        let (_, v14) = manage_bid_record_for_user(arg0, v1, v0, false, arg1, v2, 0x1::option::none<BidInfo>(), 0x1::option::some<0x2::object::ID>(arg2), arg6);
        let v15 = 0;
        if (0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::is_pre_launch_phase(arg5)) {
            let v16 = v3 - v14;
            let v17 = 0x1::string::utf8(b"Time active:");
            0x1::debug::print<0x1::string::String>(&v17);
            0x1::debug::print<u64>(&v16);
            v15 = v5 * v16;
            add_to_box_with_referral(v0, arg0, arg3, v15, arg4, arg5);
            let v18 = 0x1::string::utf8(b"GEARBOX points awarded for canceling:");
            0x1::debug::print<0x1::string::String>(&v18);
            0x1::debug::print<u64>(&v15);
        };
        let v19 = 0x1::string::utf8(b"Bid canceled successfully");
        0x1::debug::print<0x1::string::String>(&v19);
        let v20 = CancelBidEvent{
            bid_id              : arg2,
            nft_type            : v1,
            bidder              : v0,
            nft_id              : arg1,
            bid_pool_identifier : v9,
            is_collection_bid   : v2,
            cancelled_at        : v3,
            points              : v15,
        };
        0x2::event::emit<CancelBidEvent>(v20);
    }

    public fun claim_referral_points(arg0: &0x2::clock::Clock, arg1: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxChef, arg2: &mut MarketPlace, arg3: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBox, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::option::none<address>();
        let v2 = 0;
        let v3 = 0;
        assert!(0x2::linked_table::contains<address, u64>(&arg2.referrals, v0), 769);
        let v4 = *0x2::linked_table::borrow<address, u64>(&arg2.referrals, v0);
        *0x2::linked_table::borrow_mut<address, u64>(&mut arg2.referrals, v0) = 0;
        if (0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::has_referrer(arg3)) {
            let v5 = 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::get_referrer(arg3);
            if (0x1::option::is_some<address>(&v5)) {
                0x1::option::fill<address>(&mut v1, *0x1::option::borrow<address>(&v5));
                let v6 = 0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::mul_div_u128((v4 as u128), (15 as u128), 100);
                v2 = v6;
                v3 = 0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::mul_div_u128((v4 as u128), (10 as u128), 100);
                if (0x2::linked_table::contains<address, u64>(&arg2.referrals, *0x1::option::borrow<address>(&v1))) {
                    let v7 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg2.referrals, *0x1::option::borrow<address>(&v1));
                    *v7 = *v7 + v6;
                } else {
                    0x2::linked_table::push_back<address, u64>(&mut arg2.referrals, *0x1::option::borrow<address>(&v1), v6);
                };
            };
        };
        let v8 = v2 + v3;
        0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::add_to_box(&arg2.gearbox_points_cap, arg0, arg1, arg3, v8);
        let v9 = ReferralPointsClaimedEvent{
            user_address     : v0,
            claimable_points : v4,
            referral_points  : v2,
            bonus_points     : v3,
            total_points     : v8,
        };
        0x2::event::emit<ReferralPointsClaimedEvent>(v9);
    }

    public fun claim_withdrawable_sui(arg0: &MarketPlaceFeeClaimCap, arg1: &mut MarketPlace) : 0x2::balance::Balance<0x2::sui::SUI> {
        validation_check(arg1);
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.withdrawable_sui)
    }

    fun create_trait_summary(arg0: 0x1::option::Option<0x1::ascii::String>, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: 0x1::option::Option<0x1::ascii::String>) : 0x1::ascii::String {
        let v0 = 0x1::ascii::string(b"");
        let v1 = true;
        let v2 = v1;
        if (0x1::option::is_some<0x1::ascii::String>(&arg0)) {
            if (!v1) {
                0x1::ascii::append(&mut v0, 0x1::ascii::string(b","));
            };
            0x1::ascii::append(&mut v0, *0x1::option::borrow<0x1::ascii::String>(&arg0));
            v2 = false;
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            if (!v2) {
                0x1::ascii::append(&mut v0, 0x1::ascii::string(b","));
            };
            0x1::ascii::append(&mut v0, *0x1::option::borrow<0x1::ascii::String>(&arg1));
            v2 = false;
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            if (!v2) {
                0x1::ascii::append(&mut v0, 0x1::ascii::string(b","));
            };
            0x1::ascii::append(&mut v0, *0x1::option::borrow<0x1::ascii::String>(&arg2));
        };
        v0
    }

    public fun deposit_sui_to_bid_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg3: 0x1::ascii::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = &mut arg1.user_activity;
        ensure_user_activity_exists(v1, v0, arg6);
        let v2 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v0);
        if (!0x2::linked_table::contains<0x1::ascii::String, BidPool>(&v2.bid_pools, arg3)) {
            let v3 = BidPool{
                bid_pool_identifier : arg3,
                ggsui_balance       : 0x2::balance::zero<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(),
                sui_added           : 0,
                sui_bidded          : 0,
            };
            0x2::linked_table::push_back<0x1::ascii::String, BidPool>(&mut v2.bid_pools, arg3, v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v2.bid_pool_identifiers, arg3);
        };
        let v4 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut v2.bid_pools, arg3);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v6 = 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::stake_sui_request(arg0, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v5, arg5), 0x1::option::none<address>(), arg6);
        0x2::balance::join<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&mut v4.ggsui_balance, v6);
        v4.sui_added = v4.sui_added + arg5;
        let v7 = BidPoolDepositedEvent{
            user                : v0,
            bid_pool_identifier : arg3,
            amount              : arg5,
            staked_ggsui        : 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v6),
            new_ggsui_balance   : 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v4.ggsui_balance),
        };
        0x2::event::emit<BidPoolDepositedEvent>(v7);
        v5
    }

    fun destroy_active_bid(arg0: ActiveBid) {
        let ActiveBid {
            id                     : v0,
            bidder                 : _,
            bid_price              : _,
            bid_pool_identifier    : _,
            bid_at                 : _,
            commission             : _,
            royalty                : _,
            points                 : _,
            last_points_claimed_at : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun destroy_active_trait_bid(arg0: ActiveTraitBid) : (u64, 0x1::ascii::String) {
        let ActiveTraitBid {
            id                     : v0,
            bidder                 : _,
            bid_pool_identifier    : v2,
            bid_price              : v3,
            bid_at                 : _,
            trait_key1             : _,
            trait_value1           : _,
            trait_key2             : _,
            trait_value2           : _,
            trait_key3             : _,
            trait_value3           : _,
            commission             : v11,
            royalty                : v12,
            points                 : _,
            last_points_claimed_at : _,
        } = arg0;
        0x2::object::delete(v0);
        (v3 + v11 + v12, v2)
    }

    fun destroy_bid_pool(arg0: BidPool) {
        let BidPool {
            bid_pool_identifier : _,
            ggsui_balance       : v1,
            sui_added           : _,
            sui_bidded          : _,
        } = arg0;
        0x2::balance::destroy_zero<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(v1);
    }

    fun destroy_listing<T0: store + key>(arg0: Listing<T0>) : (0x2::kiosk::PurchaseCap<T0>, 0x2::object::ID, u64, u64) {
        let Listing {
            seller                 : _,
            kiosk_id               : v1,
            nft_id                 : _,
            cap                    : v3,
            price                  : v4,
            royalty                : _,
            commission             : v6,
            points                 : _,
            last_points_claimed_at : _,
            listed_at              : _,
        } = arg0;
        (v3, v1, v4, v6)
    }

    public fun distribute_accumulated_fee(arg0: &mut MarketPlace, arg1: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = arg0.config.ggsui_share_pct * 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui) / 100;
        0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::add_to_staking_rewards(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.available_sui, v0));
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.available_sui);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.withdrawable_sui, v1);
        let v2 = DistributeAccumulatedFeeEvent{
            for_ggsui     : v0,
            remaining_sui : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<DistributeAccumulatedFeeEvent>(v2);
    }

    fun ensure_user_activity_exists(arg0: &mut 0x2::linked_table::LinkedTable<address, UserInfo>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<address, UserInfo>(arg0, arg1)) {
            let v0 = UserInfo{
                id                   : 0x2::object::new(arg2),
                listings             : 0x2::linked_table::new<0x2::object::ID, ListingInfo>(arg2),
                bid_pool_identifiers : 0x1::vector::empty<0x1::ascii::String>(),
                bid_pools            : 0x2::linked_table::new<0x1::ascii::String, BidPool>(arg2),
                bids                 : 0x2::linked_table::new<0x2::object::ID, BidInfo>(arg2),
                collection_bids      : 0x2::linked_table::new<0x1::ascii::String, vector<BidInfo>>(arg2),
                trait_bids           : 0x2::linked_table::new<0x1::ascii::String, vector<TraitBidInfo>>(arg2),
                claimable_points     : 0,
            };
            0x2::linked_table::push_back<address, UserInfo>(arg0, arg1, v0);
        };
    }

    public entry fun entry_deposit_sui_to_bid_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg3: 0x1::ascii::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_sui_to_bid_pool(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun entry_withdraw_ggsui_from_bid_pool(arg0: &mut MarketPlace, arg1: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_ggsui_from_bid_pool(arg0, arg1, arg2, arg3, arg4);
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun entry_withdraw_sui_from_bid_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_sui_from_bid_pool(arg0, arg1, arg2, arg3, arg4, arg5);
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
    }

    public fun get_referral_points_balance(arg0: &MarketPlace, arg1: address) : u64 {
        if (0x2::linked_table::contains<address, u64>(&arg0.referrals, arg1)) {
            *0x2::linked_table::borrow<address, u64>(&arg0.referrals, arg1)
        } else {
            0
        }
    }

    fun get_royalty_and_commission<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, arg2)
        } else {
            0
        };
        (v0, arg2 * arg1 / 100)
    }

    public fun get_trait_bid_details(arg0: &MarketPlace, arg1: address, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, u64, u64, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, u64, u64) {
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (0x1::ascii::string(b""), 0, 0, 0, 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v1 = *0x2::linked_table::front<0x1::ascii::String, vector<TraitBidInfo>>(&v0.trait_bids);
        while (0x1::option::is_some<0x1::ascii::String>(&v1)) {
            let v2 = 0x1::option::borrow<0x1::ascii::String>(&v1);
            let v3 = 0x2::linked_table::borrow<0x1::ascii::String, vector<TraitBidInfo>>(&v0.trait_bids, *v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<TraitBidInfo>(v3)) {
                let v5 = 0x1::vector::borrow<TraitBidInfo>(v3, v4);
                if (v5.bid_id == arg2) {
                    return (v5.nft_type, v5.bid_price, v5.commission, v5.royalty, v5.trait_key1, v5.trait_value1, v5.trait_key2, v5.trait_value2, v5.trait_key3, v5.trait_value3, v5.bid_at, v5.last_points_claimed_at)
                };
                v4 = v4 + 1;
            };
            v1 = *0x2::linked_table::next<0x1::ascii::String, vector<TraitBidInfo>>(&v0.trait_bids, *v2);
        };
        (0x1::ascii::string(b""), 0, 0, 0, 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0, 0)
    }

    public fun get_user_pending_claims(arg0: &MarketPlace, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, PendingClaims>(&arg0.pending_claims, arg1)) {
            return (v0, v1, v2, v3, v4, 0)
        };
        let v5 = 0x2::linked_table::borrow<address, PendingClaims>(&arg0.pending_claims, arg1);
        let v6 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, PendingClaim>(&v5.pending_claims)
        };
        let v7 = v6;
        let v8 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v7) && v8 < arg3) {
            let v9 = 0x1::option::borrow<0x2::object::ID>(&v7);
            let v10 = 0x2::linked_table::borrow<0x2::object::ID, PendingClaim>(&v5.pending_claims, *v9);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v9);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v10.nft_type);
            0x1::vector::push_back<u64>(&mut v2, v10.price);
            0x1::vector::push_back<u64>(&mut v3, v10.commission);
            0x1::vector::push_back<u64>(&mut v4, v10.royalty);
            v7 = *0x2::linked_table::next<0x2::object::ID, PendingClaim>(&v5.pending_claims, *v9);
            v8 = v8 + 1;
        };
        (v0, v1, v2, v3, v4, v8)
    }

    public fun get_user_trait_bids_info(arg0: &MarketPlace, arg1: address, arg2: 0x1::option::Option<0x1::ascii::String>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<u64>, vector<u64>, vector<u64>, vector<0x1::ascii::String>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<0x1::ascii::String>();
        let v6 = 0;
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, v4, v5, 0)
        };
        let v7 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v8 = if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids)
        };
        let v9 = v8;
        let v10 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v9) && v10 < arg3) {
            let v11 = 0x1::option::borrow<0x1::ascii::String>(&v9);
            let v12 = 0x2::linked_table::borrow<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids, *v11);
            let v13 = 0;
            while (v13 < 0x1::vector::length<TraitBidInfo>(v12) && v10 < arg3) {
                let v14 = 0x1::vector::borrow<TraitBidInfo>(v12, v13);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v14.bid_id);
                0x1::vector::push_back<0x1::ascii::String>(&mut v1, v14.nft_type);
                0x1::vector::push_back<u64>(&mut v2, v14.bid_price);
                0x1::vector::push_back<u64>(&mut v3, v14.commission);
                0x1::vector::push_back<u64>(&mut v4, v14.royalty);
                0x1::vector::push_back<0x1::ascii::String>(&mut v5, create_trait_summary(v14.trait_key1, v14.trait_key2, v14.trait_key3));
                v13 = v13 + 1;
                v10 = v10 + 1;
                v6 = v6 + 1;
            };
            v9 = *0x2::linked_table::next<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids, *v11);
        };
        let v15 = 0;
        let v16 = *0x2::linked_table::front<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids);
        while (0x1::option::is_some<0x1::ascii::String>(&v16)) {
            let v17 = 0x1::option::borrow<0x1::ascii::String>(&v16);
            v15 = v15 + 0x1::vector::length<TraitBidInfo>(0x2::linked_table::borrow<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids, *v17));
            v16 = *0x2::linked_table::next<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids, *v17);
        };
        (v0, v1, v2, v3, v4, v5, v15)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketPlaceFeeClaimCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MarketPlaceFeeClaimCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = LaunchpadCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<LaunchpadCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = TraitBidsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TraitBidsAdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun init_marketplace(arg0: &AdminCap, arg1: 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxPointsCap, arg2: 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::RedeemFeeDiscCap, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg3);
        let v2 = v1;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v3 = ConfigInfo{
            is_permissionless    : false,
            new_collection_fee   : 100000000000,
            commission_pct       : 2,
            ggsui_share_pct      : 15,
            max_leverage_allowed : 2,
        };
        let v4 = MarketPlace{
            id                   : 0x2::object::new(arg3),
            redeem_fee_disc_cap  : arg2,
            gearbox_points_cap   : arg1,
            config               : v3,
            available_sui        : 0x2::balance::zero<0x2::sui::SUI>(),
            withdrawable_sui     : 0x2::balance::zero<0x2::sui::SUI>(),
            user_activity        : 0x2::linked_table::new<address, UserInfo>(arg3),
            active_collections   : 0x2::linked_table::new<0x1::ascii::String, bool>(arg3),
            referrals            : 0x2::linked_table::new<address, u64>(arg3),
            referral_earnings    : 0x2::linked_table::new<address, u64>(arg3),
            referral_pool        : 0x2::balance::zero<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(),
            kiosk_id             : 0x2::kiosk::kiosk_owner_cap_for(&v2),
            escrow_kiosk_cap     : v2,
            pending_claims       : 0x2::linked_table::new<address, PendingClaims>(arg3),
            simulated_yearly_fee : 0,
            bag                  : 0x2::bag::new(arg3),
            version              : 0,
        };
        0x2::transfer::share_object<MarketPlace>(v4);
    }

    public fun launchpad_add_collection<T0: store + key>(arg0: &mut MarketPlace, arg1: &LaunchpadCap, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        assert!(arg3 <= 10000, 781);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
        let v1 = TypeMarket<T0>{
            id                     : 0x2::object::new(arg4),
            listings               : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg4),
            bids                   : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg4),
            collection_bids        : 0x2::linked_table::new<address, vector<ActiveBid>>(arg4),
            are_trait_bids_enabled : false,
            lifetime_volume        : 0,
            points_enabled         : arg2,
            points_multiplier      : arg3,
            weight                 : 0,
            avg_sale_price         : 0,
            recent_sale_prices     : 0x1::vector::empty<u64>(),
            simulated_yearly_fee   : 0,
            avg_time_bw_trades     : 0,
            recent_trades_times    : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, TypeMarket<T0>>(&mut arg0.id, v0, v1);
        let v2 = UpdateActiveCollectionsEvent{
            nft_type : v0,
            boolean  : true,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v2);
        let v3 = UpdateGearBoxMultiplierEvent{
            nft_type                   : v0,
            are_gearbox_points_enabled : arg2,
            points_multiplier          : arg3,
        };
        0x2::event::emit<UpdateGearBoxMultiplierEvent>(v3);
    }

    public entry fun make_bid<T0: store + key>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxChef, arg3: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBox, arg4: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg5: 0x1::option::Option<0x2::object::ID>, arg6: u64, arg7: 0x1::ascii::String, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::transfer_policy::TransferPolicy<T0>, arg12: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = !0x1::option::is_some<0x2::object::ID>(&arg5);
        let v3 = 0x2::clock::timestamp_ms(arg10);
        let v4 = 0x1::string::utf8(b"=== MAKING BID ===");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<address>(&v0);
        0x1::debug::print<0x1::option::Option<0x2::object::ID>>(&arg5);
        0x1::debug::print<u64>(&arg6);
        0x1::debug::print<bool>(&v2);
        0x1::debug::print<0x1::ascii::String>(&v1);
        validate_collection_exists<T0>(arg1);
        let (v5, v6) = get_royalty_and_commission<T0>(arg11, arg1.config.commission_pct, arg6);
        let v7 = &mut arg1.user_activity;
        ensure_user_activity_exists(v7, v0, arg12);
        let v8 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v0);
        if (!0x2::linked_table::contains<0x1::ascii::String, BidPool>(&v8.bid_pools, arg7)) {
            let v9 = BidPool{
                bid_pool_identifier : arg7,
                ggsui_balance       : 0x2::balance::zero<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(),
                sui_added           : 0,
                sui_bidded          : 0,
            };
            0x2::linked_table::push_back<0x1::ascii::String, BidPool>(&mut v8.bid_pools, arg7, v9);
            0x1::vector::push_back<0x1::ascii::String>(&mut v8.bid_pool_identifiers, arg7);
        };
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(arg8);
        if (arg9 > 0) {
            let v11 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut v8.bid_pools, arg7);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v10) >= arg9, 772);
            let v12 = 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::stake_sui_request(arg0, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut v10, arg9), 0x1::option::none<address>(), arg12);
            0x2::balance::join<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&mut v11.ggsui_balance, v12);
            let v13 = BidPoolDepositedEvent{
                user                : v0,
                bid_pool_identifier : arg7,
                amount              : arg9,
                staked_ggsui        : 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v12),
                new_ggsui_balance   : 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v11.ggsui_balance),
            };
            0x2::event::emit<BidPoolDepositedEvent>(v13);
        };
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(v10, v0, arg12);
        let v14 = arg6 + v6 + v5;
        let v15 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut v8.bid_pools, arg7);
        let v16 = 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::get_sui_by_ggsui(arg4, 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v15.ggsui_balance));
        let v17 = arg1.config.max_leverage_allowed * v16;
        v15.sui_bidded = v15.sui_bidded + v14;
        assert!(v15.sui_bidded <= (v17 as u64), 772);
        let v18 = BidPoolUpdatedEvent{
            user                : v0,
            bid_pool_identifier : arg7,
            new_balance         : 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v15.ggsui_balance),
            total_bidded        : v15.sui_bidded,
        };
        0x2::event::emit<BidPoolUpdatedEvent>(v18);
        let v19 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, TypeMarket<T0>>(&arg1.id, v1);
        let v20 = if (v15.sui_bidded > v16) {
            v15.sui_bidded - v16
        } else {
            0
        };
        let v21 = calc_bid_points(arg6, v19.points_enabled, v19.avg_sale_price, v19.weight, v19.points_multiplier, v17 - v16, v20);
        if (!0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::is_pre_launch_phase(arg2)) {
            add_to_box_with_referral(v0, arg1, arg3, v21, arg10, arg2);
        };
        let v22 = ActiveBid{
            id                     : 0x2::object::new(arg12),
            bidder                 : v0,
            bid_price              : arg6,
            bid_pool_identifier    : arg7,
            bid_at                 : v3,
            commission             : v6,
            royalty                : v5,
            points                 : v21,
            last_points_claimed_at : v3,
        };
        let v23 = 0x2::object::id<ActiveBid>(&v22);
        let v24 = 0x1::string::utf8(b"Created bid with ID:");
        0x1::debug::print<0x1::string::String>(&v24);
        0x1::debug::print<0x2::object::ID>(&v23);
        let (_, _, _, _, _, _) = manage_bids_for_collection<T0>(arg1, v1, v0, arg5, v2, 0x1::option::some<ActiveBid>(v22), 0x1::option::none<0x2::object::ID>(), arg12);
        let v31 = BidInfo{
            bid_id                 : v23,
            nft_type               : v1,
            bid_pool_identifier    : arg7,
            bid_price              : arg6,
            commission             : v6,
            royalty                : v5,
            is_collection_bid      : v2,
            bid_at                 : v3,
            points                 : v21,
            last_points_claimed_at : v3,
        };
        let (_, _) = manage_bid_record_for_user(arg1, v1, v0, true, arg5, v2, 0x1::option::some<BidInfo>(v31), 0x1::option::none<0x2::object::ID>(), arg12);
        let v34 = 0x1::string::utf8(b"Bid created successfully");
        0x1::debug::print<0x1::string::String>(&v34);
        let v35 = MakeBidEvent{
            bid_id              : v23,
            nft_type            : v1,
            buyer               : v0,
            nft_id              : arg5,
            bid_pool_identifier : arg7,
            price               : arg6,
            commission          : v6,
            royalty             : v5,
            total_cost          : v14,
            is_collection_bid   : v2,
            bid_at              : v3,
            points              : v21,
        };
        0x2::event::emit<MakeBidEvent>(v35);
    }

    fun manage_bid_record_for_user(arg0: &mut MarketPlace, arg1: 0x1::ascii::String, arg2: address, arg3: bool, arg4: 0x1::option::Option<0x2::object::ID>, arg5: bool, arg6: 0x1::option::Option<BidInfo>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = &mut arg0.user_activity;
        ensure_user_activity_exists(v0, arg2, arg8);
        let v1 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, arg2);
        let v2 = 0;
        let v3 = 0;
        if (arg3) {
            if (arg5) {
                if (0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v1.collection_bids, arg1)) {
                    0x1::vector::push_back<BidInfo>(0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v1.collection_bids, arg1), 0x1::option::destroy_some<BidInfo>(arg6));
                } else {
                    let v4 = 0x1::vector::empty<BidInfo>();
                    0x1::vector::push_back<BidInfo>(&mut v4, 0x1::option::destroy_some<BidInfo>(arg6));
                    0x2::linked_table::push_back<0x1::ascii::String, vector<BidInfo>>(&mut v1.collection_bids, arg1, v4);
                };
            } else {
                let v5 = *0x1::option::borrow<0x2::object::ID>(&arg4);
                assert!(!0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v1.bids, v5), 775);
                0x2::linked_table::push_back<0x2::object::ID, BidInfo>(&mut v1.bids, v5, 0x1::option::destroy_some<BidInfo>(arg6));
            };
        } else {
            0x1::option::destroy_none<BidInfo>(arg6);
            if (arg5) {
                assert!(0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v1.collection_bids, arg1), 776);
                let v6 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v1.collection_bids, arg1);
                let v7 = 0;
                while (v7 < 0x1::vector::length<BidInfo>(v6)) {
                    if (0x1::vector::borrow<BidInfo>(v6, v7).bid_id == *0x1::option::borrow<0x2::object::ID>(&arg7)) {
                        let v8 = 0x1::vector::remove<BidInfo>(v6, v7);
                        v2 = v8.bid_price;
                        v3 = v8.last_points_claimed_at;
                        break
                    };
                    v7 = v7 + 1;
                };
                if (0x1::vector::length<BidInfo>(v6) == 0) {
                    0x2::linked_table::remove<0x1::ascii::String, vector<BidInfo>>(&mut v1.collection_bids, arg1);
                };
            } else {
                let v9 = *0x1::option::borrow<0x2::object::ID>(&arg4);
                assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v1.bids, v9), 776);
                let v10 = 0x2::linked_table::remove<0x2::object::ID, BidInfo>(&mut v1.bids, v9);
                v2 = v10.bid_price;
                v3 = v10.last_points_claimed_at;
            };
        };
        (v2, v3)
    }

    fun manage_bids_for_collection<T0: store + key>(arg0: &mut MarketPlace, arg1: 0x1::ascii::String, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: bool, arg5: 0x1::option::Option<ActiveBid>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, 0x1::ascii::String, u64) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg0.id, arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x1::ascii::string(b"");
        let v6 = 0;
        if (0x1::option::is_some<ActiveBid>(&arg5)) {
            if (!arg4) {
                let v7 = *0x1::option::borrow<0x2::object::ID>(&arg3);
                if (0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v0.bids, v7)) {
                    let v8 = 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v0.bids, v7);
                    assert!(!0x2::linked_table::contains<address, ActiveBid>(&v8.bids, arg2), 775);
                    0x2::linked_table::push_back<address, ActiveBid>(&mut v8.bids, arg2, 0x1::option::destroy_some<ActiveBid>(arg5));
                } else {
                    let v9 = ActiveBids{
                        id   : 0x2::object::new(arg7),
                        bids : 0x2::linked_table::new<address, ActiveBid>(arg7),
                    };
                    0x2::linked_table::push_back<address, ActiveBid>(&mut v9.bids, arg2, 0x1::option::destroy_some<ActiveBid>(arg5));
                    0x2::linked_table::push_back<0x2::object::ID, ActiveBids>(&mut v0.bids, v7, v9);
                };
            } else if (0x2::linked_table::contains<address, vector<ActiveBid>>(&v0.collection_bids, arg2)) {
                0x1::vector::push_back<ActiveBid>(0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v0.collection_bids, arg2), 0x1::option::destroy_some<ActiveBid>(arg5));
            } else {
                let v10 = 0x1::vector::empty<ActiveBid>();
                0x1::vector::push_back<ActiveBid>(&mut v10, 0x1::option::destroy_some<ActiveBid>(arg5));
                0x2::linked_table::push_back<address, vector<ActiveBid>>(&mut v0.collection_bids, arg2, v10);
            };
        } else {
            0x1::option::destroy_none<ActiveBid>(arg5);
            if (!arg4) {
                let v11 = *0x1::option::borrow<0x2::object::ID>(&arg3);
                assert!(0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v0.bids, v11), 776);
                let v12 = 0x2::linked_table::remove<address, ActiveBid>(&mut 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v0.bids, v11).bids, arg2);
                v3 = v12.bid_price;
                v2 = v12.commission;
                v1 = v12.royalty;
                v5 = v12.bid_pool_identifier;
                destroy_active_bid(v12);
            } else {
                assert!(0x2::linked_table::contains<address, vector<ActiveBid>>(&v0.collection_bids, arg2), 776);
                let v13 = 0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v0.collection_bids, arg2);
                let v14 = 0;
                while (v14 < 0x1::vector::length<ActiveBid>(v13)) {
                    if (0x2::object::uid_to_inner(&0x1::vector::borrow<ActiveBid>(v13, v14).id) == *0x1::option::borrow<0x2::object::ID>(&arg6)) {
                        let v15 = 0x1::vector::remove<ActiveBid>(v13, v14);
                        v3 = v15.bid_price;
                        v2 = v15.commission;
                        v1 = v15.royalty;
                        v5 = v15.bid_pool_identifier;
                        v4 = v15.points;
                        v6 = v15.last_points_claimed_at;
                        destroy_active_bid(v15);
                        break
                    };
                    v14 = v14 + 1;
                };
                if (0x1::vector::length<ActiveBid>(v13) == 0) {
                    0x1::vector::destroy_empty<ActiveBid>(0x2::linked_table::remove<address, vector<ActiveBid>>(&mut v0.collection_bids, arg2));
                };
            };
        };
        (v4, v3, v2, v1, v5, v6)
    }

    public fun permissionless_add_collection<T0: store + key>(arg0: &mut MarketPlace, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        assert!(arg0.config.is_permissionless, 774);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.config.new_collection_fee, 772);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v1, arg0.config.new_collection_fee));
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg2), arg2);
        0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
        let v2 = TypeMarket<T0>{
            id                     : 0x2::object::new(arg2),
            listings               : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg2),
            bids                   : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg2),
            collection_bids        : 0x2::linked_table::new<address, vector<ActiveBid>>(arg2),
            are_trait_bids_enabled : false,
            lifetime_volume        : 0,
            points_enabled         : false,
            points_multiplier      : 0,
            weight                 : 0,
            avg_sale_price         : 0,
            recent_sale_prices     : 0x1::vector::empty<u64>(),
            simulated_yearly_fee   : 0,
            avg_time_bw_trades     : 0,
            recent_trades_times    : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, TypeMarket<T0>>(&mut arg0.id, v0, v2);
        let v3 = UpdateActiveCollectionsEvent{
            nft_type : v0,
            boolean  : true,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v3);
    }

    public fun process_pending_claim<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::string::utf8(b"=== PROCESSING PENDING CLAIM ===");
        0x1::debug::print<0x1::string::String>(&v1);
        0x1::debug::print<address>(&v0);
        0x1::debug::print<0x2::object::ID>(&arg6);
        assert!(0x2::linked_table::contains<address, PendingClaims>(&arg1.pending_claims, v0), 786);
        let v2 = 0x2::linked_table::borrow_mut<address, PendingClaims>(&mut arg1.pending_claims, v0);
        assert!(0x2::linked_table::contains<0x2::object::ID, PendingClaim>(&v2.pending_claims, arg6), 787);
        let v3 = 0x2::linked_table::remove<0x2::object::ID, PendingClaim>(&mut v2.pending_claims, arg6);
        assert!(v3.buyer == v0, 784);
        let PendingClaim {
            buyer      : _,
            nft_type   : v5,
            price      : _,
            commission : _,
            royalty    : _,
        } = v3;
        let v9 = 0x1::string::utf8(b"Pending claim verified for buyer");
        0x1::debug::print<0x1::string::String>(&v9);
        0x1::debug::print<address>(&v0);
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg5) == 0x2::object::id<0x2::kiosk::Kiosk>(arg4), 778);
        0x2::kiosk::list<T0>(arg2, &arg1.escrow_kiosk_cap, arg6, 0);
        let (v10, v11) = 0x2::kiosk::purchase<T0>(arg2, arg6, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg7));
        let v12 = v11;
        0x2::kiosk::lock<T0>(arg4, arg5, arg3, v10);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v12, arg4);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v12, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg7));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg3, &mut v12);
        };
        let v13 = NFTClaimedEvent{
            nft_type    : v5,
            nft_id      : arg6,
            buyer       : v0,
            buyer_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            claimed_at  : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<NFTClaimedEvent>(v13);
        v12
    }

    public fun remove_trait_bidding_support<T0: store + key, T1: store + key>(arg0: &mut MarketPlace, arg1: &TraitBidsAdminCap, arg2: &mut 0x2::tx_context::TxContext) : T1 {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg0.id, v0);
        v1.are_trait_bids_enabled = false;
        let v2 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : false,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v2);
        0x2::dynamic_object_field::remove<vector<u8>, T1>(&mut v1.id, b"trait_bids")
    }

    public fun switch_trait_bidding_support<T0: store + key>(arg0: &mut MarketPlace, arg1: &TraitBidsAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg0.id, v0);
        v1.are_trait_bids_enabled = !v1.are_trait_bids_enabled;
        let v2 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : v1.are_trait_bids_enabled,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v2);
    }

    public fun transfer_withdrawable_sui(arg0: &MarketPlaceFeeClaimCap, arg1: &mut MarketPlace, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.withdrawable_sui), arg2, arg3);
    }

    public fun unlist<T0: store + key>(arg0: &mut MarketPlace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBox, arg4: &0x2::clock::Clock, arg5: &mut 0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::GearBoxChef, arg6: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = 0x1::string::utf8(b"=== UNLISTING NFT ===");
        0x1::debug::print<0x1::string::String>(&v3);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 769);
        let v4 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v4.listings, arg2), 770);
        0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut v4.listings, arg2);
        let v5 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg0.id, v1);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v5.listings, arg2), 770);
        let v6 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v5.listings, arg2);
        if (0xe0fb5a9471a99f9142c5adb00a270f3a44fc95d3c16414975f4657947a3fd440::gearbox::is_pre_launch_phase(arg5)) {
            let v7 = v2 - v6.last_points_claimed_at;
            let v8 = 0x1::string::utf8(b"Time active:");
            0x1::debug::print<0x1::string::String>(&v8);
            0x1::debug::print<u64>(&v7);
            add_to_box_with_referral(v0, arg0, arg3, v6.points * v7, arg4, arg5);
        };
        let v9 = UnlistEvent{
            nft_type    : v1,
            seller      : v0,
            nft_id      : arg2,
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            price       : v6.price,
            unlisted_at : v2,
        };
        0x2::event::emit<UnlistEvent>(v9);
        let (v10, _, _, _) = destroy_listing<T0>(v6);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v10);
        let v14 = 0x1::string::utf8(b"NFT unlisted successfully");
        0x1::debug::print<0x1::string::String>(&v14);
    }

    public fun update_active_collections<T0: store + key>(arg0: &mut MarketPlace, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (arg2) {
            if (!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0)) {
                0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
            } else {
                *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.active_collections, v0) = true;
            };
            if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
                let v1 = TypeMarket<T0>{
                    id                     : 0x2::object::new(arg3),
                    listings               : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg3),
                    bids                   : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg3),
                    collection_bids        : 0x2::linked_table::new<address, vector<ActiveBid>>(arg3),
                    are_trait_bids_enabled : false,
                    lifetime_volume        : 0,
                    points_enabled         : false,
                    points_multiplier      : 0,
                    weight                 : 0,
                    avg_sale_price         : 0,
                    recent_sale_prices     : 0x1::vector::empty<u64>(),
                    simulated_yearly_fee   : 0,
                    avg_time_bw_trades     : 0,
                    recent_trades_times    : 0x1::vector::empty<u64>(),
                };
                0x2::dynamic_object_field::add<0x1::ascii::String, TypeMarket<T0>>(&mut arg0.id, v0, v1);
            };
        } else {
            *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.active_collections, v0) = false;
        };
        let v2 = UpdateActiveCollectionsEvent{
            nft_type : v0,
            boolean  : arg2,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v2);
    }

    public fun update_chest_point_multiplier<T0: store + key>(arg0: &mut MarketPlace, arg1: &AdminCap, arg2: bool, arg3: u64) {
        validation_check(arg0);
        assert!(arg3 <= 10000, 781);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, TypeMarket<T0>>(&mut arg0.id, v0);
        v1.points_enabled = arg2;
        v1.points_multiplier = arg3;
        let v2 = UpdateGearBoxMultiplierEvent{
            nft_type                   : v0,
            are_gearbox_points_enabled : arg2,
            points_multiplier          : arg3,
        };
        0x2::event::emit<UpdateGearBoxMultiplierEvent>(v2);
    }

    public fun update_collection_fee(arg0: &mut MarketPlace, arg1: &AdminCap, arg2: u64) {
        validation_check(arg0);
        arg0.config.new_collection_fee = arg2;
    }

    fun update_collection_metrics<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, bool) {
        if (0x1::vector::length<u64>(&arg0.recent_sale_prices) >= 10) {
            0x1::vector::remove<u64>(&mut arg0.recent_sale_prices, 0);
            0x1::vector::remove<u64>(&mut arg0.recent_trades_times, 0);
        };
        0x1::vector::push_back<u64>(&mut arg0.recent_sale_prices, arg2);
        0x1::vector::push_back<u64>(&mut arg0.recent_trades_times, arg4);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg0.recent_sale_prices)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0.recent_sale_prices, v4);
            if (v3 > 0) {
                v3 = *0x1::vector::borrow<u64>(&arg0.recent_trades_times, v4);
                let v5 = v1 + v3;
                v1 = v5 - v2;
            };
            v4 = v4 + 1;
        };
        arg0.avg_sale_price = v0 / 0x1::vector::length<u64>(&arg0.recent_sale_prices);
        let v6 = false;
        let v7 = 0;
        if (v1 > 0) {
            arg0.avg_time_bw_trades = v1 / 0x1::vector::length<u64>(&arg0.recent_trades_times);
            let v8 = arg0.simulated_yearly_fee * 31536000000 / arg0.avg_time_bw_trades;
            let (v9, v10) = if (v8 > arg0.simulated_yearly_fee) {
                (v8 - arg0.simulated_yearly_fee, true)
            } else {
                (arg0.simulated_yearly_fee - v8, false)
            };
            v6 = v10;
            v7 = v9;
            arg0.simulated_yearly_fee = arg0.avg_time_bw_trades * arg3;
        };
        let v11 = if (v6) {
            arg1 + v7
        } else {
            arg1 - v7
        };
        arg0.weight = (0xca034d35243198f549e9696befe44afe1a5f1946c36ca1171b97184b70dbd2cd::math::mul_div_u256((arg0.simulated_yearly_fee as u256), (1000000000 as u256), (v11 as u256)) as u64);
        (v11, v7, v6)
    }

    public fun update_commission_pct(arg0: &mut MarketPlace, arg1: &AdminCap, arg2: u64) {
        validation_check(arg0);
        assert!(arg2 <= 10, 771);
        arg0.config.commission_pct = arg2;
    }

    public fun update_module_version(arg0: &mut MarketPlace) {
        assert!(arg0.version < 0, 773);
        arg0.version = 0;
    }

    public fun update_permissionless_status(arg0: &mut MarketPlace, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        arg0.config.is_permissionless = arg2;
        let v0 = UpdatePermissionlessStatusEvent{is_permissionless: arg2};
        0x2::event::emit<UpdatePermissionlessStatusEvent>(v0);
    }

    fun validate_collection_exists<T0: store + key>(arg0: &MarketPlace) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(*0x2::linked_table::borrow<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
    }

    fun validation_check(arg0: &MarketPlace) {
        assert!(arg0.version == 0, 7684);
    }

    public fun withdraw_ggsui_from_bid_pool(arg0: &mut MarketPlace, arg1: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI> {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 769);
        let v1 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        assert!(0x2::linked_table::contains<0x1::ascii::String, BidPool>(&v1.bid_pools, arg2), 785);
        let v2 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut v1.bid_pools, arg2);
        assert!(v2.sui_bidded <= arg0.config.max_leverage_allowed * 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::get_sui_by_ggsui(arg1, 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v2.ggsui_balance) - arg3), 772);
        let v3 = BidPoolWithdrawnEvent{
            user                : v0,
            bid_pool_identifier : arg2,
            new_balance         : 0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v2.ggsui_balance),
            total_bidded        : v2.sui_bidded,
        };
        0x2::event::emit<BidPoolWithdrawnEvent>(v3);
        if (0x2::balance::value<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&v2.ggsui_balance) == 0) {
            destroy_bid_pool(0x2::linked_table::remove<0x1::ascii::String, BidPool>(&mut v1.bid_pools, arg2));
            let (_, v5) = 0x1::vector::index_of<0x1::ascii::String>(&v1.bid_pool_identifiers, &arg2);
            0x1::vector::remove<0x1::ascii::String>(&mut v1.bid_pool_identifiers, v5);
            let v6 = BidPoolRemovedEvent{
                user                : v0,
                bid_pool_identifier : arg2,
            };
            0x2::event::emit<BidPoolRemovedEvent>(v6);
        };
        0x2::balance::split<0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::ggsui::GGSUI>(&mut v2.ggsui_balance, arg3)
    }

    public fun withdraw_sui_from_bid_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::GgSuiVault, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::get_ggsui_by_sui(arg2, arg4);
        let v1 = withdraw_ggsui_from_bid_pool(arg1, arg2, arg3, v0, arg5);
        0x244a88a740f1ae2576a4e2c0f54fb5e7e935bb9c8c96d2f7cf781eb0319c1f34::vault::request_instant_unstake_disc(&arg1.redeem_fee_disc_cap, arg0, arg2, v1, arg5)
    }

    // decompiled from Move bytecode v6
}

