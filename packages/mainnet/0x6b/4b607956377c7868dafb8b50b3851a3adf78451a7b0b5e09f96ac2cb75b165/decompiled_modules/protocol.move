module 0x6b4b607956377c7868dafb8b50b3851a3adf78451a7b0b5e09f96ac2cb75b165::protocol {
    struct GlobalRegistry has key {
        id: 0x2::object::UID,
        active_offers: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct SwapOffer has store, key {
        id: 0x2::object::UID,
        maker: address,
        taker: 0x1::option::Option<address>,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        requested_nft_type: 0x1::type_name::TypeName,
        maker_sui: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        taker_sui_required: u64,
        expiration_ms: u64,
    }

    struct OfferedCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: 0x1::option::Option<address>,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        requested_nft_type: 0x1::type_name::TypeName,
        taker_sui_required: u64,
    }

    struct SwapExecuted has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: address,
        fees_paid: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
    }

    public fun cancel_offer(arg0: &mut GlobalRegistry, arg1: SwapOffer, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let SwapOffer {
            id                 : v1,
            maker              : v2,
            taker              : _,
            offered_nft_id     : v4,
            requested_nft_id   : _,
            requested_nft_type : _,
            maker_sui          : v7,
            taker_sui_required : _,
            expiration_ms      : _,
        } = arg1;
        let v10 = v7;
        assert!(v0 == v2, 1);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, v4);
        let v11 = v1;
        let v12 = OfferedCapKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<OfferedCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v11, v12), v0);
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

    fun consolidate_sui(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
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

    public fun create_offer<T0>(arg0: &mut GlobalRegistry, arg1: 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: 0x1::option::Option<address>, arg7: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(&arg1, arg3), 8);
        assert!(0x2::kiosk::has_access(&mut arg1, &arg2), 9);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.active_offers, arg3), 6);
        assert!(arg8 >= 300000 && arg8 <= 31536000000, 5);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.active_offers, arg3, true);
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = OfferedCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<OfferedCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v0, v2, arg2);
        let v3 = OfferCreated{
            offer_id           : 0x2::object::uid_to_inner(&v0),
            maker              : 0x2::tx_context::sender(arg10),
            taker              : arg6,
            offered_nft_id     : arg3,
            requested_nft_id   : arg4,
            requested_nft_type : v1,
            taker_sui_required : arg5,
        };
        0x2::event::emit<OfferCreated>(v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg1);
        let v4 = SwapOffer{
            id                 : v0,
            maker              : 0x2::tx_context::sender(arg10),
            taker              : arg6,
            offered_nft_id     : arg3,
            requested_nft_id   : arg4,
            requested_nft_type : v1,
            maker_sui          : consolidate_sui(arg7),
            taker_sui_required : arg5,
            expiration_ms      : 0x2::clock::timestamp_ms(arg9) + arg8,
        };
        0x2::transfer::share_object<SwapOffer>(v4);
    }

    public fun execute_swap<T0: store + key>(arg0: &mut GlobalRegistry, arg1: SwapOffer, arg2: 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x6b4b607956377c7868dafb8b50b3851a3adf78451a7b0b5e09f96ac2cb75b165::fee_manager::PlatformConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let SwapOffer {
            id                 : v1,
            maker              : v2,
            taker              : v3,
            offered_nft_id     : v4,
            requested_nft_id   : v5,
            requested_nft_type : v6,
            maker_sui          : v7,
            taker_sui_required : v8,
            expiration_ms      : v9,
        } = arg1;
        let v10 = v7;
        let v11 = v3;
        assert!(0x2::kiosk::has_item(&arg2, v5), 8);
        assert!(0x2::kiosk::has_access(&mut arg2, &arg3), 9);
        assert!(0x1::type_name::get<T0>() == v6, 10);
        if (0x1::option::is_some<address>(&v11)) {
            assert!(v0 == *0x1::option::borrow<address>(&v11), 1);
        };
        assert!(0x2::clock::timestamp_ms(arg6) <= v9, 3);
        let v12 = 0x6b4b607956377c7868dafb8b50b3851a3adf78451a7b0b5e09f96ac2cb75b165::fee_manager::get_flat_fee(arg5, 0x1::type_name::get<T0>());
        if (v12 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v8 + v12, 4);
            0x6b4b607956377c7868dafb8b50b3851a3adf78451a7b0b5e09f96ac2cb75b165::fee_manager::collect_fee(arg5, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v12, arg7));
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, v4);
        let v13 = v1;
        let v14 = OfferedCapKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<OfferedCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v13, v14), v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg3, v2);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v10)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v10), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v10);
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v8, arg7), v2);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg2);
        let v15 = SwapExecuted{
            offer_id  : 0x2::object::uid_to_inner(&v13),
            maker     : v2,
            taker     : v0,
            fees_paid : v12,
        };
        0x2::event::emit<SwapExecuted>(v15);
        0x2::object::delete(v13);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalRegistry{
            id            : 0x2::object::new(arg0),
            active_offers : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<GlobalRegistry>(v0);
    }

    // decompiled from Move bytecode v7
}

