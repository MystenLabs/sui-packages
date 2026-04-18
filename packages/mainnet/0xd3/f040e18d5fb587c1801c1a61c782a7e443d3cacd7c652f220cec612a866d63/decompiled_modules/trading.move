module 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::trading {
    struct MarketRegistered has copy, drop {
        polygon_id: 0x2::object::ID,
        owner: address,
        area_m2: u64,
        price_paid: u64,
        immediate_treasury: u64,
        hierarchy_pool: u64,
    }

    struct MarketPurchasedFull has copy, drop {
        polygon_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
        new_premium_ppm: u64,
        seller_proceeds: u64,
        immediate_treasury_fee: u64,
        hierarchy_pool: u64,
        sale_count: u64,
    }

    struct PriceStateUpdated has copy, drop {
        polygon_id: 0x2::object::ID,
        premium_ppm: u64,
    }

    struct PriceBumped has copy, drop {
        polygon_id: 0x2::object::ID,
        owner: address,
        old_premium_ppm: u64,
        new_premium_ppm: u64,
        cost_paid: u64,
        immediate_treasury: u64,
        hierarchy_pool: u64,
        sale_count: u64,
    }

    struct PriceDropped has copy, drop {
        polygon_id: 0x2::object::ID,
        owner: address,
        old_premium_ppm: u64,
        new_premium_ppm: u64,
        cost_paid: u64,
        immediate_treasury: u64,
        hierarchy_pool: u64,
        sale_count: u64,
    }

    public fun remove(arg0: &0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::MarketAdminCap, arg1: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg2: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg1), arg3)) {
            0x2::table::remove<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg1), arg3);
        };
        if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_is_initialized(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid(arg1))) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg1), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_and_sweep(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg1), arg3));
        };
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::mutations::remove_polygon(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::lifecycle_cap(arg1), arg2, arg3, arg4);
    }

    entry fun register(arg0: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: vector<vector<u64>>, arg3: vector<vector<u64>>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::is_market_paused(arg0), 3115);
        let v0 = 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::register(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::lifecycle_cap(arg0), arg1, arg2, arg3, arg5);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, v1);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v2);
        let v4 = *0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, v0);
        assert!(v3 > 0, 3108);
        assert!(v3 >= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_min_area_m2(&v4) && v3 <= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_max_area_m2(&v4), 3107);
        let v5 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::quote_price_from_premium(v3, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_price_per_km2_mist(&v4), 1000000);
        assert!(v5 > 0, 3118);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v5, 3109);
        let v6 = 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v5, arg5);
        let v7 = (((v5 as u128) * 92 / 100) as u64);
        let v8 = v5 - v7;
        if (v7 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg5)));
        };
        if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::revenue::route_hierarchy_pool(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), v1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v8, arg5)), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_rank_for_index_id(arg0, v0), arg5));
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
        let v9 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::post_registration_premium_ppm();
        0x2::table::add<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), v1, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::new_price_state(v9, 1));
        let v10 = MarketRegistered{
            polygon_id         : v1,
            owner              : 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v2),
            area_m2            : v3,
            price_paid         : v5,
            immediate_treasury : v7,
            hierarchy_pool     : v8,
        };
        0x2::event::emit<MarketRegistered>(v10);
        let v11 = PriceStateUpdated{
            polygon_id  : v1,
            premium_ppm : v9,
        };
        0x2::event::emit<PriceStateUpdated>(v11);
        (v1, arg4)
    }

    entry fun bump_price(arg0: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::is_market_paused(arg0), 3115);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v2) == v0, 3110);
        let v3 = *0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, v1);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        let v4 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2);
        let v5 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v4);
        assert!(v5 < 4900000000, 3120);
        let v6 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::quote_price_from_premium(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v2), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_price_per_km2_mist(&v3), v5);
        assert!(v6 > 0, 3118);
        let v7 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::treasury_fee_for_price(v6);
        let v8 = v6 - 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::seller_proceeds_for_price(v6) - v7;
        let v9 = v7 + v8;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v9, 3109);
        let v10 = 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v9, arg4);
        if (v7 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v7, arg4)));
        };
        if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::revenue::route_hierarchy_pool(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v8, arg4)), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_rank_for_index_id(arg0, v1), arg4));
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
        let v11 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v4);
        let v12 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::next_resale_premium_ppm(v5, v11);
        let v13 = v11 + 1;
        let v14 = 0x2::table::borrow_mut<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg2);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_premium_ppm(v14, v12);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_sale_count(v14, v13);
        let v15 = PriceBumped{
            polygon_id         : arg2,
            owner              : v0,
            old_premium_ppm    : v5,
            new_premium_ppm    : v12,
            cost_paid          : v9,
            immediate_treasury : v7,
            hierarchy_pool     : v8,
            sale_count         : v13,
        };
        0x2::event::emit<PriceBumped>(v15);
        let v16 = PriceStateUpdated{
            polygon_id  : arg2,
            premium_ppm : v12,
        };
        0x2::event::emit<PriceStateUpdated>(v16);
        arg3
    }

    entry fun buy_full(arg0: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::is_market_paused(arg0), 3115);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v2);
        let v4 = *0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, v1);
        assert!(v0 != v3, 3106);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        let v5 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2);
        let v6 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v5);
        let v7 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::quote_price_from_premium(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v2), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_price_per_km2_mist(&v4), v6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v7, 3109);
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v7, arg4);
        let v9 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::seller_proceeds_for_price(v7);
        let v10 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::treasury_fee_for_price(v7);
        let v11 = v7 - v9 - v10;
        if (v10 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v10, arg4)));
        };
        if (v11 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::revenue::route_hierarchy_pool(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v11, arg4)), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_rank_for_index_id(arg0, v1), arg4));
        };
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v9, arg4), v3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v9, arg4));
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
        let v12 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v5);
        let v13 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::next_resale_premium_ppm(v6, v12);
        let v14 = v12 + 1;
        let v15 = 0x2::table::borrow_mut<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg2);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_premium_ppm(v15, v13);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_sale_count(v15, v14);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::force_transfer(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::transfer_cap(arg0), arg1, arg2, v0);
        let v16 = MarketPurchasedFull{
            polygon_id             : arg2,
            buyer                  : v0,
            seller                 : v3,
            price                  : v7,
            new_premium_ppm        : v13,
            seller_proceeds        : v9,
            immediate_treasury_fee : v10,
            hierarchy_pool         : v11,
            sale_count             : v14,
        };
        0x2::event::emit<MarketPurchasedFull>(v16);
        let v17 = PriceStateUpdated{
            polygon_id  : arg2,
            premium_ppm : v13,
        };
        0x2::event::emit<PriceStateUpdated>(v17);
        arg3
    }

    public fun current_price(arg0: &0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID) : u64 {
        let v0 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1));
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::quote_price_from_premium(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2)), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_price_per_km2_mist(v0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2)))
    }

    entry fun drop_price(arg0: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::is_market_paused(arg0), 3115);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v2) == v0, 3110);
        let v3 = *0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, v1);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        let v4 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2);
        let v5 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v4);
        assert!(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v4) >= 1, 3121);
        let v6 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::quote_price_from_premium(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v2), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_price_per_km2_mist(&v3), v5);
        assert!(v6 > 0, 3118);
        let v7 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::hierarchy_pool_for_price(v6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v7, 3109);
        0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::revenue::route_hierarchy_pool(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v7, arg4)), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_rank_for_index_id(arg0, v1), arg4));
        let v8 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::prev_resale_premium_ppm(v5, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v4));
        let v9 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v4) - 1;
        let v10 = 0x2::table::borrow_mut<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg2);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_premium_ppm(v10, v8);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_sale_count(v10, v9);
        let v11 = PriceDropped{
            polygon_id         : arg2,
            owner              : v0,
            old_premium_ppm    : v5,
            new_premium_ppm    : v8,
            cost_paid          : v7,
            immediate_treasury : 0,
            hierarchy_pool     : v7,
            sale_count         : v9,
        };
        0x2::event::emit<PriceDropped>(v11);
        let v12 = PriceStateUpdated{
            polygon_id  : arg2,
            premium_ppm : v8,
        };
        0x2::event::emit<PriceStateUpdated>(v12);
        arg3
    }

    public fun quote_bump_cost(arg0: &0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID) : u64 {
        let v0 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1));
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        let v1 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::quote_price_from_premium(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2)), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_price_per_km2_mist(v0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2)));
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::treasury_fee_for_price(v1) + 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::hierarchy_pool_for_price(v1)
    }

    public fun quote_drop_cost(arg0: &0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID) : u64 {
        let v0 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1));
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::hierarchy_pool_for_price(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::quote_price_from_premium(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2)), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_price_per_km2_mist(v0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2))))
    }

    // decompiled from Move bytecode v7
}

