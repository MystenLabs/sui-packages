module 0xe49a0c61b44be6940d4ed52aa7923f00dff09f9339b91edb7b8d420f7e668594::ninja_store {
    struct Paper has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
    }

    struct NFTTypeInfo has copy, drop, store {
        type_name: 0x1::string::String,
    }

    struct SwapListing has key {
        id: 0x2::object::UID,
        creator: address,
        swap_type: u8,
        offered_nft_id: 0x2::object::ID,
        offered_nft_type: NFTTypeInfo,
        requested_nft_id: 0x2::object::ID,
        requested_nft_type: NFTTypeInfo,
        requested_sui_amount: u64,
        offered_sui_amount: u64,
        status: u8,
        is_kiosk_swap: bool,
        kiosk_id: 0x2::object::ID,
    }

    struct SwapCompleted has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
        acceptor: address,
        swap_type: u8,
    }

    struct SwapCancelled has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
        swap_type: u8,
    }

    struct NINJA_STORE has drop {
        dummy_field: bool,
    }

    public entry fun AcceptKioskSwap<T0: store + key>(arg0: &mut SwapListing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 8);
        assert!(arg0.swap_type == 1, 10);
        assert!(arg0.is_kiosk_swap, 16);
        assert!(0x2::tx_context::sender(arg4) != arg0.creator, 17);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 19);
        assert!(get_type_name<T0>() == arg0.requested_nft_type.type_name, 9);
        assert!(0x2::kiosk::has_item(arg1, arg0.offered_nft_id), 9);
        arg0.status = 1;
        0x2::transfer::public_transfer<T0>(arg3, arg0.creator);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, arg2, arg0.offered_nft_id), 0x2::tx_context::sender(arg4));
        let v0 = SwapCompleted{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            acceptor  : 0x2::tx_context::sender(arg4),
            swap_type : arg0.swap_type,
        };
        0x2::event::emit<SwapCompleted>(v0);
    }

    public entry fun AcceptKioskToKioskSwap<T0: store + key, T1: store + key>(arg0: &mut SwapListing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 8);
        assert!(arg0.swap_type == 3, 10);
        assert!(arg0.is_kiosk_swap, 16);
        assert!(0x2::tx_context::sender(arg6) != arg0.creator, 17);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 19);
        assert!(0x2::kiosk::owner(arg3) == 0x2::tx_context::sender(arg6), 20);
        assert!(0x2::kiosk::has_item(arg3, arg5), 9);
        assert!(0x2::kiosk::has_item(arg1, arg0.offered_nft_id), 9);
        arg0.status = 1;
        0x2::kiosk::place<T0>(arg3, arg4, 0x2::kiosk::take<T0>(arg1, arg2, arg0.offered_nft_id));
        0x2::kiosk::place<T1>(arg1, arg2, 0x2::kiosk::take<T1>(arg3, arg4, arg5));
        let v0 = SwapCompleted{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            acceptor  : 0x2::tx_context::sender(arg6),
            swap_type : arg0.swap_type,
        };
        0x2::event::emit<SwapCompleted>(v0);
    }

    public entry fun AcceptSwap<T0: store + key, T1: store + key>(arg0: &mut SwapListing, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 8);
        assert!(arg0.swap_type == 0, 10);
        assert!(!arg0.is_kiosk_swap, 16);
        assert!(0x2::tx_context::sender(arg2) != arg0.creator, 17);
        assert!(get_type_name<T1>() == arg0.requested_nft_type.type_name, 9);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg0.offered_nft_id), 18);
        arg0.status = 1;
        0x2::transfer::public_transfer<T1>(arg1, arg0.creator);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), 0x2::tx_context::sender(arg2));
        let v0 = SwapCompleted{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            acceptor  : 0x2::tx_context::sender(arg2),
            swap_type : arg0.swap_type,
        };
        0x2::event::emit<SwapCompleted>(v0);
    }

    public entry fun CancelKioskSwap(arg0: &mut SwapListing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.status == 0, 8);
        assert!(arg0.is_kiosk_swap, 16);
        arg0.status = 2;
        let v0 = SwapCancelled{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            swap_type : arg0.swap_type,
        };
        0x2::event::emit<SwapCancelled>(v0);
    }

    public entry fun CancelSwap<T0: store + key>(arg0: &mut SwapListing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.status == 0, 8);
        assert!(!arg0.is_kiosk_swap, 16);
        arg0.status = 2;
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg0.offered_nft_id), 18);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), arg0.creator);
        let v0 = SwapCancelled{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            swap_type : arg0.swap_type,
        };
        0x2::event::emit<SwapCancelled>(v0);
    }

    public entry fun OfferKioskSwap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg4), 20);
        assert!(0x2::kiosk::has_item(arg0, arg2), 9);
        assert!(0x2::kiosk::is_locked(arg0, arg2), 9);
        let v0 = 0x1::string::utf8(arg3);
        assert!(0x1::string::length(&v0) > 0, 9);
        let v1 = NFTTypeInfo{type_name: 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))};
        let v2 = NFTTypeInfo{type_name: 0x1::string::utf8(arg3)};
        let v3 = SwapListing{
            id                   : 0x2::object::new(arg4),
            creator              : 0x2::tx_context::sender(arg4),
            swap_type            : 1,
            offered_nft_id       : arg2,
            offered_nft_type     : v1,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_nft_type   : v2,
            requested_sui_amount : 0,
            offered_sui_amount   : 0,
            status               : 0,
            is_kiosk_swap        : true,
            kiosk_id             : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::transfer::share_object<SwapListing>(v3);
    }

    public entry fun OfferKioskToKioskSwap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg4), 20);
        assert!(0x2::kiosk::has_item(arg0, arg2), 9);
        assert!(0x2::kiosk::is_locked(arg0, arg2), 9);
        let v0 = 0x1::string::utf8(arg3);
        assert!(0x1::string::length(&v0) > 0, 9);
        let v1 = NFTTypeInfo{type_name: 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))};
        let v2 = NFTTypeInfo{type_name: 0x1::string::utf8(arg3)};
        let v3 = SwapListing{
            id                   : 0x2::object::new(arg4),
            creator              : 0x2::tx_context::sender(arg4),
            swap_type            : 3,
            offered_nft_id       : arg2,
            offered_nft_type     : v1,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_nft_type   : v2,
            requested_sui_amount : 0,
            offered_sui_amount   : 0,
            status               : 0,
            is_kiosk_swap        : true,
            kiosk_id             : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::transfer::share_object<SwapListing>(v3);
    }

    public entry fun OfferSwap<T0: store + key>(arg0: T0, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x1::string::length(&v0) > 0, 9);
        let v1 = 0x2::object::id<T0>(&arg0);
        let v2 = NFTTypeInfo{type_name: get_type_name<T0>()};
        let v3 = NFTTypeInfo{type_name: 0x1::string::utf8(arg1)};
        let v4 = SwapListing{
            id                   : 0x2::object::new(arg2),
            creator              : 0x2::tx_context::sender(arg2),
            swap_type            : 0,
            offered_nft_id       : v1,
            offered_nft_type     : v2,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_nft_type   : v3,
            requested_sui_amount : 0,
            offered_sui_amount   : 0,
            status               : 0,
            is_kiosk_swap        : false,
            kiosk_id             : 0x2::object::id_from_address(@0x0),
        };
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v4.id, v1, arg0);
        0x2::transfer::share_object<SwapListing>(v4);
    }

    fun get_type_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    fun init(arg0: NINJA_STORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NINJA_STORE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun verify_nft_type<T0: store + key>(arg0: &T0, arg1: 0x1::string::String) : bool {
        get_type_name<T0>() == arg1
    }

    // decompiled from Move bytecode v6
}

