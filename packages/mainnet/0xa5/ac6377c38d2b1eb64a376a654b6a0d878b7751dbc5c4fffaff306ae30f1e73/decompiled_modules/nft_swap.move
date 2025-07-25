module 0xa5ac6377c38d2b1eb64a376a654b6a0d878b7751dbc5c4fffaff306ae30f1e73::nft_swap {
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
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = 0x1::vector::empty<0x2::object::ID>();
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = 0x2::vec_set::into_keys<TradeItem>(v0.creator_items);
        let v16 = 0;
        while (v16 < 0x1::vector::length<TradeItem>(&v15)) {
            let v17 = *0x1::vector::borrow<TradeItem>(&v15, v16);
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v17.item_id);
            0x1::vector::push_back<0x1::string::String>(&mut v12, v17.type_name);
            v16 = v16 + 1;
        };
        let v18 = 0x2::vec_set::into_keys<TradeItem>(v0.counterparty_items);
        let v19 = 0;
        while (v19 < 0x1::vector::length<TradeItem>(&v18)) {
            let v20 = *0x1::vector::borrow<TradeItem>(&v18, v19);
            0x1::vector::push_back<0x2::object::ID>(&mut v13, v20.item_id);
            0x1::vector::push_back<0x1::string::String>(&mut v14, v20.type_name);
            v19 = v19 + 1;
        };
        v0.active = false;
        if (v0.partial_accept_at == 0) {
            v0.partial_accept_at = 0x2::tx_context::epoch(arg7);
        };
        let v21 = 0x2::tx_context::sender(arg7);
        let v22 = if (v9 > 0) {
            let v23 = v9 * arg0.fee_percentage / 10000;
            if (v23 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, v23, arg7), arg0.fee_address);
                v23
            } else {
                0
            }
        } else {
            0
        };
        if (v9 > 0) {
            let v24 = v9 - v22;
            if (v24 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, v24, arg7), v8);
            };
        };
        let v25 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        let v26 = if (v10 > 0) {
            0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v25.id, b"sui_payment")
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg7)
        };
        let v27 = 0;
        while (v27 < 0x1::vector::length<0x2::object::ID>(&v13)) {
            let v28 = *0x1::vector::borrow<0x2::object::ID>(&v13, v27);
            if (0x2::kiosk::is_listed(arg2, v28)) {
                0x2::kiosk::delist<T0>(arg2, arg3, v28);
            };
            let (v29, v30) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, v28, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
            let v31 = v30;
            0x2::kiosk::lock<T0>(&mut v7, &v6, arg6, v29);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v31, &v7);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v31, 0x2::coin::split<0x2::sui::SUI>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, 0x2::transfer_policy::paid<T0>(&v31)), arg7));
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v31);
            v27 = v27 + 1;
        };
        let v35 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Trade>(&mut arg0.id, arg4);
        let v36 = 0;
        while (v36 < 0x1::vector::length<0x2::object::ID>(&v11)) {
            let v37 = *0x1::vector::borrow<0x2::object::ID>(&v11, v36);
            let v38 = 0x2::bcs::to_bytes<0x2::object::ID>(&v37);
            if (0x2::dynamic_object_field::exists_<vector<u8>>(&v35.id, v38)) {
                let (v39, v40) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v35.id, v38), 0x2::coin::zero<0x2::sui::SUI>(arg7));
                let v41 = v40;
                0x2::kiosk::lock<T0>(arg2, arg3, arg6, v39);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v41, arg2);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v41, 0x2::coin::split<0x2::sui::SUI>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, 0x2::transfer_policy::paid<T0>(&v41)), arg7));
                let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v41);
            };
            v36 = v36 + 1;
        };
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v26, v21);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v26);
        };
        arg0.active_trades = arg0.active_trades - 1;
        arg0.total_volume = arg0.total_volume + v9 + v10;
        let v45 = TradeAcceptedEvent{
            trade_id           : arg4,
            creator            : v8,
            counterparty       : v21,
            creator_items      : v11,
            creator_types      : v12,
            counterparty_items : v13,
            counterparty_types : v14,
            sui_requested      : v9,
            sui_offered        : v10,
            platform_fee       : v22,
        };
        0x2::event::emit<TradeAcceptedEvent>(v45);
        let Trade {
            id                 : v46,
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
        0x2::object::delete(v46);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v7);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, v8);
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
            if (0x2::kiosk::is_listed(arg1, v3.item_id)) {
                0x2::kiosk::delist<T0>(arg1, arg2, v3.item_id);
            };
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

    public entry fun check_expired_trade<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_compatible_version(arg0), 13);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Trade>(&arg0.id, arg3), 3);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Trade>(&arg0.id, arg3);
        assert!(v0.expiration != 0 && 0x2::tx_context::epoch(arg4) > v0.expiration, 6);
        cancel_trade<T0>(arg0, arg1, arg2, arg3, 0x1::string::utf8(b"Trade expired"), arg4);
        let v1 = TradeExpiredEvent{
            trade_id   : arg3,
            creator    : v0.creator,
            expiration : v0.expiration,
        };
        0x2::event::emit<TradeExpiredEvent>(v1);
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

    public fun create_trade<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<TradeItem>, arg4: vector<TradeItem>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
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
            0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v8.item_id), 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, v8.item_id, 0, arg9));
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

    public entry fun create_trade_entry<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: vector<0x1::string::String>, arg5: vector<0x2::object::ID>, arg6: vector<0x1::string::String>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
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
        create_trade<T0>(arg0, arg1, arg2, v0, v1, arg7, arg8, arg9, arg10, arg11)
    }

    public fun create_trade_item<T0: store + key>(arg0: 0x2::object::ID) : TradeItem {
        TradeItem{
            item_id   : arg0,
            type_name : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
        }
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

