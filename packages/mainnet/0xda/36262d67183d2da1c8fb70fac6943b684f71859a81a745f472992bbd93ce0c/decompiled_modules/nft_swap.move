module 0xda36262d67183d2da1c8fb70fac6943b684f71859a81a745f472992bbd93ce0c::nft_swap {
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
        total_volume: u64,
        fee_percentage: u64,
        fee_address: address,
        version: Version,
    }

    struct TradeItem has copy, drop, store {
        item_id: 0x2::object::ID,
        type_name: 0x1::string::String,
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
        creator_items: vector<0x2::object::ID>,
        creator_types: vector<0x1::string::String>,
        counterparty_items: vector<0x2::object::ID>,
        counterparty_types: vector<0x1::string::String>,
        sui_requested: u64,
        sui_offered: u64,
        expiration: u64,
    }

    struct TradeAcceptedEvent has copy, drop {
        trade_id: 0x2::object::ID,
        creator: address,
        counterparty: address,
        creator_items: vector<0x2::object::ID>,
        creator_types: vector<0x1::string::String>,
        counterparty_items: vector<0x2::object::ID>,
        counterparty_types: vector<0x1::string::String>,
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

    struct TypeRegistry has key {
        id: 0x2::object::UID,
        types: vector<TypeDispatcher>,
    }

    struct TypeDispatcher has copy, drop, store {
        type_name: 0x1::string::String,
        witness_function: vector<u8>,
    }

    struct TypeWitness<phantom T0: store + key> has drop {
        dummy_field: bool,
    }

    public entry fun accept_trade_for_collection_a<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        accept_trade_improved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun accept_trade_for_collection_b<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        accept_trade_improved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun accept_trade_improved<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) {
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
        let v4 = v0.creator;
        let v5 = v0.sui_requested;
        let v6 = v0.sui_offered;
        let v7 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v8 = 0x1::vector::empty<0x2::object::ID>();
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = 0x1::vector::empty<0x2::object::ID>();
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = 0x2::vec_set::into_keys<TradeItem>(v0.creator_items);
        let v13 = 0;
        while (v13 < 0x1::vector::length<TradeItem>(&v12)) {
            let v14 = *0x1::vector::borrow<TradeItem>(&v12, v13);
            0x1::vector::push_back<0x2::object::ID>(&mut v8, v14.item_id);
            0x1::vector::push_back<0x1::string::String>(&mut v9, v14.type_name);
            v13 = v13 + 1;
        };
        let v15 = 0x2::vec_set::into_keys<TradeItem>(v0.counterparty_items);
        let v16 = 0;
        while (v16 < 0x1::vector::length<TradeItem>(&v15)) {
            let v17 = *0x1::vector::borrow<TradeItem>(&v15, v16);
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v17.item_id);
            0x1::vector::push_back<0x1::string::String>(&mut v11, v17.type_name);
            v16 = v16 + 1;
        };
        v0.active = false;
        if (v0.partial_accept_at == 0) {
            v0.partial_accept_at = 0x2::tx_context::epoch(arg7);
        };
        let v18 = 0x2::tx_context::sender(arg7);
        let v19 = if (v5 > 0) {
            let v20 = v5 * arg0.fee_percentage / 10000;
            if (v20 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, v20, arg7), arg0.fee_address);
                v20
            } else {
                0
            }
        } else {
            0
        };
        if (v5 > 0) {
            let v21 = v5 - v19;
            if (v21 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, v21, arg7), v4);
            };
        };
        let v22 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        let v23 = if (v6 > 0) {
            0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v22.id, b"sui_payment")
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg7)
        };
        let v24 = 0;
        while (v24 < 0x1::vector::length<0x2::object::ID>(&v10)) {
            let v25 = *0x1::vector::borrow<0x2::object::ID>(&v10, v24);
            if (*0x1::vector::borrow<0x1::string::String>(&v11, v24) == v7 && 0x2::kiosk::has_item(arg2, v25)) {
                if (0x2::kiosk::is_listed(arg2, v25)) {
                    0x2::kiosk::delist<T0>(arg2, arg3, v25);
                };
                let (v26, v27) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, v25, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
                0x2::kiosk::place<T0>(arg1, arg3, v26);
                let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v27);
            };
            v24 = v24 + 1;
        };
        let v31 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        let v32 = 0;
        while (v32 < 0x1::vector::length<0x2::object::ID>(&v8)) {
            let v33 = *0x1::vector::borrow<0x2::object::ID>(&v8, v32);
            if (*0x1::vector::borrow<0x1::string::String>(&v9, v32) == v7 && 0x2::kiosk::has_item(arg1, v33)) {
                let v34 = 0x2::bcs::to_bytes<0x2::object::ID>(&v33);
                if (0x2::dynamic_object_field::exists_<vector<u8>>(&v31.id, v34)) {
                    if (0x2::kiosk::is_listed(arg1, v33)) {
                        0x2::kiosk::delist<Trade>(arg1, arg3, v33);
                    };
                    0x2::kiosk::return_purchase_cap<Trade>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<Trade>>(&mut v31.id, v34));
                    let (v35, v36) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg3, v33, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
                    0x2::kiosk::place<T0>(arg2, arg3, v35);
                    let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v36);
                };
            };
            v32 = v32 + 1;
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v23, v18);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v23);
        };
        arg0.active_trades = arg0.active_trades - 1;
        arg0.total_volume = arg0.total_volume + v5 + v6;
        let v40 = TradeAcceptedEvent{
            trade_id           : arg4,
            creator            : v4,
            counterparty       : v18,
            creator_items      : v8,
            creator_types      : v9,
            counterparty_items : v10,
            counterparty_types : v11,
            sui_requested      : v5,
            sui_offered        : v6,
            platform_fee       : v19,
        };
        0x2::event::emit<TradeAcceptedEvent>(v40);
        let Trade {
            id                 : v41,
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
        0x2::object::delete(v41);
    }

    public entry fun accept_trade_single_kiosks<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        accept_trade_improved<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun accept_trade_two_creator_kiosks<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::transfer_policy::TransferPolicy<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg7), 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg7);
        assert!(v0.active, 6);
        let v1 = 0x2::tx_context::epoch(arg10);
        if (v0.expiration != 0 && v1 > v0.expiration) {
            v0.active = false;
            abort 6
        };
        if (v0.sui_requested > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg8) >= v0.sui_requested, 5);
        };
        let v2 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v3 = 0x2::vec_set::into_keys<TradeItem>(v0.creator_items);
        let v4 = 0x2::vec_set::into_keys<TradeItem>(v0.counterparty_items);
        let v5 = 0x1::vector::empty<TradeItem>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<TradeItem>(&v3)) {
            let v7 = *0x1::vector::borrow<TradeItem>(&v3, v6);
            if (v7.type_name == v2) {
                0x1::vector::push_back<TradeItem>(&mut v5, v7);
            };
            v6 = v6 + 1;
        };
        let v8 = 0x1::vector::empty<TradeItem>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<TradeItem>(&v4)) {
            let v10 = *0x1::vector::borrow<TradeItem>(&v4, v9);
            if (v10.type_name == v2) {
                0x1::vector::push_back<TradeItem>(&mut v8, v10);
            };
            v9 = v9 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<TradeItem>(&v8)) {
            let v12 = *0x1::vector::borrow<TradeItem>(&v8, v11);
            assert!(0x2::kiosk::has_item(arg5, v12.item_id), 7);
            v11 = v11 + 1;
        };
        if (0x1::vector::is_empty<TradeItem>(&v5) && 0x1::vector::is_empty<TradeItem>(&v8)) {
            return
        };
        let v13 = !0x1::vector::is_empty<TradeItem>(&v5) && !0x1::vector::is_empty<TradeItem>(&v8);
        if (v13) {
            v0.active = false;
            if (v0.partial_accept_at == 0) {
                v0.partial_accept_at = 0x2::tx_context::epoch(arg10);
            };
        };
        let v14 = v0.creator;
        let v15 = v0.sui_requested;
        let v16 = v0.sui_offered;
        let v17 = 0x1::vector::empty<0x2::object::ID>();
        let v18 = 0x1::vector::empty<0x1::string::String>();
        let v19 = 0x1::vector::empty<0x2::object::ID>();
        let v20 = 0x1::vector::empty<0x1::string::String>();
        let v21 = 0;
        while (v21 < 0x1::vector::length<TradeItem>(&v5)) {
            let v22 = *0x1::vector::borrow<TradeItem>(&v5, v21);
            0x1::vector::push_back<0x2::object::ID>(&mut v17, v22.item_id);
            0x1::vector::push_back<0x1::string::String>(&mut v18, v22.type_name);
            v21 = v21 + 1;
        };
        let v23 = 0;
        while (v23 < 0x1::vector::length<TradeItem>(&v8)) {
            let v24 = *0x1::vector::borrow<TradeItem>(&v8, v23);
            0x1::vector::push_back<0x2::object::ID>(&mut v19, v24.item_id);
            0x1::vector::push_back<0x1::string::String>(&mut v20, v24.type_name);
            v23 = v23 + 1;
        };
        let v25 = 0x2::tx_context::sender(arg10);
        let v26 = if (v13 && v15 > 0) {
            let v27 = v15 * arg0.fee_percentage / 10000;
            if (v27 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg8, v27, arg10), arg0.fee_address);
                v27
            } else {
                0
            }
        } else {
            0
        };
        if (v13 && v15 > 0) {
            let v28 = v15 - v26;
            if (v28 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg8, v28, arg10), v14);
            };
        };
        let v29 = if (v13 && v16 > 0) {
            0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg7).id, b"sui_payment")
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg10)
        };
        let v30 = 0;
        let v31 = 0;
        while (v30 < 0x1::vector::length<0x2::object::ID>(&v19)) {
            let v32 = *0x1::vector::borrow<0x2::object::ID>(&v19, v30);
            if (0x2::kiosk::is_listed(arg5, v32)) {
                0x2::kiosk::delist<T0>(arg5, arg6, v32);
            };
            let (v33, v34) = 0x2::kiosk::purchase_with_cap<T0>(arg5, 0x2::kiosk::list_with_purchase_cap<T0>(arg5, arg6, v32, 0, arg10), 0x2::coin::zero<0x2::sui::SUI>(arg10));
            if (v31 == 0) {
                0x2::kiosk::place<T0>(arg1, arg2, v33);
                v31 = 1;
            } else {
                0x2::kiosk::place<T0>(arg3, arg4, v33);
                v31 = 0;
            };
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg9, v34);
            v30 = v30 + 1;
        };
        let v38 = 0;
        while (v38 < 0x1::vector::length<0x2::object::ID>(&v17)) {
            let v39 = *0x1::vector::borrow<0x2::object::ID>(&v17, v38);
            if (0x2::kiosk::has_item(arg1, v39)) {
                let v40 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg7);
                let v41 = 0x2::bcs::to_bytes<0x2::object::ID>(&v39);
                if (0x2::dynamic_object_field::exists_<vector<u8>>(&v40.id, v41)) {
                    if (0x2::kiosk::is_listed(arg1, v39)) {
                        0x2::kiosk::delist<Trade>(arg1, arg2, v39);
                    };
                    0x2::kiosk::return_purchase_cap<Trade>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<Trade>>(&mut v40.id, v41));
                    let (v42, v43) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, v39, 0, arg10), 0x2::coin::zero<0x2::sui::SUI>(arg10));
                    0x2::kiosk::place<T0>(arg5, arg6, v42);
                    let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg9, v43);
                };
            } else if (0x2::kiosk::has_item(arg3, v39)) {
                let v47 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg7);
                let v48 = 0x2::bcs::to_bytes<0x2::object::ID>(&v39);
                if (0x2::dynamic_object_field::exists_<vector<u8>>(&v47.id, v48)) {
                    if (0x2::kiosk::is_listed(arg3, v39)) {
                        0x2::kiosk::delist<Trade>(arg3, arg4, v39);
                    };
                    0x2::kiosk::return_purchase_cap<Trade>(arg3, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<Trade>>(&mut v47.id, v48));
                    let (v49, v50) = 0x2::kiosk::purchase_with_cap<T0>(arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg3, arg4, v39, 0, arg10), 0x2::coin::zero<0x2::sui::SUI>(arg10));
                    0x2::kiosk::place<T0>(arg5, arg6, v49);
                    let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg9, v50);
                };
            };
            v38 = v38 + 1;
        };
        if (v13) {
            if (v16 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v29, v25);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v29);
            };
            arg0.active_trades = arg0.active_trades - 1;
            arg0.total_volume = arg0.total_volume + v15 + v16;
            let v54 = TradeAcceptedEvent{
                trade_id           : arg7,
                creator            : v14,
                counterparty       : v25,
                creator_items      : v17,
                creator_types      : v18,
                counterparty_items : v19,
                counterparty_types : v20,
                sui_requested      : v15,
                sui_offered        : v16,
                platform_fee       : v26,
            };
            0x2::event::emit<TradeAcceptedEvent>(v54);
            let Trade {
                id                 : v55,
                creator            : _,
                creator_items      : _,
                counterparty_items : _,
                sui_requested      : _,
                sui_offered        : _,
                active             : _,
                created_at         : _,
                expiration         : _,
                partial_accept_at  : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, Trade>(&mut arg0.id, arg7);
            0x2::object::delete(v55);
        } else {
            if (!0x1::vector::is_empty<0x2::object::ID>(&v17) || !0x1::vector::is_empty<0x2::object::ID>(&v19)) {
                let v65 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg7);
                if (v65.partial_accept_at == 0) {
                    v65.partial_accept_at = v1;
                };
            };
            0x2::coin::destroy_zero<0x2::sui::SUI>(v29);
        };
    }

    public fun cancel_trade(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
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
            if (0x2::kiosk::is_listed(arg1, v3.item_id)) {
                0x2::kiosk::delist<Trade>(arg1, arg2, v3.item_id);
            };
            if (0x2::dynamic_object_field::exists_<vector<u8>>(&v0.id, 0x2::bcs::to_bytes<0x2::object::ID>(&v3.item_id))) {
                0x2::kiosk::return_purchase_cap<Trade>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<Trade>>(&mut v0.id, 0x2::bcs::to_bytes<0x2::object::ID>(&v3.item_id)));
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

    public entry fun cancel_trade_entry(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        cancel_trade(arg0, arg1, arg2, arg3, 0x1::string::utf8(b"User cancelled"), arg4);
    }

    public entry fun check_expired_trade(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg3), 3);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg3);
        assert!(v0.expiration != 0 && 0x2::tx_context::epoch(arg4) > v0.expiration, 6);
        cancel_trade(arg0, arg1, arg2, arg3, 0x1::string::utf8(b"Trade expired"), arg4);
        let v1 = TradeExpiredEvent{
            trade_id   : arg3,
            creator    : v0.creator,
            expiration : v0.expiration,
        };
        0x2::event::emit<TradeExpiredEvent>(v1);
    }

    public entry fun consolidate_kiosk<T0: store + key>(arg0: &Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::kiosk::has_access(arg1, arg2), 1);
        assert!(0x2::kiosk::has_access(arg3, arg4), 1);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg5), 4);
        if (0x2::kiosk::is_listed(arg1, arg5)) {
            0x2::kiosk::delist<T0>(arg1, arg2, arg5);
        };
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg5, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        0x2::kiosk::lock<T0>(arg3, arg4, arg6, v0);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v1);
    }

    public fun create_trade(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<TradeItem>, arg4: vector<TradeItem>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::kiosk::has_access(arg1, arg2), 1);
        assert!(arg6 == 0 || 0x2::coin::value<0x2::sui::SUI>(arg8) >= arg6, 5);
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0x2::tx_context::epoch(arg9);
        let v3 = 0x2::vec_set::empty<TradeItem>();
        let v4 = 0x2::vec_set::empty<TradeItem>();
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<TradeItem>(&arg3)) {
            let v8 = *0x1::vector::borrow<TradeItem>(&arg3, v7);
            assert!(0x2::kiosk::has_item(arg1, v8.item_id), 4);
            assert!(!0x2::kiosk::is_listed(arg1, v8.item_id), 10);
            0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<Trade>>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v8.item_id), 0x2::kiosk::list_with_purchase_cap<Trade>(arg1, arg2, v8.item_id, 0, arg9));
            0x2::vec_set::insert<TradeItem>(&mut v3, v8);
            0x1::vector::push_back<0x2::object::ID>(&mut v5, v8.item_id);
            0x1::vector::push_back<0x1::string::String>(&mut v6, v8.type_name);
            v7 = v7 + 1;
        };
        let v9 = 0x1::vector::empty<0x2::object::ID>();
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = 0;
        while (v11 < 0x1::vector::length<TradeItem>(&arg4)) {
            let v12 = *0x1::vector::borrow<TradeItem>(&arg4, v11);
            0x2::vec_set::insert<TradeItem>(&mut v4, v12);
            0x1::vector::push_back<0x2::object::ID>(&mut v9, v12.item_id);
            0x1::vector::push_back<0x1::string::String>(&mut v10, v12.type_name);
            v11 = v11 + 1;
        };
        let v13 = if (arg6 > 0) {
            0x2::coin::split<0x2::sui::SUI>(arg8, arg6, arg9)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg9)
        };
        let v14 = v13;
        let v15 = if (arg7 == 0) {
            0
        } else {
            v2 + arg7
        };
        let v16 = Trade{
            id                 : v0,
            creator            : v1,
            creator_items      : v3,
            counterparty_items : v4,
            sui_requested      : arg5,
            sui_offered        : 0x2::coin::value<0x2::sui::SUI>(&v14),
            active             : true,
            created_at         : v2,
            expiration         : v15,
            partial_accept_at  : 0,
        };
        if (arg6 > 0) {
            0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v16.id, b"sui_payment", v14);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v14);
        };
        let v17 = 0x2::object::uid_to_inner(&v16.id);
        0x2::dynamic_object_field::add<0x2::object::ID, Trade>(&mut arg0.id, v17, v16);
        arg0.active_trades = arg0.active_trades + 1;
        let v18 = if (arg7 == 0) {
            0
        } else {
            v2 + arg7
        };
        let v19 = TradeCreatedEvent{
            trade_id           : v17,
            creator            : v1,
            creator_items      : v5,
            creator_types      : v6,
            counterparty_items : v9,
            counterparty_types : v10,
            sui_requested      : arg5,
            sui_offered        : arg6,
            expiration         : v18,
        };
        0x2::event::emit<TradeCreatedEvent>(v19);
        v17
    }

    public entry fun create_trade_entry(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: vector<0x1::string::String>, arg5: vector<0x2::object::ID>, arg6: vector<0x1::string::String>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<TradeItem>();
        let v1 = 0x1::vector::empty<TradeItem>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v3 = TradeItem{
                item_id   : *0x1::vector::borrow<0x2::object::ID>(&arg3, v2),
                type_name : *0x1::vector::borrow<0x1::string::String>(&arg4, v2),
            };
            0x1::vector::push_back<TradeItem>(&mut v0, v3);
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&arg5)) {
            let v5 = TradeItem{
                item_id   : *0x1::vector::borrow<0x2::object::ID>(&arg5, v4),
                type_name : *0x1::vector::borrow<0x1::string::String>(&arg6, v4),
            };
            0x1::vector::push_back<TradeItem>(&mut v1, v5);
            v4 = v4 + 1;
        };
        create_trade(arg0, arg1, arg2, v0, v1, arg7, arg8, arg9, arg10, arg11);
    }

    public fun create_trade_item<T0: store + key>(arg0: 0x2::object::ID) : TradeItem {
        TradeItem{
            item_id   : arg0,
            type_name : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
        }
    }

    public entry fun execute_multi_type_trade<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        if (!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg4)) {
            return
        };
        0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg4);
        if (is_allowed_nft_type<T0>()) {
            accept_trade_improved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        };
    }

    fun execute_purchase_for_type<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg3), 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    public fun get_active_trades(arg0: &Store) : u64 {
        arg0.active_trades
    }

    public fun get_counterparty_items(arg0: &Store, arg1: 0x2::object::ID) : vector<TradeItem> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg1), 3);
        0x2::vec_set::into_keys<TradeItem>(0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1).counterparty_items)
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

    public fun get_total_volume(arg0: &Store) : u64 {
        arg0.total_volume
    }

    public fun get_trade_creator(arg0: &Store, arg1: 0x2::object::ID) : address {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1).creator
    }

    public fun get_trade_types(arg0: &Store, arg1: 0x2::object::ID) : vector<0x1::string::String> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg1), 3);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x2::vec_set::empty<0x1::string::String>();
        let v3 = 0x2::vec_set::into_keys<TradeItem>(v0.creator_items);
        let v4 = 0;
        while (v4 < 0x1::vector::length<TradeItem>(&v3)) {
            let v5 = *0x1::vector::borrow<TradeItem>(&v3, v4);
            if (!0x2::vec_set::contains<0x1::string::String>(&v2, &v5.type_name)) {
                0x2::vec_set::insert<0x1::string::String>(&mut v2, v5.type_name);
                0x1::vector::push_back<0x1::string::String>(&mut v1, v5.type_name);
            };
            v4 = v4 + 1;
        };
        let v6 = 0x2::vec_set::into_keys<TradeItem>(v0.counterparty_items);
        let v7 = 0;
        while (v7 < 0x1::vector::length<TradeItem>(&v6)) {
            let v8 = *0x1::vector::borrow<TradeItem>(&v6, v7);
            if (!0x2::vec_set::contains<0x1::string::String>(&v2, &v8.type_name)) {
                0x2::vec_set::insert<0x1::string::String>(&mut v2, v8.type_name);
                0x1::vector::push_back<0x1::string::String>(&mut v1, v8.type_name);
            };
            v7 = v7 + 1;
        };
        v1
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
            id             : 0x2::object::new(arg1),
            active_trades  : 0,
            total_volume   : 0,
            fee_percentage : 25,
            fee_address    : 0x2::tx_context::sender(arg1),
            version        : v1,
        };
        0x2::transfer::share_object<Store>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<NFT_SWAP>(arg0, arg1);
    }

    fun init_type_registry(arg0: &mut 0x2::tx_context::TxContext) : TypeRegistry {
        TypeRegistry{
            id    : 0x2::object::new(arg0),
            types : 0x1::vector::empty<TypeDispatcher>(),
        }
    }

    public fun is_allowed_nft_type<T0: store + key>() : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x1::ascii::length(&v0) > 0 && *0x1::vector::borrow<u8>(0x1::ascii::as_bytes(&v0), 0) == 48
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

    public entry fun reclaim_failed_trade(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg3), 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg3);
        assert!(!v0.active, 6);
        assert!(v0.creator == 0x2::tx_context::sender(arg4), 1);
        assert!(v0.partial_accept_at > 0, 6);
        assert!(0x2::tx_context::epoch(arg4) > v0.partial_accept_at + 100, 6);
        cancel_trade(arg0, arg1, arg2, 0x2::object::uid_to_inner(&v0.id), 0x1::string::utf8(b"Partial trade reclaim timeout"), arg4);
    }

    public fun register_type<T0: store + key>(arg0: &mut TypeRegistry, arg1: TypeWitness<T0>) {
        let v0 = TypeDispatcher{
            type_name        : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
            witness_function : 0x2::bcs::to_bytes<TypeWitness<T0>>(&arg1),
        };
        0x1::vector::push_back<TypeDispatcher>(&mut arg0.types, v0);
    }

    public fun trade_contains_type<T0: store + key>(arg0: &Store, arg1: 0x2::object::ID) : bool {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg1), 3);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg1);
        let v1 = is_allowed_nft_type<T0>();
        let v2 = 0x2::vec_set::into_keys<TradeItem>(v0.creator_items);
        let v3 = 0;
        while (v3 < 0x1::vector::length<TradeItem>(&v2)) {
            if (v1) {
                return true
            };
            v3 = v3 + 1;
        };
        let v4 = 0x2::vec_set::into_keys<TradeItem>(v0.counterparty_items);
        let v5 = 0;
        while (v5 < 0x1::vector::length<TradeItem>(&v4)) {
            if (v1) {
                return true
            };
            v5 = v5 + 1;
        };
        false
    }

    public fun trade_exists(arg0: &Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg1)
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

