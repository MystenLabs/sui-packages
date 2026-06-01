module 0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::kiosk_adapter_v2 {
    struct KioskRegistry has key {
        id: 0x2::object::UID,
        active_offers: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct KioskSwapOffer has store, key {
        id: 0x2::object::UID,
        maker: address,
        taker: 0x1::option::Option<address>,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        requested_nft_type: 0x1::type_name::TypeName,
        maker_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        taker_sui_required: u64,
        expiration_ms: u64,
        state: u8,
    }

    struct ItemKioskSwapOffer has store, key {
        id: 0x2::object::UID,
        maker: address,
        taker: 0x1::option::Option<address>,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        requested_nft_type: 0x1::type_name::TypeName,
        maker_receive_kiosk_id: 0x2::object::ID,
        sweetener_coin_type: 0x1::type_name::TypeName,
        taker_coin_required: u64,
        expiration_ms: u64,
        state: u8,
        requested_delivered: bool,
        offered_claimed: bool,
    }

    struct OfferedCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OfferedPurchaseCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MakerReceiveCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ItemMakerCoinKey has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    struct KioskOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: 0x1::option::Option<address>,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        requested_nft_type: 0x1::type_name::TypeName,
        taker_sui_required: u64,
        expiration_ms: u64,
    }

    struct KioskSwapExecuted has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: address,
        fees_paid: u64,
    }

    struct KioskOfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        state: u8,
    }

    struct ItemKioskOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: 0x1::option::Option<address>,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        requested_nft_type: 0x1::type_name::TypeName,
        maker_receive_kiosk_id: 0x2::object::ID,
        sweetener_coin_type: 0x1::type_name::TypeName,
        taker_coin_required: u64,
        expiration_ms: u64,
    }

    struct ItemKioskRequestedDelivered has copy, drop {
        offer_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        maker_receive_kiosk_id: 0x2::object::ID,
    }

    struct ItemKioskOfferedClaimed has copy, drop {
        offer_id: 0x2::object::ID,
        offered_nft_id: 0x2::object::ID,
        taker: address,
    }

    public fun admin_cancel_offer(arg0: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::AdminCap, arg1: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg2: &mut KioskRegistry, arg3: KioskSwapOffer, arg4: &mut 0x2::tx_context::TxContext) {
        0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::assert_admin(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        cancel_internal(arg2, arg3, 4, v0, arg4);
    }

    fun assert_item_taker_allowed(arg0: &ItemKioskSwapOffer, arg1: address) {
        if (0x1::option::is_some<address>(&arg0.taker)) {
            assert!(arg1 == *0x1::option::borrow<address>(&arg0.taker), 1);
        };
    }

    fun assert_taker_allowed(arg0: &KioskSwapOffer, arg1: address) {
        if (0x1::option::is_some<address>(&arg0.taker)) {
            assert!(arg1 == *0x1::option::borrow<address>(&arg0.taker), 1);
        };
    }

    fun cancel_internal(arg0: &mut KioskRegistry, arg1: KioskSwapOffer, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 1, 4);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, arg1.offered_nft_id);
        let KioskSwapOffer {
            id                 : v0,
            maker              : v1,
            taker              : _,
            offered_nft_id     : _,
            requested_nft_id   : _,
            requested_nft_type : _,
            maker_sui          : v6,
            taker_sui_required : _,
            expiration_ms      : _,
            state              : _,
        } = arg1;
        let v10 = v6;
        let v11 = v0;
        let v12 = OfferedCapKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<OfferedCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v11, v12), v1);
        if (0x2::balance::value<0x2::sui::SUI>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v10, arg4), v1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
        };
        let v13 = KioskOfferCancelled{
            offer_id : 0x2::object::uid_to_inner(&v11),
            maker    : arg3,
            state    : arg2,
        };
        0x2::event::emit<KioskOfferCancelled>(v13);
        0x2::object::delete(v11);
    }

    public fun cancel_item_offer<T0: store + key, T1>(arg0: &mut KioskRegistry, arg1: ItemKioskSwapOffer, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.maker, 1);
        assert!(arg1.state == 1, 4);
        assert!(!arg1.requested_delivered, 11);
        assert!(!arg1.offered_claimed, 13);
        assert!(0x1::type_name::with_defining_ids<T1>() == arg1.sweetener_coin_type, 8);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, arg1.offered_nft_id);
        let ItemKioskSwapOffer {
            id                     : v1,
            maker                  : v2,
            taker                  : _,
            offered_nft_id         : _,
            requested_nft_id       : _,
            requested_nft_type     : _,
            maker_receive_kiosk_id : _,
            sweetener_coin_type    : v8,
            taker_coin_required    : _,
            expiration_ms          : _,
            state                  : _,
            requested_delivered    : _,
            offered_claimed        : _,
        } = arg1;
        let v14 = v1;
        let v15 = OfferedPurchaseCapKey{dummy_field: false};
        0x2::kiosk::return_purchase_cap<T0>(arg2, 0x2::dynamic_object_field::remove<OfferedPurchaseCapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut v14, v15));
        let v16 = MakerReceiveCapKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<MakerReceiveCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v14, v16), v2);
        let v17 = ItemMakerCoinKey{coin_type: v8};
        let v18 = 0x2::dynamic_field::remove<ItemMakerCoinKey, 0x2::balance::Balance<T1>>(&mut v14, v17);
        if (0x2::balance::value<T1>(&v18) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v18, arg3), v2);
        } else {
            0x2::balance::destroy_zero<T1>(v18);
        };
        let v19 = KioskOfferCancelled{
            offer_id : 0x2::object::uid_to_inner(&v14),
            maker    : v0,
            state    : 3,
        };
        0x2::event::emit<KioskOfferCancelled>(v19);
        0x2::object::delete(v14);
    }

    public fun cancel_offer(arg0: &mut KioskRegistry, arg1: KioskSwapOffer, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.maker, 1);
        cancel_internal(arg0, arg1, 3, v0, arg2);
    }

    public fun claim_offered_item<T0: store + key>(arg0: &mut ItemKioskSwapOffer, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_item_taker_allowed(arg0, v0);
        assert!(!0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::is_paused(arg4), 10);
        assert!(arg0.state == 1, 4);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.expiration_ms, 2);
        assert!(arg0.requested_delivered, 12);
        assert!(!arg0.offered_claimed, 13);
        let v1 = OfferedPurchaseCapKey{dummy_field: false};
        let (v2, v3) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::dynamic_object_field::remove<OfferedPurchaseCapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, v1), arg2);
        let v4 = v2;
        assert!(0x2::object::id<T0>(&v4) == arg0.offered_nft_id, 6);
        arg0.offered_claimed = true;
        let v5 = ItemKioskOfferedClaimed{
            offer_id       : 0x2::object::id<ItemKioskSwapOffer>(arg0),
            offered_nft_id : arg0.offered_nft_id,
            taker          : v0,
        };
        0x2::event::emit<ItemKioskOfferedClaimed>(v5);
        (v4, v3)
    }

    fun consolidate_coin<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0)));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    fun consolidate_sui(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::coin::into_balance<0x2::sui::SUI>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0)));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        v0
    }

    public fun create_item_offer<T0: store + key, T1, T2>(arg0: &mut KioskRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: 0x1::option::Option<address>, arg7: vector<0x2::coin::Coin<T2>>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::is_paused(arg10), 10);
        assert!(arg8 >= 300000 && arg8 <= 31536000000, 3);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg3), 6);
        assert!(0x2::kiosk::has_access(arg1, arg2), 7);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.active_offers, arg3), 9);
        let (v0, v1) = 0x2::kiosk::new(arg11);
        let v2 = v0;
        let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(&v2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.active_offers, arg3, true);
        let v4 = 0x2::object::new(arg11);
        let v5 = 0x2::tx_context::sender(arg11);
        let v6 = 0x2::clock::timestamp_ms(arg9) + arg8;
        let v7 = 0x1::type_name::with_defining_ids<T1>();
        let v8 = 0x1::type_name::with_defining_ids<T2>();
        let v9 = OfferedPurchaseCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<OfferedPurchaseCapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut v4, v9, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg11));
        let v10 = MakerReceiveCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<MakerReceiveCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v4, v10, v1);
        let v11 = ItemMakerCoinKey{coin_type: v8};
        0x2::dynamic_field::add<ItemMakerCoinKey, 0x2::balance::Balance<T2>>(&mut v4, v11, consolidate_coin<T2>(arg7));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        let v12 = ItemKioskOfferCreated{
            offer_id               : 0x2::object::uid_to_inner(&v4),
            maker                  : v5,
            taker                  : arg6,
            offered_nft_id         : arg3,
            requested_nft_id       : arg4,
            requested_nft_type     : v7,
            maker_receive_kiosk_id : v3,
            sweetener_coin_type    : v8,
            taker_coin_required    : arg5,
            expiration_ms          : v6,
        };
        0x2::event::emit<ItemKioskOfferCreated>(v12);
        let v13 = ItemKioskSwapOffer{
            id                     : v4,
            maker                  : v5,
            taker                  : arg6,
            offered_nft_id         : arg3,
            requested_nft_id       : arg4,
            requested_nft_type     : v7,
            maker_receive_kiosk_id : v3,
            sweetener_coin_type    : v8,
            taker_coin_required    : arg5,
            expiration_ms          : v6,
            state                  : 1,
            requested_delivered    : false,
            offered_claimed        : false,
        };
        0x2::transfer::share_object<ItemKioskSwapOffer>(v13);
    }

    public fun create_offer<T0>(arg0: &mut KioskRegistry, arg1: 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: 0x1::option::Option<address>, arg7: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::is_paused(arg10), 10);
        assert!(arg8 >= 300000 && arg8 <= 31536000000, 3);
        assert!(0x2::kiosk::has_item(&arg1, arg3), 6);
        assert!(0x2::kiosk::has_access(&mut arg1, &arg2), 7);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.active_offers, arg3), 9);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.active_offers, arg3, true);
        let v0 = 0x2::object::new(arg11);
        let v1 = 0x2::tx_context::sender(arg11);
        let v2 = 0x2::clock::timestamp_ms(arg9) + arg8;
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        let v4 = OfferedCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<OfferedCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v0, v4, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg1);
        let v5 = KioskOfferCreated{
            offer_id           : 0x2::object::uid_to_inner(&v0),
            maker              : v1,
            taker              : arg6,
            offered_nft_id     : arg3,
            requested_nft_id   : arg4,
            requested_nft_type : v3,
            taker_sui_required : arg5,
            expiration_ms      : v2,
        };
        0x2::event::emit<KioskOfferCreated>(v5);
        let v6 = KioskSwapOffer{
            id                 : v0,
            maker              : v1,
            taker              : arg6,
            offered_nft_id     : arg3,
            requested_nft_id   : arg4,
            requested_nft_type : v3,
            maker_sui          : consolidate_sui(arg7),
            taker_sui_required : arg5,
            expiration_ms      : v2,
            state              : 1,
        };
        0x2::transfer::share_object<KioskSwapOffer>(v6);
    }

    public fun create_registry(arg0: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::AdminCap, arg1: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::assert_admin(arg0, arg1);
        let v0 = KioskRegistry{
            id            : 0x2::object::new(arg2),
            active_offers : 0x2::table::new<0x2::object::ID, bool>(arg2),
        };
        0x2::transfer::share_object<KioskRegistry>(v0);
    }

    public fun deliver_requested_item<T0: store + key>(arg0: &mut ItemKioskSwapOffer, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0, arg3: 0x2::transfer_policy::TransferRequest<T0>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x2::clock::Clock, arg6: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert_item_taker_allowed(arg0, 0x2::tx_context::sender(arg7));
        assert!(!0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::is_paused(arg6), 10);
        assert!(arg0.state == 1, 4);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg0.expiration_ms, 2);
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.requested_nft_type, 8);
        assert!(!arg0.requested_delivered, 11);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.maker_receive_kiosk_id, 7);
        assert!(0x2::object::id<T0>(&arg2) == arg0.requested_nft_id, 6);
        assert!(0x2::transfer_policy::item<T0>(&arg3) == arg0.requested_nft_id, 6);
        let v0 = MakerReceiveCapKey{dummy_field: false};
        0x2::kiosk::lock<T0>(arg1, 0x2::dynamic_object_field::borrow<MakerReceiveCapKey, 0x2::kiosk::KioskOwnerCap>(&arg0.id, v0), arg4, arg2);
        arg0.requested_delivered = true;
        let v1 = ItemKioskRequestedDelivered{
            offer_id               : 0x2::object::id<ItemKioskSwapOffer>(arg0),
            requested_nft_id       : arg0.requested_nft_id,
            maker_receive_kiosk_id : arg0.maker_receive_kiosk_id,
        };
        0x2::event::emit<ItemKioskRequestedDelivered>(v1);
        arg3
    }

    public fun execute_swap<T0: store + key>(arg0: &mut KioskRegistry, arg1: KioskSwapOffer, arg2: 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert_taker_allowed(&arg1, v0);
        assert!(arg1.state == 1, 4);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg1.expiration_ms, 2);
        assert!(0x1::type_name::with_defining_ids<T0>() == arg1.requested_nft_type, 8);
        assert!(0x2::kiosk::has_item(&arg2, arg1.requested_nft_id), 6);
        assert!(0x2::kiosk::has_access(&mut arg2, &arg3), 7);
        let v1 = 0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::get_flat_fee<0x2::sui::SUI>(arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg1.taker_sui_required + v1, 5);
        if (v1 > 0) {
            0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::collect_fee<0x2::sui::SUI>(arg5, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1, arg7));
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, arg1.offered_nft_id);
        let KioskSwapOffer {
            id                 : v2,
            maker              : v3,
            taker              : _,
            offered_nft_id     : _,
            requested_nft_id   : _,
            requested_nft_type : _,
            maker_sui          : v8,
            taker_sui_required : v9,
            expiration_ms      : _,
            state              : _,
        } = arg1;
        let v12 = v8;
        let v13 = v2;
        let v14 = OfferedCapKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<OfferedCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v13, v14), v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg3, v3);
        if (0x2::balance::value<0x2::sui::SUI>(&v12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v12, arg7), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        };
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v9, arg7), v3);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg2);
        let v15 = KioskSwapExecuted{
            offer_id  : 0x2::object::uid_to_inner(&v13),
            maker     : v3,
            taker     : v0,
            fees_paid : v1,
        };
        0x2::event::emit<KioskSwapExecuted>(v15);
        0x2::object::delete(v13);
    }

    public fun finalize_item_offer<T0>(arg0: &mut KioskRegistry, arg1: ItemKioskSwapOffer, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_item_taker_allowed(&arg1, v0);
        assert!(arg1.state == 1, 4);
        assert!(arg1.requested_delivered, 12);
        assert!(arg1.offered_claimed, 12);
        assert!(0x1::type_name::with_defining_ids<T0>() == arg1.sweetener_coin_type, 8);
        let v1 = 0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::get_flat_fee<T0>(arg3);
        assert!(0x2::coin::value<T0>(&arg2) >= arg1.taker_coin_required + v1, 5);
        if (v1 > 0) {
            0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::collect_fee<T0>(arg3, 0x2::coin::split<T0>(&mut arg2, v1, arg4));
        };
        if (arg1.taker_coin_required > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, arg1.taker_coin_required, arg4), arg1.maker);
        };
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, arg1.offered_nft_id);
        let ItemKioskSwapOffer {
            id                     : v2,
            maker                  : v3,
            taker                  : _,
            offered_nft_id         : _,
            requested_nft_id       : _,
            requested_nft_type     : _,
            maker_receive_kiosk_id : _,
            sweetener_coin_type    : v9,
            taker_coin_required    : _,
            expiration_ms          : _,
            state                  : _,
            requested_delivered    : _,
            offered_claimed        : _,
        } = arg1;
        let v15 = v2;
        let v16 = MakerReceiveCapKey{dummy_field: false};
        let v17 = ItemMakerCoinKey{coin_type: v9};
        let v18 = 0x2::dynamic_field::remove<ItemMakerCoinKey, 0x2::balance::Balance<T0>>(&mut v15, v17);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<MakerReceiveCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v15, v16), v3);
        if (0x2::balance::value<T0>(&v18) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg4), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v18);
        };
        let v19 = KioskSwapExecuted{
            offer_id  : 0x2::object::uid_to_inner(&v15),
            maker     : v3,
            taker     : v0,
            fees_paid : v1,
        };
        0x2::event::emit<KioskSwapExecuted>(v19);
        0x2::object::delete(v15);
    }

    // decompiled from Move bytecode v7
}

