module 0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::protocol {
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

    struct OfferReturnedToMaker has copy, drop {
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

    public fun admin_recover_assets<T0: store + key>(arg0: &0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::AdminCap, arg1: &0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::PlatformConfig, arg2: SwapOffer, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::check_paused(arg1);
        assert!(0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::is_admin(arg1, arg0), 1);
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

    public fun cancel_offer<T0: store + key>(arg0: SwapOffer, arg1: &0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::PlatformConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::check_paused(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 1);
        return_to_maker_internal<T0>(arg0, arg2);
    }

    fun check_unique(arg0: &vector<0x2::object::ID>) {
        let v0 = 0x1::vector::length<0x2::object::ID>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<0x2::object::ID>(arg0, v1) != *0x1::vector::borrow<0x2::object::ID>(arg0, v2), 9);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun cleanup_expired<T0: store + key>(arg0: SwapOffer, arg1: &0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::PlatformConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::check_paused(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.expiration_ms, 8);
        return_to_maker_internal<T0>(arg0, arg3);
    }

    public fun create_offer<T0: store + key, T1: store + key>(arg0: vector<T0>, arg1: vector<0x2::object::ID>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: u64, arg6: &0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::PlatformConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::check_paused(arg6);
        let v0 = 0x1::vector::length<T0>(&arg0);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg1);
        assert!(v0 > 0 && v1 > 0, 6);
        assert!(v0 <= 50 && v1 <= 50, 11);
        assert!(arg2 <= 500000000000, 12);
        assert!(arg5 >= 300000 && arg5 <= 31536000000, 5);
        check_unique(&arg1);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = 0x2::object::new(arg8);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = OfferedNftKey{index: v4};
            0x2::dynamic_object_field::add<OfferedNftKey, T0>(&mut v3, v5, 0x1::vector::pop_back<T0>(&mut arg0));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
        let v6 = SwapOffer{
            id                 : v3,
            maker              : v2,
            taker              : arg3,
            requested_nft_ids  : arg1,
            requested_type     : 0x1::type_name::get<T1>(),
            maker_sui          : handle_maker_sui(arg4),
            taker_sui_required : arg2,
            expiration_ms      : 0x2::clock::timestamp_ms(arg7) + arg5,
            offered_count      : v0,
            offered_type       : 0x1::type_name::get<T0>(),
        };
        let v7 = OfferCreated{
            offer_id      : 0x2::object::uid_to_inner(&v3),
            maker         : v2,
            requested_ids : arg1,
        };
        0x2::event::emit<OfferCreated>(v7);
        0x2::transfer::share_object<SwapOffer>(v6);
    }

    public fun create_offer_from_kiosk<T0: store + key, T1: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: vector<0x2::object::ID>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg7: u64, arg8: &0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::PlatformConfig, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::check_paused(arg8);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg2);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg3);
        assert!(v0 > 0 && v1 > 0, 6);
        assert!(v0 <= 50 && v1 <= 50, 11);
        assert!(arg4 <= 500000000000, 12);
        assert!(arg7 >= 300000 && arg7 <= 31536000000, 5);
        check_unique(&arg2);
        check_unique(&arg3);
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = 0x2::object::new(arg10);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = OfferedNftKey{index: v4};
            0x2::dynamic_object_field::add<OfferedNftKey, T0>(&mut v3, v5, 0x2::kiosk::take<T0>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&arg2, v4)));
            v4 = v4 + 1;
        };
        let v6 = SwapOffer{
            id                 : v3,
            maker              : v2,
            taker              : arg5,
            requested_nft_ids  : arg3,
            requested_type     : 0x1::type_name::get<T1>(),
            maker_sui          : handle_maker_sui(arg6),
            taker_sui_required : arg4,
            expiration_ms      : 0x2::clock::timestamp_ms(arg9) + arg7,
            offered_count      : v0,
            offered_type       : 0x1::type_name::get<T0>(),
        };
        let v7 = OfferCreated{
            offer_id      : 0x2::object::uid_to_inner(&v3),
            maker         : v2,
            requested_ids : arg3,
        };
        0x2::event::emit<OfferCreated>(v7);
        0x2::transfer::share_object<SwapOffer>(v6);
    }

    public fun deny_offer<T0: store + key>(arg0: SwapOffer, arg1: &0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::PlatformConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::check_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::option::is_some<address>(&arg0.taker) && *0x1::option::borrow<address>(&arg0.taker) == v0, 1);
        let v1 = OfferDenied{
            offer_id : 0x2::object::id<SwapOffer>(&arg0),
            denier   : v0,
        };
        0x2::event::emit<OfferDenied>(v1);
        return_to_maker_internal<T0>(arg0, arg2);
    }

    public fun execute_swap<T0: store + key, T1: store + key>(arg0: SwapOffer, arg1: vector<T1>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::PlatformConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::check_paused(arg3);
        assert!(0x1::type_name::get<T0>() == arg0.offered_type && 0x1::type_name::get<T1>() == arg0.requested_type, 7);
        assert!(0x1::vector::length<T1>(&arg1) == 0x1::vector::length<0x2::object::ID>(&arg0.requested_nft_ids), 6);
        let v0 = 0x2::tx_context::sender(arg5);
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
        let v11 = v4;
        let v12 = v3;
        if (0x1::option::is_some<address>(&v12)) {
            assert!(v0 == *0x1::option::borrow<address>(&v12), 1);
        };
        assert!(0x2::clock::timestamp_ms(arg4) <= v8, 3);
        let v13 = 0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::get_flat_fee(arg3, 0x1::type_name::get<T1>());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v7 + v13, 4);
        if (v13 > 0) {
            0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::collect_fee(arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v13, arg5));
        };
        let v14 = 0;
        let v15 = v1;
        while (v14 < v9) {
            let v16 = OfferedNftKey{index: v14};
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v15, v16), v0);
            v14 = v14 + 1;
        };
        while (!0x1::vector::is_empty<T1>(&arg1)) {
            let v17 = 0x1::vector::pop_back<T1>(&mut arg1);
            let v18 = 0x2::object::id<T1>(&v17);
            assert!(0x1::vector::contains<0x2::object::ID>(&v11, &v18), 10);
            0x2::transfer::public_transfer<T1>(v17, v2);
        };
        0x1::vector::destroy_empty<T1>(arg1);
        finalize_settlement(v15, v2, v0, arg2, v7, v6, arg5);
    }

    public fun execute_swap_with_kiosk<T0: store + key, T1: store + key>(arg0: SwapOffer, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::PlatformConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::check_paused(arg4);
        assert!(0x1::type_name::get<T0>() == arg0.offered_type && 0x1::type_name::get<T1>() == arg0.requested_type, 7);
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
        let v11 = v4;
        let v12 = v3;
        if (0x1::option::is_some<address>(&v12)) {
            assert!(v0 == *0x1::option::borrow<address>(&v12), 1);
        };
        assert!(0x2::clock::timestamp_ms(arg5) <= v8, 3);
        let v13 = 0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::get_flat_fee(arg4, 0x1::type_name::get<T1>());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v7 + v13, 4);
        if (v13 > 0) {
            0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager::collect_fee(arg4, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v13, arg6));
        };
        let v14 = 0;
        let v15 = v1;
        while (v14 < v9) {
            let v16 = OfferedNftKey{index: v14};
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v15, v16), v0);
            v14 = v14 + 1;
        };
        let v17 = 0;
        while (v17 < 0x1::vector::length<0x2::object::ID>(&v11)) {
            0x2::transfer::public_transfer<T1>(0x2::kiosk::take<T1>(arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(&v11, v17)), v2);
            v17 = v17 + 1;
        };
        finalize_settlement(v15, v2, v0, arg3, v7, v6, arg6);
    }

    fun finalize_settlement(arg0: 0x2::object::UID, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg4, arg6), arg1);
        };
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg5)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg5), arg2);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg5);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v0 = SwapExecuted{
            offer_id : 0x2::object::uid_to_inner(&arg0),
            maker    : arg1,
            taker    : arg2,
        };
        0x2::event::emit<SwapExecuted>(v0);
        0x2::object::delete(arg0);
    }

    fun handle_maker_sui(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        if (0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
            return 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        }
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
        let v14 = OfferReturnedToMaker{offer_id: 0x2::object::uid_to_inner(&v11)};
        0x2::event::emit<OfferReturnedToMaker>(v14);
        0x2::object::delete(v11);
    }

    // decompiled from Move bytecode v6
}

