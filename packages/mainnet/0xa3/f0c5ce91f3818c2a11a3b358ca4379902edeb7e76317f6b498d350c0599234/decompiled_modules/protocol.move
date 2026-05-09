module 0xa3f0c5ce91f3818c2a11a3b358ca4379902edeb7e76317f6b498d350c0599234::protocol {
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
        maker_sui: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        taker_sui_required: u64,
        expiration_ms: u64,
    }

    struct OfferedNftKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OfferCreated<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: 0x1::option::Option<address>,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        taker_sui_required: u64,
    }

    struct SwapExecuted<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: address,
        fees_paid: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
    }

    public fun cancel_offer<T0: store + key>(arg0: &mut GlobalRegistry, arg1: SwapOffer, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let SwapOffer {
            id                 : v1,
            maker              : v2,
            taker              : _,
            offered_nft_id     : v4,
            requested_nft_id   : _,
            maker_sui          : v6,
            taker_sui_required : _,
            expiration_ms      : _,
        } = arg1;
        let v9 = v6;
        assert!(v0 == v2, 1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.active_offers, v4), 7);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, v4);
        let v10 = v1;
        let v11 = OfferedNftKey{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v10, v11), v0);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v9)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v9), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v9);
        };
        let v12 = OfferCancelled{
            offer_id : 0x2::object::uid_to_inner(&v10),
            maker    : v0,
        };
        0x2::event::emit<OfferCancelled>(v12);
        0x2::object::delete(v10);
    }

    public fun create_offer<T0: store + key, T1: store + key>(arg0: &mut GlobalRegistry, arg1: T0, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::option::Option<address>, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        internal_create_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun execute_kiosk_swap<T0: store + key, T1: store + key>(arg0: &mut GlobalRegistry, arg1: SwapOffer, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: T1, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0xa3f0c5ce91f3818c2a11a3b358ca4379902edeb7e76317f6b498d350c0599234::fee_manager::PlatformConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let SwapOffer {
            id                 : v1,
            maker              : v2,
            taker              : v3,
            offered_nft_id     : v4,
            requested_nft_id   : v5,
            maker_sui          : v6,
            taker_sui_required : v7,
            expiration_ms      : v8,
        } = arg1;
        let v9 = v6;
        let v10 = v3;
        if (0x1::option::is_some<address>(&v10)) {
            assert!(v0 == *0x1::option::borrow<address>(&v10), 1);
        };
        assert!(0x2::object::id<T1>(&arg4) == v5, 2);
        assert!(0x2::clock::timestamp_ms(arg7) <= v8, 3);
        let v11 = 0xa3f0c5ce91f3818c2a11a3b358ca4379902edeb7e76317f6b498d350c0599234::fee_manager::get_flat_fee(arg6, 0x1::type_name::get<T1>());
        if (v11 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v7 + v11, 4);
            0xa3f0c5ce91f3818c2a11a3b358ca4379902edeb7e76317f6b498d350c0599234::fee_manager::collect_fee(arg6, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v11, arg8));
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, v4);
        let v12 = v1;
        let v13 = OfferedNftKey{dummy_field: false};
        0x2::kiosk::place<T0>(arg2, arg3, 0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v12, v13));
        0x2::transfer::public_transfer<T1>(arg4, v2);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v9)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v9), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v9);
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v7, arg8), v2);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        let v14 = SwapExecuted<T0, T1>{
            offer_id  : 0x2::object::uid_to_inner(&v12),
            maker     : v2,
            taker     : v0,
            fees_paid : v11,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v14);
        0x2::object::delete(v12);
    }

    public fun execute_swap<T0: store + key, T1: store + key>(arg0: &mut GlobalRegistry, arg1: SwapOffer, arg2: T1, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0xa3f0c5ce91f3818c2a11a3b358ca4379902edeb7e76317f6b498d350c0599234::fee_manager::PlatformConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let SwapOffer {
            id                 : v1,
            maker              : v2,
            taker              : v3,
            offered_nft_id     : v4,
            requested_nft_id   : v5,
            maker_sui          : v6,
            taker_sui_required : v7,
            expiration_ms      : v8,
        } = arg1;
        let v9 = v6;
        let v10 = v3;
        if (0x1::option::is_some<address>(&v10)) {
            assert!(v0 == *0x1::option::borrow<address>(&v10), 1);
        };
        assert!(0x2::object::id<T1>(&arg2) == v5, 2);
        assert!(0x2::clock::timestamp_ms(arg5) <= v8, 3);
        let v11 = 0xa3f0c5ce91f3818c2a11a3b358ca4379902edeb7e76317f6b498d350c0599234::fee_manager::get_flat_fee(arg4, 0x1::type_name::get<T1>());
        if (v11 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v7 + v11, 4);
            0xa3f0c5ce91f3818c2a11a3b358ca4379902edeb7e76317f6b498d350c0599234::fee_manager::collect_fee(arg4, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v11, arg6));
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, v4);
        let v12 = v1;
        let v13 = OfferedNftKey{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v12, v13), v0);
        0x2::transfer::public_transfer<T1>(arg2, v2);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v9)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v9), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v9);
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v7, arg6), v2);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v14 = SwapExecuted<T0, T1>{
            offer_id  : 0x2::object::uid_to_inner(&v12),
            maker     : v2,
            taker     : v0,
            fees_paid : v11,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v14);
        0x2::object::delete(v12);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalRegistry{
            id            : 0x2::object::new(arg0),
            active_offers : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<GlobalRegistry>(v0);
    }

    fun internal_create_offer<T0: store + key, T1: store + key>(arg0: &mut GlobalRegistry, arg1: T0, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::option::Option<address>, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.active_offers, v0), 6);
        assert!(arg6 >= 300000 && arg6 <= 31536000000, 5);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.active_offers, v0, true);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x2::object::new(arg8);
        let v3 = if (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg5)) {
            let v4 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg5);
            while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg5)) {
                0x2::coin::join<0x2::sui::SUI>(&mut v4, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg5));
            };
            if (0x2::coin::value<0x2::sui::SUI>(&v4) > 0) {
                0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v4)
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v4);
                0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
            }
        } else {
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg5);
        let v5 = OfferedNftKey{dummy_field: false};
        0x2::dynamic_object_field::add<OfferedNftKey, T0>(&mut v2, v5, arg1);
        let v6 = SwapOffer{
            id                 : v2,
            maker              : v1,
            taker              : arg4,
            offered_nft_id     : v0,
            requested_nft_id   : arg2,
            maker_sui          : v3,
            taker_sui_required : arg3,
            expiration_ms      : 0x2::clock::timestamp_ms(arg7) + arg6,
        };
        0x2::transfer::share_object<SwapOffer>(v6);
        let v7 = OfferCreated<T0, T1>{
            offer_id           : 0x2::object::uid_to_inner(&v2),
            maker              : v1,
            taker              : arg4,
            offered_nft_id     : v0,
            requested_nft_id   : arg2,
            taker_sui_required : arg3,
        };
        0x2::event::emit<OfferCreated<T0, T1>>(v7);
    }

    // decompiled from Move bytecode v7
}

