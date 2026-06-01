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

    struct OfferedCapKey has copy, drop, store {
        dummy_field: bool,
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

    public fun admin_cancel_offer(arg0: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::AdminCap, arg1: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg2: &mut KioskRegistry, arg3: KioskSwapOffer, arg4: &mut 0x2::tx_context::TxContext) {
        0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::assert_admin(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        cancel_internal(arg2, arg3, 4, v0, arg4);
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

    public fun cancel_offer(arg0: &mut KioskRegistry, arg1: KioskSwapOffer, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.maker, 1);
        cancel_internal(arg0, arg1, 3, v0, arg2);
    }

    fun consolidate_sui(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::coin::into_balance<0x2::sui::SUI>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0)));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        v0
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

    // decompiled from Move bytecode v7
}

