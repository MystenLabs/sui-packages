module 0xcd82233bea9fbe2e4d5041cbc9f455b631fbb83c93e44d29b306c2cc312a8f5::marketplace {
    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct MarketplaceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchpadCap has store, key {
        id: 0x2::object::UID,
    }

    struct TraitBidsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketPlace has key {
        id: 0x2::object::UID,
        redeem_fee_disc_cap: 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::RedeemFeeDiscCap,
        honeyjar_points_cap: 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJarPointsCap,
        marketplace_cap: 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::MarketplaceCap,
        config: ConfigInfo,
        available_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        withdrawable_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        user_activity: 0x2::linked_table::LinkedTable<address, UserInfo>,
        active_collections: 0x2::linked_table::LinkedTable<0x1::ascii::String, bool>,
        kiosk_id: 0x2::object::ID,
        escrow_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        pending_claims: 0x2::linked_table::LinkedTable<address, PendingClaims>,
        simulated_yearly_fee: u128,
        default_alpha: u64,
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
    }

    struct BidPool has store {
        bid_pool_identifier: 0x1::ascii::String,
        ggsui_balance: 0x2::balance::Balance<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>,
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
    }

    struct TypeMarket<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        connected_token: 0x1::option::Option<0x1::ascii::String>,
        price_increment: u64,
        listings: 0x2::linked_table::LinkedTable<0x2::object::ID, Listing<T0>>,
        listings_via_bb: 0x2::linked_table::LinkedTable<0x2::object::ID, BBListing<T0>>,
        bids: 0x2::linked_table::LinkedTable<0x2::object::ID, ActiveBids>,
        collection_bids: 0x2::linked_table::LinkedTable<address, vector<ActiveBid>>,
        are_trait_bids_enabled: bool,
        lifetime_volume: u128,
        points_enabled: bool,
        points_multiplier: u64,
        weight: u64,
        avg_sale_price: u64,
        recent_sale_prices: vector<u64>,
        simulated_yearly_fee: u128,
        avg_time_bw_trades: u64,
        recent_trades_times: vector<u64>,
        alpha: u64,
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
        listed_at: u64,
    }

    struct BBListing<phantom T0: store + key> has store {
        nft_id: 0x2::object::ID,
        price: u64,
        royalty: u64,
        commission: u64,
        listed_at: u64,
        bought_for: u64,
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
    }

    struct UpdateActiveCollectionsEvent has copy, drop {
        collection_mp: address,
        nft_type: 0x1::ascii::String,
        nft_type_str: 0x1::string::String,
        boolean: bool,
    }

    struct DistributeAccumulatedFeeEvent has copy, drop {
        for_ggsui: u64,
        remaining_sui: u64,
    }

    struct UpdateHoneyJarMultiplierEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        are_honeyjar_points_enabled: bool,
        points_multiplier: u64,
    }

    struct UpdatePermissionlessStatusEvent has copy, drop {
        is_permissionless: bool,
    }

    struct ListEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        collection_mp: address,
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

    struct ListViaSweepFloorEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        collection_mp: address,
        nft_id: 0x2::object::ID,
        price: u64,
        commission: u64,
        royalty: u64,
        total_cost: u64,
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
        royalty: u64,
    }

    struct BuyViaSweepFloorEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        seller_kiosk: 0x2::object::ID,
        price: u64,
        commission: u64,
    }

    struct BuyListedViaSweepFloorEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        commission: u64,
    }

    struct UpdateCollectionMetricsEvent has copy, drop {
        collection_mp: address,
        collection_type: 0x1::ascii::String,
        new_protocol_total: u128,
        change: u128,
        increased: bool,
        collection_simulated_yearly_fee: u128,
        collection_weight: u64,
        recent_trades_times: vector<u64>,
        recent_sale_prices: vector<u64>,
    }

    struct UpdateCollectionWeightEvent has copy, drop {
        collection_mp: address,
        collection_type: 0x1::ascii::String,
        collection_weight: u64,
    }

    struct BidPoolDepositedEvent has copy, drop {
        user: address,
        bid_pool_identifier: 0x1::ascii::String,
        staked_sui: u64,
        staked_ggsui: u64,
        new_ggsui_balance: u64,
    }

    struct BidPoolWithdrawnEvent has copy, drop {
        user: address,
        bid_pool_identifier: 0x1::ascii::String,
        ggsui_withdrawn: u64,
        new_ggsui_balance: u64,
        total_bidded: u64,
    }

    struct BidPoolRemovedEvent has copy, drop {
        user: address,
        bid_pool_identifier: 0x1::ascii::String,
    }

    struct BidPoolUpdatedEvent has copy, drop {
        user: address,
        bid_pool_identifier: 0x1::ascii::String,
        new_ggsui_balance: u64,
        total_bidded: u64,
    }

    struct UpdatePriceIncrementEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        price_increment: u64,
    }

    struct UpdateConnectedTokenEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        connected_token: 0x1::ascii::String,
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

    struct UpdateConfigEvent has copy, drop {
        new_commission_pct: u64,
        new_leverage_allowed: u64,
        new_ggsui_share_pct: u64,
    }

    struct CollectionMetricsInfo has store {
        lifetime_volume: u128,
        points_enabled: bool,
        points_multiplier: u64,
        weight: u64,
        avg_sale_price: u64,
        simulated_yearly_fee: u128,
        avg_time_bw_trades: u64,
        recent_sale_prices: vector<u64>,
        recent_trades_times: vector<u64>,
    }

    struct CollectionMarketplaceInfo has drop, store {
        listings_count: u64,
        bids_count: u64,
        collection_bids_count: u64,
        lifetime_volume: u128,
        simulated_yearly_fee: u128,
        points_enabled: bool,
        points_multiplier: u64,
        avg_sale_price: u64,
        recent_sale_prices: vector<u64>,
        avg_time_bw_trades: u64,
        recent_trades_times: vector<u64>,
        weight: u64,
    }

    struct ListingsInfo has drop, store {
        sellers: vector<address>,
        kiosk_ids: vector<0x2::object::ID>,
        nft_ids: vector<0x2::object::ID>,
        prices: vector<u64>,
        commissions: vector<u64>,
        royalties: vector<u64>,
        listed_at: vector<u64>,
        points: vector<u64>,
        count: u64,
    }

    struct UserBidsInfo has drop, store {
        bid_ids: vector<address>,
        bid_prices: vector<u64>,
        commissions: vector<u64>,
        royalties: vector<u64>,
        bid_at: vector<u64>,
        points: vector<u64>,
        count: u64,
    }

    struct BidsInfo has drop, store {
        bidders: vector<address>,
        bid_ids: vector<address>,
        bid_prices: vector<u64>,
        commissions: vector<u64>,
        royalties: vector<u64>,
        bid_at: vector<u64>,
        points: vector<u64>,
        count: u64,
        is_listed: bool,
    }

    public fun list<T0: store + key>(arg0: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::MarketplaceChef, arg1: &mut TypeMarket<T0>, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honey_manager::HoneyManager, arg3: &mut MarketPlace, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg8: 0x2::object::ID, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        validation_check(arg3);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg5);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v3 = 0x2::clock::timestamp_ms(arg10);
        assert!(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::get_owner(arg7) == v0, 790);
        validate_collection_exists<T0>(arg3);
        let (v4, v5) = get_royalty_and_commission<T0>(arg4, arg3.config.commission_pct, arg9);
        adjust_weight<T0>(arg3, arg1);
        let v6 = calc_listing_points(arg9, arg1.points_enabled, arg1.avg_sale_price, arg1.weight, arg1.points_multiplier);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_to_honeyjar(&arg3.honeyjar_points_cap, arg10, arg0, arg2, arg7, v6);
        let v7 = Listing<T0>{
            seller     : v0,
            kiosk_id   : v1,
            nft_id     : arg8,
            cap        : 0x2::kiosk::list_with_purchase_cap<T0>(arg5, arg6, arg8, arg9, arg11),
            price      : arg9,
            royalty    : v4,
            commission : v5,
            points     : v6,
            listed_at  : v3,
        };
        0x2::linked_table::push_back<0x2::object::ID, Listing<T0>>(&mut arg1.listings, arg8, v7);
        let v8 = &mut arg3.user_activity;
        ensure_user_activity_exists(v8, v0, arg11);
        let v9 = ListingInfo{
            nft_type   : v2,
            price      : arg9,
            commission : v5,
            royalty    : v4,
            listed_at  : v3,
            points     : v6,
        };
        0x2::linked_table::push_back<0x2::object::ID, ListingInfo>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg3.user_activity, v0).listings, arg8, v9);
        let v10 = ListEvent{
            nft_type      : v2,
            collection_mp : 0x2::object::uid_to_address(&arg1.id),
            seller        : v0,
            kiosk_id      : v1,
            nft_id        : arg8,
            price         : arg9,
            commission    : v5,
            royalty       : v4,
            total_cost    : arg9 + v5 + v4,
            points        : v6,
            listed_at     : v3,
        };
        0x2::event::emit<ListEvent>(v10);
    }

    public fun accept_bid<T0: store + key>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::clock::Clock, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::MarketplaceChef, arg3: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honey_manager::HoneyManager, arg4: &mut MarketPlace, arg5: &mut TypeMarket<T0>, arg6: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: 0x2::object::ID, arg11: 0x2::object::ID, arg12: address, arg13: bool, arg14: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg15: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg16: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg17: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        validation_check(arg4);
        let v0 = 0x2::tx_context::sender(arg17);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::get_owner(arg15) == arg12, 790);
        assert!(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::get_owner(arg16) == v0, 790);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg4.user_activity, v0), 779);
        0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg4.user_activity, v0).listings, arg10);
        manage_bid_record_for_user(arg4, v1, arg12, false, 0x1::option::some<0x2::object::ID>(arg10), arg13, 0x1::option::none<BidInfo>(), 0x1::option::some<0x2::object::ID>(arg11), arg17);
        let (v2, v3, v4, v5, v6) = manage_bids_for_collection<T0>(arg5, arg12, 0x1::option::some<0x2::object::ID>(arg10), arg13, 0x1::option::none<ActiveBid>(), 0x1::option::some<0x2::object::ID>(arg11), arg17);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&arg5.listings, arg10), 770);
        let v7 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut arg5.listings, arg10);
        let (v8, v9, _, _) = destroy_listing<T0>(v7);
        assert!(v9 == 0x2::object::id<0x2::kiosk::Kiosk>(arg8), 778);
        arg5.lifetime_volume = arg5.lifetime_volume + (v3 as u128);
        let (v12, _, _) = update_collection_metrics<T0>(arg5, arg4.simulated_yearly_fee, v3, arg4.config.commission_pct, 0x2::clock::timestamp_ms(arg1));
        arg4.simulated_yearly_fee = v12;
        0x2::kiosk::return_purchase_cap<T0>(arg8, v8);
        let v15 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg4.user_activity, arg12).bid_pools, v6);
        let v16 = 0x2::balance::zero<0x2::sui::SUI>();
        assert!(0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::get_sui_by_ggsui(arg6, 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v15.ggsui_balance)) >= v3 + v4 + v5, 772);
        0x2::balance::join<0x2::sui::SUI>(&mut v16, 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::request_instant_unstake_disc(&arg4.redeem_fee_disc_cap, arg0, arg6, 0x2::balance::split<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&mut v15.ggsui_balance, 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::get_ggsui_by_sui(arg6, v3 + v4 + v5)), arg17));
        v15.sui_bidded = v15.sui_bidded - v3 + v4 + v5;
        let v17 = BidPoolUpdatedEvent{
            user                : arg12,
            bid_pool_identifier : v6,
            new_ggsui_balance   : 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v15.ggsui_balance),
            total_bidded        : v15.sui_bidded,
        };
        0x2::event::emit<BidPoolUpdatedEvent>(v17);
        0x2::kiosk::list<T0>(arg8, arg9, arg10, v3);
        let (v18, v19) = 0x2::kiosk::purchase<T0>(arg8, arg10, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v16, v3), arg17));
        let v20 = v19;
        if (v5 > 0 && 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg14)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg14, &mut v20, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v16, v5), arg17));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg14)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg14, &mut v20);
        };
        if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg14)) {
            0x2::kiosk::lock<T0>(arg7, &arg4.escrow_kiosk_cap, arg14, v18);
            if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg14)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v20, arg7);
            };
            add_pending_claim(arg4, arg12, arg10, v1, v3, v4, v5, arg17);
        } else {
            0x2::transfer::public_transfer<T0>(v18, arg12);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v16, v4));
        0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::destroy_or_transfer_balance<0x2::sui::SUI>(v16, v0, arg17);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::remove_from_honeyjar(&arg4.honeyjar_points_cap, arg1, arg2, arg3, arg15, v2);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::remove_from_honeyjar(&arg4.honeyjar_points_cap, arg1, arg2, arg3, arg16, v7.points);
        let v21 = calc_trade_points(v4, arg5.points_multiplier);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_trade_points_to_honeyjar(&arg4.honeyjar_points_cap, arg1, arg2, arg3, arg15, v21, arg17);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_trade_points_to_honeyjar(&arg4.honeyjar_points_cap, arg1, arg2, arg3, arg16, v21, arg17);
        let v22 = BidAcceptedEvent{
            nft_type          : v1,
            nft_id            : arg10,
            seller            : v0,
            buyer             : arg12,
            is_collection_bid : arg13,
            price             : v3,
            commission        : v4,
            escrow_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg7),
        };
        0x2::event::emit<BidAcceptedEvent>(v22);
        v20
    }

    public fun accept_unlisted_bid<T0: store + key>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::clock::Clock, arg2: &mut MarketPlace, arg3: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::MarketplaceChef, arg4: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honey_manager::HoneyManager, arg5: &mut TypeMarket<T0>, arg6: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: 0x2::object::ID, arg11: address, arg12: 0x2::object::ID, arg13: bool, arg14: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg15: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg16: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg17: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        validation_check(arg2);
        adjust_weight<T0>(arg2, arg5);
        let v0 = 0x2::tx_context::sender(arg17);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::get_owner(arg15) == arg11, 790);
        assert!(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::get_owner(arg16) == v0, 790);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg8, arg10), 778);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg2.user_activity, arg11), 780);
        manage_bid_record_for_user(arg2, v1, arg11, false, 0x1::option::some<0x2::object::ID>(arg10), arg13, 0x1::option::none<BidInfo>(), 0x1::option::some<0x2::object::ID>(arg12), arg17);
        let (v2, v3, v4, v5, v6) = manage_bids_for_collection<T0>(arg5, arg11, 0x1::option::some<0x2::object::ID>(arg10), arg13, 0x1::option::none<ActiveBid>(), 0x1::option::some<0x2::object::ID>(arg12), arg17);
        arg5.lifetime_volume = arg5.lifetime_volume + (v3 as u128);
        let (v7, _, _) = update_collection_metrics<T0>(arg5, arg2.simulated_yearly_fee, v3, arg2.config.commission_pct, 0x2::clock::timestamp_ms(arg1));
        arg2.simulated_yearly_fee = v7;
        let v10 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg2.user_activity, arg11).bid_pools, v6);
        let v11 = 0x2::balance::zero<0x2::sui::SUI>();
        assert!(0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::get_sui_by_ggsui(arg6, 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v10.ggsui_balance)) >= v3 + v4 + v5, 772);
        0x2::balance::join<0x2::sui::SUI>(&mut v11, 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::request_instant_unstake_disc(&arg2.redeem_fee_disc_cap, arg0, arg6, 0x2::balance::split<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&mut v10.ggsui_balance, 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::get_ggsui_by_sui(arg6, v3 + v4 + v5)), arg17));
        v10.sui_bidded = v10.sui_bidded - v3 + v4 + v5;
        let v12 = BidPoolUpdatedEvent{
            user                : arg11,
            bid_pool_identifier : v6,
            new_ggsui_balance   : 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v10.ggsui_balance),
            total_bidded        : v10.sui_bidded,
        };
        0x2::event::emit<BidPoolUpdatedEvent>(v12);
        0x2::kiosk::list<T0>(arg8, arg9, arg10, v3);
        let (v13, v14) = 0x2::kiosk::purchase<T0>(arg8, arg10, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v11, v3), arg17));
        let v15 = v14;
        if (v5 > 0 && 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg14)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg14, &mut v15, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v11, v5), arg17));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg14)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg14, &mut v15);
        };
        if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg14)) {
            0x2::kiosk::lock<T0>(arg7, &arg2.escrow_kiosk_cap, arg14, v13);
            if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg14)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v15, arg7);
            };
            add_pending_claim(arg2, arg11, arg10, v1, v3, v4, v5, arg17);
        } else {
            0x2::transfer::public_transfer<T0>(v13, arg11);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v11, v4));
        0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::destroy_or_transfer_balance<0x2::sui::SUI>(v11, v0, arg17);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::remove_from_honeyjar(&arg2.honeyjar_points_cap, arg1, arg3, arg4, arg15, v2);
        let v16 = calc_trade_points(v4, arg5.points_multiplier);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_trade_points_to_honeyjar(&arg2.honeyjar_points_cap, arg1, arg3, arg4, arg15, v16, arg17);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_trade_points_to_honeyjar(&arg2.honeyjar_points_cap, arg1, arg3, arg4, arg16, v16, arg17);
        let v17 = BidAcceptedEvent{
            nft_type          : v1,
            nft_id            : arg10,
            seller            : v0,
            buyer             : arg11,
            is_collection_bid : arg13,
            price             : v3,
            commission        : v4,
            escrow_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg7),
        };
        0x2::event::emit<BidAcceptedEvent>(v17);
        v15
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

    public fun add_trait_bidding_support<T0: store + key, T1: store + key>(arg0: &mut MarketPlace, arg1: &mut TypeMarket<T0>, arg2: &TraitBidsAdminCap, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut arg1.id, b"trait_bids", arg3);
        arg1.are_trait_bids_enabled = true;
        let v1 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : true,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v1);
    }

    public fun adjust_weight<T0: store + key>(arg0: &mut MarketPlace, arg1: &mut TypeMarket<T0>) {
        if (arg0.simulated_yearly_fee > 0) {
            arg1.weight = (0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u256((arg1.simulated_yearly_fee as u256), (1000000000 as u256), (arg0.simulated_yearly_fee as u256)) as u64);
        } else {
            arg1.weight = 0;
        };
        if (arg1.weight > 0) {
            let v0 = UpdateCollectionWeightEvent{
                collection_mp     : 0x2::object::uid_to_address(&arg1.id),
                collection_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                collection_weight : arg1.weight,
            };
            0x2::event::emit<UpdateCollectionWeightEvent>(v0);
        };
    }

    public fun buy<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace, arg2: &mut TypeMarket<T0>, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg8: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg9: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::MarketplaceChef, arg10: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honey_manager::HoneyManager, arg11: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, u64) {
        validation_check(arg1);
        adjust_weight<T0>(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::kiosk::owner(arg4);
        assert!(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::get_owner(arg7) == v1, 790);
        assert!(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::get_owner(arg8) == v0, 790);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg1.user_activity, v1), 769);
        let v2 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v1);
        assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v2.listings, arg5), 770);
        0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut v2.listings, arg5);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&arg2.listings, arg5), 777);
        let v3 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut arg2.listings, arg5);
        let v4 = v3.price;
        let v5 = v3.commission;
        let v6 = v3.royalty;
        arg2.lifetime_volume = arg2.lifetime_volume + (v4 as u128);
        let (v7, _, _) = update_collection_metrics<T0>(arg2, arg1.simulated_yearly_fee, v4, arg1.config.commission_pct, 0x2::clock::timestamp_ms(arg0));
        arg1.simulated_yearly_fee = v7;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v4 + v5 + v6, 772);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v10, v5));
        let (v11, v12, v13, v14) = destroy_listing<T0>(v3);
        assert!(v12 == 0x2::object::id<0x2::kiosk::Kiosk>(arg4), 778);
        let (v15, v16) = 0x2::kiosk::purchase_with_cap<T0>(arg4, v11, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v10, v4), arg11));
        let v17 = v16;
        let v18 = v15;
        if (v6 > 0 && 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v17, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v10, v6), arg11));
        };
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::remove_from_honeyjar(&arg1.honeyjar_points_cap, arg0, arg9, arg10, arg7, v3.points);
        let v19 = calc_trade_points(v5, arg2.points_multiplier);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_trade_points_to_honeyjar(&arg1.honeyjar_points_cap, arg0, arg9, arg10, arg8, v19, arg11);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_trade_points_to_honeyjar(&arg1.honeyjar_points_cap, arg0, arg9, arg10, arg7, v19, arg11);
        let v20 = BuyEvent{
            nft_type     : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            nft_id       : 0x2::object::id<T0>(&v18),
            buyer        : v0,
            seller       : v1,
            seller_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            price        : v13,
            commission   : v14,
            royalty      : v6,
        };
        0x2::event::emit<BuyEvent>(v20);
        0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::destroy_or_transfer_balance<0x2::sui::SUI>(v10, v0, arg11);
        (v18, v17, v13 - v14)
    }

    public fun buy_listed_via_sweep_floor<T0: store + key, T1: store + key, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut MarketPlace, arg3: &mut TypeMarket<T0>, arg4: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T1>, arg5: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<0x2::sui::SUI, T1, T2>, arg6: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg7: 0x2::object::ID, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::MarketplaceChef, arg10: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honey_manager::HoneyManager, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x1::ascii::String>(&arg3.connected_token), 795);
        assert!(*0x1::option::borrow<0x1::ascii::String>(&arg3.connected_token) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), 796);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg8);
        assert!(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::get_owner(arg6) == v0, 790);
        assert!(0x2::linked_table::contains<0x2::object::ID, BBListing<T0>>(&arg3.listings_via_bb, arg7), 777);
        let v2 = 0x2::linked_table::remove<0x2::object::ID, BBListing<T0>>(&mut arg3.listings_via_bb, arg7);
        let v3 = v2.price;
        let v4 = v2.commission;
        let v5 = v2.royalty;
        arg3.lifetime_volume = arg3.lifetime_volume + (v3 as u128);
        let (v6, _, _) = update_collection_metrics<T0>(arg3, arg2.simulated_yearly_fee, v3, arg2.config.commission_pct, 0x2::clock::timestamp_ms(arg0));
        arg2.simulated_yearly_fee = v6;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) >= v3 + v4 + v5, 772);
        let v9 = 0x2::balance::split<0x2::sui::SUI>(&mut v1, v3 + v4 + v5);
        0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::destroy_or_transfer_balance<0x2::sui::SUI>(v1, v0, arg11);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v4 + v5));
        destroy_bb_listing<T0>(v2);
        let v10 = 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg3.id, arg7);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_trade_points_to_honeyjar(&arg2.honeyjar_points_cap, arg0, arg9, arg10, arg6, calc_trade_points(v4 + v5, arg3.points_multiplier), arg11);
        let v11 = BuyListedViaSweepFloorEvent{
            nft_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            nft_id     : 0x2::object::id<T0>(&v10),
            buyer      : v0,
            price      : v3,
            commission : v4 + v5,
        };
        0x2::event::emit<BuyListedViaSweepFloorEvent>(v11);
        let (v12, v13) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<0x2::sui::SUI, T1, T2, T3, T4>(arg0, arg1, arg5, v9, 0, 0x2::balance::zero<T1>(), 1, true);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::add_treasury_for_coin<T1>(arg4, v13);
        0x2::transfer::public_transfer<T0>(v10, v0);
    }

    public fun calc_bid_points(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        if (!arg1) {
            return 0
        };
        if (arg5 == 0) {
            return 0
        };
        ((0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u128(((0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u128(((0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u128((0x1::u64::sqrt(arg0) as u128), ((0xcd82233bea9fbe2e4d5041cbc9f455b631fbb83c93e44d29b306c2cc312a8f5::helpers::bid_proximity_multiplier(arg0, arg2) * arg4) as u128), (1000 as u128)) as u64) as u128), ((arg5 - arg6) as u128), (arg5 as u128)) as u64) as u128), (arg3 as u128), (1000000000 as u128)) as u64) as u64)
    }

    public fun calc_listing_points(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (!arg1) {
            return 0
        };
        if (arg3 == 0) {
            return 0
        };
        ((0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u128(((0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u128((0x1::u64::sqrt(arg0) as u128), ((0xcd82233bea9fbe2e4d5041cbc9f455b631fbb83c93e44d29b306c2cc312a8f5::helpers::listing_proximity_multiplier(arg0, arg2) * arg4) as u128), (1000 as u128)) as u64) as u128), (arg3 as u128), (1000000000 as u128)) as u64) as u64)
    }

    public fun calc_trade_points(arg0: u64, arg1: u64) : u64 {
        (0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u128((arg0 as u128), (arg1 as u128), (1000 as u128)) as u64)
    }

    public fun cancel_bid<T0: store + key>(arg0: &mut MarketPlace, arg1: &mut TypeMarket<T0>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x2::object::ID, arg4: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg5: &0x2::clock::Clock, arg6: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::MarketplaceChef, arg7: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honey_manager::HoneyManager, arg8: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        adjust_weight<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = !0x1::option::is_some<0x2::object::ID>(&arg2);
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v1), 774);
        let (v3, v4, v5, v6, v7) = manage_bids_for_collection<T0>(arg1, v0, arg2, v2, 0x1::option::none<ActiveBid>(), 0x1::option::some<0x2::object::ID>(arg3), arg8);
        let v8 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0).bid_pools, v7);
        v8.sui_bidded = v8.sui_bidded - v4 + v5 + v6;
        let v9 = BidPoolUpdatedEvent{
            user                : v0,
            bid_pool_identifier : v7,
            new_ggsui_balance   : 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v8.ggsui_balance),
            total_bidded        : v8.sui_bidded,
        };
        0x2::event::emit<BidPoolUpdatedEvent>(v9);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 769);
        manage_bid_record_for_user(arg0, v1, v0, false, arg2, v2, 0x1::option::none<BidInfo>(), 0x1::option::some<0x2::object::ID>(arg3), arg8);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::remove_from_honeyjar(&arg0.honeyjar_points_cap, arg5, arg6, arg7, arg4, v3);
        let v10 = CancelBidEvent{
            bid_id              : arg3,
            nft_type            : v1,
            bidder              : v0,
            nft_id              : arg2,
            bid_pool_identifier : v7,
            is_collection_bid   : v2,
            cancelled_at        : 0x2::clock::timestamp_ms(arg5),
            points              : v3,
        };
        0x2::event::emit<CancelBidEvent>(v10);
    }

    public fun claim_withdrawable_sui(arg0: &mut MarketPlace, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<0x2::sui::SUI>) {
        validation_check(arg0);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::collect_fee_for_coin<0x2::sui::SUI>(arg1, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.withdrawable_sui));
    }

    public fun connect_token<T0: store + key, T1: store + key>(arg0: &mut TypeMarket<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0x2::coin::TreasuryCap<T1>) {
        arg0.connected_token = 0x1::option::some<0x1::ascii::String>(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        let v0 = UpdateConnectedTokenEvent{
            nft_type        : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            connected_token : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
        };
        0x2::event::emit<UpdateConnectedTokenEvent>(v0);
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

    public fun deposit_ggsui_to_bid_pool(arg0: &mut MarketPlace, arg1: &0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg2: 0x1::ascii::String, arg3: 0x2::coin::Coin<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI> {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = &mut arg0.user_activity;
        ensure_user_activity_exists(v1, v0, arg5);
        let v2 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        if (!0x2::linked_table::contains<0x1::ascii::String, BidPool>(&v2.bid_pools, arg2)) {
            let v3 = BidPool{
                bid_pool_identifier : arg2,
                ggsui_balance       : 0x2::balance::zero<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(),
                sui_bidded          : 0,
            };
            0x2::linked_table::push_back<0x1::ascii::String, BidPool>(&mut v2.bid_pools, arg2, v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v2.bid_pool_identifiers, arg2);
        };
        let v4 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut v2.bid_pools, arg2);
        let v5 = 0x2::coin::into_balance<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(arg3);
        0x2::balance::join<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&mut v4.ggsui_balance, 0x2::balance::split<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&mut v5, arg4));
        let v6 = BidPoolDepositedEvent{
            user                : v0,
            bid_pool_identifier : arg2,
            staked_sui          : 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::get_sui_by_ggsui(arg1, arg4),
            staked_ggsui        : arg4,
            new_ggsui_balance   : 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v4.ggsui_balance),
        };
        0x2::event::emit<BidPoolDepositedEvent>(v6);
        v5
    }

    public fun deposit_sui_to_bid_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg3: 0x1::ascii::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v1 = 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::stake_sui_request(arg0, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg5), 0x1::option::none<address>(), arg6);
        let v2 = 0x2::coin::from_balance<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(v1, arg6);
        entry_deposit_ggsui_to_bid_pool(arg1, arg2, arg3, v2, 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v1), arg6);
        v0
    }

    fun destroy_active_bid(arg0: ActiveBid) {
        let ActiveBid {
            id                  : v0,
            bidder              : _,
            bid_price           : _,
            bid_pool_identifier : _,
            bid_at              : _,
            commission          : _,
            royalty             : _,
            points              : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun destroy_bb_listing<T0: store + key>(arg0: BBListing<T0>) {
        let BBListing {
            nft_id     : _,
            price      : _,
            royalty    : _,
            commission : _,
            listed_at  : _,
            bought_for : _,
        } = arg0;
    }

    fun destroy_bid_pool(arg0: BidPool) {
        let BidPool {
            bid_pool_identifier : _,
            ggsui_balance       : v1,
            sui_bidded          : _,
        } = arg0;
        0x2::balance::destroy_zero<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(v1);
    }

    fun destroy_listing<T0: store + key>(arg0: Listing<T0>) : (0x2::kiosk::PurchaseCap<T0>, 0x2::object::ID, u64, u64) {
        let Listing {
            seller     : _,
            kiosk_id   : v1,
            nft_id     : _,
            cap        : v3,
            price      : v4,
            royalty    : _,
            commission : v6,
            points     : _,
            listed_at  : _,
        } = arg0;
        (v3, v1, v4, v6)
    }

    public fun distribute_accumulated_fee(arg0: &mut MarketPlace, arg1: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault) {
        validation_check(arg0);
        let v0 = arg0.config.ggsui_share_pct * 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui) / 100;
        0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::add_to_staking_rewards(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.available_sui, v0));
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

    public fun entry_deposit_ggsui_to_bid_pool(arg0: &mut MarketPlace, arg1: &0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg2: 0x1::ascii::String, arg3: 0x2::coin::Coin<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_ggsui_to_bid_pool(arg0, arg1, arg2, arg3, arg4, arg5);
        0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::destroy_or_transfer_balance<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg5), arg5);
    }

    public fun entry_deposit_sui_to_bid_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg3: 0x1::ascii::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_sui_to_bid_pool(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun entry_withdraw_ggsui_from_bid_pool(arg0: &mut MarketPlace, arg1: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_ggsui_from_bid_pool(arg0, arg1, arg2, arg3, arg4);
        0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::destroy_or_transfer_balance<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
    }

    public fun entry_withdraw_sui_from_bid_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_sui_from_bid_pool(arg0, arg1, arg2, arg3, arg4, arg5);
        0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
    }

    public fun get_active_bid_info(arg0: &ActiveTraitBid) : (address, u64, u64, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, u64, u64) {
        (arg0.bidder, arg0.bid_price, arg0.bid_at, arg0.trait_key1, arg0.trait_value1, arg0.trait_key2, arg0.trait_value2, arg0.trait_key3, arg0.trait_value3, arg0.commission, arg0.royalty)
    }

    public fun get_bid_pool_info(arg0: &MarketPlace, arg1: address, arg2: 0x1::ascii::String) : (u64, u64) {
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        if (!0x2::linked_table::contains<0x1::ascii::String, BidPool>(&v0.bid_pools, arg2)) {
            return (0, 0)
        };
        let v1 = 0x2::linked_table::borrow<0x1::ascii::String, BidPool>(&v0.bid_pools, arg2);
        (0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v1.ggsui_balance), v1.sui_bidded)
    }

    public fun get_bids_for_any_nft<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: 0x2::object::ID, arg2: 0x1::option::Option<address>, arg3: u64) : BidsInfo {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&arg0.bids, arg1)) {
            return BidsInfo{
                bidders     : v0,
                bid_ids     : v1,
                bid_prices  : v2,
                commissions : v3,
                royalties   : v4,
                bid_at      : v5,
                points      : v6,
                count       : 0,
                is_listed   : 0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&arg0.listings, arg1),
            }
        };
        let v7 = 0x2::linked_table::borrow<0x2::object::ID, ActiveBids>(&arg0.bids, arg1);
        let v8 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, ActiveBid>(&v7.bids)
        };
        let v9 = v8;
        let v10 = 0;
        while (0x1::option::is_some<address>(&v9) && v10 < arg3) {
            let v11 = 0x1::option::borrow<address>(&v9);
            let v12 = 0x2::linked_table::borrow<address, ActiveBid>(&v7.bids, *v11);
            0x1::vector::push_back<address>(&mut v0, *v11);
            0x1::vector::push_back<address>(&mut v1, 0x2::object::uid_to_address(&v12.id));
            0x1::vector::push_back<u64>(&mut v2, v12.bid_price);
            0x1::vector::push_back<u64>(&mut v3, v12.commission);
            0x1::vector::push_back<u64>(&mut v4, v12.royalty);
            0x1::vector::push_back<u64>(&mut v5, v12.bid_at);
            0x1::vector::push_back<u64>(&mut v6, v12.points);
            v9 = *0x2::linked_table::next<address, ActiveBid>(&v7.bids, *v11);
            v10 = v10 + 1;
        };
        BidsInfo{
            bidders     : v0,
            bid_ids     : v1,
            bid_prices  : v2,
            commissions : v3,
            royalties   : v4,
            bid_at      : v5,
            points      : v6,
            count       : 0x2::linked_table::length<address, ActiveBid>(&v7.bids),
            is_listed   : 0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&arg0.listings, arg1),
        }
    }

    public fun get_bids_for_listing<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: 0x2::object::ID, arg2: 0x1::option::Option<address>, arg3: u64) : BidsInfo {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&arg0.bids, arg1)) {
            return BidsInfo{
                bidders     : v0,
                bid_ids     : v1,
                bid_prices  : v2,
                commissions : v3,
                royalties   : v4,
                bid_at      : v5,
                points      : v6,
                count       : 0,
                is_listed   : 0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&arg0.listings, arg1),
            }
        };
        let v7 = 0x2::linked_table::borrow<0x2::object::ID, ActiveBids>(&arg0.bids, arg1);
        let v8 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, ActiveBid>(&v7.bids)
        };
        let v9 = v8;
        let v10 = 0;
        while (0x1::option::is_some<address>(&v9) && v10 < arg3) {
            let v11 = 0x1::option::borrow<address>(&v9);
            let v12 = 0x2::linked_table::borrow<address, ActiveBid>(&v7.bids, *v11);
            0x1::vector::push_back<address>(&mut v0, *v11);
            0x1::vector::push_back<address>(&mut v1, 0x2::object::uid_to_address(&v12.id));
            0x1::vector::push_back<u64>(&mut v2, v12.bid_price);
            0x1::vector::push_back<u64>(&mut v3, v12.commission);
            0x1::vector::push_back<u64>(&mut v4, v12.royalty);
            0x1::vector::push_back<u64>(&mut v5, v12.bid_at);
            0x1::vector::push_back<u64>(&mut v6, v12.points);
            v9 = *0x2::linked_table::next<address, ActiveBid>(&v7.bids, *v11);
            v10 = v10 + 1;
        };
        BidsInfo{
            bidders     : v0,
            bid_ids     : v1,
            bid_prices  : v2,
            commissions : v3,
            royalties   : v4,
            bid_at      : v5,
            points      : v6,
            count       : 0x2::linked_table::length<address, ActiveBid>(&v7.bids),
            is_listed   : 0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&arg0.listings, arg1),
        }
    }

    public fun get_collection_bidders_for_collection<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, vector<ActiveBid>>(&arg0.collection_bids)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, *v5);
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::length<ActiveBid>(0x2::linked_table::borrow<address, vector<ActiveBid>>(&arg0.collection_bids, *v5)));
            v3 = *0x2::linked_table::next<address, vector<ActiveBid>>(&arg0.collection_bids, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<address, vector<ActiveBid>>(&arg0.collection_bids))
    }

    public fun get_collection_bids_by_user_for_collection<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: address, arg2: u64, arg3: u64) : UserBidsInfo {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, vector<ActiveBid>>(&arg0.collection_bids, arg1)) {
            return UserBidsInfo{
                bid_ids     : v0,
                bid_prices  : v1,
                commissions : v2,
                royalties   : v3,
                bid_at      : v4,
                points      : v5,
                count       : 0,
            }
        };
        let v6 = 0x2::linked_table::borrow<address, vector<ActiveBid>>(&arg0.collection_bids, arg1);
        while (arg2 < 0x1::vector::length<ActiveBid>(v6) && arg2 < arg3) {
            let v7 = 0x1::vector::borrow<ActiveBid>(v6, arg2);
            0x1::vector::push_back<address>(&mut v0, 0x2::object::uid_to_address(&v7.id));
            0x1::vector::push_back<u64>(&mut v1, v7.bid_price);
            0x1::vector::push_back<u64>(&mut v2, v7.commission);
            0x1::vector::push_back<u64>(&mut v3, v7.royalty);
            0x1::vector::push_back<u64>(&mut v4, v7.bid_at);
            0x1::vector::push_back<u64>(&mut v5, v7.points);
            arg2 = arg2 + 1;
        };
        UserBidsInfo{
            bid_ids     : v0,
            bid_prices  : v1,
            commissions : v2,
            royalties   : v3,
            bid_at      : v4,
            points      : v5,
            count       : 0x1::vector::length<ActiveBid>(v6),
        }
    }

    public fun get_collection_fee(arg0: &MarketPlace) : u64 {
        arg0.config.new_collection_fee
    }

    public fun get_collection_marketplace_info<T0: store + key>(arg0: &mut TypeMarket<T0>) : CollectionMarketplaceInfo {
        CollectionMarketplaceInfo{
            listings_count        : 0x2::linked_table::length<0x2::object::ID, Listing<T0>>(&arg0.listings),
            bids_count            : 0x2::linked_table::length<0x2::object::ID, ActiveBids>(&arg0.bids),
            collection_bids_count : 0x2::linked_table::length<address, vector<ActiveBid>>(&arg0.collection_bids),
            lifetime_volume       : arg0.lifetime_volume,
            simulated_yearly_fee  : arg0.simulated_yearly_fee,
            points_enabled        : arg0.points_enabled,
            points_multiplier     : arg0.points_multiplier,
            avg_sale_price        : arg0.avg_sale_price,
            recent_sale_prices    : arg0.recent_sale_prices,
            avg_time_bw_trades    : arg0.avg_time_bw_trades,
            recent_trades_times   : arg0.recent_trades_times,
            weight                : arg0.weight,
        }
    }

    public fun get_collection_metrics<T0: store + key>(arg0: &TypeMarket<T0>) : (u128, bool, u64, u64, u64, u128, u64, vector<u64>, vector<u64>) {
        (arg0.lifetime_volume, arg0.points_enabled, arg0.points_multiplier, arg0.weight, arg0.avg_sale_price, arg0.simulated_yearly_fee, arg0.avg_time_bw_trades, arg0.recent_sale_prices, arg0.recent_trades_times)
    }

    public fun get_collection_metrics_info<T0: store + key>(arg0: &TypeMarket<T0>) : CollectionMetricsInfo {
        CollectionMetricsInfo{
            lifetime_volume      : arg0.lifetime_volume,
            points_enabled       : arg0.points_enabled,
            points_multiplier    : arg0.points_multiplier,
            weight               : arg0.weight,
            avg_sale_price       : arg0.avg_sale_price,
            simulated_yearly_fee : arg0.simulated_yearly_fee,
            avg_time_bw_trades   : arg0.avg_time_bw_trades,
            recent_sale_prices   : arg0.recent_sale_prices,
            recent_trades_times  : arg0.recent_trades_times,
        }
    }

    public fun get_listings_for_marketplace<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) : ListingsInfo {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x2::object::ID, Listing<T0>>(&arg0.listings)
        };
        let v9 = v8;
        let v10 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v9) && v10 < arg2) {
            let v11 = 0x1::option::borrow<0x2::object::ID>(&v9);
            let v12 = 0x2::linked_table::borrow<0x2::object::ID, Listing<T0>>(&arg0.listings, *v11);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, *v11);
            0x1::vector::push_back<address>(&mut v0, v12.seller);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, v12.kiosk_id);
            0x1::vector::push_back<u64>(&mut v3, v12.price);
            0x1::vector::push_back<u64>(&mut v4, v12.commission);
            0x1::vector::push_back<u64>(&mut v5, v12.royalty);
            0x1::vector::push_back<u64>(&mut v6, v12.points);
            0x1::vector::push_back<u64>(&mut v7, v12.listed_at);
            v9 = *0x2::linked_table::next<0x2::object::ID, Listing<T0>>(&arg0.listings, *v11);
            v10 = v10 + 1;
        };
        ListingsInfo{
            sellers     : v0,
            kiosk_ids   : v1,
            nft_ids     : v2,
            prices      : v3,
            commissions : v4,
            royalties   : v5,
            listed_at   : v7,
            points      : v6,
            count       : 0x2::linked_table::length<0x2::object::ID, Listing<T0>>(&arg0.listings),
        }
    }

    public fun get_marketplace_info(arg0: &MarketPlace) : (address, bool, u64, u64, u64, u64, u64, 0x2::object::ID, u64, u128) {
        (0x2::object::uid_to_address(&arg0.id), arg0.config.is_permissionless, arg0.config.new_collection_fee, arg0.config.commission_pct, 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui), 0x2::linked_table::length<address, UserInfo>(&arg0.user_activity), 0x2::linked_table::length<0x1::ascii::String, bool>(&arg0.active_collections), arg0.kiosk_id, arg0.version, arg0.simulated_yearly_fee)
    }

    fun get_royalty_and_commission<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, arg2)
        } else {
            0
        };
        (v0, arg2 * arg1 / 100)
    }

    public fun get_user_activity_overview(arg0: &MarketPlace, arg1: address) : (u64, u64, u64, u64, u64) {
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            (0, 0, 0, 0, 0)
        } else {
            let v5 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
            (0x2::linked_table::length<0x2::object::ID, ListingInfo>(&v5.listings), 0x2::linked_table::length<0x2::object::ID, BidInfo>(&v5.bids), 0x2::linked_table::length<0x1::ascii::String, vector<BidInfo>>(&v5.collection_bids), 0x2::linked_table::length<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids), v5.claimable_points)
        }
    }

    public fun get_user_addresses_list(arg0: &MarketPlace, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, u64) {
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

    public fun get_user_bid_pools(arg0: &MarketPlace, arg1: address, arg2: u64, arg3: u64) : (vector<0x1::ascii::String>, vector<u64>, vector<u64>, u64) {
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (0x1::vector::empty<0x1::ascii::String>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0)
        };
        let v0 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v1 = 0x1::vector::length<0x1::ascii::String>(&v0.bid_pool_identifiers);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        while (arg2 < v1 && 0x1::vector::length<0x1::ascii::String>(&v2) < arg3) {
            let v5 = *0x1::vector::borrow<0x1::ascii::String>(&v0.bid_pool_identifiers, arg2);
            let v6 = 0x2::linked_table::borrow<0x1::ascii::String, BidPool>(&v0.bid_pools, v5);
            0x1::vector::push_back<0x1::ascii::String>(&mut v2, v5);
            0x1::vector::push_back<u64>(&mut v3, 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v6.ggsui_balance));
            0x1::vector::push_back<u64>(&mut v4, v6.sui_bidded);
            arg2 = arg2 + 1;
        };
        (v2, v3, v4, v1)
    }

    public fun get_user_bids_info(arg0: &MarketPlace, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, v4, v5, v6, 0)
        };
        let v7 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v8 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, BidInfo>(&v7.bids)
        };
        let v9 = v8;
        let v10 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v9) && v10 < arg3) {
            let v11 = 0x1::option::borrow<0x2::object::ID>(&v9);
            let v12 = 0x2::linked_table::borrow<0x2::object::ID, BidInfo>(&v7.bids, *v11);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v11);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v12.nft_type);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v12.bid_id);
            0x1::vector::push_back<u64>(&mut v3, v12.bid_price);
            0x1::vector::push_back<u64>(&mut v4, v12.commission);
            0x1::vector::push_back<u64>(&mut v5, v12.royalty);
            0x1::vector::push_back<u64>(&mut v6, v12.bid_at);
            v9 = *0x2::linked_table::next<0x2::object::ID, BidInfo>(&v7.bids, *v11);
            v10 = v10 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<0x2::object::ID, BidInfo>(&v7.bids))
    }

    public fun get_user_collection_bids_for_type(arg0: &MarketPlace, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) : (vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, v4, 0)
        };
        let v5 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        if (!0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v5.collection_bids, arg2)) {
            return (v0, v1, v2, v3, v4, 0)
        };
        let v6 = 0x2::linked_table::borrow<0x1::ascii::String, vector<BidInfo>>(&v5.collection_bids, arg2);
        let v7 = 0x1::vector::length<BidInfo>(v6);
        while (arg3 < v7 && arg3 < arg4) {
            let v8 = 0x1::vector::borrow<BidInfo>(v6, arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v8.bid_id);
            0x1::vector::push_back<u64>(&mut v1, v8.bid_price);
            0x1::vector::push_back<u64>(&mut v2, v8.commission);
            0x1::vector::push_back<u64>(&mut v3, v8.royalty);
            0x1::vector::push_back<u64>(&mut v4, v8.bid_at);
            arg3 = arg3 + 1;
        };
        (v0, v1, v2, v3, v4, v7)
    }

    public fun get_user_collection_bids_info(arg0: &MarketPlace, arg1: address, arg2: 0x1::option::Option<0x1::ascii::String>, arg3: u64) : (vector<0x1::ascii::String>, vector<u64>, u64) {
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

    public fun get_user_listings_info(arg0: &MarketPlace, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
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
            *0x2::linked_table::front<0x2::object::ID, ListingInfo>(&v6.listings)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v8) && v9 < arg3) {
            let v10 = 0x1::option::borrow<0x2::object::ID>(&v8);
            let v11 = 0x2::linked_table::borrow<0x2::object::ID, ListingInfo>(&v6.listings, *v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v10);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v11.nft_type);
            0x1::vector::push_back<u64>(&mut v2, v11.price);
            0x1::vector::push_back<u64>(&mut v3, v11.commission);
            0x1::vector::push_back<u64>(&mut v4, v11.royalty);
            0x1::vector::push_back<u64>(&mut v5, v11.listed_at);
            v8 = *0x2::linked_table::next<0x2::object::ID, ListingInfo>(&v6.listings, *v10);
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, 0x2::linked_table::length<0x2::object::ID, ListingInfo>(&v6.listings))
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

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MARKETPLACE>(arg0, arg1);
        let v1 = 0x2::display::new<MarketPlace>(&v0, arg1);
        0x2::display::add<MarketPlace>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"HoneyPlay Marketplace"));
        0x2::display::add<MarketPlace>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"High-performance NFT marketplace on Sui. Kiosk-native trading with volume-based HONEY rewards and programmable royalties."));
        0x2::display::add<MarketPlace>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://assets.honeyplay.fun/global_objects/marketplace.png"));
        0x2::display::add<MarketPlace>(&mut v1, 0x1::string::utf8(b"project"), 0x1::string::utf8(b"https://honeyplay.fun"));
        0x2::display::add<MarketPlace>(&mut v1, 0x1::string::utf8(b"Available SUI"), 0x1::string::utf8(b"{available_sui}"));
        0x2::display::add<MarketPlace>(&mut v1, 0x1::string::utf8(b"Withdrawable SUI"), 0x1::string::utf8(b"{withdrawable_sui}"));
        0x2::display::add<MarketPlace>(&mut v1, 0x1::string::utf8(b"Simulated yearly fee"), 0x1::string::utf8(b"{simulated_yearly_fee}"));
        0x2::display::update_version<MarketPlace>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<MarketPlace>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = MarketplaceAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MarketplaceAdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = LaunchpadCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<LaunchpadCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = TraitBidsAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TraitBidsAdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun init_marketplace(arg0: &MarketplaceAdminCap, arg1: 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::MarketplaceCap, arg2: 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJarPointsCap, arg3: 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::RedeemFeeDiscCap, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg4);
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
            id                   : 0x2::object::new(arg4),
            redeem_fee_disc_cap  : arg3,
            honeyjar_points_cap  : arg2,
            marketplace_cap      : arg1,
            config               : v3,
            available_sui        : 0x2::balance::zero<0x2::sui::SUI>(),
            withdrawable_sui     : 0x2::balance::zero<0x2::sui::SUI>(),
            user_activity        : 0x2::linked_table::new<address, UserInfo>(arg4),
            active_collections   : 0x2::linked_table::new<0x1::ascii::String, bool>(arg4),
            kiosk_id             : 0x2::kiosk::kiosk_owner_cap_for(&v2),
            escrow_kiosk_cap     : v2,
            pending_claims       : 0x2::linked_table::new<address, PendingClaims>(arg4),
            simulated_yearly_fee : 0,
            default_alpha        : 500,
            bag                  : 0x2::bag::new(arg4),
            version              : 0,
        };
        0x2::transfer::share_object<MarketPlace>(v4);
    }

    public fun is_permissionless(arg0: &MarketPlace) : bool {
        arg0.config.is_permissionless
    }

    public fun launchpad_add_collection<T0: store + key>(arg0: &mut MarketPlace, arg1: &LaunchpadCap, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        assert!(arg3 <= 10000, 781);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::string::from_ascii(v0);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
        let v2 = TypeMarket<T0>{
            id                     : 0x2::derived_object::claim<0x1::string::String>(&mut arg0.id, v1),
            connected_token        : 0x1::option::none<0x1::ascii::String>(),
            price_increment        : 0,
            listings               : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg4),
            listings_via_bb        : 0x2::linked_table::new<0x2::object::ID, BBListing<T0>>(arg4),
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
            alpha                  : arg0.default_alpha,
        };
        let v3 = UpdateActiveCollectionsEvent{
            collection_mp : 0x2::object::uid_to_address(&v2.id),
            nft_type      : v0,
            nft_type_str  : v1,
            boolean       : true,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v3);
        0x2::transfer::share_object<TypeMarket<T0>>(v2);
        let v4 = UpdateHoneyJarMultiplierEvent{
            nft_type                    : v0,
            are_honeyjar_points_enabled : arg2,
            points_multiplier           : arg3,
        };
        0x2::event::emit<UpdateHoneyJarMultiplierEvent>(v4);
    }

    public fun make_bid<T0: store + key>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut TypeMarket<T0>, arg3: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::MarketplaceChef, arg4: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honey_manager::HoneyManager, arg5: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg6: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg7: 0x1::option::Option<0x2::object::ID>, arg8: u64, arg9: 0x1::ascii::String, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &0x2::transfer_policy::TransferPolicy<T0>, arg14: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        adjust_weight<T0>(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = !0x1::option::is_some<0x2::object::ID>(&arg7);
        let v3 = 0x2::clock::timestamp_ms(arg12);
        validate_collection_exists<T0>(arg1);
        let (v4, v5) = get_royalty_and_commission<T0>(arg13, arg1.config.commission_pct, arg8);
        let v6 = &mut arg1.user_activity;
        ensure_user_activity_exists(v6, v0, arg14);
        entry_deposit_sui_to_bid_pool(arg0, arg1, arg6, arg9, arg10, arg11, arg14);
        let v7 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v0);
        if (!0x2::linked_table::contains<0x1::ascii::String, BidPool>(&v7.bid_pools, arg9)) {
            let v8 = BidPool{
                bid_pool_identifier : arg9,
                ggsui_balance       : 0x2::balance::zero<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(),
                sui_bidded          : 0,
            };
            0x2::linked_table::push_back<0x1::ascii::String, BidPool>(&mut v7.bid_pools, arg9, v8);
            0x1::vector::push_back<0x1::ascii::String>(&mut v7.bid_pool_identifiers, arg9);
        };
        let v9 = arg8 + v5 + v4;
        let v10 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut v7.bid_pools, arg9);
        let v11 = 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::get_sui_by_ggsui(arg6, 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v10.ggsui_balance));
        let v12 = arg1.config.max_leverage_allowed * v11;
        v10.sui_bidded = v10.sui_bidded + v9;
        assert!(v10.sui_bidded <= (v12 as u64), 792);
        let v13 = BidPoolUpdatedEvent{
            user                : v0,
            bid_pool_identifier : arg9,
            new_ggsui_balance   : 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v10.ggsui_balance),
            total_bidded        : v10.sui_bidded,
        };
        0x2::event::emit<BidPoolUpdatedEvent>(v13);
        let v14 = if (v10.sui_bidded > v11) {
            v10.sui_bidded - v11
        } else {
            0
        };
        let v15 = calc_bid_points(arg8, arg2.points_enabled, arg2.avg_sale_price, arg2.weight, arg2.points_multiplier, v12 - v11, v14);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_to_honeyjar(&arg1.honeyjar_points_cap, arg12, arg3, arg4, arg5, v15);
        let v16 = ActiveBid{
            id                  : 0x2::object::new(arg14),
            bidder              : v0,
            bid_price           : arg8,
            bid_pool_identifier : arg9,
            bid_at              : v3,
            commission          : v5,
            royalty             : v4,
            points              : v15,
        };
        let v17 = 0x2::object::id<ActiveBid>(&v16);
        let (_, _, _, _, _) = manage_bids_for_collection<T0>(arg2, v0, arg7, v2, 0x1::option::some<ActiveBid>(v16), 0x1::option::none<0x2::object::ID>(), arg14);
        let v23 = BidInfo{
            bid_id              : v17,
            nft_type            : v1,
            bid_pool_identifier : arg9,
            bid_price           : arg8,
            commission          : v5,
            royalty             : v4,
            is_collection_bid   : v2,
            bid_at              : v3,
            points              : v15,
        };
        manage_bid_record_for_user(arg1, v1, v0, true, arg7, v2, 0x1::option::some<BidInfo>(v23), 0x1::option::none<0x2::object::ID>(), arg14);
        let v24 = MakeBidEvent{
            bid_id              : v17,
            nft_type            : v1,
            buyer               : v0,
            nft_id              : arg7,
            bid_pool_identifier : arg9,
            price               : arg8,
            commission          : v5,
            royalty             : v4,
            total_cost          : v9,
            is_collection_bid   : v2,
            bid_at              : v3,
            points              : v15,
        };
        0x2::event::emit<MakeBidEvent>(v24);
    }

    fun manage_bid_record_for_user(arg0: &mut MarketPlace, arg1: 0x1::ascii::String, arg2: address, arg3: bool, arg4: 0x1::option::Option<0x2::object::ID>, arg5: bool, arg6: 0x1::option::Option<BidInfo>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, arg2);
        let v1 = 0;
        if (arg3) {
            if (arg5) {
                if (0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v0.collection_bids, arg1)) {
                    0x1::vector::push_back<BidInfo>(0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v0.collection_bids, arg1), 0x1::option::destroy_some<BidInfo>(arg6));
                } else {
                    let v2 = 0x1::vector::empty<BidInfo>();
                    0x1::vector::push_back<BidInfo>(&mut v2, 0x1::option::destroy_some<BidInfo>(arg6));
                    0x2::linked_table::push_back<0x1::ascii::String, vector<BidInfo>>(&mut v0.collection_bids, arg1, v2);
                };
            } else {
                let v3 = *0x1::option::borrow<0x2::object::ID>(&arg4);
                assert!(!0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v0.bids, v3), 775);
                0x2::linked_table::push_back<0x2::object::ID, BidInfo>(&mut v0.bids, v3, 0x1::option::destroy_some<BidInfo>(arg6));
            };
        } else {
            0x1::option::destroy_none<BidInfo>(arg6);
            if (arg5) {
                assert!(0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v0.collection_bids, arg1), 776);
                let v4 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v0.collection_bids, arg1);
                let v5 = 0;
                while (v5 < 0x1::vector::length<BidInfo>(v4)) {
                    if (0x1::vector::borrow<BidInfo>(v4, v5).bid_id == *0x1::option::borrow<0x2::object::ID>(&arg7)) {
                        let v6 = 0x1::vector::remove<BidInfo>(v4, v5);
                        v1 = v6.bid_price;
                        break
                    };
                    v5 = v5 + 1;
                };
                if (0x1::vector::length<BidInfo>(v4) == 0) {
                    0x2::linked_table::remove<0x1::ascii::String, vector<BidInfo>>(&mut v0.collection_bids, arg1);
                };
            } else {
                let v7 = *0x1::option::borrow<0x2::object::ID>(&arg4);
                assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v0.bids, v7), 776);
                let v8 = 0x2::linked_table::remove<0x2::object::ID, BidInfo>(&mut v0.bids, v7);
                v1 = v8.bid_price;
            };
        };
        v1
    }

    fun manage_bids_for_collection<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: bool, arg4: 0x1::option::Option<ActiveBid>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, 0x1::ascii::String) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::ascii::string(b"");
        if (0x1::option::is_some<ActiveBid>(&arg4)) {
            if (!arg3) {
                let v5 = *0x1::option::borrow<0x2::object::ID>(&arg2);
                if (0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&arg0.bids, v5)) {
                    let v6 = 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut arg0.bids, v5);
                    assert!(!0x2::linked_table::contains<address, ActiveBid>(&v6.bids, arg1), 775);
                    0x2::linked_table::push_back<address, ActiveBid>(&mut v6.bids, arg1, 0x1::option::destroy_some<ActiveBid>(arg4));
                } else {
                    let v7 = ActiveBids{
                        id   : 0x2::object::new(arg6),
                        bids : 0x2::linked_table::new<address, ActiveBid>(arg6),
                    };
                    0x2::linked_table::push_back<address, ActiveBid>(&mut v7.bids, arg1, 0x1::option::destroy_some<ActiveBid>(arg4));
                    0x2::linked_table::push_back<0x2::object::ID, ActiveBids>(&mut arg0.bids, v5, v7);
                };
            } else if (0x2::linked_table::contains<address, vector<ActiveBid>>(&arg0.collection_bids, arg1)) {
                0x1::vector::push_back<ActiveBid>(0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut arg0.collection_bids, arg1), 0x1::option::destroy_some<ActiveBid>(arg4));
            } else {
                let v8 = 0x1::vector::empty<ActiveBid>();
                0x1::vector::push_back<ActiveBid>(&mut v8, 0x1::option::destroy_some<ActiveBid>(arg4));
                0x2::linked_table::push_back<address, vector<ActiveBid>>(&mut arg0.collection_bids, arg1, v8);
            };
        } else {
            0x1::option::destroy_none<ActiveBid>(arg4);
            if (!arg3) {
                let v9 = *0x1::option::borrow<0x2::object::ID>(&arg2);
                assert!(0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&arg0.bids, v9), 776);
                let v10 = 0x2::linked_table::remove<address, ActiveBid>(&mut 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut arg0.bids, v9).bids, arg1);
                v2 = v10.bid_price;
                v1 = v10.commission;
                v0 = v10.royalty;
                v4 = v10.bid_pool_identifier;
                v3 = v10.points;
                destroy_active_bid(v10);
            } else {
                assert!(0x2::linked_table::contains<address, vector<ActiveBid>>(&arg0.collection_bids, arg1), 776);
                let v11 = 0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut arg0.collection_bids, arg1);
                let v12 = 0;
                while (v12 < 0x1::vector::length<ActiveBid>(v11)) {
                    if (0x2::object::uid_to_inner(&0x1::vector::borrow<ActiveBid>(v11, v12).id) == *0x1::option::borrow<0x2::object::ID>(&arg5)) {
                        let v13 = 0x1::vector::remove<ActiveBid>(v11, v12);
                        v2 = v13.bid_price;
                        v1 = v13.commission;
                        v0 = v13.royalty;
                        v4 = v13.bid_pool_identifier;
                        v3 = v13.points;
                        destroy_active_bid(v13);
                        break
                    };
                    v12 = v12 + 1;
                };
                if (0x1::vector::length<ActiveBid>(v11) == 0) {
                    0x1::vector::destroy_empty<ActiveBid>(0x2::linked_table::remove<address, vector<ActiveBid>>(&mut arg0.collection_bids, arg1));
                };
            };
        };
        (v3, v2, v1, v0, v4)
    }

    public fun permissionless_add_collection<T0: store + key>(arg0: &mut MarketPlace, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        assert!(arg0.config.is_permissionless, 774);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::string::from_ascii(v0);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.config.new_collection_fee, 772);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v2, arg0.config.new_collection_fee));
        0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::destroy_or_transfer_balance<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg2), arg2);
        0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
        let v3 = TypeMarket<T0>{
            id                     : 0x2::derived_object::claim<0x1::string::String>(&mut arg0.id, v1),
            connected_token        : 0x1::option::none<0x1::ascii::String>(),
            price_increment        : 0,
            listings               : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg2),
            listings_via_bb        : 0x2::linked_table::new<0x2::object::ID, BBListing<T0>>(arg2),
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
            alpha                  : arg0.default_alpha,
        };
        let v4 = UpdateActiveCollectionsEvent{
            collection_mp : 0x2::object::uid_to_address(&v3.id),
            nft_type      : v0,
            nft_type_str  : v1,
            boolean       : true,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v4);
        0x2::transfer::share_object<TypeMarket<T0>>(v3);
    }

    public fun process_pending_claim<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        validation_check(arg1);
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg5) == 0x2::object::id<0x2::kiosk::Kiosk>(arg4), 778);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::linked_table::contains<address, PendingClaims>(&arg1.pending_claims, v0), 786);
        let v1 = 0x2::linked_table::borrow_mut<address, PendingClaims>(&mut arg1.pending_claims, v0);
        assert!(0x2::linked_table::contains<0x2::object::ID, PendingClaim>(&v1.pending_claims, arg6), 787);
        let v2 = 0x2::linked_table::remove<0x2::object::ID, PendingClaim>(&mut v1.pending_claims, arg6);
        assert!(v2.buyer == v0, 784);
        let PendingClaim {
            buyer      : _,
            nft_type   : v4,
            price      : _,
            commission : _,
            royalty    : _,
        } = v2;
        0x2::kiosk::list<T0>(arg2, &arg1.escrow_kiosk_cap, arg6, 0);
        let (v8, v9) = 0x2::kiosk::purchase<T0>(arg2, arg6, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg7));
        let v10 = v9;
        0x2::kiosk::lock<T0>(arg4, arg5, arg3, v8);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v10, arg4);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v10, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg7));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg3, &mut v10);
        };
        let v11 = NFTClaimedEvent{
            nft_type    : v4,
            nft_id      : arg6,
            buyer       : v0,
            buyer_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            claimed_at  : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<NFTClaimedEvent>(v11);
        v10
    }

    public fun remove_trait_bidding_support<T0: store + key, T1: store + key>(arg0: &mut TypeMarket<T0>, arg1: &TraitBidsAdminCap, arg2: &mut 0x2::tx_context::TxContext) : T1 {
        arg0.are_trait_bids_enabled = false;
        let v0 = UpdateTraitBiddingSupportEvent{
            nft_type               : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            are_trait_bids_enabled : false,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v0);
        0x2::dynamic_object_field::remove<vector<u8>, T1>(&mut arg0.id, b"trait_bids")
    }

    public fun sweep_floor_using_token_treasury_balance<T0: store + key, T1: store + key, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut MarketPlace, arg3: &mut TypeMarket<T0>, arg4: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T1>, arg5: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<0x2::sui::SUI, T1, T2>, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::kiosk::Kiosk, arg8: 0x2::object::ID, arg9: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg10: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::MarketplaceChef, arg11: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honey_manager::HoneyManager, arg12: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x1::option::is_some<0x1::ascii::String>(&arg3.connected_token), 795);
        assert!(*0x1::option::borrow<0x1::ascii::String>(&arg3.connected_token) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), 796);
        let (v0, v1) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<0x2::sui::SUI, T1, T2, T3, T4>(arg0, arg1, arg5, 0x2::balance::zero<0x2::sui::SUI>(), 1, 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::claim_treasury_balance<T1>(&arg2.marketplace_cap, arg4), 0, true);
        let v2 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::kiosk::owner(arg7);
        assert!(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::get_owner(arg9) == v3, 790);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg2.user_activity, v3), 769);
        let v4 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg2.user_activity, v3);
        assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v4.listings, arg8), 770);
        0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut v4.listings, arg8);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&arg3.listings, arg8), 777);
        let v5 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut arg3.listings, arg8);
        let v6 = v5.price;
        let v7 = v5.commission;
        let v8 = v5.royalty;
        assert!(v6 < arg3.avg_sale_price, 794);
        arg3.lifetime_volume = arg3.lifetime_volume + (v6 as u128);
        let (v9, _, _) = update_collection_metrics<T0>(arg3, arg2.simulated_yearly_fee, v6, arg2.config.commission_pct, 0x2::clock::timestamp_ms(arg0));
        arg2.simulated_yearly_fee = v9;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v2) >= v6 + v7 + v8, 772);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v7));
        let (v12, v13, v14, v15) = destroy_listing<T0>(v5);
        assert!(v13 == 0x2::object::id<0x2::kiosk::Kiosk>(arg7), 778);
        let (v16, v17) = 0x2::kiosk::purchase_with_cap<T0>(arg7, v12, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v6), arg12));
        let v18 = v17;
        let v19 = v16;
        if (v8 > 0 && 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg6)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v18, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v8), arg12));
        };
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::remove_from_honeyjar(&arg2.honeyjar_points_cap, arg0, arg10, arg11, arg9, v5.points);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::add_trade_points_to_honeyjar(&arg2.honeyjar_points_cap, arg0, arg10, arg11, arg9, calc_trade_points(v7, arg3.points_multiplier), arg12);
        let v20 = BuyViaSweepFloorEvent{
            nft_type     : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            nft_id       : 0x2::object::id<T0>(&v19),
            seller       : v3,
            seller_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg7),
            price        : v14,
            commission   : v15,
        };
        0x2::event::emit<BuyViaSweepFloorEvent>(v20);
        let v21 = v6 + v6 * arg3.price_increment / 100;
        let v22 = 0x2::clock::timestamp_ms(arg0);
        let (v23, v24) = get_royalty_and_commission<T0>(arg6, arg2.config.commission_pct, v21);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg3.id, arg8, v19);
        let v25 = BBListing<T0>{
            nft_id     : arg8,
            price      : v21,
            royalty    : v23,
            commission : v24,
            listed_at  : v22,
            bought_for : v6,
        };
        0x2::linked_table::push_back<0x2::object::ID, BBListing<T0>>(&mut arg3.listings_via_bb, arg8, v25);
        let v26 = ListViaSweepFloorEvent{
            nft_type      : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            collection_mp : 0x2::object::uid_to_address(&arg3.id),
            nft_id        : arg8,
            price         : v21,
            commission    : v24,
            royalty       : v23,
            total_cost    : v21 + v24 + v23,
            listed_at     : v22,
        };
        0x2::event::emit<ListViaSweepFloorEvent>(v26);
        let (v27, v28) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<0x2::sui::SUI, T1, T2, T3, T4>(arg0, arg1, arg5, v2, 0, 0x2::balance::zero<T1>(), 1, true);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v27);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::add_treasury_for_coin<T1>(arg4, v28);
        v18
    }

    public fun switch_trait_bidding_support<T0: store + key>(arg0: &mut MarketPlace, arg1: &mut TypeMarket<T0>, arg2: &TraitBidsAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        arg1.are_trait_bids_enabled = !arg1.are_trait_bids_enabled;
        let v1 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : arg1.are_trait_bids_enabled,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v1);
    }

    public fun unlist<T0: store + key>(arg0: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::MarketplaceChef, arg1: &mut MarketPlace, arg2: &mut TypeMarket<T0>, arg3: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honey_manager::HoneyManager, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg8);
        adjust_weight<T0>(arg1, arg2);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg1.user_activity, v0), 769);
        let v1 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg1.user_activity, v0);
        assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v1.listings, arg5), 770);
        0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut v1.listings, arg5);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&arg2.listings, arg5), 770);
        let v2 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut arg2.listings, arg5);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::remove_from_honeyjar(&arg1.honeyjar_points_cap, arg7, arg0, arg3, arg6, v2.points);
        let v3 = UnlistEvent{
            nft_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            seller      : v0,
            nft_id      : arg5,
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            price       : v2.price,
            unlisted_at : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<UnlistEvent>(v3);
        let (v4, _, _, _) = destroy_listing<T0>(v2);
        0x2::kiosk::return_purchase_cap<T0>(arg4, v4);
    }

    public fun update_active_collections<T0: store + key>(arg0: &mut MarketPlace, arg1: &MarketplaceAdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::string::from_ascii(v0);
        if (arg2) {
            if (!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0)) {
                0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
            } else {
                *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.active_collections, v0) = true;
            };
            if (!0x2::derived_object::exists<0x1::ascii::String>(&arg0.id, v0)) {
                let v2 = TypeMarket<T0>{
                    id                     : 0x2::derived_object::claim<0x1::string::String>(&mut arg0.id, v1),
                    connected_token        : 0x1::option::none<0x1::ascii::String>(),
                    price_increment        : 0,
                    listings               : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg3),
                    listings_via_bb        : 0x2::linked_table::new<0x2::object::ID, BBListing<T0>>(arg3),
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
                    alpha                  : arg0.default_alpha,
                };
                let v3 = UpdateActiveCollectionsEvent{
                    collection_mp : 0x2::object::uid_to_address(&v2.id),
                    nft_type      : v0,
                    nft_type_str  : v1,
                    boolean       : arg2,
                };
                0x2::event::emit<UpdateActiveCollectionsEvent>(v3);
                0x2::transfer::share_object<TypeMarket<T0>>(v2);
            };
        } else {
            *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.active_collections, v0) = false;
        };
    }

    public fun update_collection_alpha<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: &MarketplaceAdminCap, arg2: u64) {
        assert!(arg2 <= 2000, 771);
        assert!(arg2 > 0, 771);
        arg0.alpha = arg2;
        let v0 = UpdateConfigEvent{
            new_commission_pct   : 0,
            new_leverage_allowed : 0,
            new_ggsui_share_pct  : 0,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    public fun update_collection_fee(arg0: &mut MarketPlace, arg1: &MarketplaceAdminCap, arg2: u64) {
        validation_check(arg0);
        arg0.config.new_collection_fee = arg2;
    }

    fun update_collection_metrics<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: u128, arg2: u64, arg3: u64, arg4: u64) : (u128, u128, bool) {
        if (0x1::vector::length<u64>(&arg0.recent_sale_prices) >= 10) {
            0x1::vector::remove<u64>(&mut arg0.recent_sale_prices, 0);
            0x1::vector::remove<u64>(&mut arg0.recent_trades_times, 0);
        };
        0x1::vector::push_back<u64>(&mut arg0.recent_sale_prices, arg2);
        0x1::vector::push_back<u64>(&mut arg0.recent_trades_times, arg4);
        let v0 = 0x1::vector::length<u64>(&arg0.recent_sale_prices);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg0.recent_sale_prices, v2);
            v2 = v2 + 1;
        };
        if (arg0.avg_sale_price == 0) {
            arg0.avg_sale_price = v1 / v0;
        } else {
            arg0.avg_sale_price = (0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u256((arg0.avg_sale_price as u256), ((10000 - arg0.alpha) as u256), (10000 as u256)) as u64) + (0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u256(((v1 / v0) as u256), (arg0.alpha as u256), (10000 as u256)) as u64);
        };
        if (v0 >= 2) {
            if (arg0.avg_time_bw_trades == 0) {
                arg0.avg_time_bw_trades = (*0x1::vector::borrow<u64>(&arg0.recent_trades_times, v0 - 1) - *0x1::vector::borrow<u64>(&arg0.recent_trades_times, 0)) / (v0 - 1);
            } else {
                arg0.avg_time_bw_trades = (0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u256((arg0.avg_time_bw_trades as u256), ((10000 - arg0.alpha) as u256), (10000 as u256)) as u64) + (0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u256((((*0x1::vector::borrow<u64>(&arg0.recent_trades_times, v0 - 1) - *0x1::vector::borrow<u64>(&arg0.recent_trades_times, 0)) / (v0 - 1)) as u256), (arg0.alpha as u256), (10000 as u256)) as u64);
            };
        };
        let v3 = 0;
        if (arg0.avg_time_bw_trades > 0) {
            v3 = (arg0.avg_sale_price as u128) * (arg3 as u128) * ((31536000000 / arg0.avg_time_bw_trades) as u128);
        };
        let v4 = (arg0.simulated_yearly_fee as u128);
        let (v5, v6, v7) = if (v3 >= v4) {
            (arg1 + v3 - v4, v3 - v4, true)
        } else {
            (arg1 - v4 - v3, v4 - v3, false)
        };
        arg0.simulated_yearly_fee = v3;
        if (v5 > 0) {
            arg0.weight = (0xa4491edd3a3a63c01e0afb0c81fd7062c7c94c770095958cc1426a714d58d960::math::mul_div_u256((arg0.simulated_yearly_fee as u256), (1000000000 as u256), (v5 as u256)) as u64);
        } else {
            arg0.weight = 0;
        };
        let v8 = UpdateCollectionMetricsEvent{
            collection_mp                   : 0x2::object::uid_to_address(&arg0.id),
            collection_type                 : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            new_protocol_total              : v5,
            change                          : v6,
            increased                       : v7,
            collection_simulated_yearly_fee : arg0.simulated_yearly_fee,
            collection_weight               : arg0.weight,
            recent_trades_times             : arg0.recent_trades_times,
            recent_sale_prices              : arg0.recent_sale_prices,
        };
        0x2::event::emit<UpdateCollectionMetricsEvent>(v8);
        (v5, v6, v7)
    }

    public fun update_config(arg0: &mut MarketPlace, arg1: &MarketplaceAdminCap, arg2: u64, arg3: u64, arg4: u64) {
        validation_check(arg0);
        if (arg2 != 0) {
            assert!(arg2 <= 10, 771);
            arg0.config.commission_pct = arg2;
        };
        if (arg3 != 0) {
            arg0.config.max_leverage_allowed = arg3;
        };
        if (arg4 != 0) {
            arg0.config.ggsui_share_pct = arg4;
        };
        let v0 = UpdateConfigEvent{
            new_commission_pct   : arg2,
            new_leverage_allowed : arg3,
            new_ggsui_share_pct  : arg4,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    public fun update_default_alpha(arg0: &mut MarketPlace, arg1: &MarketplaceAdminCap, arg2: u64) {
        validation_check(arg0);
        assert!(arg2 <= 2000, 771);
        assert!(arg2 > 0, 771);
        arg0.default_alpha = arg2;
        let v0 = UpdateConfigEvent{
            new_commission_pct   : 0,
            new_leverage_allowed : 0,
            new_ggsui_share_pct  : 0,
        };
        0x2::event::emit<UpdateConfigEvent>(v0);
    }

    public fun update_honeyjar_multiplier<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: &MarketplaceAdminCap, arg2: bool, arg3: u64) {
        assert!(100 <= arg3 && arg3 <= 10000, 781);
        arg0.points_enabled = arg2;
        arg0.points_multiplier = arg3;
        let v0 = UpdateHoneyJarMultiplierEvent{
            nft_type                    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            are_honeyjar_points_enabled : arg2,
            points_multiplier           : arg3,
        };
        0x2::event::emit<UpdateHoneyJarMultiplierEvent>(v0);
    }

    public fun update_module_version(arg0: &mut MarketPlace) {
        assert!(arg0.version < 0, 773);
        arg0.version = 0;
    }

    public fun update_permissionless_status(arg0: &mut MarketPlace, arg1: &MarketplaceAdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        arg0.config.is_permissionless = arg2;
        let v0 = UpdatePermissionlessStatusEvent{is_permissionless: arg2};
        0x2::event::emit<UpdatePermissionlessStatusEvent>(v0);
    }

    public fun update_price_increment<T0: store + key>(arg0: &mut TypeMarket<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64) {
        assert!(arg2 >= 1 && arg2 <= 100, 793);
        arg0.price_increment = arg2;
        let v0 = UpdatePriceIncrementEvent{
            nft_type        : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            price_increment : arg2,
        };
        0x2::event::emit<UpdatePriceIncrementEvent>(v0);
    }

    fun validate_collection_exists<T0: store + key>(arg0: &MarketPlace) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(*0x2::linked_table::borrow<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
    }

    fun validation_check(arg0: &MarketPlace) {
        assert!(arg0.version == 0, 7684);
    }

    public fun withdraw_ggsui_from_bid_pool(arg0: &mut MarketPlace, arg1: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI> {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 769);
        let v1 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        assert!(0x2::linked_table::contains<0x1::ascii::String, BidPool>(&v1.bid_pools, arg2), 785);
        let v2 = 0x2::linked_table::borrow_mut<0x1::ascii::String, BidPool>(&mut v1.bid_pools, arg2);
        assert!(arg3 <= 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v2.ggsui_balance), 772);
        assert!(v2.sui_bidded <= arg0.config.max_leverage_allowed * 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::get_sui_by_ggsui(arg1, 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v2.ggsui_balance) - arg3), 791);
        let v3 = 0x2::balance::split<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&mut v2.ggsui_balance, arg3);
        let v4 = BidPoolWithdrawnEvent{
            user                : v0,
            bid_pool_identifier : arg2,
            ggsui_withdrawn     : 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v3),
            new_ggsui_balance   : 0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v2.ggsui_balance),
            total_bidded        : v2.sui_bidded,
        };
        0x2::event::emit<BidPoolWithdrawnEvent>(v4);
        if (0x2::balance::value<0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui::GGSUI>(&v2.ggsui_balance) == 0) {
            destroy_bid_pool(0x2::linked_table::remove<0x1::ascii::String, BidPool>(&mut v1.bid_pools, arg2));
            let (_, v6) = 0x1::vector::index_of<0x1::ascii::String>(&v1.bid_pool_identifiers, &arg2);
            0x1::vector::remove<0x1::ascii::String>(&mut v1.bid_pool_identifiers, v6);
            let v7 = BidPoolRemovedEvent{
                user                : v0,
                bid_pool_identifier : arg2,
            };
            0x2::event::emit<BidPoolRemovedEvent>(v7);
        };
        v3
    }

    public fun withdraw_sui_from_bid_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketPlace, arg2: &mut 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::Vault, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::get_ggsui_by_sui(arg2, arg4);
        let v1 = withdraw_ggsui_from_bid_pool(arg1, arg2, arg3, v0, arg5);
        0x653f1af7535a3dc04ac560621a9164995a9bccdcbaf2133364b29b7fc1f9de0e::vault::request_instant_unstake_disc(&arg1.redeem_fee_disc_cap, arg0, arg2, v1, arg5)
    }

    // decompiled from Move bytecode v6
}

