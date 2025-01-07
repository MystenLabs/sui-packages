module 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::listing {
    struct Listing has store, key {
        id: 0x2::object::UID,
        admin: address,
        receiver: address,
        proceeds: 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::proceeds::Proceeds,
        venues: 0x2::object_table::ObjectTable<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>,
        inventories: 0x2::object_bag::ObjectBag,
    }

    struct CreateListingEvent has copy, drop {
        listing_id: 0x2::object::ID,
    }

    struct DeleteListingEvent has copy, drop {
        listing_id: 0x2::object::ID,
    }

    struct NftSoldEvent has copy, drop {
        nft: 0x2::object::ID,
        price: u64,
        ft_type: 0x1::ascii::String,
        nft_type: 0x1::ascii::String,
        buyer: address,
    }

    public fun new(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Listing {
        let v0 = 0x2::object::new(arg2);
        let v1 = CreateListingEvent{listing_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<CreateListingEvent>(v1);
        Listing{
            id          : v0,
            admin       : arg0,
            receiver    : arg1,
            proceeds    : 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::proceeds::empty(arg2),
            venues      : 0x2::object_table::new<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(arg2),
            inventories : 0x2::object_bag::new(arg2),
        }
    }

    public fun supply<T0: store + key>(arg0: &Listing, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        assert_inventory<T0>(arg0, arg1);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::supply<T0>(borrow_inventory<T0>(arg0, arg1))
    }

    public entry fun add_inventory<T0>(arg0: &mut Listing, arg1: 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg2);
        0x2::object_bag::add<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0>>(&mut arg0.inventories, 0x2::object::id<0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0>>(&arg1), arg1);
    }

    public entry fun add_nft<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg3);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::deposit_nft<T0>(borrow_inventory_mut<T0>(arg0, arg1), arg2);
    }

    public entry fun add_venue(arg0: &mut Listing, arg1: 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue, arg2: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg2);
        0x2::object_table::add<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(&mut arg0.venues, 0x2::object::id<0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(&arg1), arg1);
    }

    public entry fun add_warehouse<T0: store + key>(arg0: &mut Listing, arg1: 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::warehouse::Warehouse<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        insert_warehouse<T0>(arg0, arg1, arg2);
    }

    public fun admin(arg0: &Listing) : address {
        arg0.admin
    }

    public entry fun admin_set_live(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::keepsake_marketplace::Marketplace, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::keepsake_marketplace::is_admin(arg4, 0x2::tx_context::sender(arg5)), 3);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::set_live(borrow_venue_mut(arg0, arg1), arg2, arg3);
    }

    public fun assert_inventory<T0>(arg0: &Listing, arg1: 0x2::object::ID) {
        assert!(contains_inventory<T0>(arg0, arg1), 2);
    }

    public fun assert_listing_admin(arg0: &Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
    }

    public fun assert_venue(arg0: &Listing, arg1: 0x2::object::ID) {
        assert!(contains_venue(arg0, arg1), 1);
    }

    public fun borrow_inventory<T0>(arg0: &Listing, arg1: 0x2::object::ID) : &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0> {
        assert_inventory<T0>(arg0, arg1);
        0x2::object_bag::borrow<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0>>(&arg0.inventories, arg1)
    }

    fun borrow_inventory_mut<T0>(arg0: &mut Listing, arg1: 0x2::object::ID) : &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0> {
        assert_inventory<T0>(arg0, arg1);
        0x2::object_bag::borrow_mut<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0>>(&mut arg0.inventories, arg1)
    }

    public fun borrow_proceeds(arg0: &Listing) : &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::proceeds::Proceeds {
        &arg0.proceeds
    }

    public fun borrow_venue(arg0: &Listing, arg1: 0x2::object::ID) : &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue {
        assert_venue(arg0, arg1);
        0x2::object_table::borrow<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(&arg0.venues, arg1)
    }

    fun borrow_venue_mut(arg0: &mut Listing, arg1: 0x2::object::ID) : &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue {
        assert_venue(arg0, arg1);
        0x2::object_table::borrow_mut<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(&mut arg0.venues, arg1)
    }

    public fun buy_nft<T0: store + key, T1, T2: store, T3: copy + drop + store>(arg0: &mut Listing, arg1: T3, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::balance::Balance<T1>) : T0 {
        let v0 = inventory_internal_mut<T0, T2, T3>(arg0, arg1, arg3, arg2);
        let v1 = 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::redeem_nft<T0>(v0);
        pay_and_emit_sold_event<T1, T0>(arg0, &v1, arg5, arg4);
        v1
    }

    public fun buy_pseudorandom_nft<T0: store + key, T1, T2: store, T3: copy + drop + store>(arg0: &mut Listing, arg1: T3, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = inventory_internal_mut<T0, T2, T3>(arg0, arg1, arg3, arg2);
        let v1 = 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::redeem_pseudorandom_nft<T0>(v0, arg6);
        pay_and_emit_sold_event<T1, T0>(arg0, &v1, arg5, arg4);
        v1
    }

    public fun buy_random_nft<T0: store + key, T1, T2: store, T3: copy + drop + store>(arg0: &mut Listing, arg1: T3, arg2: 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::warehouse::RedeemCommitment, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: address, arg7: 0x2::balance::Balance<T1>, arg8: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = inventory_internal_mut<T0, T2, T3>(arg0, arg1, arg5, arg4);
        let v1 = 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::redeem_random_nft<T0>(v0, arg2, arg3, arg8);
        pay_and_emit_sold_event<T1, T0>(arg0, &v1, arg7, arg6);
        v1
    }

    public entry fun collect_proceeds<T0>(arg0: &mut Listing, arg1: &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::keepsake_marketplace::Marketplace, arg2: &mut 0x2::tx_context::TxContext) {
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::proceeds::collect_with_fees<T0>(&mut arg0.proceeds, arg1, arg0.receiver, arg2);
    }

    public entry fun confiscate_proceeds<T0>(arg0: &mut Listing, arg1: &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::keepsake_marketplace::Marketplace, arg2: &mut 0x2::tx_context::TxContext) {
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::proceeds::collect_to_market_owner<T0>(&mut arg0.proceeds, arg1, arg2);
    }

    public fun contains_inventory<T0>(arg0: &Listing, arg1: 0x2::object::ID) : bool {
        0x2::object_bag::contains_with_type<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0>>(&arg0.inventories, arg1)
    }

    public fun contains_venue(arg0: &Listing, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(&arg0.venues, arg1)
    }

    public fun create_venue<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: T0, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::new<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        add_venue(arg0, v0, arg6);
        0x2::object::id<0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(&v0)
    }

    public fun create_warehouse<T0: store + key>(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::from_warehouse<T0>(0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::warehouse::new<T0>(arg1), arg1);
        add_inventory<T0>(arg0, v0, arg1);
        0x2::object::id<0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0>>(&v0)
    }

    public fun emit_sold_event<T0, T1: key>(arg0: &T1, arg1: u64, arg2: address) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = NftSoldEvent{
            nft      : 0x2::object::id<T1>(arg0),
            price    : arg1,
            ft_type  : *0x1::type_name::borrow_string(&v0),
            nft_type : *0x1::type_name::borrow_string(&v1),
            buyer    : arg2,
        };
        0x2::event::emit<NftSoldEvent>(v2);
    }

    public fun get_proceeds_amount<T0>(arg0: &Listing) : u64 {
        0x2::balance::value<T0>(0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::proceeds::balance<T0>(&arg0.proceeds))
    }

    public entry fun init_listing(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Listing>(new(arg0, arg1, arg2));
    }

    public entry fun init_venue<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: T0, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        create_venue<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun init_warehouse<T0: store + key>(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        create_warehouse<T0>(arg0, arg1);
    }

    public fun insert_warehouse<T0: store + key>(arg0: &mut Listing, arg1: 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::warehouse::Warehouse<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::from_warehouse<T0>(arg1, arg2);
        add_inventory<T0>(arg0, v0, arg2);
        0x2::object::id<0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0>>(&v0)
    }

    public fun inventory_admin_mut<T0>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0> {
        assert_listing_admin(arg0, arg2);
        borrow_inventory_mut<T0>(arg0, arg1)
    }

    public fun inventory_internal_mut<T0, T1: store, T2: copy + drop + store>(arg0: &mut Listing, arg1: T2, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::Inventory<T0> {
        venue_internal_mut<T1, T2>(arg0, arg1, arg2);
        borrow_inventory_mut<T0>(arg0, arg3)
    }

    public fun market_internal_mut<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: 0x2::object::ID) : &mut T0 {
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::borrow_market_mut<T0, T1>(arg1, venue_internal_mut<T0, T1>(arg0, arg1, arg2))
    }

    public fun pay<T0>(arg0: &mut Listing, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::proceeds::add<T0>(&mut arg0.proceeds, arg1, arg2);
    }

    public fun pay_and_emit_sold_event<T0, T1: key>(arg0: &mut Listing, arg1: &T1, arg2: 0x2::balance::Balance<T0>, arg3: address) {
        emit_sold_event<T0, T1>(arg1, 0x2::balance::value<T0>(&arg2), arg3);
        pay<T0>(arg0, arg2, 1);
    }

    public fun receiver(arg0: &Listing) : address {
        arg0.receiver
    }

    public fun remove_venue<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: 0x2::object::ID) : 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue {
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(&mut arg0.venues, arg2);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::assert_market<T0, T1>(arg1, &v0);
        v0
    }

    public entry fun set_live(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg4);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::set_live(borrow_venue_mut(arg0, arg1), arg2, arg3);
    }

    public fun set_whitelisted(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg3);
        assert_venue(arg0, arg1);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::set_whitelisted(0x2::object_table::borrow_mut<0x2::object::ID, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(&mut arg0.venues, arg1), arg2);
    }

    public fun venue_internal_mut<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: 0x2::object::ID) : &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue {
        let v0 = borrow_venue_mut(arg0, arg2);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::assert_market<T0, T1>(arg1, v0);
        v0
    }

    public fun withdraw_by_id<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg3);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::redeem_nft_with_id_and_transfer<T0>(borrow_inventory_mut<T0>(arg0, arg1), arg2, arg3);
    }

    public fun withdraw_one<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg2);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::inventory::redeem_nft_at_index_and_transfer<T0>(borrow_inventory_mut<T0>(arg0, arg1), 0, arg2);
    }

    // decompiled from Move bytecode v6
}

