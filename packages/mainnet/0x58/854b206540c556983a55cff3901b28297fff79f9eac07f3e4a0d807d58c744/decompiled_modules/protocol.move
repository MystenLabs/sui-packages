module 0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::protocol {
    struct SwapOffer has store, key {
        id: 0x2::object::UID,
        maker: address,
        taker: 0x1::option::Option<address>,
        requested_nft_ids: vector<0x2::object::ID>,
        requested_type: 0x1::type_name::TypeName,
        maker_sui: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        taker_sui_required: u64,
        expiration_ms: u64,
        offered_count: u64,
        offered_type: 0x1::type_name::TypeName,
    }

    struct OfferedNftKey has copy, drop, store {
        index: u64,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        requested_ids: vector<0x2::object::ID>,
    }

    struct SwapExecuted has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: address,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
    }

    struct OfferDenied has copy, drop {
        offer_id: 0x2::object::ID,
        denier: address,
    }

    struct AdminRecovered has copy, drop {
        offer_id: 0x2::object::ID,
        recipient: address,
    }

    public fun admin_recover_assets<T0: store + key>(arg0: &0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::AdminCap, arg1: &0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::PlatformConfig, arg2: SwapOffer, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::is_admin(arg1, arg0), 1);
        assert!(0x1::type_name::get<T0>() == arg2.offered_type, 7);
        let SwapOffer {
            id                 : v0,
            maker              : _,
            taker              : _,
            requested_nft_ids  : _,
            requested_type     : _,
            maker_sui          : v5,
            taker_sui_required : _,
            expiration_ms      : _,
            offered_count      : v8,
            offered_type       : _,
        } = arg2;
        let v10 = v5;
        let v11 = v0;
        let v12 = 0;
        while (v12 < v8) {
            let v13 = OfferedNftKey{index: v12};
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v11, v13), arg3);
            v12 = v12 + 1;
        };
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v10)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v10), arg3);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v10);
        };
        let v14 = AdminRecovered{
            offer_id  : 0x2::object::uid_to_inner(&v11),
            recipient : arg3,
        };
        0x2::event::emit<AdminRecovered>(v14);
        0x2::object::delete(v11);
    }

    public fun cancel_offer<T0: store + key>(arg0: SwapOffer, arg1: &0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::PlatformConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::check_paused(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 1);
        return_to_maker_internal<T0>(arg0, arg2);
    }

    public fun cleanup_expired<T0: store + key>(arg0: SwapOffer, arg1: &0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::PlatformConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::check_paused(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.expiration_ms, 8);
        return_to_maker_internal<T0>(arg0, arg3);
    }

    public fun create_offer<T0: store + key, T1: store + key>(arg0: vector<T0>, arg1: vector<0x2::object::ID>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: u64, arg6: &0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::PlatformConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::check_paused(arg6);
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg1), 6);
        assert!(arg5 >= 300000 && arg5 <= 31536000000, 5);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::new(arg8);
        let v2 = if (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) {
            let v3 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4);
            while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) {
                0x2::coin::join<0x2::sui::SUI>(&mut v3, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4));
            };
            0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
            if (0x2::coin::value<0x2::sui::SUI>(&v3) > 0) {
                0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v3)
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
                0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
            }
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        let v4 = 0x1::vector::length<T0>(&arg0);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = OfferedNftKey{index: v5};
            0x2::dynamic_object_field::add<OfferedNftKey, T0>(&mut v1, v6, 0x1::vector::pop_back<T0>(&mut arg0));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
        let v7 = SwapOffer{
            id                 : v1,
            maker              : v0,
            taker              : arg3,
            requested_nft_ids  : arg1,
            requested_type     : 0x1::type_name::get<T1>(),
            maker_sui          : v2,
            taker_sui_required : arg2,
            expiration_ms      : 0x2::clock::timestamp_ms(arg7) + arg5,
            offered_count      : v4,
            offered_type       : 0x1::type_name::get<T0>(),
        };
        let v8 = OfferCreated{
            offer_id      : 0x2::object::uid_to_inner(&v1),
            maker         : v0,
            requested_ids : arg1,
        };
        0x2::event::emit<OfferCreated>(v8);
        0x2::transfer::share_object<SwapOffer>(v7);
    }

    public fun deny_offer<T0: store + key>(arg0: SwapOffer, arg1: &0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::PlatformConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::check_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::option::is_some<address>(&arg0.taker) && *0x1::option::borrow<address>(&arg0.taker) == v0, 1);
        let v1 = OfferDenied{
            offer_id : 0x2::object::id<SwapOffer>(&arg0),
            denier   : v0,
        };
        0x2::event::emit<OfferDenied>(v1);
        return_to_maker_internal<T0>(arg0, arg2);
    }

    public fun execute_swap_with_kiosk<T0: store + key, T1: store + key>(arg0: SwapOffer, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::PlatformConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<0x2::kiosk::PurchaseCap<T1>> {
        0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::check_paused(arg4);
        assert!(0x1::type_name::get<T0>() == arg0.offered_type, 7);
        assert!(0x1::type_name::get<T1>() == arg0.requested_type, 7);
        let v0 = 0x2::tx_context::sender(arg6);
        let SwapOffer {
            id                 : v1,
            maker              : v2,
            taker              : v3,
            requested_nft_ids  : v4,
            requested_type     : _,
            maker_sui          : v6,
            taker_sui_required : v7,
            expiration_ms      : v8,
            offered_count      : v9,
            offered_type       : _,
        } = arg0;
        let v11 = v6;
        let v12 = v4;
        let v13 = v3;
        if (0x1::option::is_some<address>(&v13)) {
            assert!(v0 == *0x1::option::borrow<address>(&v13), 1);
        };
        assert!(0x2::clock::timestamp_ms(arg5) <= v8, 3);
        let v14 = 0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::get_flat_fee(arg4, 0x1::type_name::get<T1>());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v7 + v14, 4);
        if (v14 > 0) {
            0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager::collect_fee(arg4, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v14, arg6));
        };
        let v15 = 0;
        let v16 = v1;
        while (v15 < v9) {
            let v17 = OfferedNftKey{index: v15};
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v16, v17), v0);
            v15 = v15 + 1;
        };
        let v18 = 0x1::vector::empty<0x2::kiosk::PurchaseCap<T1>>();
        let v19 = 0;
        while (v19 < 0x1::vector::length<0x2::object::ID>(&v12)) {
            0x1::vector::push_back<0x2::kiosk::PurchaseCap<T1>>(&mut v18, 0x2::kiosk::list_with_purchase_cap<T1>(arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(&v12, v19), 0, arg6));
            v19 = v19 + 1;
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v7, arg6), v2);
        };
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v11)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v11), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v11);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v20 = SwapExecuted{
            offer_id : 0x2::object::uid_to_inner(&v16),
            maker    : v2,
            taker    : v0,
        };
        0x2::event::emit<SwapExecuted>(v20);
        0x2::object::delete(v16);
        v18
    }

    fun return_to_maker_internal<T0: store + key>(arg0: SwapOffer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg0.offered_type, 7);
        let SwapOffer {
            id                 : v0,
            maker              : v1,
            taker              : _,
            requested_nft_ids  : _,
            requested_type     : _,
            maker_sui          : v5,
            taker_sui_required : _,
            expiration_ms      : _,
            offered_count      : v8,
            offered_type       : _,
        } = arg0;
        let v10 = v5;
        let v11 = v0;
        let v12 = 0;
        while (v12 < v8) {
            let v13 = OfferedNftKey{index: v12};
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v11, v13), v1);
            v12 = v12 + 1;
        };
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v10)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v10), v1);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v10);
        };
        let v14 = OfferCancelled{offer_id: 0x2::object::uid_to_inner(&v11)};
        0x2::event::emit<OfferCancelled>(v14);
        0x2::object::delete(v11);
    }

    // decompiled from Move bytecode v6
}

