module 0x149404a6bbed897c8404edf5002f2906faeaecd65b190f75a4ec59c3f523e07b::protocol {
    struct SwapOffer has store, key {
        id: 0x2::object::UID,
        maker: address,
        taker: 0x1::option::Option<address>,
        requested_nft_id: 0x2::object::ID,
        requested_item_type: 0x1::type_name::TypeName,
        maker_sui: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        taker_sui_required: u64,
        expiration_ms: u64,
        offered_item_type: 0x1::type_name::TypeName,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        requested_nft_id: 0x2::object::ID,
        requested_type: 0x1::type_name::TypeName,
        offered_type: 0x1::type_name::TypeName,
    }

    struct SwapExecuted has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: address,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
    }

    struct AdminRecoveryClaimed has copy, drop {
        offer_id: 0x2::object::ID,
        recipient: address,
    }

    struct OfferedNftKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun admin_emergency_recover<T0: store + key>(arg0: &0x149404a6bbed897c8404edf5002f2906faeaecd65b190f75a4ec59c3f523e07b::fee_manager::AdminCap, arg1: &0x149404a6bbed897c8404edf5002f2906faeaecd65b190f75a4ec59c3f523e07b::fee_manager::PlatformConfig, arg2: &0x2::clock::Clock, arg3: SwapOffer, arg4: address) {
        assert!(0x2::object::id<0x149404a6bbed897c8404edf5002f2906faeaecd65b190f75a4ec59c3f523e07b::fee_manager::AdminCap>(arg0) == 0x149404a6bbed897c8404edf5002f2906faeaecd65b190f75a4ec59c3f523e07b::fee_manager::admin_cap_id(arg1), 1);
        assert!(0x1::type_name::get<T0>() == arg3.offered_item_type, 6);
        assert!(0x2::clock::timestamp_ms(arg2) > arg3.expiration_ms, 7);
        let SwapOffer {
            id                  : v0,
            maker               : _,
            taker               : _,
            requested_nft_id    : _,
            requested_item_type : _,
            maker_sui           : v5,
            taker_sui_required  : _,
            expiration_ms       : _,
            offered_item_type   : _,
        } = arg3;
        let v9 = v5;
        let v10 = v0;
        let v11 = OfferedNftKey{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v10, v11), arg4);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v9)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v9), arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v9);
        };
        let v12 = AdminRecoveryClaimed{
            offer_id  : 0x2::object::uid_to_inner(&v10),
            recipient : arg4,
        };
        0x2::event::emit<AdminRecoveryClaimed>(v12);
        0x2::object::delete(v10);
    }

    public fun cancel_offer<T0: store + key>(arg0: SwapOffer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg0.offered_item_type, 6);
        let v0 = 0x2::tx_context::sender(arg1);
        let SwapOffer {
            id                  : v1,
            maker               : v2,
            taker               : _,
            requested_nft_id    : _,
            requested_item_type : _,
            maker_sui           : v6,
            taker_sui_required  : _,
            expiration_ms       : _,
            offered_item_type   : _,
        } = arg0;
        let v10 = v6;
        let v11 = v1;
        assert!(v0 == v2, 1);
        let v12 = OfferedNftKey{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v11, v12), v0);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v10)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v10), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v10);
        };
        let v13 = OfferCancelled{
            offer_id : 0x2::object::uid_to_inner(&v11),
            maker    : v0,
        };
        0x2::event::emit<OfferCancelled>(v13);
        0x2::object::delete(v11);
    }

    public fun create_offer<T0: store + key>(arg0: T0, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::option::Option<address>, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 >= 300000 && arg6 <= 31536000000, 5);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = if (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg5)) {
            let v4 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg5);
            while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg5)) {
                0x2::coin::join<0x2::sui::SUI>(&mut v4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg5));
            };
            0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg5);
            if (0x2::coin::value<0x2::sui::SUI>(&v4) > 0) {
                0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v4)
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v4);
                0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
            }
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg5);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        let v5 = OfferedNftKey{dummy_field: false};
        0x2::dynamic_object_field::add<OfferedNftKey, T0>(&mut v1, v5, arg0);
        let v6 = OfferCreated{
            offer_id         : 0x2::object::uid_to_inner(&v1),
            maker            : v0,
            requested_nft_id : arg1,
            requested_type   : arg2,
            offered_type     : v2,
        };
        0x2::event::emit<OfferCreated>(v6);
        let v7 = SwapOffer{
            id                  : v1,
            maker               : v0,
            taker               : arg4,
            requested_nft_id    : arg1,
            requested_item_type : arg2,
            maker_sui           : v3,
            taker_sui_required  : arg3,
            expiration_ms       : 0x2::clock::timestamp_ms(arg7) + arg6,
            offered_item_type   : v2,
        };
        0x2::transfer::share_object<SwapOffer>(v7);
    }

    public fun execute_swap<T0: store + key, T1: store + key>(arg0: SwapOffer, arg1: T1, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x149404a6bbed897c8404edf5002f2906faeaecd65b190f75a4ec59c3f523e07b::fee_manager::PlatformConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg0.offered_item_type, 6);
        assert!(0x1::type_name::get<T1>() == arg0.requested_item_type, 6);
        assert!(0x2::object::id<T1>(&arg1) == arg0.requested_nft_id, 2);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg0.expiration_ms, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        let SwapOffer {
            id                  : v1,
            maker               : v2,
            taker               : v3,
            requested_nft_id    : _,
            requested_item_type : _,
            maker_sui           : v6,
            taker_sui_required  : v7,
            expiration_ms       : _,
            offered_item_type   : _,
        } = arg0;
        let v10 = v6;
        let v11 = v3;
        let v12 = v1;
        if (0x1::option::is_some<address>(&v11)) {
            assert!(v0 == *0x1::option::borrow<address>(&v11), 1);
        };
        let v13 = 0x149404a6bbed897c8404edf5002f2906faeaecd65b190f75a4ec59c3f523e07b::fee_manager::get_flat_fee(arg3, 0x1::type_name::get<T1>());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v7 + v13, 4);
        if (v13 > 0) {
            0x149404a6bbed897c8404edf5002f2906faeaecd65b190f75a4ec59c3f523e07b::fee_manager::collect_fee(arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v13, arg5));
        };
        let v14 = OfferedNftKey{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v12, v14), v0);
        0x2::transfer::public_transfer<T1>(arg1, v2);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v7, arg5), v2);
        };
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v10)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v10), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v10);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v15 = SwapExecuted{
            offer_id : 0x2::object::uid_to_inner(&v12),
            maker    : v2,
            taker    : v0,
        };
        0x2::event::emit<SwapExecuted>(v15);
        0x2::object::delete(v12);
    }

    // decompiled from Move bytecode v6
}

