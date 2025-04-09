module 0x47d26abe0cb363e48cf69d661a81ba81d8bf84b73d43cd64cefc99b2849a0671::ninja_store {
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
        status: u8,
        created_at: u64,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        owner: address,
        fee_bps: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_volume: u64,
        total_fees: u64,
        active_listings: u64,
        completed_trades: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SwapCreated has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
        swap_type: u8,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        offered_nft_type: 0x1::string::String,
        requested_nft_type: 0x1::string::String,
        created_at: u64,
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

    public entry fun accept_swap<T0: store + key, T1: store + key>(arg0: &mut SwapListing, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 8);
        assert!(arg0.swap_type == 0, 7);
        let v0 = get_type_name<T1>();
        assert!(0x1::string::to_ascii(v0) == 0x1::string::to_ascii(0x1::string::utf8(b"0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFTAttachment")), 11);
        assert!(0x1::string::to_ascii(v0) == 0x1::string::to_ascii(arg0.requested_nft_type.type_name), 6);
        arg0.status = 1;
        let v1 = SwapCompleted{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            acceptor  : 0x2::tx_context::sender(arg2),
            swap_type : 0,
        };
        0x2::event::emit<SwapCompleted>(v1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<T1>(arg1, arg0.creator);
    }

    public entry fun cancel_swap<T0: store + key>(arg0: &mut SwapListing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.status == 0, 8);
        arg0.status = 2;
        let v0 = SwapCancelled{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            swap_type : arg0.swap_type,
        };
        0x2::event::emit<SwapCancelled>(v0);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), arg0.creator);
    }

    public fun get_active_listings(arg0: &Marketplace) : u64 {
        arg0.active_listings
    }

    public fun get_completed_trades(arg0: &Marketplace) : u64 {
        arg0.completed_trades
    }

    public fun get_fee(arg0: &Marketplace) : u64 {
        arg0.fee_bps
    }

    public fun get_swap_created_at(arg0: &SwapListing) : u64 {
        arg0.created_at
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

    public fun get_total_fees(arg0: &Marketplace) : u64 {
        arg0.total_fees
    }

    public fun get_total_volume(arg0: &Marketplace) : u64 {
        arg0.total_volume
    }

    public fun get_treasury_balance(arg0: &Marketplace) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
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
        let v6 = Marketplace{
            id               : 0x2::object::new(arg1),
            owner            : 0x2::tx_context::sender(arg1),
            fee_bps          : 100,
            treasury         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_volume     : 0,
            total_fees       : 0,
            active_listings  : 0,
            completed_trades : 0,
        };
        0x2::transfer::share_object<Marketplace>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Paper{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
            creator     : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::transfer<Paper>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun offer_swap<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg0);
        let v1 = get_type_name<T0>();
        assert!(0x1::string::to_ascii(v1) == 0x1::string::to_ascii(0x1::string::utf8(b"0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFTAttachment")), 11);
        let v2 = NFTTypeInfo{type_name: v1};
        let v3 = NFTTypeInfo{type_name: 0x1::string::utf8(b"0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFTAttachment")};
        let v4 = SwapListing{
            id                 : 0x2::object::new(arg1),
            creator            : 0x2::tx_context::sender(arg1),
            swap_type          : 0,
            offered_nft_id     : v0,
            offered_nft_type   : v2,
            requested_nft_id   : 0x2::object::id_from_address(@0x0),
            requested_nft_type : v3,
            status             : 0,
            created_at         : 0x2::tx_context::epoch(arg1),
        };
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v4.id, v0, arg0);
        let v5 = SwapCreated{
            swap_id            : 0x2::object::id<SwapListing>(&v4),
            creator            : 0x2::tx_context::sender(arg1),
            swap_type          : 0,
            offered_nft_id     : v0,
            requested_nft_id   : 0x2::object::id_from_address(@0x0),
            offered_nft_type   : v1,
            requested_nft_type : 0x1::string::utf8(b"0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFTAttachment"),
            created_at         : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<SwapCreated>(v5);
        0x2::transfer::share_object<SwapListing>(v4);
    }

    // decompiled from Move bytecode v6
}

