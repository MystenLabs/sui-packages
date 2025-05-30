module 0xc2b1ce066ffb8d62a7e979edee2b994753d8cd81c1becd4d55b0818d0c02ff3e::nft_swap {
    struct Version has copy, drop, store {
        major: u64,
        minor: u64,
        patch: u64,
    }

    struct VersionUpdatedEvent has copy, drop {
        old_version: Version,
        new_version: Version,
        updated_by: address,
    }

    struct NFT_SWAP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store has key {
        id: 0x2::object::UID,
        active_trades: u64,
        total_trades: u64,
        completed_trades: u64,
        total_volume: u64,
        total_fees: u64,
        fee_percentage: u64,
        fee_address: address,
        create_trade_fee: u64,
        version: Version,
    }

    struct TradeItem has copy, drop, store {
        item_id: 0x2::object::ID,
    }

    struct Trade has store, key {
        id: 0x2::object::UID,
        creator: address,
        creator_items: 0x2::vec_set::VecSet<TradeItem>,
        counterparty_items: 0x2::vec_set::VecSet<TradeItem>,
        sui_requested: u64,
        sui_offered: u64,
        active: bool,
        created_at: u64,
        expiration: u64,
        partial_accept_at: u64,
    }

    struct TradeCreatedEvent has copy, drop {
        trade_id: 0x2::object::ID,
        creator: address,
        target_counterparty: address,
        creator_items: vector<0x2::object::ID>,
        counterparty_items: vector<0x2::object::ID>,
        sui_requested: u64,
        sui_offered: u64,
        expiration: u64,
    }

    struct TradeAcceptedEvent has copy, drop {
        trade_id: 0x2::object::ID,
        creator: address,
        counterparty: address,
        creator_items: vector<0x2::object::ID>,
        counterparty_items: vector<0x2::object::ID>,
        sui_requested: u64,
        sui_offered: u64,
        platform_fee: u64,
    }

    struct TradeCancelledEvent has copy, drop {
        trade_id: 0x2::object::ID,
        creator: address,
        reason: 0x1::string::String,
    }

    struct TradeExpiredEvent has copy, drop {
        trade_id: 0x2::object::ID,
        creator: address,
        expiration: u64,
    }

    struct FeeUpdatedEvent has copy, drop {
        old_fee: u64,
        new_fee: u64,
        changed_by: address,
    }

    struct FeeAddressUpdatedEvent has copy, drop {
        old_address: address,
        new_address: address,
        changed_by: address,
    }

    struct CreateTradeFeeUpdatedEvent has copy, drop {
        old_fee: u64,
        new_fee: u64,
        changed_by: address,
    }

    struct TypeWitness<phantom T0: store + key> has drop {
        dummy_field: bool,
    }

    public fun accept_trade_improved<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg4), 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        assert!(v0.active, 6);
        if (v0.expiration != 0 && 0x2::tx_context::epoch(arg7) > v0.expiration) {
            v0.active = false;
            abort 6
        };
        if (v0.sui_requested > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg5) >= v0.sui_requested, 5);
        };
        let v1 = 0x2::vec_set::into_keys<TradeItem>(v0.counterparty_items);
        let v2 = 0;
        while (v2 < 0x1::vector::length<TradeItem>(&v1)) {
            let v3 = *0x1::vector::borrow<TradeItem>(&v1, v2);
            assert!(0x2::kiosk::has_item(arg2, v3.item_id), 7);
            v2 = v2 + 1;
        };
        let (v4, v5) = create_kiosk(arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v0.creator;
        let v9 = v0.sui_requested;
        let v10 = v0.sui_offered;
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v11 = 0x1::vector::empty<0x2::object::ID>();
        let v12 = 0x1::vector::empty<0x2::object::ID>();
        let v13 = 0x2::vec_set::into_keys<TradeItem>(v0.creator_items);
        let v14 = 0;
        while (v14 < 0x1::vector::length<TradeItem>(&v13)) {
            let v15 = *0x1::vector::borrow<TradeItem>(&v13, v14);
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v15.item_id);
            v14 = v14 + 1;
        };
        let v16 = 0x2::vec_set::into_keys<TradeItem>(v0.counterparty_items);
        let v17 = 0;
        while (v17 < 0x1::vector::length<TradeItem>(&v16)) {
            let v18 = *0x1::vector::borrow<TradeItem>(&v16, v17);
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v18.item_id);
            v17 = v17 + 1;
        };
        v0.active = false;
        if (v0.partial_accept_at == 0) {
            v0.partial_accept_at = 0x2::tx_context::epoch(arg7);
        };
        let v19 = 0x2::tx_context::sender(arg7);
        let v20 = if (v9 > 0) {
            let v21 = v9 * arg0.fee_percentage / 10000;
            if (v21 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, v21, arg7), arg0.fee_address);
                arg0.total_fees = arg0.total_fees + v21;
                v21
            } else {
                0
            }
        } else {
            0
        };
        if (v9 > 0) {
            let v22 = v9 - v20;
            if (v22 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, v22, arg7), v8);
            };
        };
        let v23 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        let v24 = if (v10 > 0) {
            0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v23.id, b"sui_payment")
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg7)
        };
        let v25 = 0;
        while (v25 < 0x1::vector::length<0x2::object::ID>(&v12)) {
            let v26 = *0x1::vector::borrow<0x2::object::ID>(&v12, v25);
            if (0x2::kiosk::is_listed(arg2, v26)) {
                0x2::kiosk::delist<T0>(arg2, arg3, v26);
            };
            let (v27, v28) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, v26, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
            let v29 = v28;
            0x2::kiosk::lock<T0>(&mut v7, &v6, arg6, v27);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v29, &v7);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v29, 0x2::coin::split<0x2::sui::SUI>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, 0x2::transfer_policy::paid<T0>(&v29)), arg7));
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v29);
            v25 = v25 + 1;
        };
        let v33 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        let v34 = 0;
        while (v34 < 0x1::vector::length<0x2::object::ID>(&v11)) {
            let v35 = *0x1::vector::borrow<0x2::object::ID>(&v11, v34);
            let v36 = 0x2::bcs::to_bytes<0x2::object::ID>(&v35);
            if (0x2::dynamic_object_field::exists_<vector<u8>>(&v33.id, v36)) {
                let (v37, v38) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v33.id, v36), 0x2::coin::zero<0x2::sui::SUI>(arg7));
                let v39 = v38;
                0x2::kiosk::lock<T0>(arg2, arg3, arg6, v37);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v39, arg2);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v39, 0x2::coin::split<0x2::sui::SUI>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, 0x2::transfer_policy::paid<T0>(&v39)), arg7));
                let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v39);
            };
            v34 = v34 + 1;
        };
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v24, v19);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v24);
        };
        arg0.active_trades = arg0.active_trades - 1;
        arg0.completed_trades = arg0.completed_trades + 1;
        arg0.total_volume = arg0.total_volume + v9 + v10;
        arg0.total_fees = arg0.total_fees + v20;
        let v43 = TradeAcceptedEvent{
            trade_id           : arg4,
            creator            : v8,
            counterparty       : v19,
            creator_items      : v11,
            counterparty_items : v12,
            sui_requested      : v9,
            sui_offered        : v10,
            platform_fee       : v20,
        };
        0x2::event::emit<TradeAcceptedEvent>(v43);
        let Trade {
            id                 : v44,
            creator            : _,
            creator_items      : _,
            counterparty_items : _,
            sui_requested      : _,
            sui_offered        : _,
            active             : _,
            created_at         : _,
            expiration         : _,
            partial_accept_at  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        0x2::object::delete(v44);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v7);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, v8);
    }

    public entry fun accept_trade_multi<T0: store + key, T1: store + key, T2: store + key, T3: store + key, T4: store + key, T5: store + key, T6: store + key, T7: store + key, T8: store + key, T9: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg9: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg10: &mut 0x2::transfer_policy::TransferPolicy<T2>, arg11: &mut 0x2::transfer_policy::TransferPolicy<T3>, arg12: &mut 0x2::transfer_policy::TransferPolicy<T4>, arg13: &mut 0x2::transfer_policy::TransferPolicy<T5>, arg14: &mut 0x2::transfer_policy::TransferPolicy<T6>, arg15: &mut 0x2::transfer_policy::TransferPolicy<T7>, arg16: &mut 0x2::transfer_policy::TransferPolicy<T8>, arg17: &mut 0x2::transfer_policy::TransferPolicy<T9>, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg4), 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        assert!(v0.active, 6);
        if (v0.expiration != 0 && 0x2::tx_context::epoch(arg18) > v0.expiration) {
            v0.active = false;
            abort 6
        };
        if (v0.sui_requested > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg7) >= v0.sui_requested, 5);
        };
        let v1 = 0x2::vec_set::into_keys<TradeItem>(v0.creator_items);
        let v2 = 0x2::vec_set::into_keys<TradeItem>(v0.counterparty_items);
        let v3 = 0;
        while (v3 < 0x1::vector::length<TradeItem>(&v2)) {
            let v4 = *0x1::vector::borrow<TradeItem>(&v2, v3);
            assert!(0x2::kiosk::has_item(arg2, v4.item_id), 7);
            v3 = v3 + 1;
        };
        let (v5, v6) = create_kiosk(arg18);
        let v7 = v6;
        let v8 = v5;
        let v9 = v0.creator;
        let v10 = v0.sui_requested;
        let v11 = v0.sui_offered;
        let v12 = 0x2::tx_context::sender(arg18);
        let v13 = if (v10 > 0) {
            let v14 = v10 * arg0.fee_percentage / 10000;
            if (v14 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg7, v14, arg18), arg0.fee_address);
                arg0.total_fees = arg0.total_fees + v14;
                v14
            } else {
                0
            }
        } else {
            0
        };
        if (v10 > 0) {
            let v15 = v10 - v13;
            if (v15 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg7, v15, arg18), v9);
            };
        };
        v0.active = false;
        let v16 = if (v11 > 0) {
            0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.id, b"sui_payment")
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg18)
        };
        let v17 = 0;
        while (v17 < 0x1::vector::length<TradeItem>(&v2)) {
            let v18 = *0x1::vector::borrow<TradeItem>(&v2, v17);
            let v19 = *0x1::vector::borrow<u8>(&arg6, v17);
            if (v19 == 1) {
                let v20 = &mut v8;
                transfer_item<T0>(arg2, arg3, v20, &v7, v18.item_id, arg8, arg7, arg18);
            } else if (v19 == 2) {
                let v21 = &mut v8;
                transfer_item<T1>(arg2, arg3, v21, &v7, v18.item_id, arg9, arg7, arg18);
            } else if (v19 == 3) {
                let v22 = &mut v8;
                transfer_item<T2>(arg2, arg3, v22, &v7, v18.item_id, arg10, arg7, arg18);
            } else if (v19 == 4) {
                let v23 = &mut v8;
                transfer_item<T3>(arg2, arg3, v23, &v7, v18.item_id, arg11, arg7, arg18);
            } else if (v19 == 5) {
                let v24 = &mut v8;
                transfer_item<T4>(arg2, arg3, v24, &v7, v18.item_id, arg12, arg7, arg18);
            } else if (v19 == 6) {
                let v25 = &mut v8;
                transfer_item<T5>(arg2, arg3, v25, &v7, v18.item_id, arg13, arg7, arg18);
            } else if (v19 == 7) {
                let v26 = &mut v8;
                transfer_item<T6>(arg2, arg3, v26, &v7, v18.item_id, arg14, arg7, arg18);
            } else if (v19 == 8) {
                let v27 = &mut v8;
                transfer_item<T7>(arg2, arg3, v27, &v7, v18.item_id, arg15, arg7, arg18);
            } else if (v19 == 9) {
                let v28 = &mut v8;
                transfer_item<T8>(arg2, arg3, v28, &v7, v18.item_id, arg16, arg7, arg18);
            } else if (v19 == 10) {
                let v29 = &mut v8;
                transfer_item<T9>(arg2, arg3, v29, &v7, v18.item_id, arg17, arg7, arg18);
            };
            v17 = v17 + 1;
        };
        let v30 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        let v31 = 0;
        while (v31 < 0x1::vector::length<TradeItem>(&v1)) {
            let v32 = *0x1::vector::borrow<TradeItem>(&v1, v31);
            let v33 = *0x1::vector::borrow<u8>(&arg5, v31);
            let v34 = 0x2::bcs::to_bytes<0x2::object::ID>(&v32.item_id);
            if (0x2::dynamic_object_field::exists_<vector<u8>>(&v30.id, v34)) {
                if (v33 == 1) {
                    purchase_and_transfer<T0>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v30.id, v34), arg8, arg7, arg18);
                } else if (v33 == 2) {
                    purchase_and_transfer<T1>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T1>>(&mut v30.id, v34), arg9, arg7, arg18);
                } else if (v33 == 3) {
                    purchase_and_transfer<T2>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T2>>(&mut v30.id, v34), arg10, arg7, arg18);
                } else if (v33 == 4) {
                    purchase_and_transfer<T3>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T3>>(&mut v30.id, v34), arg11, arg7, arg18);
                } else if (v33 == 5) {
                    purchase_and_transfer<T4>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T4>>(&mut v30.id, v34), arg12, arg7, arg18);
                } else if (v33 == 6) {
                    purchase_and_transfer<T5>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T5>>(&mut v30.id, v34), arg13, arg7, arg18);
                } else if (v33 == 7) {
                    purchase_and_transfer<T6>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T6>>(&mut v30.id, v34), arg14, arg7, arg18);
                } else if (v33 == 8) {
                    purchase_and_transfer<T7>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T7>>(&mut v30.id, v34), arg15, arg7, arg18);
                } else if (v33 == 9) {
                    purchase_and_transfer<T8>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T8>>(&mut v30.id, v34), arg16, arg7, arg18);
                } else if (v33 == 10) {
                    purchase_and_transfer<T9>(arg1, arg2, arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T9>>(&mut v30.id, v34), arg17, arg7, arg18);
                };
            };
            v31 = v31 + 1;
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v16, v12);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v16);
        };
        arg0.active_trades = arg0.active_trades - 1;
        arg0.completed_trades = arg0.completed_trades + 1;
        arg0.total_volume = arg0.total_volume + v10 + v11;
        arg0.total_fees = arg0.total_fees + v13;
        let v35 = 0x1::vector::empty<0x2::object::ID>();
        let v36 = 0x1::vector::empty<0x2::object::ID>();
        let v37 = 0;
        while (v37 < 0x1::vector::length<TradeItem>(&v1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v35, 0x1::vector::borrow<TradeItem>(&v1, v37).item_id);
            v37 = v37 + 1;
        };
        let v38 = 0;
        while (v38 < 0x1::vector::length<TradeItem>(&v2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v36, 0x1::vector::borrow<TradeItem>(&v2, v38).item_id);
            v38 = v38 + 1;
        };
        let v39 = TradeAcceptedEvent{
            trade_id           : arg4,
            creator            : v9,
            counterparty       : v12,
            creator_items      : v35,
            counterparty_items : v36,
            sui_requested      : v10,
            sui_offered        : v11,
            platform_fee       : v13,
        };
        0x2::event::emit<TradeAcceptedEvent>(v39);
        let Trade {
            id                 : v40,
            creator            : _,
            creator_items      : _,
            counterparty_items : _,
            sui_requested      : _,
            sui_offered        : _,
            active             : _,
            created_at         : _,
            expiration         : _,
            partial_accept_at  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        0x2::object::delete(v40);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v8);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, v9);
    }

    public entry fun accept_trade_single_kiosks<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        accept_trade_improved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun cancel_trade<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg3), 3);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Trade>(&mut arg0.id, arg3);
        assert!(v0.creator == 0x2::tx_context::sender(arg5), 1);
        assert!(v0.active, 6);
        if (v0.sui_offered > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.id, b"sui_payment"), v0.creator);
        };
        let v1 = 0x2::vec_set::into_keys<TradeItem>(v0.creator_items);
        let v2 = 0;
        while (v2 < 0x1::vector::length<TradeItem>(&v1)) {
            let v3 = *0x1::vector::borrow<TradeItem>(&v1, v2);
            if (0x2::dynamic_object_field::exists_<vector<u8>>(&v0.id, 0x2::bcs::to_bytes<0x2::object::ID>(&v3.item_id))) {
                0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, 0x2::bcs::to_bytes<0x2::object::ID>(&v3.item_id)));
            };
            v2 = v2 + 1;
        };
        arg0.active_trades = arg0.active_trades - 1;
        let v4 = TradeCancelledEvent{
            trade_id : arg3,
            creator  : v0.creator,
            reason   : arg4,
        };
        0x2::event::emit<TradeCancelledEvent>(v4);
        let Trade {
            id                 : v5,
            creator            : _,
            creator_items      : _,
            counterparty_items : _,
            sui_requested      : _,
            sui_offered        : _,
            active             : _,
            created_at         : _,
            expiration         : _,
            partial_accept_at  : _,
        } = v0;
        0x2::object::delete(v5);
    }

    public entry fun cancel_trade_entry<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        cancel_trade<T0>(arg0, arg1, arg2, arg3, 0x1::string::utf8(b"User cancelled"), arg4);
    }

    public entry fun cancel_trade_multi<T0: store + key, T1: store + key, T2: store + key, T3: store + key, T4: store + key, T5: store + key, T6: store + key, T7: store + key, T8: store + key, T9: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg3), 3);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Trade>(&mut arg0.id, arg3);
        assert!(v0.creator == 0x2::tx_context::sender(arg6), 1);
        assert!(v0.active, 6);
        if (v0.sui_offered > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0.id, b"sui_payment"), v0.creator);
        };
        let v1 = 0x2::vec_set::into_keys<TradeItem>(v0.creator_items);
        let v2 = 0;
        while (v2 < 0x1::vector::length<TradeItem>(&v1)) {
            let v3 = *0x1::vector::borrow<TradeItem>(&v1, v2);
            let v4 = *0x1::vector::borrow<u8>(&arg4, v2);
            let v5 = 0x2::bcs::to_bytes<0x2::object::ID>(&v3.item_id);
            if (0x2::dynamic_object_field::exists_<vector<u8>>(&v0.id, v5)) {
                if (v4 == 1) {
                    0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, v5));
                } else if (v4 == 2) {
                    0x2::kiosk::return_purchase_cap<T1>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T1>>(&mut v0.id, v5));
                } else if (v4 == 3) {
                    0x2::kiosk::return_purchase_cap<T2>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T2>>(&mut v0.id, v5));
                } else if (v4 == 4) {
                    0x2::kiosk::return_purchase_cap<T3>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T3>>(&mut v0.id, v5));
                } else if (v4 == 5) {
                    0x2::kiosk::return_purchase_cap<T4>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T4>>(&mut v0.id, v5));
                } else if (v4 == 6) {
                    0x2::kiosk::return_purchase_cap<T5>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T5>>(&mut v0.id, v5));
                } else if (v4 == 7) {
                    0x2::kiosk::return_purchase_cap<T6>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T6>>(&mut v0.id, v5));
                } else if (v4 == 8) {
                    0x2::kiosk::return_purchase_cap<T7>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T7>>(&mut v0.id, v5));
                } else if (v4 == 9) {
                    0x2::kiosk::return_purchase_cap<T8>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T8>>(&mut v0.id, v5));
                } else if (v4 == 10) {
                    0x2::kiosk::return_purchase_cap<T9>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T9>>(&mut v0.id, v5));
                };
            };
            v2 = v2 + 1;
        };
        arg0.active_trades = arg0.active_trades - 1;
        let v6 = TradeCancelledEvent{
            trade_id : arg3,
            creator  : v0.creator,
            reason   : 0x1::string::utf8(b"User cancelled"),
        };
        0x2::event::emit<TradeCancelledEvent>(v6);
        let Trade {
            id                 : v7,
            creator            : _,
            creator_items      : _,
            counterparty_items : _,
            sui_requested      : _,
            sui_offered        : _,
            active             : _,
            created_at         : _,
            expiration         : _,
            partial_accept_at  : _,
        } = v0;
        0x2::object::delete(v7);
    }

    public entry fun consolidate_kiosk<T0: store + key>(arg0: &Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::kiosk::has_access(arg1, arg2), 1);
        assert!(0x2::kiosk::has_access(arg3, arg4), 1);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg5), 4);
        if (0x2::kiosk::is_listed(arg1, arg5)) {
            0x2::kiosk::delist<T0>(arg1, arg2, arg5);
        };
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg5, 0, arg8), 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v2 = v1;
        0x2::kiosk::lock<T0>(arg3, arg4, arg6, v0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v2, arg3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v2, 0x2::coin::split<0x2::sui::SUI>(arg7, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, 0x2::transfer_policy::paid<T0>(&v2)), arg8));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v2);
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
    }

    public fun create_trade<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<TradeItem>, arg4: vector<TradeItem>, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::kiosk::has_access(arg1, arg2), 1);
        let v0 = if (arg7 > 0) {
            arg7 * arg0.fee_percentage / 10000
        } else {
            0
        };
        let v1 = arg7 + v0;
        assert!(v1 == 0 || 0x2::coin::value<0x2::sui::SUI>(arg9) >= v1, 5);
        if (arg0.create_trade_fee > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg9) >= arg0.create_trade_fee + v1, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg9, arg0.create_trade_fee, arg10), arg0.fee_address);
            arg0.total_fees = arg0.total_fees + arg0.create_trade_fee;
        };
        let v2 = 0x2::object::new(arg10);
        let v3 = 0x2::tx_context::sender(arg10);
        let v4 = 0x2::tx_context::epoch(arg10);
        let v5 = 0x2::vec_set::empty<TradeItem>();
        let v6 = 0x2::vec_set::empty<TradeItem>();
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<TradeItem>(&arg3)) {
            let v9 = *0x1::vector::borrow<TradeItem>(&arg3, v8);
            assert!(0x2::kiosk::has_item(arg1, v9.item_id), 4);
            assert!(!0x2::kiosk::is_listed(arg1, v9.item_id), 10);
            0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v9.item_id), 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, v9.item_id, 0, arg10));
            0x2::vec_set::insert<TradeItem>(&mut v5, v9);
            0x1::vector::push_back<0x2::object::ID>(&mut v7, v9.item_id);
            v8 = v8 + 1;
        };
        let v10 = 0x1::vector::empty<0x2::object::ID>();
        let v11 = 0;
        while (v11 < 0x1::vector::length<TradeItem>(&arg4)) {
            let v12 = *0x1::vector::borrow<TradeItem>(&arg4, v11);
            0x2::vec_set::insert<TradeItem>(&mut v6, v12);
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v12.item_id);
            v11 = v11 + 1;
        };
        let v13 = if (arg7 > 0) {
            0x2::coin::split<0x2::sui::SUI>(arg9, arg7, arg10)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg10)
        };
        let v14 = v13;
        let v15 = if (arg8 == 0) {
            0
        } else {
            v4 + arg8
        };
        let v16 = Trade{
            id                 : v2,
            creator            : v3,
            creator_items      : v5,
            counterparty_items : v6,
            sui_requested      : arg6,
            sui_offered        : 0x2::coin::value<0x2::sui::SUI>(&v14),
            active             : true,
            created_at         : v4,
            expiration         : v15,
            partial_accept_at  : 0,
        };
        if (arg7 > 0) {
            0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v16.id, b"sui_payment", v14);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v14);
        };
        let v17 = 0x2::object::uid_to_inner(&v16.id);
        0x2::dynamic_object_field::add<0x2::object::ID, Trade>(&mut arg0.id, v17, v16);
        arg0.active_trades = arg0.active_trades + 1;
        arg0.total_trades = arg0.total_trades + 1;
        let v18 = if (arg8 == 0) {
            0
        } else {
            v4 + arg8
        };
        let v19 = TradeCreatedEvent{
            trade_id            : v17,
            creator             : v3,
            target_counterparty : arg5,
            creator_items       : v7,
            counterparty_items  : v10,
            sui_requested       : arg6,
            sui_offered         : arg7,
            expiration          : v18,
        };
        0x2::event::emit<TradeCreatedEvent>(v19);
        v17
    }

    public entry fun create_trade_entry<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: vector<0x1::string::String>, arg5: vector<0x2::object::ID>, arg6: vector<0x1::string::String>, arg7: address, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::vector::empty<TradeItem>();
        let v1 = 0x1::vector::empty<TradeItem>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v3 = TradeItem{item_id: *0x1::vector::borrow<0x2::object::ID>(&arg3, v2)};
            0x1::vector::push_back<TradeItem>(&mut v0, v3);
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&arg5)) {
            let v5 = TradeItem{item_id: *0x1::vector::borrow<0x2::object::ID>(&arg5, v4)};
            0x1::vector::push_back<TradeItem>(&mut v1, v5);
            v4 = v4 + 1;
        };
        create_trade<T0>(arg0, arg1, arg2, v0, v1, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun create_trade_item<T0: store + key>(arg0: 0x2::object::ID) : TradeItem {
        TradeItem{item_id: arg0}
    }

    public entry fun create_trade_multi<T0: store + key, T1: store + key, T2: store + key, T3: store + key, T4: store + key, T5: store + key, T6: store + key, T7: store + key, T8: store + key, T9: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: vector<u8>, arg5: vector<0x2::object::ID>, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::kiosk::has_access(arg1, arg2), 1);
        let v0 = if (arg8 > 0) {
            arg8 * arg0.fee_percentage / 10000
        } else {
            0
        };
        let v1 = arg8 + v0;
        assert!(v1 == 0 || 0x2::coin::value<0x2::sui::SUI>(arg10) >= v1, 5);
        if (arg0.create_trade_fee > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg10) >= arg0.create_trade_fee + v1, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg10, arg0.create_trade_fee, arg11), arg0.fee_address);
            arg0.total_fees = arg0.total_fees + arg0.create_trade_fee;
        };
        let v2 = 0x2::object::new(arg11);
        let v3 = 0x2::tx_context::sender(arg11);
        let v4 = 0x2::tx_context::epoch(arg11);
        let v5 = 0x2::vec_set::empty<TradeItem>();
        let v6 = 0x2::vec_set::empty<TradeItem>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v8 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v7);
            let v9 = *0x1::vector::borrow<u8>(&arg4, v7);
            assert!(0x2::kiosk::has_item(arg1, v8), 4);
            assert!(!0x2::kiosk::is_listed(arg1, v8), 10);
            if (v9 == 1) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, v8, 0, arg11));
            } else if (v9 == 2) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T1>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T1>(arg1, arg2, v8, 0, arg11));
            } else if (v9 == 3) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T2>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T2>(arg1, arg2, v8, 0, arg11));
            } else if (v9 == 4) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T3>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T3>(arg1, arg2, v8, 0, arg11));
            } else if (v9 == 5) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T4>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T4>(arg1, arg2, v8, 0, arg11));
            } else if (v9 == 6) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T5>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T5>(arg1, arg2, v8, 0, arg11));
            } else if (v9 == 7) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T6>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T6>(arg1, arg2, v8, 0, arg11));
            } else if (v9 == 8) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T7>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T7>(arg1, arg2, v8, 0, arg11));
            } else if (v9 == 9) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T8>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T8>(arg1, arg2, v8, 0, arg11));
            } else if (v9 == 10) {
                0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T9>>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v8), 0x2::kiosk::list_with_purchase_cap<T9>(arg1, arg2, v8, 0, arg11));
            };
            let v10 = TradeItem{item_id: v8};
            0x2::vec_set::insert<TradeItem>(&mut v5, v10);
            v7 = v7 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x2::object::ID>(&arg5)) {
            let v12 = TradeItem{item_id: *0x1::vector::borrow<0x2::object::ID>(&arg5, v11)};
            0x2::vec_set::insert<TradeItem>(&mut v6, v12);
            v11 = v11 + 1;
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg10, v0, arg11), arg0.fee_address);
            arg0.total_fees = arg0.total_fees + v0;
        };
        let v13 = if (arg8 > 0) {
            0x2::coin::split<0x2::sui::SUI>(arg10, arg8, arg11)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg11)
        };
        let v14 = v13;
        let v15 = if (arg9 == 0) {
            0
        } else {
            v4 + arg9
        };
        let v16 = Trade{
            id                 : v2,
            creator            : v3,
            creator_items      : v5,
            counterparty_items : v6,
            sui_requested      : arg7,
            sui_offered        : 0x2::coin::value<0x2::sui::SUI>(&v14),
            active             : true,
            created_at         : v4,
            expiration         : v15,
            partial_accept_at  : 0,
        };
        if (arg8 > 0) {
            0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v16.id, b"sui_payment", v14);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v14);
        };
        let v17 = 0x2::object::uid_to_inner(&v16.id);
        0x2::dynamic_object_field::add<0x2::object::ID, Trade>(&mut arg0.id, v17, v16);
        arg0.active_trades = arg0.active_trades + 1;
        arg0.total_trades = arg0.total_trades + 1;
        let v18 = if (arg9 == 0) {
            0
        } else {
            v4 + arg9
        };
        let v19 = TradeCreatedEvent{
            trade_id            : v17,
            creator             : v3,
            target_counterparty : arg6,
            creator_items       : arg3,
            counterparty_items  : arg5,
            sui_requested       : arg7,
            sui_offered         : arg8,
            expiration          : v18,
        };
        0x2::event::emit<TradeCreatedEvent>(v19);
        v17
    }

    public entry fun emergency_return_purchase_cap<T0: store + key>(arg0: &AdminCap, arg1: &mut Store, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg1), 13);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg1.id, arg3), 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg1.id, arg3);
        let v1 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg4);
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&v0.id, v1), 4);
        0x2::kiosk::return_purchase_cap<T0>(arg2, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, v1));
    }

    public fun get_active_trades(arg0: &Store) : u64 {
        arg0.active_trades
    }

    public fun get_completed_trades(arg0: &Store) : u64 {
        arg0.completed_trades
    }

    public fun get_counterparty_items(arg0: &Store, arg1: 0x2::object::ID) : vector<TradeItem> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg1), 3);
        0x2::vec_set::into_keys<TradeItem>(0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1).counterparty_items)
    }

    public fun get_create_trade_fee(arg0: &Store) : u64 {
        arg0.create_trade_fee
    }

    public fun get_creator_items(arg0: &Store, arg1: 0x2::object::ID) : vector<TradeItem> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg1), 3);
        0x2::vec_set::into_keys<TradeItem>(0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1).creator_items)
    }

    public fun get_fee_address(arg0: &Store) : address {
        arg0.fee_address
    }

    public fun get_fee_percentage(arg0: &Store) : u64 {
        arg0.fee_percentage
    }

    public fun get_purchase_cap_bytes<T0: store + key>(arg0: &0x2::kiosk::PurchaseCap<T0>) : vector<u8> {
        0x2::bcs::to_bytes<0x2::kiosk::PurchaseCap<T0>>(arg0)
    }

    public fun get_sui_offered(arg0: &Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg1), 3);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1).sui_offered
    }

    public fun get_sui_requested(arg0: &Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg1), 3);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1).sui_requested
    }

    public fun get_total_fees(arg0: &Store) : u64 {
        arg0.total_fees
    }

    public fun get_total_trades(arg0: &Store) : u64 {
        arg0.total_trades
    }

    public fun get_total_volume(arg0: &Store) : u64 {
        arg0.total_volume
    }

    public fun get_trade_creator(arg0: &Store, arg1: 0x2::object::ID) : address {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1).creator
    }

    public fun get_version(arg0: &Store) : Version {
        arg0.version
    }

    fun init(arg0: NFT_SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Version{
            major : 1,
            minor : 0,
            patch : 0,
        };
        let v2 = Store{
            id               : 0x2::object::new(arg1),
            active_trades    : 0,
            total_trades     : 0,
            completed_trades : 0,
            total_volume     : 0,
            total_fees       : 0,
            fee_percentage   : 25,
            fee_address      : 0x2::tx_context::sender(arg1),
            create_trade_fee : 100000000,
            version          : v1,
        };
        0x2::transfer::share_object<Store>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<NFT_SWAP>(arg0, arg1);
    }

    public fun is_compatible_version(arg0: &Store) : bool {
        let v0 = arg0.version;
        if (v0.major == 1) {
            if (v0.minor >= 0) {
                v0.patch >= 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_trade_expired(arg0: &Store, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1);
        v0.expiration != 0 && arg2 > v0.expiration
    }

    fun purchase_and_transfer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::kiosk::PurchaseCap<T0>, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v2 = v1;
        0x2::kiosk::lock<T0>(arg1, arg2, arg4, v0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v2, arg1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v2, 0x2::coin::split<0x2::sui::SUI>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg4, 0x2::transfer_policy::paid<T0>(&v2)), arg6));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v2);
    }

    public fun trade_exists(arg0: &Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg1)
    }

    fun transfer_item<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg4, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v2 = v1;
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v2, arg2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v2, 0x2::coin::split<0x2::sui::SUI>(arg6, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg5, 0x2::transfer_policy::paid<T0>(&v2)), arg7));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v2);
    }

    public entry fun update_create_trade_fee(arg0: &AdminCap, arg1: &mut Store, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg1), 13);
        arg1.create_trade_fee = arg2;
        let v0 = CreateTradeFeeUpdatedEvent{
            old_fee    : arg1.create_trade_fee,
            new_fee    : arg2,
            changed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CreateTradeFeeUpdatedEvent>(v0);
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut Store, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg1), 13);
        assert!(arg2 <= 500, 2);
        arg1.fee_percentage = arg2;
        let v0 = FeeUpdatedEvent{
            old_fee    : arg1.fee_percentage,
            new_fee    : arg2,
            changed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeUpdatedEvent>(v0);
    }

    public entry fun update_fee_address(arg0: &AdminCap, arg1: &mut Store, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg1), 13);
        arg1.fee_address = arg2;
        let v0 = FeeAddressUpdatedEvent{
            old_address : arg1.fee_address,
            new_address : arg2,
            changed_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeAddressUpdatedEvent>(v0);
    }

    public entry fun update_version(arg0: &AdminCap, arg1: &mut Store, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1, 12);
        if (arg2 == 1) {
            assert!(arg3 >= 0, 12);
            if (arg3 == 0) {
                assert!(arg4 >= 0, 12);
            };
        };
        let v0 = Version{
            major : arg2,
            minor : arg3,
            patch : arg4,
        };
        arg1.version = v0;
        let v1 = VersionUpdatedEvent{
            old_version : arg1.version,
            new_version : v0,
            updated_by  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<VersionUpdatedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

