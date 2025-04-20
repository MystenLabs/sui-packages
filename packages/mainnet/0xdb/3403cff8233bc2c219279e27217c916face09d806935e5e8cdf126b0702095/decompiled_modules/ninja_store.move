module 0xdb3403cff8233bc2c219279e27217c916face09d806935e5e8cdf126b0702095::ninja_store {
    struct NFTTypeInfo has copy, drop, store {
        type_name: 0x1::string::String,
    }

    struct SwapOffer has key {
        id: 0x2::object::UID,
        creator: address,
        offered_nft_id: 0x2::object::ID,
        offered_nft_type: NFTTypeInfo,
        requested_nft_id: 0x2::object::ID,
        requested_nft_type: NFTTypeInfo,
        status: u8,
        is_kiosk_swap: bool,
        kiosk_id: 0x2::object::ID,
    }

    struct SwapOfferCreated has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        is_kiosk_swap: bool,
    }

    struct SwapCompleted has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
        acceptor: address,
    }

    struct SwapCancelled has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
    }

    public entry fun accept_kiosk_swap<T0: store + key>(arg0: &mut SwapOffer, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(arg0.is_kiosk_swap, 5);
        assert!(0x2::tx_context::sender(arg4) != arg0.creator, 6);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 7);
        assert!(0x2::kiosk::has_access(arg1, arg2), 8);
        assert!(get_type_name<T0>() == arg0.requested_nft_type.type_name, 4);
        assert!(0x2::kiosk::has_item(arg1, arg0.offered_nft_id), 4);
        arg0.status = 1;
        0x2::transfer::public_transfer<T0>(arg3, arg0.creator);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, arg2, arg0.offered_nft_id), 0x2::tx_context::sender(arg4));
        let v0 = SwapCompleted{
            swap_id  : 0x2::object::id<SwapOffer>(arg0),
            creator  : arg0.creator,
            acceptor : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SwapCompleted>(v0);
    }

    public entry fun accept_swap<T0: store + key, T1: store + key>(arg0: &mut SwapOffer, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(!arg0.is_kiosk_swap, 5);
        assert!(0x2::tx_context::sender(arg2) != arg0.creator, 6);
        assert!(0x2::object::id<T1>(&arg1) == arg0.requested_nft_id, 3);
        assert!(get_type_name<T1>() == arg0.requested_nft_type.type_name, 4);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg0.offered_nft_id), 3);
        arg0.status = 1;
        0x2::transfer::public_transfer<T1>(arg1, arg0.creator);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), 0x2::tx_context::sender(arg2));
        let v0 = SwapCompleted{
            swap_id  : 0x2::object::id<SwapOffer>(arg0),
            creator  : arg0.creator,
            acceptor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SwapCompleted>(v0);
    }

    public entry fun cancel_kiosk_swap(arg0: &mut SwapOffer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.status == 0, 2);
        assert!(arg0.is_kiosk_swap, 5);
        arg0.status = 2;
        let v0 = SwapCancelled{
            swap_id : 0x2::object::id<SwapOffer>(arg0),
            creator : arg0.creator,
        };
        0x2::event::emit<SwapCancelled>(v0);
    }

    public entry fun cancel_swap<T0: store + key>(arg0: &mut SwapOffer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.status == 0, 2);
        assert!(!arg0.is_kiosk_swap, 5);
        arg0.status = 2;
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg0.offered_nft_id), 3);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), arg0.creator);
        let v0 = SwapCancelled{
            swap_id : 0x2::object::id<SwapOffer>(arg0),
            creator : arg0.creator,
        };
        0x2::event::emit<SwapCancelled>(v0);
    }

    public entry fun create_kiosk_swap_offer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg5), 8);
        assert!(0x2::kiosk::has_item(arg0, arg2), 4);
        assert!(0x2::kiosk::has_access(arg0, arg1), 8);
        let v0 = 0x1::string::utf8(arg3);
        assert!(0x1::string::length(&v0) > 0, 4);
        let v1 = NFTTypeInfo{type_name: 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))};
        let v2 = NFTTypeInfo{type_name: 0x1::string::utf8(arg3)};
        let v3 = SwapOffer{
            id                 : 0x2::object::new(arg5),
            creator            : 0x2::tx_context::sender(arg5),
            offered_nft_id     : arg2,
            offered_nft_type   : v1,
            requested_nft_id   : arg4,
            requested_nft_type : v2,
            status             : 0,
            is_kiosk_swap      : true,
            kiosk_id           : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        let v4 = SwapOfferCreated{
            swap_id          : 0x2::object::id<SwapOffer>(&v3),
            creator          : 0x2::tx_context::sender(arg5),
            offered_nft_id   : arg2,
            requested_nft_id : arg4,
            is_kiosk_swap    : true,
        };
        0x2::event::emit<SwapOfferCreated>(v4);
        0x2::transfer::share_object<SwapOffer>(v3);
    }

    public entry fun create_swap_offer<T0: store + key>(arg0: T0, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x1::string::length(&v0) > 0, 4);
        let v1 = 0x2::object::id<T0>(&arg0);
        let v2 = NFTTypeInfo{type_name: get_type_name<T0>()};
        let v3 = NFTTypeInfo{type_name: 0x1::string::utf8(arg1)};
        let v4 = SwapOffer{
            id                 : 0x2::object::new(arg3),
            creator            : 0x2::tx_context::sender(arg3),
            offered_nft_id     : v1,
            offered_nft_type   : v2,
            requested_nft_id   : arg2,
            requested_nft_type : v3,
            status             : 0,
            is_kiosk_swap      : false,
            kiosk_id           : 0x2::object::id_from_address(@0x0),
        };
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v4.id, v1, arg0);
        let v5 = SwapOfferCreated{
            swap_id          : 0x2::object::id<SwapOffer>(&v4),
            creator          : 0x2::tx_context::sender(arg3),
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            is_kiosk_swap    : false,
        };
        0x2::event::emit<SwapOfferCreated>(v5);
        0x2::transfer::share_object<SwapOffer>(v4);
    }

    fun get_type_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun verify_nft_type<T0: store + key>(arg0: &T0, arg1: 0x1::string::String) : bool {
        get_type_name<T0>() == arg1
    }

    // decompiled from Move bytecode v6
}

