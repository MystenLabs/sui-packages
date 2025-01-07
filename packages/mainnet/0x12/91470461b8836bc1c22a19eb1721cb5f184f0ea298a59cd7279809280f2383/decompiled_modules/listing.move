module 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::listing {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
    }

    struct Listing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        venues: 0x2::object_bag::ObjectBag,
        proceeds: 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::proceeds::Proceeds,
        warehouse: 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::warehouse::Warehouse<T0>,
    }

    struct CreateListingEvent has copy, drop, store {
        listing_id: 0x2::object::ID,
        creator: address,
    }

    struct NftSold has copy, drop, store {
        nft: 0x2::object::ID,
        price: u64,
        ft_type: 0x1::ascii::String,
        nft_type: 0x1::ascii::String,
        buyer: address,
    }

    struct ProceedsCollected has copy, drop, store {
        ft_type: 0x1::ascii::String,
        amount: u64,
        collector: address,
    }

    public entry fun add_nft<T0: store + key>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: T0, arg3: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg3);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::warehouse::deposit_nft<T0>(borrow_warehouse_mut<T0>(arg1), arg2);
    }

    public entry fun add_whitelist<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: 0x2::object::ID, arg3: vector<address>, arg4: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg4);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::market_whitelist::add_addresses(0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::borrow_whitelist_mut<T1>(0x2::object_bag::borrow_mut<0x2::object::ID, 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(&mut arg1.venues, arg2)), arg3);
    }

    public fun admin_redeem_nft<T0: store + key>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned) : T0 {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg2);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::warehouse::redeem_nft<T0>(borrow_warehouse_mut<T0>(arg1))
    }

    public entry fun admin_redeem_nft_and_transfer<T0: store + key>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: address, arg3: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg3);
        assert_listing_admin<T0>(arg0, arg1);
        0x2::transfer::public_transfer<T0>(admin_redeem_nft<T0>(arg0, arg1, arg3), arg2);
    }

    public fun admin_redeem_nft_with_id<T0: store + key>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: 0x2::object::ID, arg3: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned) : T0 {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg3);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::warehouse::redeem_nft_with_id<T0>(borrow_warehouse_mut<T0>(arg1), arg2)
    }

    public entry fun admin_redeem_nft_with_id_and_transfer<T0: store + key>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: 0x2::object::ID, arg3: address, arg4: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg4);
        assert_listing_admin<T0>(arg0, arg1);
        0x2::transfer::public_transfer<T0>(admin_redeem_nft_with_id<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    fun assert_listing_admin<T0: store + key>(arg0: &AdminCap, arg1: &Listing<T0>) {
        assert!(0x2::object::borrow_id<Listing<T0>>(arg1) == &arg0.listing_id, 1);
    }

    fun borrow_mut_venues<T0: store + key>(arg0: &mut Listing<T0>) : &mut 0x2::object_bag::ObjectBag {
        &mut arg0.venues
    }

    fun borrow_proceeds_mut<T0: store + key>(arg0: &mut Listing<T0>) : &mut 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::proceeds::Proceeds {
        &mut arg0.proceeds
    }

    fun borrow_warehouse_mut<T0: store + key>(arg0: &mut Listing<T0>) : &mut 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::warehouse::Warehouse<T0> {
        &mut arg0.warehouse
    }

    entry fun buy_nft<T0: store + key, T1>(arg0: &mut Listing<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        buy_nft_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun buy_nft_internal<T0: store + key, T1>(arg0: &mut Listing<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg6);
        assert!(arg2 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = borrow_mut_venues<T0>(arg0);
        let v2 = 0x2::object_bag::borrow_mut<0x2::object::ID, 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(v1, arg1);
        let v3 = 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::price<T1>(v2);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::assert_is_live<T1>(v2, arg7);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::assert_is_allowed<T1>(v2, v0);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::sell<T1>(v2, arg2, v0);
        if (v3 > 0) {
            assert!(0x2::coin::value<T1>(&arg3) >= v3 * arg2, 3);
            let v4 = borrow_proceeds_mut<T0>(arg0);
            pay<T1>(v4, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, arg2 * v3, arg8)));
        };
        while (arg2 > 0) {
            let v5 = 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::warehouse::redeem_pseudorandom_nft<T0>(borrow_warehouse_mut<T0>(arg0), arg4, arg8);
            emit_sold_event<T0, T1>(&v5, v3, v0);
            0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(arg5, v5, arg8);
            arg2 = arg2 - 1;
        };
        if (0x2::coin::value<T1>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<T1>(arg3);
        };
    }

    entry fun buy_nft_to_new_kiosk<T0: store + key, T1>(arg0: &mut Listing<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::random::Random, arg5: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(v0, arg7);
        let v3 = v1;
        let v4 = &mut v3;
        buy_nft_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, v4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v3, v0);
    }

    public entry fun collect_proceeds<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: address, arg3: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg3);
        assert_listing_admin<T0>(arg0, arg1);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = ProceedsCollected{
            ft_type   : *0x1::type_name::borrow_string(&v0),
            amount    : 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::proceeds::collect<T1>(borrow_proceeds_mut<T0>(arg1), arg2, arg4),
            collector : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ProceedsCollected>(v1);
    }

    public entry fun decrease_sale_duration<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg5: &0x2::clock::Clock) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg4);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::decrease_sale_duration<T1>(0x2::object_bag::borrow_mut<0x2::object::ID, 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(borrow_mut_venues<T0>(arg1), arg2), arg3, arg5);
    }

    fun emit_sold_event<T0: store + key, T1>(arg0: &T0, arg1: u64, arg2: address) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        let v2 = NftSold{
            nft      : 0x2::object::id<T0>(arg0),
            price    : arg1,
            ft_type  : *0x1::type_name::borrow_string(&v0),
            nft_type : *0x1::type_name::borrow_string(&v1),
            buyer    : arg2,
        };
        0x2::event::emit<NftSold>(v2);
    }

    public entry fun increase_sale_duration<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg5: &0x2::clock::Clock) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg4);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::increase_sale_duration<T1>(0x2::object_bag::borrow_mut<0x2::object::ID, 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(borrow_mut_venues<T0>(arg1), arg2), arg3, arg5);
    }

    public entry fun init_listing<T0: store + key>(arg0: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg1: &mut 0x2::tx_context::TxContext) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg0);
        let v0 = 0x2::object::new(arg1);
        let v1 = CreateListingEvent{
            listing_id : 0x2::object::uid_to_inner(&v0),
            creator    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CreateListingEvent>(v1);
        let v2 = AdminCap{
            id         : 0x2::object::new(arg1),
            listing_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = Listing<T0>{
            id        : v0,
            venues    : 0x2::object_bag::new(arg1),
            proceeds  : 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::proceeds::new(arg1),
            warehouse : 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::warehouse::new<T0>(arg1),
        };
        0x2::transfer::public_share_object<Listing<T0>>(v3);
    }

    public entry fun init_venue<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg7);
        assert_listing_admin<T0>(arg0, arg1);
        let v0 = 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::new<T1>(arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        0x2::object_bag::add<0x2::object::ID, 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(&mut arg1.venues, 0x2::object::id<0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(&v0), v0);
    }

    fun pay<T0>(arg0: &mut 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::proceeds::Proceeds, arg1: 0x2::balance::Balance<T0>) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::proceeds::add<T0>(arg0, arg1);
    }

    public entry fun remove_whitelist<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: 0x2::object::ID, arg3: vector<address>, arg4: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg4);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::market_whitelist::remove_addresses(0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::borrow_whitelist_mut<T1>(0x2::object_bag::borrow_mut<0x2::object::ID, 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(&mut arg1.venues, arg2)), arg3);
    }

    public entry fun set_max_purchase_qty<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg5: &0x2::clock::Clock) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg4);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::set_max_purchase_qty<T1>(0x2::object_bag::borrow_mut<0x2::object::ID, 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(borrow_mut_venues<T0>(arg1), arg2), arg3, arg5);
    }

    public entry fun set_sale_start_time<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg5: &0x2::clock::Clock) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg4);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::set_sale_start_time<T1>(0x2::object_bag::borrow_mut<0x2::object::ID, 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(borrow_mut_venues<T0>(arg1), arg2), arg3, arg5);
    }

    public entry fun set_sales_cap<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut Listing<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::Versioned, arg5: &0x2::clock::Clock) {
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::versioned::assert_version(arg4);
        assert_listing_admin<T0>(arg0, arg1);
        0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::set_sales_cap<T1>(0x2::object_bag::borrow_mut<0x2::object::ID, 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::venue::Venue<T1>>(borrow_mut_venues<T0>(arg1), arg2), arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

