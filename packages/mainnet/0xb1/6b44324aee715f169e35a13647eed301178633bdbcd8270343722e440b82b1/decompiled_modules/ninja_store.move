module 0xb16b44324aee715f169e35a13647eed301178633bdbcd8270343722e440b82b1::ninja_store {
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

    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        owner: address,
        nft_id: 0x2::object::ID,
        price: u64,
        listing_type: u8,
        is_kiosk_listing: bool,
    }

    struct ListingSold has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        nft_id: 0x2::object::ID,
        price: u64,
        fee_amount: u64,
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        owner: address,
        nft_id: 0x2::object::ID,
    }

    struct SwapCreated has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
        swap_type: u8,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        requested_sui_amount: u64,
        offered_sui_amount: u64,
        is_kiosk_swap: bool,
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

    public entry fun AcceptSwap<T0: store + key, T1: store + key>(arg0: &mut SwapListing, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 11);
        assert!(arg0.swap_type == 0, 10);
        assert!(!arg0.is_kiosk_swap, 16);
        get_type_name<T1>();
        arg0.status = 1;
        let v0 = SwapCompleted{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            acceptor  : 0x2::tx_context::sender(arg2),
            swap_type : 0,
        };
        0x2::event::emit<SwapCompleted>(v0);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<T1>(arg1, arg0.creator);
    }

    public entry fun CancelSwap<T0: store + key>(arg0: &mut SwapListing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.status == 0, 11);
        assert!(!arg0.is_kiosk_swap, 16);
        arg0.status = 2;
        let v0 = SwapCancelled{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            swap_type : arg0.swap_type,
        };
        0x2::event::emit<SwapCancelled>(v0);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), arg0.creator);
    }

    public entry fun Mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Paper{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
            creator     : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::transfer<Paper>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun OfferSwap<T0: store + key>(arg0: T0, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::object::id<T0>(&arg0);
        get_type_name<T0>();
        let v0 = 0x2::object::id<T0>(&arg0);
        let v1 = NFTTypeInfo{type_name: get_type_name<T0>()};
        let v2 = NFTTypeInfo{type_name: 0x1::string::utf8(arg1)};
        let v3 = SwapListing{
            id                   : 0x2::object::new(arg2),
            creator              : 0x2::tx_context::sender(arg2),
            swap_type            : 0,
            offered_nft_id       : v0,
            offered_nft_type     : v1,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_nft_type   : v2,
            requested_sui_amount : 0,
            offered_sui_amount   : 0,
            status               : 0,
            is_kiosk_swap        : false,
            kiosk_id             : 0x2::object::id_from_address(@0x0),
        };
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v3.id, v0, arg0);
        let v4 = SwapCreated{
            swap_id              : 0x2::object::id<SwapListing>(&v3),
            creator              : 0x2::tx_context::sender(arg2),
            swap_type            : 0,
            offered_nft_id       : v0,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_sui_amount : 0,
            offered_sui_amount   : 0,
            is_kiosk_swap        : false,
        };
        0x2::event::emit<SwapCreated>(v4);
        0x2::transfer::share_object<SwapListing>(v3);
    }

    public fun get_swap_creator(arg0: &SwapListing) : address {
        arg0.creator
    }

    public fun get_swap_status(arg0: &SwapListing) : u8 {
        arg0.status
    }

    public fun get_swap_type(arg0: &SwapListing) : u8 {
        arg0.swap_type
    }

    fun get_type_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    fun init(arg0: NINJA_STORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NINJA_STORE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<Paper>(&v0, v1, v3, arg1);
        0x2::display::update_version<Paper>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Paper>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

