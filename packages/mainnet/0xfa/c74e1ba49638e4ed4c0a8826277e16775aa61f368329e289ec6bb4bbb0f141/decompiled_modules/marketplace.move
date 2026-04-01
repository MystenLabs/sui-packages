module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace {
    struct MarketplaceAdminCap has store, key {
        id: 0x2::object::UID,
        marketplace_id: 0x2::object::ID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        listing_manager: 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::ListingManager,
        collection_registry: 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::CollectionRegistry,
        offer_registry: 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::OfferRegistry,
        auction_house: 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::AuctionHouse,
        analytics: 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::analytics::Analytics,
        fee_config: 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::FeeConfig,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        paused: bool,
        version: u64,
    }

    public entry fun cancel_auction(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::cancel_auction(&mut arg0.auction_house, arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public entry fun end_auction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::get_auction(&arg0.auction_house, arg4);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::end_auction<T0>(&mut arg0.auction_house, &mut arg0.collection_registry, &mut arg0.treasury, arg1, arg2, arg3, arg4, arg5, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::get_platform_fee_bps(&arg0.fee_config), arg6, arg7);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::analytics::record_sale(&mut arg0.analytics, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::auction_seller(v0), 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::auction_current_bidder(v0), 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::auction_current_bid(v0), 0x2::clock::timestamp_ms(arg6));
    }

    public entry fun place_bid(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::place_bid(&mut arg0.auction_house, arg1, arg2, arg3, arg4);
    }

    public entry fun start_auction(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::start_auction(&mut arg0.auction_house, 0x2::tx_context::sender(arg8), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::increment_total_listings(&mut arg0.collection_registry, arg3);
    }

    public fun get_collection_info(arg0: &Marketplace, arg1: 0x2::object::ID) : 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::CollectionInfo {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::get_collection_info(&arg0.collection_registry, arg1)
    }

    public fun is_collection_verified(arg0: &Marketplace, arg1: 0x2::object::ID) : bool {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::is_collection_verified(&arg0.collection_registry, arg1)
    }

    public entry fun register_collection(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: address, arg4: u16, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::register_collection(&mut arg0.collection_registry, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun get_min_listing_price(arg0: &Marketplace) : u64 {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::get_min_listing_price(&arg0.fee_config)
    }

    public fun get_platform_fee_bps(arg0: &Marketplace) : u16 {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::get_platform_fee_bps(&arg0.fee_config)
    }

    public fun get_treasury_balance(arg0: &Marketplace) : u64 {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::get_treasury_balance(&arg0.treasury)
    }

    public entry fun update_min_listing_price(arg0: &mut Marketplace, arg1: &MarketplaceAdminCap, arg2: u64) {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::update_min_listing_price(&mut arg0.fee_config, arg2);
    }

    public entry fun update_platform_fee(arg0: &mut Marketplace, arg1: &MarketplaceAdminCap, arg2: u16, arg3: &0x2::clock::Clock) {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_platform_fee_updated(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::update_platform_fee(&mut arg0.fee_config, arg2), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_listing<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        let v0 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::get_listing(&arg0.listing_manager, arg1);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::decrement_total_listings(&mut arg0.collection_registry, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::collection_id(&v0));
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::analytics::record_listing_cancellation(&mut arg0.analytics);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::cancel_listing<T0>(&mut arg0.listing_manager, arg1, 0x2::tx_context::sender(arg3), arg2)
    }

    public entry fun cleanup_expired_listing<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::get_listing(&arg0.listing_manager, arg1);
        0x2::transfer::public_transfer<0x2::kiosk::PurchaseCap<T0>>(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::cleanup_expired_listing<T0>(&mut arg0.listing_manager, arg1, arg2), 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::seller(&v0));
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::decrement_total_listings(&mut arg0.collection_registry, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::collection_id(&v0));
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::analytics::record_listing_cancellation(&mut arg0.analytics);
    }

    public fun get_listing(arg0: &Marketplace, arg1: 0x2::object::ID) : 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::Listing {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::get_listing(&arg0.listing_manager, arg1)
    }

    public fun get_listing_by_nft(arg0: &Marketplace, arg1: 0x2::object::ID) : 0x2::object::ID {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::get_listing_by_nft(&arg0.listing_manager, arg1)
    }

    public fun is_listing_active(arg0: &Marketplace, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::is_listing_active(&arg0.listing_manager, arg1, arg2)
    }

    public entry fun update_listing_price(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::validate_listing_price(arg2, &arg0.fee_config), 2);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::update_listing_price(&mut arg0.listing_manager, arg1, arg2, 0x2::tx_context::sender(arg4), arg3);
    }

    public entry fun accept_offer<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::get_offer(&arg0.offer_registry, arg1);
        let v1 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::listing_id(&v0);
        let v2 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::offerer(&v0);
        let v3 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::amount(&v0);
        assert!(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::is_listing_active(&arg0.listing_manager, v1, arg6), 3);
        let v4 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::get_listing(&arg0.listing_manager, v1);
        let v5 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::seller(&v4);
        let v6 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::collection_id(&v4);
        assert!(v5 == 0x2::tx_context::sender(arg7), 3);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::kiosk_id(&v4), 3);
        let (v7, _) = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::accept_offer(&mut arg0.offer_registry, arg1, arg6);
        let v9 = v7;
        let v10 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::calculate_platform_fee(v3, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::get_platform_fee_bps(&arg0.fee_config));
        let v11 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::calculate_royalty_fee(v3, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::get_collection_royalty_bps(&arg0.collection_registry, v6));
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::deposit_to_treasury(&mut arg0.treasury, 0x2::coin::split<0x2::sui::SUI>(&mut v9, v10, arg7));
        let v12 = 0x2::coin::split<0x2::sui::SUI>(&mut v9, v11, arg7);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v9);
        let (v13, v14) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::take_purchase_cap<T0>(&mut arg0.listing_manager, v1), 0x2::coin::split<0x2::sui::SUI>(&mut v9, v3 - v10 - v11, arg7));
        if (0x2::coin::value<0x2::sui::SUI>(&v12) > 0) {
            if (0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::is_collection_registered(&arg0.collection_registry, v6)) {
                let v15 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::get_collection_info(&arg0.collection_registry, v6);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v12, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::creator(&v15));
            } else {
                0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::deposit_to_treasury(&mut arg0.treasury, v12);
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v12);
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v14);
        0x2::kiosk::place<T0>(arg3, arg4, v13);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::update_collection_stats(&mut arg0.collection_registry, v6, v3, 0);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::decrement_total_listings(&mut arg0.collection_registry, v6);
        let v19 = 0x2::clock::timestamp_ms(arg6);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::analytics::record_sale(&mut arg0.analytics, v5, v2, v3, v19);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_offer_accepted(arg1, v1, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::nft_id(&v0), v5, v2, v3, v10, v11, v19);
    }

    public entry fun cancel_offer(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::cancel_offer(&mut arg0.offer_registry, arg1, v0, arg2), v0);
    }

    public entry fun cleanup_expired_offer(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::get_offer(&arg0.offer_registry, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::cleanup_expired_offer(&mut arg0.offer_registry, arg1, arg2), 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::offerer(&v0));
    }

    public entry fun create_listing<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::kiosk::PurchaseCap<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::validate_listing_price(arg4, &arg0.fee_config), 2);
        assert!(arg4 >= arg5, 3);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::create_fixed_listing<T0>(&mut arg0.listing_manager, 0x2::tx_context::sender(arg9), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::increment_total_listings(&mut arg0.collection_registry, arg3);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::analytics::record_listing(&mut arg0.analytics);
    }

    public entry fun create_offer(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::is_listing_active(&arg0.listing_manager, arg1, arg5), 3);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::create_offer(&mut arg0.offer_registry, arg1, arg2, 0x2::tx_context::sender(arg6), arg3, arg4, arg5, arg6);
    }

    public fun get_admin(arg0: &Marketplace) : address {
        arg0.admin
    }

    public fun get_version(arg0: &Marketplace) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = Marketplace{
            id                  : v0,
            listing_manager     : 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::new(arg0),
            collection_registry : 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::new(arg0),
            offer_registry      : 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry::new(arg0),
            auction_house       : 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house::new(arg0),
            analytics           : 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::analytics::new(arg0),
            fee_config          : 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::new_fee_config(250, 100000000),
            treasury            : 0x2::balance::zero<0x2::sui::SUI>(),
            admin               : v1,
            paused              : false,
            version             : 1,
        };
        let v3 = MarketplaceAdminCap{
            id             : 0x2::object::new(arg0),
            marketplace_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::share_object<Marketplace>(v2);
        0x2::transfer::transfer<MarketplaceAdminCap>(v3, v1);
    }

    public fun is_paused(arg0: &Marketplace) : bool {
        arg0.paused
    }

    public entry fun pause_marketplace(arg0: &mut Marketplace, arg1: &MarketplaceAdminCap, arg2: &0x2::clock::Clock) {
        arg0.paused = true;
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_marketplace_paused_status_changed(true, 0x2::clock::timestamp_ms(arg2));
    }

    public entry fun purchase_nft<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::get_listing(&arg0.listing_manager, arg4);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::collection_id(&v0);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::trading_engine::execute_purchase<T0>(&mut arg0.listing_manager, &mut arg0.collection_registry, &mut arg0.treasury, arg1, arg2, arg3, arg4, arg5, arg6, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::get_platform_fee_bps(&arg0.fee_config), arg7, arg8);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::analytics::record_sale(&mut arg0.analytics, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::seller(&v0), 0x2::tx_context::sender(arg8), 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::price(&v0), 0x2::clock::timestamp_ms(arg7));
    }

    public entry fun unpause_marketplace(arg0: &mut Marketplace, arg1: &MarketplaceAdminCap, arg2: &0x2::clock::Clock) {
        arg0.paused = false;
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_marketplace_paused_status_changed(false, 0x2::clock::timestamp_ms(arg2));
    }

    public entry fun unverify_collection(arg0: &mut Marketplace, arg1: &MarketplaceAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::set_collection_verified(&mut arg0.collection_registry, arg2, false, arg3);
    }

    public entry fun verify_collection(arg0: &mut Marketplace, arg1: &MarketplaceAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::set_collection_verified(&mut arg0.collection_registry, arg2, true, arg3);
    }

    public entry fun withdraw_fees(arg0: &mut Marketplace, arg1: &MarketplaceAdminCap, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::withdraw_from_treasury(&mut arg0.treasury, arg2, arg5), arg3);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_fees_withdrawn(arg3, arg2, 0x2::clock::timestamp_ms(arg4));
    }

    // decompiled from Move bytecode v6
}

