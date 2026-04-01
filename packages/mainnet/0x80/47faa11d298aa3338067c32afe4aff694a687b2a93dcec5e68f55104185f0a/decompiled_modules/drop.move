module 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::drop {
    entry fun mint_drop(arg0: &mut 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::Registry, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::registry_paused(arg0), 314);
        let v0 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
        assert!(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_type(v0) == 1, 310);
        assert!(!0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_paused(v0), 313);
        assert!(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_minted(v0) + 1 <= 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_max_supply(v0), 311);
        let (v1, v2) = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::get_active_stage(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_stages(v0), arg5);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg6);
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::increment_wallet_mints(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_mint_records_mut(v0), v4, v2, 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::stage_wallet_limit(&v3), arg6);
        if (0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::stage_is_allowlist(&v3)) {
            let v5 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::stage_merkle_root(&v3);
            assert!(0x1::option::is_some<vector<u8>>(&v5), 315);
            let v6 = 0x1::option::destroy_some<vector<u8>>(v5);
            assert!(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::merkle::verify_proof(&arg4, v4, &v6), 315);
        };
        let v7 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::stage_price(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v7, 312);
        if (v7 > 0) {
            let v8 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, v7, arg6));
            let v9 = (((v7 as u128) * (0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::registry_platform_fee_bps(arg0) as u128) / 10000) as u64);
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v8, v9), arg6), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::registry_platform_address(arg0));
            };
            let v10 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::add_to_treasury(v10, v8);
            let (v11, v12) = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::get_next_unminted_item(v10);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::mark_item_minted(v10, v11);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::increment_minted(v10);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::increment_registry_minted(arg0);
            let v13 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
            let v14 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::create_nft(arg1, v11, 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_name(v12), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_description(v13), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_uri(v12), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_creator(v13), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_attributes(v12), arg6);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_nft_minted(0x2::object::id<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::GanbiteraNFT>(&v14), arg1, v11, v4, arg2, v7, v2);
            0x2::transfer::public_transfer<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::GanbiteraNFT>(v14, arg2);
        } else {
            let v15 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
            let (v16, v17) = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::get_next_unminted_item(v15);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::mark_item_minted(v15, v16);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::increment_minted(v15);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::increment_registry_minted(arg0);
            let v18 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
            let v19 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::create_nft(arg1, v16, 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_name(v17), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_description(v18), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_uri(v17), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_creator(v18), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_attributes(v17), arg6);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_nft_minted(0x2::object::id<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::GanbiteraNFT>(&v19), arg1, v16, v4, arg2, v7, v2);
            0x2::transfer::public_transfer<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::GanbiteraNFT>(v19, arg2);
        };
    }

    entry fun mint_drop_to_kiosk(arg0: &mut 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::Registry, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg2, arg3), 316);
        assert!(!0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::registry_paused(arg0), 314);
        let v0 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
        assert!(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_type(v0) == 1, 310);
        assert!(!0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_paused(v0), 313);
        assert!(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_minted(v0) + 1 <= 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_max_supply(v0), 311);
        let (v1, v2) = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::get_active_stage(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_stages(v0), arg6);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg7);
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::increment_wallet_mints(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_mint_records_mut(v0), v4, v2, 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::stage_wallet_limit(&v3), arg7);
        if (0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::stage_is_allowlist(&v3)) {
            let v5 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::stage_merkle_root(&v3);
            assert!(0x1::option::is_some<vector<u8>>(&v5), 315);
            let v6 = 0x1::option::destroy_some<vector<u8>>(v5);
            assert!(0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::merkle::verify_proof(&arg5, v4, &v6), 315);
        };
        let v7 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::stage_price(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= v7, 312);
        if (v7 > 0) {
            let v8 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg4, v7, arg7));
            let v9 = (((v7 as u128) * (0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::registry_platform_fee_bps(arg0) as u128) / 10000) as u64);
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v8, v9), arg7), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::registry_platform_address(arg0));
            };
            let v10 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::add_to_treasury(v10, v8);
            let (v11, v12) = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::get_next_unminted_item(v10);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::mark_item_minted(v10, v11);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::increment_minted(v10);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::increment_registry_minted(arg0);
            let v13 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
            let v14 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::create_nft(arg1, v11, 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_name(v12), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_description(v13), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_uri(v12), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_creator(v13), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_attributes(v12), arg7);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_nft_minted(0x2::object::id<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::GanbiteraNFT>(&v14), arg1, v11, v4, v4, v7, v2);
            0x2::kiosk::place<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::GanbiteraNFT>(arg2, arg3, v14);
        } else {
            let v15 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
            let (v16, v17) = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::get_next_unminted_item(v15);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::mark_item_minted(v15, v16);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::increment_minted(v15);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::increment_registry_minted(arg0);
            let v18 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::borrow_collection_mut(arg0, arg1);
            let v19 = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::create_nft(arg1, v16, 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_name(v17), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_description(v18), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_uri(v17), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::collection_creator(v18), 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core::drop_item_attributes(v17), arg7);
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_nft_minted(0x2::object::id<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::GanbiteraNFT>(&v19), arg1, v16, v4, v4, v7, v2);
            0x2::kiosk::place<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::GanbiteraNFT>(arg2, arg3, v19);
        };
    }

    // decompiled from Move bytecode v6
}

