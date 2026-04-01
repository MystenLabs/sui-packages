module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::trading_engine {
    public(friend) fun execute_purchase<T0: store + key>(arg0: &mut 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::ListingManager, arg1: &mut 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::CollectionRegistry, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::transfer_policy::TransferPolicy<T0>, arg9: u16, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::is_listing_active(arg0, arg6, arg10), 1);
        let v0 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::get_listing(arg0, arg6);
        let v1 = 0x2::tx_context::sender(arg11);
        assert!(v1 != 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::seller(&v0), 2);
        let v2 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::price(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= v2, 0);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::kiosk_id(&v0), 3);
        let v3 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::collection_id(&v0);
        let v4 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::calculate_platform_fee(v2, arg9);
        let v5 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::calculate_royalty_fee(v2, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::get_collection_royalty_bps(arg1, v3));
        assert!(v4 + v5 <= v2, 4);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::deposit_to_treasury(arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, v4, arg11));
        if (0x2::coin::value<0x2::sui::SUI>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        };
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg3, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::take_purchase_cap<T0>(arg0, arg6), 0x2::coin::split<0x2::sui::SUI>(&mut arg7, v2 - v4 - v5, arg11));
        if (v5 > 0) {
            if (0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::is_collection_registered(arg1, v3)) {
                let v8 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::get_collection_info(arg1, v3);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v5, arg11), 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::creator(&v8));
            } else {
                0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::deposit_to_treasury(arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, v5, arg11));
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v5, arg11));
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg8, v7);
        0x2::kiosk::place<T0>(arg4, arg5, v6);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::update_collection_stats(arg1, v3, v2, 0);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::decrement_total_listings(arg1, v3);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_nft_purchased(arg6, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::nft_id(&v0), v3, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager::seller(&v0), v1, v2, v4, v5, 0x2::clock::timestamp_ms(arg10));
    }

    // decompiled from Move bytecode v6
}

