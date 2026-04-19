module 0xff2cb11360fb487e48e9781764feaeb232a34683340a6634060464b28475ecd5::protocol {
    struct SwapOffer has store, key {
        id: 0x2::object::UID,
        maker: address,
        taker: 0x1::option::Option<address>,
        requested_nft_id: 0x2::object::ID,
        maker_sui: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        taker_sui_required: u64,
        expiration_ms: u64,
    }

    struct OfferCreated<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: 0x1::option::Option<address>,
        requested_nft_id: 0x2::object::ID,
        taker_sui_required: u64,
    }

    struct SwapExecuted<phantom T0, phantom T1> has copy, drop {
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

    public fun admin_emergency_recover<T0: store + key>(arg0: &0xff2cb11360fb487e48e9781764feaeb232a34683340a6634060464b28475ecd5::fee_manager::AdminCap, arg1: &0xff2cb11360fb487e48e9781764feaeb232a34683340a6634060464b28475ecd5::fee_manager::PlatformConfig, arg2: SwapOffer, arg3: address) {
        assert!(0xff2cb11360fb487e48e9781764feaeb232a34683340a6634060464b28475ecd5::fee_manager::is_admin(arg1, arg0), 1);
        let SwapOffer {
            id                 : v0,
            maker              : _,
            taker              : _,
            requested_nft_id   : _,
            maker_sui          : v4,
            taker_sui_required : _,
            expiration_ms      : _,
        } = arg2;
        let v7 = v4;
        let v8 = v0;
        let v9 = OfferedNftKey{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v8, v9), arg3);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v7), arg3);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v7);
        };
        let v10 = AdminRecoveryClaimed{
            offer_id  : 0x2::object::uid_to_inner(&v8),
            recipient : arg3,
        };
        0x2::event::emit<AdminRecoveryClaimed>(v10);
        0x2::object::delete(v8);
    }

    public fun cancel_offer<T0: store + key>(arg0: SwapOffer, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let SwapOffer {
            id                 : v1,
            maker              : v2,
            taker              : _,
            requested_nft_id   : _,
            maker_sui          : v5,
            taker_sui_required : _,
            expiration_ms      : _,
        } = arg0;
        let v8 = v5;
        let v9 = v1;
        assert!(v0 == v2, 1);
        let v10 = OfferedNftKey{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v9, v10), v0);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v8)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v8), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v8);
        };
        let v11 = OfferCancelled{
            offer_id : 0x2::object::uid_to_inner(&v9),
            maker    : v0,
        };
        0x2::event::emit<OfferCancelled>(v11);
        0x2::object::delete(v9);
    }

    public fun create_offer<T0: store + key, T1: store + key>(arg0: T0, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::option::Option<address>, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 300000 && arg5 <= 31536000000, 5);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::new(arg7);
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
        let v4 = OfferedNftKey{dummy_field: false};
        0x2::dynamic_object_field::add<OfferedNftKey, T0>(&mut v1, v4, arg0);
        let v5 = SwapOffer{
            id                 : v1,
            maker              : v0,
            taker              : arg3,
            requested_nft_id   : arg1,
            maker_sui          : v2,
            taker_sui_required : arg2,
            expiration_ms      : 0x2::clock::timestamp_ms(arg6) + arg5,
        };
        let v6 = OfferCreated<T0, T1>{
            offer_id           : 0x2::object::uid_to_inner(&v1),
            maker              : v0,
            taker              : arg3,
            requested_nft_id   : arg1,
            taker_sui_required : arg2,
        };
        0x2::event::emit<OfferCreated<T0, T1>>(v6);
        0x2::transfer::share_object<SwapOffer>(v5);
    }

    public fun execute_swap<T0: store + key, T1: store + key>(arg0: SwapOffer, arg1: T1, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xff2cb11360fb487e48e9781764feaeb232a34683340a6634060464b28475ecd5::fee_manager::PlatformConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let SwapOffer {
            id                 : v1,
            maker              : v2,
            taker              : v3,
            requested_nft_id   : v4,
            maker_sui          : v5,
            taker_sui_required : v6,
            expiration_ms      : v7,
        } = arg0;
        let v8 = v5;
        let v9 = v3;
        let v10 = v1;
        if (0x1::option::is_some<address>(&v9)) {
            assert!(v0 == *0x1::option::borrow<address>(&v9), 1);
        };
        assert!(0x2::object::id<T1>(&arg1) == v4, 2);
        assert!(0x2::clock::timestamp_ms(arg4) <= v7, 3);
        let v11 = 0xff2cb11360fb487e48e9781764feaeb232a34683340a6634060464b28475ecd5::fee_manager::get_flat_fee(arg3, 0x1::type_name::get<T1>());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v6 + v11, 4);
        if (v11 > 0) {
            0xff2cb11360fb487e48e9781764feaeb232a34683340a6634060464b28475ecd5::fee_manager::collect_fee(arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v11, arg5));
        };
        let v12 = OfferedNftKey{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<OfferedNftKey, T0>(&mut v10, v12), v0);
        0x2::transfer::public_transfer<T1>(arg1, v2);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v6, arg5), v2);
        };
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v8)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v8), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v8);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v13 = SwapExecuted<T0, T1>{
            offer_id : 0x2::object::uid_to_inner(&v10),
            maker    : v2,
            taker    : v0,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v13);
        0x2::object::delete(v10);
    }

    // decompiled from Move bytecode v6
}

