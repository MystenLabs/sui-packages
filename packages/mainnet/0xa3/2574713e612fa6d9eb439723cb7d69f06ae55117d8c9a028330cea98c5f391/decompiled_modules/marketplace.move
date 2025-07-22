module 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::marketplace {
    struct CollectorCap has store, key {
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

    struct MarketPlaceStore has key {
        id: 0x2::object::UID,
        points_admin_cap: 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::PointsAdminCap,
        is_permissionless: bool,
        new_collection_fee: u64,
        commission_pct: u64,
        available_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        user_activity: 0x2::linked_table::LinkedTable<address, UserInfo>,
        active_collections: 0x2::linked_table::LinkedTable<0x1::ascii::String, bool>,
        referrals: 0x2::linked_table::LinkedTable<address, u64>,
        kiosk_id: 0x2::object::ID,
        escrow_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        pending_claims: 0x2::linked_table::LinkedTable<address, PendingClaims>,
        version: u64,
    }

    struct PendingClaims has store {
        pending_claims: 0x2::linked_table::LinkedTable<0x2::object::ID, PendingClaim>,
    }

    struct PendingClaim has store {
        buyer: address,
        nft_type: 0x1::ascii::String,
        price: u64,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        listings: 0x2::linked_table::LinkedTable<0x2::object::ID, ListingInfo>,
        bids: 0x2::linked_table::LinkedTable<0x2::object::ID, BidInfo>,
        collection_bids: 0x2::linked_table::LinkedTable<0x1::ascii::String, vector<BidInfo>>,
        trait_bids: 0x2::linked_table::LinkedTable<0x1::ascii::String, vector<TraitBidInfo>>,
        claimable_points: u64,
    }

    struct ListingInfo has drop, store {
        nft_type: 0x1::ascii::String,
        price: u64,
        listed_at: u64,
        last_points_claimed_at: u64,
    }

    struct BidInfo has drop, store {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bid_price: u64,
        is_collection_bid: bool,
        bid_at: u64,
        last_points_claimed_at: u64,
    }

    struct TraitBidInfo has drop, store {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bid_price: u64,
        trait_key1: 0x1::option::Option<0x1::ascii::String>,
        trait_value1: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key2: 0x1::option::Option<0x1::ascii::String>,
        trait_value2: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key3: 0x1::option::Option<0x1::ascii::String>,
        trait_value3: 0x1::option::Option<vector<0x1::ascii::String>>,
        bid_at: u64,
        last_points_claimed_at: u64,
    }

    struct CollectionMarketPlace<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        listings: 0x2::linked_table::LinkedTable<0x2::object::ID, Listing<T0>>,
        bids: 0x2::linked_table::LinkedTable<0x2::object::ID, ActiveBids>,
        collection_bids: 0x2::linked_table::LinkedTable<address, vector<ActiveBid>>,
        sui_trait_bids_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        are_trait_bids_enabled: bool,
        lifetime_volume: u128,
        ion_points_enabled: bool,
        ion_collection_multiplier: u64,
        avg_sale_price: u64,
        recent_sale_prices: vector<u64>,
    }

    struct Listing<phantom T0: store + key> has store {
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        commission: u64,
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
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        bid_at: u64,
    }

    struct ActiveTraitBid has store, key {
        id: 0x2::object::UID,
        bidder: address,
        bid_price: u64,
        bid_at: u64,
        trait_key1: 0x1::option::Option<0x1::ascii::String>,
        trait_value1: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key2: 0x1::option::Option<0x1::ascii::String>,
        trait_value2: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key3: 0x1::option::Option<0x1::ascii::String>,
        trait_value3: 0x1::option::Option<vector<0x1::ascii::String>>,
    }

    struct UpdateActiveCollectionsEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        boolean: bool,
    }

    struct CollectCommissionsEvent has copy, drop {
        recepient: address,
        amount: u64,
    }

    struct UpdateIONMultiplierEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        is_ion_points_enabled: bool,
        ion_collection_multiplier: u64,
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
        listed_at: u64,
    }

    struct UnlistEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        seller: address,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        unlisted_at: u64,
        ion_points_awarded: u64,
    }

    struct MakeBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        buyer: address,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        price: u64,
        is_collection_bid: bool,
        bid_at: u64,
    }

    struct CancelBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bidder: address,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        is_collection_bid: bool,
        cancelled_at: u64,
        ion_points_awarded: u64,
    }

    struct BuyEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        seller_kiosk: 0x2::object::ID,
        price: u64,
        commission: u64,
        buyer_ion_points: u64,
        seller_ion_points: u64,
    }

    struct AwardIonPointsEvent has copy, drop {
        user_address: address,
        points_earned: u64,
        referrer_address: 0x1::option::Option<address>,
        referral_points: u64,
        bonus_points: u64,
        total_points: u64,
    }

    struct ReferralPointsClaimedEvent has copy, drop {
        user_address: address,
        claimable_points: u64,
        referral_points: u64,
        bonus_points: u64,
        total_points: u64,
    }

    struct TraitBidMadeEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        bidder: address,
        bid_id: 0x2::object::ID,
        bid_amount: u64,
        trait_key1: 0x1::option::Option<0x1::ascii::String>,
        trait_value1: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key2: 0x1::option::Option<0x1::ascii::String>,
        trait_value2: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key3: 0x1::option::Option<0x1::ascii::String>,
        trait_value3: 0x1::option::Option<vector<0x1::ascii::String>>,
        bid_at: u64,
    }

    struct TraitBidAcceptedEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        commission: u64,
        buyer_ion_points: u64,
        seller_ion_points: u64,
    }

    struct TraitBidCancelledEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        bidder: address,
        bid_id: 0x2::object::ID,
        refund_amount: u64,
        ion_points_awarded: u64,
        cancelled_at: u64,
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
        buyer_ion_points: u64,
        seller_ion_points: u64,
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

    public entry fun list<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"=== LISTING NFT ===");
        0x1::debug::print<0x1::string::String>(&v0);
        validation_check(arg0);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = 0x2::clock::timestamp_ms(arg5);
        validate_collection_exists<T0>(arg0);
        let v5 = arg4 * arg0.commission_pct / 100;
        let v6 = Listing<T0>{
            seller     : v1,
            kiosk_id   : v2,
            nft_id     : arg3,
            cap        : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4 - v5, arg6),
            price      : arg4,
            commission : v5,
            listed_at  : v4,
        };
        0x2::linked_table::push_back<0x2::object::ID, Listing<T0>>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v3).listings, arg3, v6);
        let v7 = &mut arg0.user_activity;
        ensure_user_activity_exists(v7, v1, arg6);
        let v8 = ListingInfo{
            nft_type               : v3,
            price                  : arg4,
            listed_at              : v4,
            last_points_claimed_at : v4,
        };
        0x2::linked_table::push_back<0x2::object::ID, ListingInfo>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v1).listings, arg3, v8);
        let v9 = 0x1::string::utf8(b"NFT listed successfully");
        0x1::debug::print<0x1::string::String>(&v9);
        let v10 = ListEvent{
            nft_type  : v3,
            seller    : v1,
            kiosk_id  : v2,
            nft_id    : arg3,
            price     : arg4,
            listed_at : v4,
        };
        0x2::event::emit<ListEvent>(v10);
    }

    public fun accept_bid<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlaceStore, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: address, arg8: bool, arg9: &0x2::transfer_policy::TransferPolicy<T0>, arg10: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg11: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef, arg12: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg12);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x1::string::utf8(b"=== ACCEPTING BID ===");
        0x1::debug::print<0x1::string::String>(&v3);
        0x1::debug::print<address>(&v1);
        0x1::debug::print<0x2::object::ID>(&arg5);
        0x1::debug::print<0x2::object::ID>(&arg6);
        0x1::debug::print<bool>(&arg8);
        0x1::debug::print<0x1::ascii::String>(&v2);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg1.user_activity, v1), 779);
        let v4 = 0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v1).listings, arg5);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg1.user_activity, arg7), 780);
        let v5 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, arg7);
        let v6 = 0;
        if (arg8) {
            assert!(0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v5.collection_bids, v2), 776);
            let v7 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v5.collection_bids, v2);
            let v8 = 0;
            while (v8 < 0x1::vector::length<BidInfo>(v7)) {
                if (0x1::vector::borrow<BidInfo>(v7, v8).bid_id == arg6) {
                    let v9 = 0x1::vector::remove<BidInfo>(v7, v8);
                    v6 = v9.last_points_claimed_at;
                    break
                };
                v8 = v8 + 1;
            };
            if (0x1::vector::length<BidInfo>(v7) == 0) {
                0x2::linked_table::remove<0x1::ascii::String, vector<BidInfo>>(&mut v5.collection_bids, v2);
            };
        } else {
            assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v5.bids, arg5), 776);
            let v10 = 0x2::linked_table::remove<0x2::object::ID, BidInfo>(&mut v5.bids, arg5);
            v6 = v10.last_points_claimed_at;
        };
        let v11 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg1.id, v2);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v11.listings, arg5), 770);
        let (v12, v13, _, _) = destroy_listing<T0>(0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v11.listings, arg5));
        assert!(v13 == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 778);
        let v16 = 0x2::balance::zero<0x2::sui::SUI>();
        if (arg8) {
            let v17 = 0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v11.collection_bids, arg7);
            let v18 = 0;
            while (v18 < 0x1::vector::length<ActiveBid>(v17)) {
                if (0x2::object::uid_to_inner(&0x1::vector::borrow<ActiveBid>(v17, v18).id) == arg6) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v16, destroy_active_bid(0x1::vector::remove<ActiveBid>(v17, v18)));
                    break
                };
                v18 = v18 + 1;
            };
            if (0x1::vector::length<ActiveBid>(v17) == 0) {
                0x1::vector::destroy_empty<ActiveBid>(0x2::linked_table::remove<address, vector<ActiveBid>>(&mut v11.collection_bids, arg7));
            };
        } else {
            let v19 = 0x2::linked_table::remove<address, ActiveBid>(&mut 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v11.bids, arg5).bids, arg7);
            assert!(0x2::object::uid_to_inner(&v19.id) == arg6, 785);
            0x2::balance::join<0x2::sui::SUI>(&mut v16, destroy_active_bid(v19));
        };
        let v20 = 0x2::balance::value<0x2::sui::SUI>(&v16);
        let v21 = 0x1::string::utf8(b"Purchase amount:");
        0x1::debug::print<0x1::string::String>(&v21);
        0x1::debug::print<u64>(&v20);
        v11.lifetime_volume = v11.lifetime_volume + (0x2::balance::value<0x2::sui::SUI>(&v16) as u128);
        update_collection_avg_price<T0>(v11, 0x2::balance::value<0x2::sui::SUI>(&v16));
        let v22 = 0x2::balance::value<0x2::sui::SUI>(&v16) * arg1.commission_pct / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v16, v22));
        let v23 = 0x1::string::utf8(b"Commission amount:");
        0x1::debug::print<0x1::string::String>(&v23);
        0x1::debug::print<u64>(&v22);
        0x2::kiosk::return_purchase_cap<T0>(arg2, v12);
        0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::destroy_or_transfer_balance<0x2::sui::SUI>(v16, v1, arg12);
        0x2::kiosk::lock<T0>(arg4, &arg1.escrow_kiosk_cap, arg9, 0x2::kiosk::take<T0>(arg2, arg3, arg5));
        let v24 = PendingClaim{
            buyer    : arg7,
            nft_type : v2,
            price    : v20 - v22,
        };
        if (0x2::linked_table::contains<address, PendingClaims>(&arg1.pending_claims, arg7)) {
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut 0x2::linked_table::borrow_mut<address, PendingClaims>(&mut arg1.pending_claims, arg7).pending_claims, arg5, v24);
        } else {
            let v25 = PendingClaims{pending_claims: 0x2::linked_table::new<0x2::object::ID, PendingClaim>(arg12)};
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut v25.pending_claims, arg5, v24);
            0x2::linked_table::push_back<address, PendingClaims>(&mut arg1.pending_claims, arg7, v25);
        };
        let (v26, v27) = if (v11.ion_points_enabled) {
            let v28 = if (v11.ion_collection_multiplier == 0) {
                1000
            } else {
                v11.ion_collection_multiplier
            };
            let v29 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v20, v28, 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_listing_proximity_multiplier(v20, v11.avg_sale_price), 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(v0 - v4.last_points_claimed_at, true));
            award_ion_points_with_referral(v1, arg1, arg10, v29, arg0, arg11);
            let v30 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v20, v28, 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_bid_proximity_multiplier(v20, v11.avg_sale_price), 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(v0 - v6, true));
            let v31 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, arg7);
            v31.claimable_points = v31.claimable_points + v30;
            (v30, v29)
        } else {
            (0, 0)
        };
        let v32 = v27;
        let v33 = v26;
        let v34 = 0x1::string::utf8(b"ION points awarded - Buyer:");
        0x1::debug::print<0x1::string::String>(&v34);
        0x1::debug::print<u64>(&v33);
        let v35 = 0x1::string::utf8(b"ION points awarded - Seller:");
        0x1::debug::print<0x1::string::String>(&v35);
        0x1::debug::print<u64>(&v32);
        let v36 = 0x1::string::utf8(b"Bid accepted successfully");
        0x1::debug::print<0x1::string::String>(&v36);
        let v37 = BidAcceptedEvent{
            nft_type          : v2,
            nft_id            : arg5,
            seller            : v1,
            buyer             : arg7,
            is_collection_bid : arg8,
            price             : v20,
            commission        : v22,
            escrow_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            buyer_ion_points  : v33,
            seller_ion_points : v32,
        };
        0x2::event::emit<BidAcceptedEvent>(v37);
    }

    public fun accept_trait_bid<T0: store + key, T1: store + key>(arg0: &mut MarketPlaceStore, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) : (T0, T1, TraitBidsPotato) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        validate_collection_exists<T0>(arg0);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v1);
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&v2.id, b"trait_bids"), 774);
        assert!(v2.are_trait_bids_enabled, 789);
        let v3 = 0x2::dynamic_object_field::remove<vector<u8>, T1>(&mut v2.id, b"trait_bids");
        let v4 = TraitBidsPotato{id: 0x2::object::id<T1>(&v3)};
        if (0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v1).listings, arg1)) {
            assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 779);
            let v5 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
            assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v5.listings, arg1), 770);
            0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut v5.listings, arg1);
            let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v1);
            assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v6.listings, arg1), 777);
            let (v7, v8, _, _) = destroy_listing<T0>(0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v6.listings, arg1));
            assert!(v8 == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 778);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v7);
        };
        (0x2::kiosk::take<T0>(arg2, arg3, arg1), v3, v4)
    }

    public fun accept_trait_bid_settle<T0: store + key, T1: store + key>(arg0: &mut MarketPlaceStore, arg1: T1, arg2: TraitBidsPotato, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: ActiveTraitBid, arg6: T0, arg7: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg8: &0x2::clock::Clock, arg9: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef, arg10: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let TraitBidsPotato { id: v0 } = arg2;
        assert!(0x2::object::id<T1>(&arg1) == v0, 783);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x2::clock::timestamp_ms(arg8);
        let v4 = arg5.bidder;
        let v5 = arg5.bid_price;
        let v6 = 0x2::object::id<T0>(&arg6);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v4), 780);
        let v7 = 0;
        let v8 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<TraitBidInfo>>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v4).trait_bids, v2);
        let v9 = 0;
        while (v9 < 0x1::vector::length<TraitBidInfo>(v8)) {
            if (0x1::vector::borrow<TraitBidInfo>(v8, v9).bid_id == 0x2::object::id<ActiveTraitBid>(&arg5)) {
                let v10 = 0x1::vector::remove<TraitBidInfo>(v8, v9);
                v7 = v10.last_points_claimed_at;
                break
            };
            v9 = v9 + 1;
        };
        assert!(v7 != 0, 788);
        let v11 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v2);
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut v11.id, b"trait_bids", arg1);
        let v12 = v5 * arg0.commission_pct / 100;
        let v13 = 0x2::balance::split<0x2::sui::SUI>(&mut v11.sui_trait_bids_pool, destroy_active_trait_bid(arg5));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v13, v12));
        0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v13, v1, arg10);
        0x2::kiosk::lock<T0>(arg3, &arg0.escrow_kiosk_cap, arg4, arg6);
        let v14 = PendingClaim{
            buyer    : v4,
            nft_type : v2,
            price    : v5 - v12,
        };
        if (0x2::linked_table::contains<address, PendingClaims>(&arg0.pending_claims, v4)) {
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut 0x2::linked_table::borrow_mut<address, PendingClaims>(&mut arg0.pending_claims, v4).pending_claims, v6, v14);
        } else {
            let v15 = PendingClaims{pending_claims: 0x2::linked_table::new<0x2::object::ID, PendingClaim>(arg10)};
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut v15.pending_claims, v6, v14);
            0x2::linked_table::push_back<address, PendingClaims>(&mut arg0.pending_claims, v4, v15);
        };
        v11.lifetime_volume = v11.lifetime_volume + (v5 as u128);
        update_collection_avg_price<T0>(v11, v5);
        let (v16, v17) = if (v11.ion_points_enabled) {
            let v18 = if (v11.ion_collection_multiplier == 0) {
                1000
            } else {
                v11.ion_collection_multiplier
            };
            let v19 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_bid_proximity_multiplier(v5, v11.avg_sale_price);
            let v20 = if (v7 == 0) {
                arg5.bid_at
            } else {
                v7
            };
            (0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v5, v18, v19, 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(v3 - v20, true)), 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v5, v18, v19, 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(v3 - v7, true)))
        } else {
            (0, 0)
        };
        if (v17 > 0) {
            award_ion_points_with_referral(v1, arg0, arg7, v17, arg8, arg9);
        };
        let v21 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v4);
        v21.claimable_points = v21.claimable_points + v16;
        let v22 = TraitBidAcceptedEvent{
            nft_type          : v2,
            nft_id            : v6,
            seller            : v1,
            buyer             : v4,
            price             : v5,
            commission        : v12,
            buyer_ion_points  : v16,
            seller_ion_points : v17,
        };
        0x2::event::emit<TraitBidAcceptedEvent>(v22);
    }

    public fun accept_unlisted_bid<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlaceStore, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: address, arg7: 0x2::object::ID, arg8: u64, arg9: bool, arg10: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg11: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg12: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef, arg13: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::kiosk::has_item_with_type<T0>(arg2, arg5), 778);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg1.user_activity, arg6), 780);
        let v2 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, arg6);
        let v3 = 0;
        if (arg9) {
            assert!(0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v2.collection_bids, v1), 776);
            let v4 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v2.collection_bids, v1);
            let v5 = 0;
            while (v5 < 0x1::vector::length<BidInfo>(v4)) {
                if (0x1::vector::borrow<BidInfo>(v4, v5).bid_id == arg7) {
                    let v6 = 0x1::vector::remove<BidInfo>(v4, v5);
                    v3 = v6.last_points_claimed_at;
                    break
                };
                v5 = v5 + 1;
            };
            if (0x1::vector::length<BidInfo>(v4) == 0) {
                0x2::linked_table::remove<0x1::ascii::String, vector<BidInfo>>(&mut v2.collection_bids, v1);
            };
        } else {
            assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v2.bids, arg5), 776);
            let v7 = 0x2::linked_table::remove<0x2::object::ID, BidInfo>(&mut v2.bids, arg5);
            v3 = v7.last_points_claimed_at;
        };
        let v8 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg1.id, v1);
        let v9 = 0x2::balance::zero<0x2::sui::SUI>();
        if (arg9) {
            let v10 = 0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v8.collection_bids, arg6);
            let v11 = 0;
            while (v11 < 0x1::vector::length<ActiveBid>(v10)) {
                if (0x2::object::uid_to_inner(&0x1::vector::borrow<ActiveBid>(v10, v11).id) == arg7) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v9, destroy_active_bid(0x1::vector::remove<ActiveBid>(v10, v11)));
                    break
                };
                v11 = v11 + 1;
            };
            if (0x1::vector::length<ActiveBid>(v10) == 0) {
                0x1::vector::destroy_empty<ActiveBid>(0x2::linked_table::remove<address, vector<ActiveBid>>(&mut v8.collection_bids, arg6));
            };
        } else {
            assert!(0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v8.bids, arg5), 776);
            let v12 = 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v8.bids, arg5);
            assert!(0x2::linked_table::contains<address, ActiveBid>(&v12.bids, arg6), 776);
            0x2::balance::join<0x2::sui::SUI>(&mut v9, destroy_active_bid(0x2::linked_table::remove<address, ActiveBid>(&mut v12.bids, arg6)));
        };
        v8.lifetime_volume = v8.lifetime_volume + (0x2::balance::value<0x2::sui::SUI>(&v9) as u128);
        update_collection_avg_price<T0>(v8, 0x2::balance::value<0x2::sui::SUI>(&v9));
        let v13 = 0x2::balance::value<0x2::sui::SUI>(&v9) * arg1.commission_pct / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v13));
        0x2::kiosk::list<T0>(arg2, arg4, arg5, 0x2::balance::value<0x2::sui::SUI>(&v9) - arg8);
        let (v14, v15) = 0x2::kiosk::purchase<T0>(arg2, arg5, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v9, arg8), arg13));
        let v16 = v15;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg10, &mut v16, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v9, arg8), arg13));
        let v17 = 0x2::balance::value<0x2::sui::SUI>(&v9);
        0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v9, v0, arg13);
        0x2::kiosk::lock<T0>(arg3, &arg1.escrow_kiosk_cap, arg10, v14);
        let v18 = PendingClaim{
            buyer    : arg6,
            nft_type : v1,
            price    : v17 - v13,
        };
        if (0x2::linked_table::contains<address, PendingClaims>(&arg1.pending_claims, arg6)) {
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut 0x2::linked_table::borrow_mut<address, PendingClaims>(&mut arg1.pending_claims, arg6).pending_claims, arg5, v18);
        } else {
            let v19 = PendingClaims{pending_claims: 0x2::linked_table::new<0x2::object::ID, PendingClaim>(arg13)};
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut v19.pending_claims, arg5, v18);
            0x2::linked_table::push_back<address, PendingClaims>(&mut arg1.pending_claims, arg6, v19);
        };
        let (v20, v21) = if (v8.ion_points_enabled) {
            let v22 = if (v8.ion_collection_multiplier == 0) {
                1000
            } else {
                v8.ion_collection_multiplier
            };
            let v23 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_bid_proximity_multiplier(v17, v8.avg_sale_price);
            let v24 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(0x2::clock::timestamp_ms(arg0) - v3, true);
            let v25 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v17, v22, v23, v24);
            award_ion_points_with_referral(v0, arg1, arg11, v25, arg0, arg12);
            let v26 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v17, v22, v23, v24);
            let v27 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, arg6);
            v27.claimable_points = v27.claimable_points + v26;
            (v26, v25)
        } else {
            (0, 0)
        };
        let v28 = BidAcceptedEvent{
            nft_type          : v1,
            nft_id            : arg5,
            seller            : v0,
            buyer             : arg6,
            is_collection_bid : arg9,
            price             : v17,
            commission        : v13,
            escrow_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            buyer_ion_points  : v20,
            seller_ion_points : v21,
        };
        0x2::event::emit<BidAcceptedEvent>(v28);
        v16
    }

    public fun add_trait_bidding_support<T0: store + key, T1: store + key>(arg0: &mut MarketPlaceStore, arg1: &TraitBidsAdminCap, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0);
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut v1.id, b"trait_bids", arg2);
        v1.are_trait_bids_enabled = true;
        let v2 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : true,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v2);
    }

    public fun award_bid_ion_points<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: address, arg2: 0x2::object::ID, arg3: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg4: &0x2::clock::Clock, arg5: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef) {
        validation_check(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1), 769);
        let v1 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, arg1);
        assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v1.bids, arg2), 776);
        let v2 = 0x2::linked_table::borrow_mut<0x2::object::ID, BidInfo>(&mut v1.bids, arg2);
        let v3 = if (v2.last_points_claimed_at == 0) {
            v2.bid_at
        } else {
            v2.last_points_claimed_at
        };
        let v4 = v0 - v3;
        let v5 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (v5.ion_points_enabled && v4 > 0) {
            let v6 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(v4, false);
            if (v6 > 0) {
                let v7 = if (v5.ion_collection_multiplier == 0) {
                    1000
                } else {
                    v5.ion_collection_multiplier
                };
                let v8 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v2.bid_price, v7, 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_bid_proximity_multiplier(v2.bid_price, v5.avg_sale_price), v6);
                v2.last_points_claimed_at = v0;
                award_ion_points_with_referral(arg1, arg0, arg3, v8, arg4, arg5);
                if (0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::has_referrer(arg3)) {
                    let v9 = 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::get_referrer(arg3);
                    if (0x1::option::is_some<address>(&v9)) {
                        let v10 = *0x1::option::borrow<address>(&v9);
                        if (0x2::linked_table::contains<address, u64>(&arg0.referrals, v10)) {
                            let v11 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg0.referrals, v10);
                            *v11 = *v11 + v8 * 15 / 100;
                        } else {
                            0x2::linked_table::push_back<address, u64>(&mut arg0.referrals, v10, v8 * 15 / 100);
                        };
                    };
                };
            };
        };
    }

    fun award_ion_points_with_referral(arg0: address, arg1: &mut MarketPlaceStore, arg2: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef) {
        let v0 = 0x1::option::none<address>();
        let v1 = 0;
        let v2 = 0;
        if (0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::has_referrer(arg2)) {
            let v3 = 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::get_referrer(arg2);
            if (0x1::option::is_some<address>(&v3)) {
                0x1::option::fill<address>(&mut v0, *0x1::option::borrow<address>(&v3));
                let v4 = 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::math::mul_div_u128((arg3 as u128), (15 as u128), 100);
                v1 = v4;
                v2 = 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::math::mul_div_u128((arg3 as u128), (10 as u128), 100);
                if (0x2::linked_table::contains<address, u64>(&arg1.referrals, *0x1::option::borrow<address>(&v0))) {
                    let v5 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg1.referrals, *0x1::option::borrow<address>(&v0));
                    *v5 = *v5 + v4;
                } else {
                    0x2::linked_table::push_back<address, u64>(&mut arg1.referrals, *0x1::option::borrow<address>(&v0), v4);
                };
            };
        };
        0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::award_ion_points(&arg1.points_admin_cap, arg4, arg5, arg2, arg3 + v2);
        let v6 = AwardIonPointsEvent{
            user_address     : arg0,
            points_earned    : arg3 + v2,
            referrer_address : v0,
            referral_points  : v1,
            bonus_points     : v2,
            total_points     : arg3 + v2,
        };
        0x2::event::emit<AwardIonPointsEvent>(v6);
    }

    public fun award_listing_ion_points<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: address, arg2: 0x2::object::ID, arg3: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg4: &0x2::clock::Clock, arg5: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef) {
        validation_check(arg0);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1), 769);
        let v0 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, arg1);
        assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v0.listings, arg2), 770);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, ListingInfo>(&mut v0.listings, arg2);
        let v2 = if (v1.last_points_claimed_at == 0) {
            v1.listed_at
        } else {
            v1.last_points_claimed_at
        };
        let v3 = 0x2::clock::timestamp_ms(arg4) - v2;
        let v4 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (v4.ion_points_enabled && v3 > 0) {
            let v5 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(v3, false);
            if (v5 > 0) {
                let v6 = if (v4.ion_collection_multiplier == 0) {
                    1000
                } else {
                    v4.ion_collection_multiplier
                };
                award_ion_points_with_referral(arg1, arg0, arg3, 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v1.price, v6, 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_listing_proximity_multiplier(v1.price, v4.avg_sale_price), v5), arg4, arg5);
            };
        };
    }

    public fun buy<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlaceStore, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg6: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef, arg7: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, u64) {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::kiosk::owner(arg2);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x1::string::utf8(b"=== BUYING NFT ===");
        0x1::debug::print<0x1::string::String>(&v3);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg1.user_activity, v1), 769);
        let v4 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v1);
        assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v4.listings, arg3), 770);
        let v5 = 0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut v4.listings, arg3);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg1.id, v2);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v6.listings, arg3), 777);
        let v7 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v6.listings, arg3);
        let v8 = v7.price;
        let v9 = v7.commission;
        let v10 = 0x1::string::utf8(b"Transaction price:");
        0x1::debug::print<0x1::string::String>(&v10);
        0x1::debug::print<u64>(&v8);
        let v11 = 0x1::string::utf8(b"Commission:");
        0x1::debug::print<0x1::string::String>(&v11);
        0x1::debug::print<u64>(&v9);
        v6.lifetime_volume = v6.lifetime_volume + (v8 as u128);
        update_collection_avg_price<T0>(v6, v8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v8, 772);
        let v12 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v12, v9));
        let (v13, v14, v15, v16) = destroy_listing<T0>(v7);
        assert!(v14 == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 778);
        let (v17, v18) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v13, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v12, v15 - v16), arg7));
        let v19 = v17;
        let (v20, v21) = if (v6.ion_points_enabled) {
            let v22 = if (v6.ion_collection_multiplier == 0) {
                1000
            } else {
                v6.ion_collection_multiplier
            };
            let v23 = v22;
            let v24 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_listing_proximity_multiplier(v8, v6.avg_sale_price);
            let v25 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(0x2::clock::timestamp_ms(arg0) - v5.last_points_claimed_at, true);
            let v26 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::integer_sqrt(v15);
            let v27 = 0x1::string::utf8(b"=== ION POINTS ===");
            0x1::debug::print<0x1::string::String>(&v27);
            let v28 = 0x1::string::utf8(b"Collection multiplier:");
            0x1::debug::print<0x1::string::String>(&v28);
            0x1::debug::print<u64>(&v23);
            let v29 = 0x1::string::utf8(b"Proximity multiplier:");
            0x1::debug::print<0x1::string::String>(&v29);
            0x1::debug::print<u64>(&v24);
            let v30 = 0x1::string::utf8(b"Time multiplier:");
            0x1::debug::print<0x1::string::String>(&v30);
            0x1::debug::print<u64>(&v25);
            let v31 = 0x1::string::utf8(b"SQRT price:");
            0x1::debug::print<0x1::string::String>(&v31);
            0x1::debug::print<u64>(&v26);
            let v32 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v26, v23, v24, v25);
            v4.claimable_points = v4.claimable_points + v32;
            let v33 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v26, v23, v24, 1000);
            award_ion_points_with_referral(v0, arg1, arg5, v33, arg0, arg6);
            (v33, v32)
        } else {
            (0, 0)
        };
        let v34 = v21;
        let v35 = v20;
        let v36 = 0x1::string::utf8(b"ION points awarded - Buyer:");
        0x1::debug::print<0x1::string::String>(&v36);
        0x1::debug::print<u64>(&v35);
        let v37 = 0x1::string::utf8(b"ION points awarded - Seller:");
        0x1::debug::print<0x1::string::String>(&v37);
        0x1::debug::print<u64>(&v34);
        let v38 = BuyEvent{
            nft_type          : v2,
            nft_id            : 0x2::object::id<T0>(&v19),
            buyer             : v0,
            seller            : v1,
            seller_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            price             : v15,
            commission        : v16,
            buyer_ion_points  : v35,
            seller_ion_points : v34,
        };
        0x2::event::emit<BuyEvent>(v38);
        let v39 = 0x1::string::utf8(b"NFT purchased successfully");
        0x1::debug::print<0x1::string::String>(&v39);
        0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v12, v0, arg7);
        (v19, v18, v15 - v16)
    }

    public fun cancel_bid<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x2::object::ID, arg3: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg4: &0x2::clock::Clock, arg5: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef, arg6: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
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
        let v5 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v1);
        let v6 = 0x2::balance::zero<0x2::sui::SUI>();
        if (!v2) {
            let v7 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            assert!(0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v5.bids, v7), 776);
            0x2::balance::join<0x2::sui::SUI>(&mut v6, destroy_active_bid(0x2::linked_table::remove<address, ActiveBid>(&mut 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v5.bids, v7).bids, v0)));
        } else {
            assert!(0x2::linked_table::contains<address, vector<ActiveBid>>(&v5.collection_bids, v0), 776);
            let v8 = 0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v5.collection_bids, v0);
            let v9 = 0;
            while (v9 < 0x1::vector::length<ActiveBid>(v8)) {
                if (0x2::object::uid_to_inner(&0x1::vector::borrow<ActiveBid>(v8, v9).id) == arg2) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v6, destroy_active_bid(0x1::vector::remove<ActiveBid>(v8, v9)));
                    break
                };
                v9 = v9 + 1;
            };
            if (0x1::vector::length<ActiveBid>(v8) == 0) {
                0x1::vector::destroy_empty<ActiveBid>(0x2::linked_table::remove<address, vector<ActiveBid>>(&mut v5.collection_bids, v0));
            };
        };
        let v10 = 0x1::string::utf8(b"Refunding amount:");
        0x1::debug::print<0x1::string::String>(&v10);
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        0x1::debug::print<u64>(&v11);
        0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v6, v0, arg6);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 769);
        let v12 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        let v13 = 0;
        let v14 = 0;
        if (v2) {
            assert!(0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v12.collection_bids, v1), 776);
            let v15 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v12.collection_bids, v1);
            let v16 = 0;
            while (v16 < 0x1::vector::length<BidInfo>(v15)) {
                if (0x1::vector::borrow<BidInfo>(v15, v16).bid_id == arg2) {
                    let v17 = 0x1::vector::remove<BidInfo>(v15, v16);
                    v13 = v17.bid_price;
                    v14 = v17.last_points_claimed_at;
                    break
                };
                v16 = v16 + 1;
            };
            if (0x1::vector::length<BidInfo>(v15) == 0) {
                0x2::linked_table::remove<0x1::ascii::String, vector<BidInfo>>(&mut v12.collection_bids, v1);
            };
        } else {
            let v18 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v12.bids, v18), 776);
            let v19 = 0x2::linked_table::remove<0x2::object::ID, BidInfo>(&mut v12.bids, v18);
            v13 = v19.bid_price;
            v14 = v19.last_points_claimed_at;
        };
        let v20 = v3 - v14;
        let v21 = if (v5.ion_points_enabled) {
            let v22 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(v20, false);
            let v23 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_bid_proximity_multiplier(v13, v5.avg_sale_price);
            let v24 = if (v5.ion_collection_multiplier == 0) {
                1000
            } else {
                v5.ion_collection_multiplier
            };
            let v25 = v24;
            let v26 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v13, v25, v23, v22);
            let v27 = 0x1::string::utf8(b"=== ION POINTS ===");
            0x1::debug::print<0x1::string::String>(&v27);
            let v28 = 0x1::string::utf8(b"Time active:");
            0x1::debug::print<0x1::string::String>(&v28);
            0x1::debug::print<u64>(&v20);
            let v29 = 0x1::string::utf8(b"Time multiplier:");
            0x1::debug::print<0x1::string::String>(&v29);
            0x1::debug::print<u64>(&v22);
            let v30 = 0x1::string::utf8(b"Proximity multiplier:");
            0x1::debug::print<0x1::string::String>(&v30);
            0x1::debug::print<u64>(&v23);
            let v31 = 0x1::string::utf8(b"Collection multiplier:");
            0x1::debug::print<0x1::string::String>(&v31);
            0x1::debug::print<u64>(&v25);
            let v32 = 0x1::string::utf8(b"Points:");
            0x1::debug::print<0x1::string::String>(&v32);
            0x1::debug::print<u64>(&v26);
            award_ion_points_with_referral(v0, arg0, arg3, v26, arg4, arg5);
            v26
        } else {
            0
        };
        let v33 = v21;
        let v34 = 0x1::string::utf8(b"ION points awarded for canceling:");
        0x1::debug::print<0x1::string::String>(&v34);
        0x1::debug::print<u64>(&v33);
        let v35 = 0x1::string::utf8(b"Bid canceled successfully");
        0x1::debug::print<0x1::string::String>(&v35);
        let v36 = CancelBidEvent{
            bid_id             : arg2,
            nft_type           : v1,
            bidder             : v0,
            nft_id             : arg1,
            is_collection_bid  : v2,
            cancelled_at       : v3,
            ion_points_awarded : v33,
        };
        0x2::event::emit<CancelBidEvent>(v36);
    }

    public fun cancel_trait_bid<T0: store + key, T1: store + key>(arg0: &mut MarketPlaceStore, arg1: &mut 0x2::tx_context::TxContext) : (T1, TraitBidsPotato) {
        validation_check(arg0);
        validate_collection_exists<T0>(arg0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&v0.id, b"trait_bids"), 774);
        let v1 = 0x2::dynamic_object_field::remove<vector<u8>, T1>(&mut v0.id, b"trait_bids");
        let v2 = TraitBidsPotato{id: 0x2::object::id<T1>(&v1)};
        (v1, v2)
    }

    public fun cancel_trait_bid_settle<T0: store + key, T1: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlaceStore, arg2: ActiveTraitBid, arg3: T1, arg4: TraitBidsPotato, arg5: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg6: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef, arg7: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let TraitBidsPotato { id: v0 } = arg4;
        assert!(0x2::object::id<T1>(&arg3) == v0, 783);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = arg2.bidder;
        let v4 = 0x2::object::id<ActiveTraitBid>(&arg2);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg1.user_activity, v3), 769);
        let v5 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v3);
        let v6 = 0;
        if (0x2::linked_table::contains<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids, v1)) {
            let v7 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<TraitBidInfo>>(&mut v5.trait_bids, v1);
            let v8 = 0;
            while (v8 < 0x1::vector::length<TraitBidInfo>(v7)) {
                if (0x1::vector::borrow<TraitBidInfo>(v7, v8).bid_id == v4) {
                    let v9 = 0x1::vector::remove<TraitBidInfo>(v7, v8);
                    v6 = v9.last_points_claimed_at;
                    break
                };
                v8 = v8 + 1;
            };
        };
        let v10 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg1.id, v1);
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut v10.id, b"trait_bids", arg3);
        let v11 = destroy_active_trait_bid(arg2);
        0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v10.sui_trait_bids_pool, v11), v3, arg7);
        let v12 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg1.id, v1);
        let v13 = if (v12.ion_points_enabled) {
            let v14 = if (v6 == 0) {
                arg2.bid_at
            } else {
                v6
            };
            let v15 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(v2 - v14, false);
            if (v15 > 0) {
                let v16 = if (v12.ion_collection_multiplier == 0) {
                    1000
                } else {
                    v12.ion_collection_multiplier
                };
                0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v11, v16, 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_bid_proximity_multiplier(v11, v12.avg_sale_price), v15)
            } else {
                0
            }
        } else {
            0
        };
        if (v13 > 0) {
            award_ion_points_with_referral(v3, arg1, arg5, v13, arg0, arg6);
        };
        let v17 = TraitBidCancelledEvent{
            nft_type           : v1,
            bidder             : v3,
            bid_id             : v4,
            refund_amount      : v11,
            ion_points_awarded : v13,
            cancelled_at       : v2,
        };
        0x2::event::emit<TraitBidCancelledEvent>(v17);
    }

    public fun claim_referral_points(arg0: &0x2::clock::Clock, arg1: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef, arg2: &mut MarketPlaceStore, arg3: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::option::none<address>();
        let v2 = 0;
        let v3 = 0;
        assert!(0x2::linked_table::contains<address, u64>(&arg2.referrals, v0), 769);
        let v4 = *0x2::linked_table::borrow<address, u64>(&arg2.referrals, v0);
        *0x2::linked_table::borrow_mut<address, u64>(&mut arg2.referrals, v0) = 0;
        if (0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::has_referrer(arg3)) {
            let v5 = 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::get_referrer(arg3);
            if (0x1::option::is_some<address>(&v5)) {
                0x1::option::fill<address>(&mut v1, *0x1::option::borrow<address>(&v5));
                let v6 = 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::math::mul_div_u128((v4 as u128), (15 as u128), 100);
                v2 = v6;
                v3 = 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::math::mul_div_u128((v4 as u128), (10 as u128), 100);
                if (0x2::linked_table::contains<address, u64>(&arg2.referrals, *0x1::option::borrow<address>(&v1))) {
                    let v7 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg2.referrals, *0x1::option::borrow<address>(&v1));
                    *v7 = *v7 + v6;
                } else {
                    0x2::linked_table::push_back<address, u64>(&mut arg2.referrals, *0x1::option::borrow<address>(&v1), v6);
                };
            };
        };
        let v8 = v2 + v3;
        0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::award_ion_points(&arg2.points_admin_cap, arg0, arg1, arg3, v8);
        let v9 = ReferralPointsClaimedEvent{
            user_address     : v0,
            claimable_points : v4,
            referral_points  : v2,
            bonus_points     : v3,
            total_points     : v8,
        };
        0x2::event::emit<ReferralPointsClaimedEvent>(v9);
    }

    public fun collect_commissions(arg0: &mut MarketPlaceStore, arg1: &CollectorCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = CollectCommissionsEvent{
            recepient : arg2,
            amount    : 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui),
        };
        0x2::event::emit<CollectCommissionsEvent>(v0);
        0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.available_sui), arg2, arg3);
    }

    public fun complete_trait_bid<T0: store + key, T1: store + key>(arg0: &mut MarketPlaceStore, arg1: T1, arg2: TraitBidsPotato, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let TraitBidsPotato { id: v0 } = arg2;
        assert!(0x2::object::id<T1>(&arg1) == v0, 783);
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>())).id, b"trait_bids", arg1);
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

    fun destroy_active_bid(arg0: ActiveBid) : 0x2::balance::Balance<0x2::sui::SUI> {
        let ActiveBid {
            id        : v0,
            bidder    : _,
            bid_price : _,
            balance   : v3,
            bid_at    : _,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    fun destroy_active_trait_bid(arg0: ActiveTraitBid) : u64 {
        let ActiveTraitBid {
            id           : v0,
            bidder       : _,
            bid_price    : v2,
            bid_at       : _,
            trait_key1   : _,
            trait_value1 : _,
            trait_key2   : _,
            trait_value2 : _,
            trait_key3   : _,
            trait_value3 : _,
        } = arg0;
        0x2::object::delete(v0);
        v2
    }

    fun destroy_listing<T0: store + key>(arg0: Listing<T0>) : (0x2::kiosk::PurchaseCap<T0>, 0x2::object::ID, u64, u64) {
        let Listing {
            seller     : _,
            kiosk_id   : v1,
            nft_id     : _,
            cap        : v3,
            price      : v4,
            commission : v5,
            listed_at  : _,
        } = arg0;
        (v3, v1, v4, v5)
    }

    fun ensure_user_activity_exists(arg0: &mut 0x2::linked_table::LinkedTable<address, UserInfo>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<address, UserInfo>(arg0, arg1)) {
            let v0 = UserInfo{
                id               : 0x2::object::new(arg2),
                listings         : 0x2::linked_table::new<0x2::object::ID, ListingInfo>(arg2),
                bids             : 0x2::linked_table::new<0x2::object::ID, BidInfo>(arg2),
                collection_bids  : 0x2::linked_table::new<0x1::ascii::String, vector<BidInfo>>(arg2),
                trait_bids       : 0x2::linked_table::new<0x1::ascii::String, vector<TraitBidInfo>>(arg2),
                claimable_points : 0,
            };
            0x2::linked_table::push_back<address, UserInfo>(arg0, arg1, v0);
        };
    }

    public fun get_active_bid_balance(arg0: &ActiveBid) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_active_bid_info(arg0: &ActiveTraitBid) : (address, u64, u64, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>) {
        (arg0.bidder, arg0.bid_price, arg0.bid_at, arg0.trait_key1, arg0.trait_value1, arg0.trait_key2, arg0.trait_value2, arg0.trait_key3, arg0.trait_value3)
    }

    public fun get_bids_for_any_nft<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x2::object::ID, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<address>, vector<0x2::object::ID>, vector<u64>, vector<u64>, u64, bool) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, 0, false)
        };
        let v5 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        if (!0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v5.bids, arg1)) {
            return (v1, v2, v3, v4, 0, 0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v5.listings, arg1))
        };
        let v6 = 0x2::linked_table::borrow<0x2::object::ID, ActiveBids>(&v5.bids, arg1);
        let v7 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, ActiveBid>(&v6.bids)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<address>(&v8) && v9 < arg3) {
            let v10 = 0x1::option::borrow<address>(&v8);
            let v11 = 0x2::linked_table::borrow<address, ActiveBid>(&v6.bids, *v10);
            0x1::vector::push_back<address>(&mut v1, *v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::uid_to_inner(&v11.id));
            0x1::vector::push_back<u64>(&mut v3, v11.bid_price);
            0x1::vector::push_back<u64>(&mut v4, 0x2::balance::value<0x2::sui::SUI>(&v11.balance));
            v8 = *0x2::linked_table::next<address, ActiveBid>(&v6.bids, *v10);
            v9 = v9 + 1;
        };
        (v1, v2, v3, v4, 0x2::linked_table::length<address, ActiveBid>(&v6.bids), 0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v5.listings, arg1))
    }

    public fun get_bids_for_listing<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x2::object::ID, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<address>, vector<0x2::object::ID>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, 0)
        };
        let v5 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        if (!0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v5.bids, arg1)) {
            return (v1, v2, v3, v4, 0)
        };
        let v6 = 0x2::linked_table::borrow<0x2::object::ID, ActiveBids>(&v5.bids, arg1);
        let v7 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, ActiveBid>(&v6.bids)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<address>(&v8) && v9 < arg3) {
            let v10 = 0x1::option::borrow<address>(&v8);
            let v11 = 0x2::linked_table::borrow<address, ActiveBid>(&v6.bids, *v10);
            0x1::vector::push_back<address>(&mut v1, *v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::uid_to_inner(&v11.id));
            0x1::vector::push_back<u64>(&mut v3, v11.bid_price);
            0x1::vector::push_back<u64>(&mut v4, 0x2::balance::value<0x2::sui::SUI>(&v11.balance));
            v8 = *0x2::linked_table::next<address, ActiveBid>(&v6.bids, *v10);
            v9 = v9 + 1;
        };
        (v1, v2, v3, v4, 0x2::linked_table::length<address, ActiveBid>(&v6.bids))
    }

    public fun get_collection_bidders_for_collection<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, 0)
        };
        let v3 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        let v4 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, vector<ActiveBid>>(&v3.collection_bids)
        };
        let v5 = v4;
        let v6 = 0;
        while (0x1::option::is_some<address>(&v5) && v6 < arg2) {
            let v7 = 0x1::option::borrow<address>(&v5);
            0x1::vector::push_back<address>(&mut v1, *v7);
            0x1::vector::push_back<u64>(&mut v2, 0x1::vector::length<ActiveBid>(0x2::linked_table::borrow<address, vector<ActiveBid>>(&v3.collection_bids, *v7)));
            v5 = *0x2::linked_table::next<address, vector<ActiveBid>>(&v3.collection_bids, *v7);
            v6 = v6 + 1;
        };
        (v1, v2, 0x2::linked_table::length<address, vector<ActiveBid>>(&v3.collection_bids))
    }

    public fun get_collection_bids_by_user_for_collection<T0: store + key>(arg0: &MarketPlaceStore, arg1: address, arg2: u64, arg3: u64) : (vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, 0)
        };
        let v5 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        if (!0x2::linked_table::contains<address, vector<ActiveBid>>(&v5.collection_bids, arg1)) {
            return (v1, v2, v3, v4, 0)
        };
        let v6 = 0x2::linked_table::borrow<address, vector<ActiveBid>>(&v5.collection_bids, arg1);
        while (arg2 < 0x1::vector::length<ActiveBid>(v6) && arg2 < arg3) {
            let v7 = 0x1::vector::borrow<ActiveBid>(v6, arg2);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::uid_to_inner(&v7.id));
            0x1::vector::push_back<u64>(&mut v2, v7.bid_price);
            0x1::vector::push_back<u64>(&mut v3, 0x2::balance::value<0x2::sui::SUI>(&v7.balance));
            0x1::vector::push_back<u64>(&mut v4, v7.bid_at);
            arg2 = arg2 + 1;
        };
        (v1, v2, v3, v4, 0x1::vector::length<ActiveBid>(v6))
    }

    public fun get_collection_fee(arg0: &MarketPlaceStore) : u64 {
        arg0.new_collection_fee
    }

    public fun get_collection_marketplace_info<T0: store + key>(arg0: &MarketPlaceStore) : (u64, u64, u64, u128, bool, u64, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (0, 0, 0, 0, false, 0, 0)
        };
        let v1 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        (0x2::linked_table::length<0x2::object::ID, Listing<T0>>(&v1.listings), 0x2::linked_table::length<0x2::object::ID, ActiveBids>(&v1.bids), 0x2::linked_table::length<address, vector<ActiveBid>>(&v1.collection_bids), v1.lifetime_volume, v1.ion_points_enabled, v1.ion_collection_multiplier, v1.avg_sale_price)
    }

    public fun get_listings_for_marketplace<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) : (vector<address>, vector<0x2::object::ID>, vector<0x2::object::ID>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, v5, 0)
        };
        let v6 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        let v7 = if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x2::object::ID, Listing<T0>>(&v6.listings)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v8) && v9 < arg2) {
            let v10 = 0x1::option::borrow<0x2::object::ID>(&v8);
            let v11 = 0x2::linked_table::borrow<0x2::object::ID, Listing<T0>>(&v6.listings, *v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, *v10);
            0x1::vector::push_back<address>(&mut v1, v11.seller);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v11.kiosk_id);
            0x1::vector::push_back<u64>(&mut v4, v11.price);
            0x1::vector::push_back<u64>(&mut v5, v11.commission);
            v8 = *0x2::linked_table::next<0x2::object::ID, Listing<T0>>(&v6.listings, *v10);
            v9 = v9 + 1;
        };
        (v1, v2, v3, v4, v5, 0x2::linked_table::length<0x2::object::ID, Listing<T0>>(&v6.listings))
    }

    public fun get_marketplace_info(arg0: &MarketPlaceStore) : (address, bool, u64, u64, u64, u64, u64, 0x2::object::ID, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), arg0.is_permissionless, arg0.new_collection_fee, arg0.commission_pct, 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui), 0x2::linked_table::length<address, UserInfo>(&arg0.user_activity), 0x2::linked_table::length<0x1::ascii::String, bool>(&arg0.active_collections), arg0.kiosk_id, 0x2::linked_table::length<address, u64>(&arg0.referrals), arg0.version)
    }

    public fun get_referral_points_balance(arg0: &MarketPlaceStore, arg1: address) : u64 {
        if (0x2::linked_table::contains<address, u64>(&arg0.referrals, arg1)) {
            *0x2::linked_table::borrow<address, u64>(&arg0.referrals, arg1)
        } else {
            0
        }
    }

    public fun get_trait_bid_details(arg0: &MarketPlaceStore, arg1: address, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, u64, u64) {
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (0x1::ascii::string(b""), 0, 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0, 0)
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
                    return (v5.nft_type, v5.bid_price, v5.trait_key1, v5.trait_value1, v5.trait_key2, v5.trait_value2, v5.trait_key3, v5.trait_value3, v5.bid_at, v5.last_points_claimed_at)
                };
                v4 = v4 + 1;
            };
            v1 = *0x2::linked_table::next<0x1::ascii::String, vector<TraitBidInfo>>(&v0.trait_bids, *v2);
        };
        (0x1::ascii::string(b""), 0, 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0, 0)
    }

    public fun get_user_activity_overview(arg0: &MarketPlaceStore, arg1: address) : (u64, u64, u64, u64, u64) {
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            (0, 0, 0, 0, 0)
        } else {
            let v5 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
            (0x2::linked_table::length<0x2::object::ID, ListingInfo>(&v5.listings), 0x2::linked_table::length<0x2::object::ID, BidInfo>(&v5.bids), 0x2::linked_table::length<0x1::ascii::String, vector<BidInfo>>(&v5.collection_bids), 0x2::linked_table::length<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids), v5.claimable_points)
        }
    }

    public fun get_user_addresses_list(arg0: &MarketPlaceStore, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, UserInfo>(&arg0.user_activity)
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<address>(&v2) && v3 < arg2) {
            let v4 = 0x1::option::borrow<address>(&v2);
            0x1::vector::push_back<address>(&mut v0, *v4);
            v2 = *0x2::linked_table::next<address, UserInfo>(&arg0.user_activity, *v4);
            v3 = v3 + 1;
        };
        (v0, 0x2::linked_table::length<address, UserInfo>(&arg0.user_activity))
    }

    public fun get_user_bids_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, v4, v5, 0)
        };
        let v6 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v7 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, BidInfo>(&v6.bids)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v8) && v9 < arg3) {
            let v10 = 0x1::option::borrow<0x2::object::ID>(&v8);
            let v11 = 0x2::linked_table::borrow<0x2::object::ID, BidInfo>(&v6.bids, *v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v10);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v11.nft_type);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v11.bid_id);
            0x1::vector::push_back<u64>(&mut v3, v11.bid_price);
            0x1::vector::push_back<u64>(&mut v4, v11.bid_at);
            0x1::vector::push_back<u64>(&mut v5, v11.last_points_claimed_at);
            v8 = *0x2::linked_table::next<0x2::object::ID, BidInfo>(&v6.bids, *v10);
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, 0x2::linked_table::length<0x2::object::ID, BidInfo>(&v6.bids))
    }

    public fun get_user_collection_bids_for_type(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) : (vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, 0)
        };
        let v4 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        if (!0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v4.collection_bids, arg2)) {
            return (v0, v1, v2, v3, 0)
        };
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, vector<BidInfo>>(&v4.collection_bids, arg2);
        let v6 = 0x1::vector::length<BidInfo>(v5);
        while (arg3 < v6 && arg3 < arg4) {
            let v7 = 0x1::vector::borrow<BidInfo>(v5, arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v7.bid_id);
            0x1::vector::push_back<u64>(&mut v1, v7.bid_price);
            0x1::vector::push_back<u64>(&mut v2, v7.bid_at);
            0x1::vector::push_back<u64>(&mut v3, v7.last_points_claimed_at);
            arg3 = arg3 + 1;
        };
        (v0, v1, v2, v3, v6)
    }

    public fun get_user_collection_bids_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x1::ascii::String>, arg3: u64) : (vector<0x1::ascii::String>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, 0)
        };
        let v2 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v3 = if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x1::ascii::String, vector<BidInfo>>(&v2.collection_bids)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v4) && v5 < arg3) {
            let v6 = 0x1::option::borrow<0x1::ascii::String>(&v4);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v6);
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::length<BidInfo>(0x2::linked_table::borrow<0x1::ascii::String, vector<BidInfo>>(&v2.collection_bids, *v6)));
            v4 = *0x2::linked_table::next<0x1::ascii::String, vector<BidInfo>>(&v2.collection_bids, *v6);
            v5 = v5 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, vector<BidInfo>>(&v2.collection_bids))
    }

    public fun get_user_listings_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, 0)
        };
        let v4 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v5 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, ListingInfo>(&v4.listings)
        };
        let v6 = v5;
        let v7 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v6) && v7 < arg3) {
            let v8 = 0x1::option::borrow<0x2::object::ID>(&v6);
            let v9 = 0x2::linked_table::borrow<0x2::object::ID, ListingInfo>(&v4.listings, *v8);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v8);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v9.nft_type);
            0x1::vector::push_back<u64>(&mut v2, v9.price);
            0x1::vector::push_back<u64>(&mut v3, v9.last_points_claimed_at);
            v6 = *0x2::linked_table::next<0x2::object::ID, ListingInfo>(&v4.listings, *v8);
            v7 = v7 + 1;
        };
        (v0, v1, v2, v3, 0x2::linked_table::length<0x2::object::ID, ListingInfo>(&v4.listings))
    }

    public fun get_user_pending_claims(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, PendingClaims>(&arg0.pending_claims, arg1)) {
            return (0x1::vector::empty<0x2::object::ID>(), 0x1::vector::empty<0x1::ascii::String>(), 0)
        };
        let v3 = 0x2::linked_table::borrow<address, PendingClaims>(&arg0.pending_claims, arg1);
        let v4 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, PendingClaim>(&v3.pending_claims)
        };
        let v5 = v4;
        let v6 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v5) && v6 < arg3) {
            let v7 = 0x1::option::borrow<0x2::object::ID>(&v5);
            let v8 = 0x2::linked_table::borrow<0x2::object::ID, PendingClaim>(&v3.pending_claims, *v7);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v7);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v8.nft_type);
            0x1::vector::push_back<u64>(&mut v2, v8.price);
            v5 = *0x2::linked_table::next<0x2::object::ID, PendingClaim>(&v3.pending_claims, *v7);
            v6 = v6 + 1;
        };
        (v0, v1, v6)
    }

    public fun get_user_trait_bids_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x1::ascii::String>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<u64>, vector<0x1::ascii::String>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        let v4 = 0;
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, 0)
        };
        let v5 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v6 = if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids)
        };
        let v7 = v6;
        let v8 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v7) && v8 < arg3) {
            let v9 = 0x1::option::borrow<0x1::ascii::String>(&v7);
            let v10 = 0x2::linked_table::borrow<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids, *v9);
            let v11 = 0;
            while (v11 < 0x1::vector::length<TraitBidInfo>(v10) && v8 < arg3) {
                let v12 = 0x1::vector::borrow<TraitBidInfo>(v10, v11);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v12.bid_id);
                0x1::vector::push_back<0x1::ascii::String>(&mut v1, v12.nft_type);
                0x1::vector::push_back<u64>(&mut v2, v12.bid_price);
                0x1::vector::push_back<0x1::ascii::String>(&mut v3, create_trait_summary(v12.trait_key1, v12.trait_key2, v12.trait_key3));
                v11 = v11 + 1;
                v8 = v8 + 1;
                v4 = v4 + 1;
            };
            v7 = *0x2::linked_table::next<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids, *v9);
        };
        let v13 = 0;
        let v14 = *0x2::linked_table::front<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids);
        while (0x1::option::is_some<0x1::ascii::String>(&v14)) {
            let v15 = 0x1::option::borrow<0x1::ascii::String>(&v14);
            v13 = v13 + 0x1::vector::length<TraitBidInfo>(0x2::linked_table::borrow<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids, *v15));
            v14 = *0x2::linked_table::next<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids, *v15);
        };
        (v0, v1, v2, v3, v13)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CollectorCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = LaunchpadCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<LaunchpadCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = TraitBidsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TraitBidsAdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun init_marketplace(arg0: &AdminCap, arg1: 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::PointsAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v1;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v3 = MarketPlaceStore{
            id                 : 0x2::object::new(arg2),
            points_admin_cap   : arg1,
            is_permissionless  : false,
            new_collection_fee : 100000000000,
            commission_pct     : 2,
            available_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            user_activity      : 0x2::linked_table::new<address, UserInfo>(arg2),
            active_collections : 0x2::linked_table::new<0x1::ascii::String, bool>(arg2),
            referrals          : 0x2::linked_table::new<address, u64>(arg2),
            kiosk_id           : 0x2::kiosk::kiosk_owner_cap_for(&v2),
            escrow_kiosk_cap   : v2,
            pending_claims     : 0x2::linked_table::new<address, PendingClaims>(arg2),
            version            : 0,
        };
        0x2::transfer::share_object<MarketPlaceStore>(v3);
    }

    public fun is_permissionless(arg0: &MarketPlaceStore) : bool {
        arg0.is_permissionless
    }

    public fun launchpad_add_collection<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &LaunchpadCap, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        assert!(arg3 <= 10000, 781);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
        let v1 = CollectionMarketPlace<T0>{
            id                        : 0x2::object::new(arg4),
            listings                  : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg4),
            bids                      : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg4),
            collection_bids           : 0x2::linked_table::new<address, vector<ActiveBid>>(arg4),
            sui_trait_bids_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
            are_trait_bids_enabled    : false,
            lifetime_volume           : 0,
            ion_points_enabled        : arg2,
            ion_collection_multiplier : arg3,
            avg_sale_price            : 0,
            recent_sale_prices        : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0, v1);
        let v2 = UpdateActiveCollectionsEvent{
            nft_type : v0,
            boolean  : true,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v2);
        let v3 = UpdateIONMultiplierEvent{
            nft_type                  : v0,
            is_ion_points_enabled     : arg2,
            ion_collection_multiplier : arg3,
        };
        0x2::event::emit<UpdateIONMultiplierEvent>(v3);
    }

    public entry fun make_bid<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = !0x1::option::is_some<0x2::object::ID>(&arg1);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = 0x1::string::utf8(b"=== MAKING BID ===");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<address>(&v0);
        0x1::debug::print<0x1::option::Option<0x2::object::ID>>(&arg1);
        0x1::debug::print<u64>(&arg2);
        0x1::debug::print<bool>(&v2);
        0x1::debug::print<0x1::ascii::String>(&v1);
        validate_collection_exists<T0>(arg0);
        let v5 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v1);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v7 = ActiveBid{
            id        : 0x2::object::new(arg5),
            bidder    : v0,
            bid_price : arg2,
            balance   : 0x2::balance::split<0x2::sui::SUI>(&mut v6, arg2),
            bid_at    : v3,
        };
        let v8 = 0x2::object::id<ActiveBid>(&v7);
        let v9 = 0x1::string::utf8(b"Created bid with ID:");
        0x1::debug::print<0x1::string::String>(&v9);
        0x1::debug::print<0x2::object::ID>(&v8);
        if (!v2) {
            let v10 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            if (0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v5.bids, v10)) {
                let v11 = 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v5.bids, v10);
                assert!(!0x2::linked_table::contains<address, ActiveBid>(&v11.bids, v0), 775);
                0x2::linked_table::push_back<address, ActiveBid>(&mut v11.bids, v0, v7);
            } else {
                let v12 = ActiveBids{
                    id   : 0x2::object::new(arg5),
                    bids : 0x2::linked_table::new<address, ActiveBid>(arg5),
                };
                0x2::linked_table::push_back<address, ActiveBid>(&mut v12.bids, v0, v7);
                0x2::linked_table::push_back<0x2::object::ID, ActiveBids>(&mut v5.bids, v10, v12);
            };
        } else if (0x2::linked_table::contains<address, vector<ActiveBid>>(&v5.collection_bids, v0)) {
            0x1::vector::push_back<ActiveBid>(0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v5.collection_bids, v0), v7);
        } else {
            let v13 = 0x1::vector::empty<ActiveBid>();
            0x1::vector::push_back<ActiveBid>(&mut v13, v7);
            0x2::linked_table::push_back<address, vector<ActiveBid>>(&mut v5.collection_bids, v0, v13);
        };
        let v14 = BidInfo{
            bid_id                 : v8,
            nft_type               : v1,
            bid_price              : arg2,
            is_collection_bid      : v2,
            bid_at                 : v3,
            last_points_claimed_at : v3,
        };
        let v15 = &mut arg0.user_activity;
        ensure_user_activity_exists(v15, v0, arg5);
        let v16 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        if (v2) {
            if (0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v16.collection_bids, v1)) {
                0x1::vector::push_back<BidInfo>(0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v16.collection_bids, v1), v14);
            } else {
                let v17 = 0x1::vector::empty<BidInfo>();
                0x1::vector::push_back<BidInfo>(&mut v17, v14);
                0x2::linked_table::push_back<0x1::ascii::String, vector<BidInfo>>(&mut v16.collection_bids, v1, v17);
            };
        } else {
            let v18 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            assert!(!0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v16.bids, v18), 775);
            0x2::linked_table::push_back<0x2::object::ID, BidInfo>(&mut v16.bids, v18, v14);
        };
        let v19 = 0x1::string::utf8(b"Bid created successfully");
        0x1::debug::print<0x1::string::String>(&v19);
        let v20 = MakeBidEvent{
            bid_id            : v8,
            nft_type          : v1,
            buyer             : v0,
            nft_id            : arg1,
            price             : arg2,
            is_collection_bid : v2,
            bid_at            : v3,
        };
        0x2::event::emit<MakeBidEvent>(v20);
        0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v6, v0, arg5);
    }

    public fun make_trait_bid<T0: store + key, T1: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlaceStore, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::option::Option<0x1::ascii::String>, arg4: 0x1::option::Option<vector<0x1::ascii::String>>, arg5: 0x1::option::Option<0x1::ascii::String>, arg6: 0x1::option::Option<vector<0x1::ascii::String>>, arg7: 0x1::option::Option<0x1::ascii::String>, arg8: 0x1::option::Option<vector<0x1::ascii::String>>, arg9: &mut 0x2::tx_context::TxContext) : (ActiveTraitBid, T1, TraitBidsPotato) {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x2::clock::timestamp_ms(arg0);
        validate_collection_exists<T0>(arg1);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg1.id, v1);
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&v3.id, b"trait_bids"), 782);
        assert!(v3.are_trait_bids_enabled, 789);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v6 = ActiveTraitBid{
            id           : 0x2::object::new(arg9),
            bidder       : v0,
            bid_price    : v4,
            bid_at       : v2,
            trait_key1   : arg3,
            trait_value1 : arg4,
            trait_key2   : arg5,
            trait_value2 : arg6,
            trait_key3   : arg7,
            trait_value3 : arg8,
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v3.sui_trait_bids_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v4));
        let v7 = 0x2::object::id<ActiveTraitBid>(&v6);
        let v8 = &mut arg1.user_activity;
        ensure_user_activity_exists(v8, v0, arg9);
        let v9 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v0);
        let v10 = TraitBidInfo{
            bid_id                 : v7,
            nft_type               : v1,
            bid_price              : v4,
            trait_key1             : arg3,
            trait_value1           : arg4,
            trait_key2             : arg5,
            trait_value2           : arg6,
            trait_key3             : arg7,
            trait_value3           : arg8,
            bid_at                 : v2,
            last_points_claimed_at : v2,
        };
        if (0x2::linked_table::contains<0x1::ascii::String, vector<TraitBidInfo>>(&v9.trait_bids, v1)) {
            0x1::vector::push_back<TraitBidInfo>(0x2::linked_table::borrow_mut<0x1::ascii::String, vector<TraitBidInfo>>(&mut v9.trait_bids, v1), v10);
        } else {
            let v11 = 0x1::vector::empty<TraitBidInfo>();
            0x1::vector::push_back<TraitBidInfo>(&mut v11, v10);
            0x2::linked_table::push_back<0x1::ascii::String, vector<TraitBidInfo>>(&mut v9.trait_bids, v1, v11);
        };
        let v12 = 0x2::dynamic_object_field::remove<vector<u8>, T1>(&mut v3.id, b"trait_bids");
        let v13 = TraitBidsPotato{id: 0x2::object::id<T1>(&v12)};
        0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v5, v0, arg9);
        let v14 = TraitBidMadeEvent{
            nft_type     : v1,
            bidder       : v0,
            bid_id       : v7,
            bid_amount   : v4,
            trait_key1   : arg3,
            trait_value1 : arg4,
            trait_key2   : arg5,
            trait_value2 : arg6,
            trait_key3   : arg7,
            trait_value3 : arg8,
            bid_at       : v2,
        };
        0x2::event::emit<TraitBidMadeEvent>(v14);
        (v6, v12, v13)
    }

    public fun permissionless_add_collection<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        assert!(arg0.is_permissionless, 774);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.new_collection_fee, 772);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v1, arg0.new_collection_fee));
        0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg2), arg2);
        0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
        let v2 = CollectionMarketPlace<T0>{
            id                        : 0x2::object::new(arg2),
            listings                  : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg2),
            bids                      : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg2),
            collection_bids           : 0x2::linked_table::new<address, vector<ActiveBid>>(arg2),
            sui_trait_bids_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
            are_trait_bids_enabled    : false,
            lifetime_volume           : 0,
            ion_points_enabled        : false,
            ion_collection_multiplier : 0,
            avg_sale_price            : 0,
            recent_sale_prices        : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0, v2);
        let v3 = UpdateActiveCollectionsEvent{
            nft_type : v0,
            boolean  : true,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v3);
    }

    public fun process_pending_claim<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlaceStore, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::string::utf8(b"=== PROCESSING PENDING CLAIM ===");
        0x1::debug::print<0x1::string::String>(&v1);
        0x1::debug::print<address>(&v0);
        0x1::debug::print<0x2::object::ID>(&arg5);
        assert!(0x2::linked_table::contains<address, PendingClaims>(&arg1.pending_claims, v0), 786);
        let v2 = 0x2::linked_table::borrow_mut<address, PendingClaims>(&mut arg1.pending_claims, v0);
        assert!(0x2::linked_table::contains<0x2::object::ID, PendingClaim>(&v2.pending_claims, arg5), 787);
        let v3 = 0x2::linked_table::remove<0x2::object::ID, PendingClaim>(&mut v2.pending_claims, arg5);
        assert!(v3.buyer == v0, 784);
        let PendingClaim {
            buyer    : _,
            nft_type : v5,
            price    : _,
        } = v3;
        let v7 = 0x1::string::utf8(b"Pending claim verified for buyer");
        0x1::debug::print<0x1::string::String>(&v7);
        0x1::debug::print<address>(&v0);
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg4) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 778);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, &arg1.escrow_kiosk_cap, arg5, 0, arg6), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg6));
        0x2::kiosk::place<T0>(arg3, arg4, v8);
        let v10 = 0x1::string::utf8(b"NFT successfully transferred to buyer's kiosk");
        0x1::debug::print<0x1::string::String>(&v10);
        let v11 = NFTClaimedEvent{
            nft_type    : v5,
            nft_id      : arg5,
            buyer       : v0,
            buyer_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            claimed_at  : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<NFTClaimedEvent>(v11);
        v9
    }

    public fun remove_trait_bidding_support<T0: store + key, T1: store + key>(arg0: &mut MarketPlaceStore, arg1: &TraitBidsAdminCap, arg2: &mut 0x2::tx_context::TxContext) : T1 {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0);
        v1.are_trait_bids_enabled = false;
        let v2 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : false,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v2);
        0x2::dynamic_object_field::remove<vector<u8>, T1>(&mut v1.id, b"trait_bids")
    }

    public fun switch_trait_bidding_support<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &TraitBidsAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0);
        v1.are_trait_bids_enabled = !v1.are_trait_bids_enabled;
        let v2 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : v1.are_trait_bids_enabled,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v2);
    }

    public fun unlist<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaIONs, arg4: &0x2::clock::Clock, arg5: &mut 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::ions::AnimaChef, arg6: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = 0x1::string::utf8(b"=== UNLISTING NFT ===");
        0x1::debug::print<0x1::string::String>(&v3);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 769);
        let v4 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v4.listings, arg2), 770);
        let v5 = 0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut v4.listings, arg2);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v1);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v6.listings, arg2), 770);
        let v7 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v6.listings, arg2);
        let v8 = v2 - v5.last_points_claimed_at;
        let v9 = 0x1::string::utf8(b"Time active:");
        0x1::debug::print<0x1::string::String>(&v9);
        0x1::debug::print<u64>(&v8);
        let v10 = if (v6.ion_points_enabled) {
            let v11 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_time_multiplier(v8, false);
            let v12 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_listing_proximity_multiplier(v7.price, v6.avg_sale_price);
            let v13 = if (v6.ion_collection_multiplier == 0) {
                1000
            } else {
                v6.ion_collection_multiplier
            };
            let v14 = v13;
            let v15 = 0xa32574713e612fa6d9eb439723cb7d69f06ae55117d8c9a028330cea98c5f391::helpers::calculate_ion_points(v7.price, v14, v12, v11);
            let v16 = 0x1::string::utf8(b"=== ION POINTS ===");
            0x1::debug::print<0x1::string::String>(&v16);
            let v17 = 0x1::string::utf8(b"Time multiplier:");
            0x1::debug::print<0x1::string::String>(&v17);
            0x1::debug::print<u64>(&v11);
            let v18 = 0x1::string::utf8(b"Proximity multiplier:");
            0x1::debug::print<0x1::string::String>(&v18);
            0x1::debug::print<u64>(&v12);
            let v19 = 0x1::string::utf8(b"Collection multiplier:");
            0x1::debug::print<0x1::string::String>(&v19);
            0x1::debug::print<u64>(&v14);
            let v20 = 0x1::string::utf8(b"Points:");
            0x1::debug::print<0x1::string::String>(&v20);
            0x1::debug::print<u64>(&v15);
            award_ion_points_with_referral(v0, arg0, arg3, v15, arg4, arg5);
            v15
        } else {
            0
        };
        let v21 = v10;
        let v22 = 0x1::string::utf8(b"ION points awarded for unlisting:");
        0x1::debug::print<0x1::string::String>(&v22);
        0x1::debug::print<u64>(&v21);
        let v23 = UnlistEvent{
            nft_type           : v1,
            seller             : v0,
            nft_id             : arg2,
            kiosk_id           : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            price              : v7.price,
            unlisted_at        : v2,
            ion_points_awarded : v21,
        };
        0x2::event::emit<UnlistEvent>(v23);
        let Listing {
            seller     : _,
            kiosk_id   : _,
            nft_id     : _,
            cap        : v27,
            price      : _,
            commission : _,
            listed_at  : _,
        } = v7;
        0x2::kiosk::return_purchase_cap<T0>(arg1, v27);
        let v31 = 0x1::string::utf8(b"NFT unlisted successfully");
        0x1::debug::print<0x1::string::String>(&v31);
    }

    public fun update_active_collections<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (arg2) {
            if (!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0)) {
                0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
            } else {
                *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.active_collections, v0) = true;
            };
            if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
                let v1 = CollectionMarketPlace<T0>{
                    id                        : 0x2::object::new(arg3),
                    listings                  : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg3),
                    bids                      : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg3),
                    collection_bids           : 0x2::linked_table::new<address, vector<ActiveBid>>(arg3),
                    sui_trait_bids_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
                    are_trait_bids_enabled    : false,
                    lifetime_volume           : 0,
                    ion_points_enabled        : false,
                    ion_collection_multiplier : 0,
                    avg_sale_price            : 0,
                    recent_sale_prices        : 0x1::vector::empty<u64>(),
                };
                0x2::dynamic_object_field::add<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0, v1);
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

    fun update_collection_avg_price<T0: store + key>(arg0: &mut CollectionMarketPlace<T0>, arg1: u64) {
        if (0x1::vector::length<u64>(&arg0.recent_sale_prices) >= 10) {
            0x1::vector::remove<u64>(&mut arg0.recent_sale_prices, 0);
        };
        0x1::vector::push_back<u64>(&mut arg0.recent_sale_prices, arg1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.recent_sale_prices)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0.recent_sale_prices, v1);
            v1 = v1 + 1;
        };
        arg0.avg_sale_price = v0 / 0x1::vector::length<u64>(&arg0.recent_sale_prices);
    }

    public fun update_collection_fee(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: u64) {
        validation_check(arg0);
        arg0.new_collection_fee = arg2;
    }

    public fun update_commission_pct(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: u64) {
        validation_check(arg0);
        assert!(arg2 <= 10, 771);
        arg0.commission_pct = arg2;
    }

    public fun update_ion_point_multiplier<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: bool, arg3: u64) {
        validation_check(arg0);
        assert!(arg3 <= 10000, 781);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0);
        v1.ion_points_enabled = arg2;
        v1.ion_collection_multiplier = arg3;
        let v2 = UpdateIONMultiplierEvent{
            nft_type                  : v0,
            is_ion_points_enabled     : arg2,
            ion_collection_multiplier : arg3,
        };
        0x2::event::emit<UpdateIONMultiplierEvent>(v2);
    }

    public fun update_module_version(arg0: &mut MarketPlaceStore) {
        assert!(arg0.version < 0, 773);
        arg0.version = 0;
    }

    public fun update_permissionless_status(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        arg0.is_permissionless = arg2;
        let v0 = UpdatePermissionlessStatusEvent{is_permissionless: arg2};
        0x2::event::emit<UpdatePermissionlessStatusEvent>(v0);
    }

    fun validate_collection_exists<T0: store + key>(arg0: &MarketPlaceStore) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(*0x2::linked_table::borrow<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
    }

    fun validation_check(arg0: &MarketPlaceStore) {
        assert!(arg0.version == 0, 7684);
    }

    // decompiled from Move bytecode v6
}

