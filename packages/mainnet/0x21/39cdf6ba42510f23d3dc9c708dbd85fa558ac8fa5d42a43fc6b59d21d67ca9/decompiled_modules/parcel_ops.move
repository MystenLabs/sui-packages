module 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::parcel_ops {
    struct ParcelExpandedUnclaimed has copy, drop {
        polygon_id: 0x2::object::ID,
        old_area: u64,
        new_area: u64,
        price_paid: u64,
        immediate_treasury: u64,
        hierarchy_pool: u64,
    }

    struct ParcelSliceAcquired has copy, drop {
        receiver_id: 0x2::object::ID,
        donor_id: 0x2::object::ID,
    }

    struct ParcelSliceRebalanced has copy, drop {
        a_id: 0x2::object::ID,
        b_id: 0x2::object::ID,
    }

    struct ParcelOwnedSplit has copy, drop {
        parent_id: 0x2::object::ID,
        child_ids: vector<0x2::object::ID>,
        premium_ppm: u64,
    }

    struct ParcelOwnedMerged has copy, drop {
        keep_id: 0x2::object::ID,
        absorbed_id: 0x2::object::ID,
        premium_ppm: u64,
    }

    struct PriceStateUpdated has copy, drop {
        polygon_id: 0x2::object::ID,
        premium_ppm: u64,
    }

    public fun acquire_slice(arg0: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: vector<vector<u64>>, arg5: vector<vector<u64>>, arg6: vector<vector<u64>>, arg7: vector<vector<u64>>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::is_market_paused(arg0), 3115);
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg3);
        let v2 = 0x2::tx_context::sender(arg9);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v1);
        let v4 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v1);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v0) == v2, 3110);
        assert!(v3 != v2, 3113);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg3), 3111);
        let v5 = 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1);
        let v6 = *0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, v5);
        let v7 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2);
        let v8 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg3);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::force_transfer(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::transfer_cap(arg0), arg1, arg3, v2);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::mutations::repartition_adjacent(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::lifecycle_cap(arg0), arg1, arg2, arg4, arg5, arg3, arg6, arg7, arg9);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::force_transfer(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::transfer_cap(arg0), arg1, arg3, v3);
        let v9 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2));
        let v10 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg3));
        assert!(v10 >= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_min_area_m2(&v6), 3107);
        assert!(v9 >= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_min_area_m2(&v6), 3107);
        assert!(v4 > v10, 3112);
        let v11 = v4 - v10;
        let v12 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::quote_price_from_premium(v11, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_price_per_km2_mist(&v6), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v8));
        assert!(v12 > 0, 3118);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) >= v12, 3109);
        let v13 = 0x2::coin::split<0x2::sui::SUI>(&mut arg8, v12, arg9);
        let v14 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::treasury_fee_for_price(v12);
        let v15 = v12 - 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::seller_proceeds_for_price(v12) - v14;
        let v16 = v12 - v14 - v15;
        if (v14 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v14, arg9)));
        };
        if (v15 > 0) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::revenue::route_hierarchy_pool(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg3, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v15, arg9)), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_rank_for_index_id(arg0, v5), arg9));
        };
        if (v16 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v16, arg9), v3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v16, arg9));
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(v13);
        if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_is_initialized(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid(arg0))) {
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_version(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg2, arg9);
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_version(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg3, arg9);
        };
        let v17 = (v9 as u128);
        let v18 = ((((0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v0) as u128) * (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v7) as u128) + (v11 as u128) * (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v8) as u128) + v17 - 1) / v17) as u64);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_premium_ppm(0x2::table::borrow_mut<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg2), v18);
        0x2::table::borrow_mut<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg3);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_premium_ppm(0x2::table::borrow_mut<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg3), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v8));
        let v19 = PriceStateUpdated{
            polygon_id  : arg2,
            premium_ppm : v18,
        };
        0x2::event::emit<PriceStateUpdated>(v19);
        let v20 = ParcelSliceAcquired{
            receiver_id : arg2,
            donor_id    : arg3,
        };
        0x2::event::emit<ParcelSliceAcquired>(v20);
        arg8
    }

    public fun expand_unclaimed(arg0: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: vector<vector<u64>>, arg4: vector<vector<u64>>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::is_market_paused(arg0), 3115);
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v0);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v0) == 0x2::tx_context::sender(arg6), 3110);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        let v2 = 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1);
        let v3 = *0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, v2);
        let v4 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::mutations::reshape_unclaimed(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::lifecycle_cap(arg0), arg1, arg2, arg3, arg4, arg6);
        let v5 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2));
        assert!(v5 > v1, 3112);
        assert!(v5 <= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_max_area_m2(&v3), 3107);
        let v6 = 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::quote_price_from_premium(v5 - v1, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_price_per_km2_mist(&v3), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v4));
        assert!(v6 > 0, 3118);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v6, 3109);
        let v7 = 0;
        let v8 = 0;
        if (v6 > 0) {
            let v9 = 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v6, arg6);
            let v10 = (((v6 as u128) * 92 / 100) as u64);
            v7 = v10;
            let v11 = v6 - v10;
            v8 = v11;
            if (v10 > 0) {
                0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v9, v10, arg6)));
            };
            if (v11 > 0) {
                0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::revenue::route_hierarchy_pool(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v9, v11, arg6)), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_rank_for_index_id(arg0, v2), arg6));
            };
            0x2::coin::destroy_zero<0x2::sui::SUI>(v9);
        };
        if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_is_initialized(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid(arg0))) {
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_version(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg2, arg6);
        };
        let v12 = ParcelExpandedUnclaimed{
            polygon_id         : arg2,
            old_area           : v1,
            new_area           : v5,
            price_paid         : v6,
            immediate_treasury : v7,
            hierarchy_pool     : v8,
        };
        0x2::event::emit<ParcelExpandedUnclaimed>(v12);
        arg5
    }

    public fun merge_owned(arg0: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: vector<vector<u64>>, arg5: vector<vector<u64>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::is_market_paused(arg0), 3115);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg3), 3111);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg3);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v1) == v0 && 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v2) == v0, 3114);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v1);
        let v4 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v2);
        let v5 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2);
        let v6 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg3);
        if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_is_initialized(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid(arg0))) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_and_sweep(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg3));
        };
        let v7 = *0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1));
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::mutations::merge_keep(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::lifecycle_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2)) <= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_max_area_m2(&v7), 3107);
        let v8 = (v3 as u128) + (v4 as u128);
        let v9 = ((((v3 as u128) * (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v5) as u128) + (v4 as u128) * (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v6) as u128) + v8 - 1) / v8) as u64);
        let v10 = if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v5) > 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v6)) {
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v5)
        } else {
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v6)
        };
        let v11 = 0x2::table::borrow_mut<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg2);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_premium_ppm(v11, v9);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_sale_count(v11, v10);
        if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_is_initialized(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid(arg0))) {
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_version(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg2, arg6);
        };
        0x2::table::remove<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg3);
        let v12 = ParcelOwnedMerged{
            keep_id     : arg2,
            absorbed_id : arg3,
            premium_ppm : v9,
        };
        0x2::event::emit<ParcelOwnedMerged>(v12);
        let v13 = PriceStateUpdated{
            polygon_id  : arg2,
            premium_ppm : v9,
        };
        0x2::event::emit<PriceStateUpdated>(v13);
    }

    public fun rebalance_slice(arg0: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: vector<vector<u64>>, arg4: vector<vector<u64>>, arg5: 0x2::object::ID, arg6: vector<vector<u64>>, arg7: vector<vector<u64>>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::is_market_paused(arg0), 3115);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg5);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v1) == v0 && 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v2) == v0, 3114);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg5), 3111);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v1);
        let v4 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v2);
        let v5 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2);
        let v6 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg5);
        let v7 = *0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1));
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::mutations::repartition_adjacent(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::lifecycle_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2)) >= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_min_area_m2(&v7), 3107);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg5)) >= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_min_area_m2(&v7), 3107);
        let v8 = (v3 as u128) + (v4 as u128);
        let v9 = ((((v3 as u128) * (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v5) as u128) + (v4 as u128) * (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v6) as u128) + v8 - 1) / v8) as u64);
        let v10 = if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v5) > 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v6)) {
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v5)
        } else {
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v6)
        };
        let v11 = 0x2::table::borrow_mut<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg2);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_premium_ppm(v11, v9);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_sale_count(v11, v10);
        let v12 = 0x2::table::borrow_mut<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg5);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_premium_ppm(v12, v9);
        0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::set_sale_count(v12, v10);
        let v13 = PriceStateUpdated{
            polygon_id  : arg2,
            premium_ppm : v9,
        };
        0x2::event::emit<PriceStateUpdated>(v13);
        let v14 = PriceStateUpdated{
            polygon_id  : arg5,
            premium_ppm : v9,
        };
        0x2::event::emit<PriceStateUpdated>(v14);
        if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_is_initialized(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid(arg0))) {
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_version(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg2, arg8);
            0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_version(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg5, arg8);
        };
        let v15 = ParcelSliceRebalanced{
            a_id : arg2,
            b_id : arg5,
        };
        0x2::event::emit<ParcelSliceRebalanced>(v15);
    }

    public fun split_owned(arg0: &mut 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::Market, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: vector<vector<vector<u64>>>, arg4: vector<vector<vector<u64>>>, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(!0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::is_market_paused(arg0), 3115);
        assert!(0x2::table::contains<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2), 3111);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2)) == 0x2::tx_context::sender(arg5), 3110);
        let v0 = *0x2::table::borrow<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states(arg0), arg2);
        if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_is_initialized(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid(arg0))) {
            0x2::balance::join<0x2::sui::SUI>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::treasury_mut(arg0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_and_sweep(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), arg2));
        };
        0x2::table::remove<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), arg2);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::mutations::split_replace(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::lifecycle_cap(arg0), arg1, arg2, arg3, arg4, arg5);
        let v2 = *0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_for_index_id(arg0, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index>(arg1));
        let v3 = 0x1::vector::length<0x2::object::ID>(&v1);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, *0x1::vector::borrow<0x2::object::ID>(&v1, v4)));
            assert!(v5 >= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_min_area_m2(&v2), 3107);
            assert!(v5 <= 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::level_max_area_m2(&v2), 3107);
            v4 = v4 + 1;
        };
        let v6 = 0;
        while (v6 < v3) {
            let v7 = *0x1::vector::borrow<0x2::object::ID>(&v1, v6);
            0x2::table::add<0x2::object::ID, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::PriceState>(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::price_states_mut(arg0), v7, 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::new_price_state(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v0), 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::sale_count(&v0)));
            let v8 = PriceStateUpdated{
                polygon_id  : v7,
                premium_ppm : 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v0),
            };
            0x2::event::emit<PriceStateUpdated>(v8);
            v6 = v6 + 1;
        };
        if (0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_is_initialized(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid(arg0))) {
            let v9 = 0;
            while (v9 < v3) {
                0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::tax::tax_close_version(0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::market::market_uid_mut(arg0), *0x1::vector::borrow<0x2::object::ID>(&v1, v9), arg5);
                v9 = v9 + 1;
            };
        };
        let v10 = ParcelOwnedSplit{
            parent_id   : arg2,
            child_ids   : v1,
            premium_ppm : 0xd3f040e18d5fb587c1801c1a61c782a7e443d3cacd7c652f220cec612a866d63::pricing::premium_ppm(&v0),
        };
        0x2::event::emit<ParcelOwnedSplit>(v10);
        v1
    }

    // decompiled from Move bytecode v7
}

