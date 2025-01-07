module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing {
    struct Listing has store, key {
        id: 0x2::object::UID,
        version: u64,
        marketplace_id: 0x1::option::Option<0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>>,
        admin: address,
        receiver: address,
        proceeds: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::proceeds::Proceeds,
        venues: 0x2::object_table::ObjectTable<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>,
        inventories: 0x2::object_bag::ObjectBag,
        custom_fee: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::ObjectBox,
    }

    struct RequestToJoin has store, key {
        id: 0x2::object::UID,
        marketplace_id: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>,
    }

    struct RequestToJoinDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MembersDfKey has copy, drop, store {
        dummy_field: bool,
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
            id             : v0,
            version        : 3,
            marketplace_id : 0x1::option::none<0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>>(),
            admin          : arg0,
            receiver       : arg1,
            proceeds       : 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::proceeds::empty(arg2),
            venues         : 0x2::object_table::new<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(arg2),
            inventories    : 0x2::object_bag::new(arg2),
            custom_fee     : 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::empty(arg2),
        }
    }

    public fun supply<T0: store + key>(arg0: &Listing, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        assert_inventory<T0>(arg0, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::supply<T0>(borrow_inventory<T0>(arg0, arg1))
    }

    public entry fun accept_listing_request(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace, arg1: &mut Listing, arg2: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::assert_version(arg0);
        assert_version_and_upgrade(arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::assert_listing_admin_or_member(arg0, arg2);
        assert!(0x1::option::is_none<0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>>(&arg1.marketplace_id), 6);
        let v0 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::new<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>(arg0);
        let v1 = RequestToJoinDfKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<RequestToJoinDfKey, RequestToJoin>(&mut arg1.id, v1);
        assert!(v0 == v2.marketplace_id, 7);
        let RequestToJoin {
            id             : v3,
            marketplace_id : _,
        } = v2;
        0x2::object::delete(v3);
        0x1::option::fill<0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>>(&mut arg1.marketplace_id, v0);
    }

    public entry fun add_fee<T0: store + key>(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace, arg1: &mut Listing, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::assert_version(arg0);
        assert_version_and_upgrade(arg1);
        assert_listing_marketplace_match(arg0, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::assert_listing_admin_or_member(arg0, arg3);
        0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::add<T0>(&mut arg1.custom_fee, arg2);
    }

    public entry fun add_inventory<T0>(arg0: &mut Listing, arg1: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_listing_admin_or_member(arg0, arg2);
        0x2::object_bag::add<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0>>(&mut arg0.inventories, 0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0>>(&arg1), arg1);
    }

    public entry fun add_member(arg0: &mut Listing, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_listing_admin(arg0, arg2);
        let v0 = MembersDfKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<MembersDfKey>(&mut arg0.id, v0)) {
            let v1 = MembersDfKey{dummy_field: false};
            0x2::vec_set::insert<address>(0x2::dynamic_field::borrow_mut<MembersDfKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v1), arg1);
        } else {
            let v2 = MembersDfKey{dummy_field: false};
            0x2::dynamic_field::add<MembersDfKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v2, 0x2::vec_set::singleton<address>(arg1));
        };
    }

    public entry fun add_nft<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_listing_admin_or_member(arg0, arg3);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::deposit_nft<T0>(borrow_inventory_mut<T0>(arg0, arg1), arg2);
    }

    public entry fun add_venue(arg0: &mut Listing, arg1: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_listing_admin_or_member(arg0, arg2);
        0x2::object_table::add<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(&mut arg0.venues, 0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(&arg1), arg1);
    }

    public entry fun add_warehouse<T0: store + key>(arg0: &mut Listing, arg1: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        insert_warehouse<T0>(arg0, arg1, arg2);
    }

    public fun admin(arg0: &Listing) : address {
        arg0.admin
    }

    public fun admin_redeem_nft<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::redeem_nft<T0>(inventory_admin_mut<T0>(arg0, arg1, arg2))
    }

    public entry fun admin_redeem_nft_and_transfer<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(admin_redeem_nft<T0>(arg0, arg1, arg3), arg2);
    }

    public entry fun admin_redeem_nft_to_kiosk<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = admin_redeem_nft<T0>(arg0, arg1, arg3);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(arg2, v0, arg3);
    }

    public entry fun admin_redeem_nft_to_new_kiosk<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = admin_redeem_nft<T0>(arg0, arg1, arg3);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg2, arg3);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(&mut v3, v0, arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public fun admin_redeem_nft_with_id<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::redeem_nft_with_id<T0>(inventory_admin_mut<T0>(arg0, arg1, arg3), arg2)
    }

    public entry fun admin_redeem_nft_with_id_and_transfer<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(admin_redeem_nft_with_id<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public entry fun admin_redeem_nft_with_id_to_kiosk<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = admin_redeem_nft_with_id<T0>(arg0, arg1, arg2, arg4);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(arg3, v0, arg4);
    }

    public entry fun admin_redeem_nft_with_id_to_new_kiosk<T0: store + key>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = admin_redeem_nft_with_id<T0>(arg0, arg1, arg2, arg4);
        let (v1, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg3, arg4);
        let v3 = v1;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(&mut v3, v0, arg4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public(friend) fun apply_rebate<T0: store + key, T1>(arg0: &mut Listing, arg1: &mut 0x2::balance::Balance<T1>) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::apply_rebate<T0, T1>(&mut arg0.id, arg1);
    }

    public fun assert_correct_admin(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace, arg1: &Listing, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin || v0 == 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::admin(arg0), 4);
    }

    public fun assert_correct_admin_or_member(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace, arg1: &Listing, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = is_admin_or_member(arg1, arg2);
        assert!(v0 || 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::is_admin_or_member(arg0, arg2), 4);
    }

    public fun assert_default_fee(arg0: &Listing) {
        assert!(!0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::is_empty(&arg0.custom_fee), 9);
    }

    public fun assert_inventory<T0>(arg0: &Listing, arg1: 0x2::object::ID) {
        assert!(contains_inventory<T0>(arg0, arg1), 2);
    }

    public fun assert_listing_admin(arg0: &Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
    }

    public fun assert_listing_admin_or_member(arg0: &Listing, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) == arg0.admin == false) {
            let v0 = MembersDfKey{dummy_field: false};
            assert!(0x2::dynamic_field::exists_<MembersDfKey>(&arg0.id, v0), 11);
            let v1 = MembersDfKey{dummy_field: false};
            let v2 = 0x2::tx_context::sender(arg1);
            assert!(0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<MembersDfKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v1), &v2), 10);
        };
    }

    public fun assert_listing_marketplace_match(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace, arg1: &Listing) {
        assert!(0x1::option::is_some<0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>>(&arg1.marketplace_id), 5);
        assert!(0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>(arg0) == *0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::as_id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>(0x1::option::borrow<0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>>(&arg1.marketplace_id)), 5);
    }

    public fun assert_venue(arg0: &Listing, arg1: 0x2::object::ID) {
        assert!(contains_venue(arg0, arg1), 1);
    }

    fun assert_version(arg0: &Listing) {
        assert!(arg0.version == 3, 1000);
    }

    fun assert_version_and_upgrade(arg0: &mut Listing) {
        if (arg0.version < 3) {
            arg0.version = 3;
        };
        assert_version(arg0);
    }

    public fun borrow_inventory<T0>(arg0: &Listing, arg1: 0x2::object::ID) : &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0> {
        assert_inventory<T0>(arg0, arg1);
        0x2::object_bag::borrow<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0>>(&arg0.inventories, arg1)
    }

    fun borrow_inventory_mut<T0>(arg0: &mut Listing, arg1: 0x2::object::ID) : &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0> {
        assert_inventory<T0>(arg0, arg1);
        0x2::object_bag::borrow_mut<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0>>(&mut arg0.inventories, arg1)
    }

    public fun borrow_members(arg0: &Listing) : &0x2::vec_set::VecSet<address> {
        let v0 = MembersDfKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<MembersDfKey>(&arg0.id, v0), 12);
        let v1 = MembersDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<MembersDfKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v1)
    }

    public fun borrow_proceeds(arg0: &Listing) : &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::proceeds::Proceeds {
        &arg0.proceeds
    }

    public(friend) fun borrow_proceeds_mut(arg0: &mut Listing) : &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::proceeds::Proceeds {
        &mut arg0.proceeds
    }

    public fun borrow_rebate<T0: store + key, T1>(arg0: &Listing) : &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::Rebate<T1> {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::borrow_rebate<T0, T1>(&arg0.id)
    }

    fun borrow_rebate_mut<T0: store + key, T1>(arg0: &mut Listing) : &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::Rebate<T1> {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::borrow_rebate_mut<T0, T1>(&mut arg0.id)
    }

    public fun borrow_venue(arg0: &Listing, arg1: 0x2::object::ID) : &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue {
        assert_venue(arg0, arg1);
        0x2::object_table::borrow<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(&arg0.venues, arg1)
    }

    fun borrow_venue_mut(arg0: &mut Listing, arg1: 0x2::object::ID) : &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue {
        assert_venue(arg0, arg1);
        0x2::object_table::borrow_mut<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(&mut arg0.venues, arg1)
    }

    public(friend) fun buy_nft<T0: store + key, T1, T2: store, T3: copy + drop + store>(arg0: &mut Listing, arg1: T3, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::balance::Balance<T1>) : T0 {
        assert_version_and_upgrade(arg0);
        let v0 = inventory_internal_mut<T0, T2, T3>(arg0, arg1, arg3, arg2);
        let v1 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::redeem_nft<T0>(v0);
        pay_and_emit_sold_event<T1, T0>(arg0, &v1, arg5, arg4);
        v1
    }

    public(friend) fun buy_pseudorandom_nft<T0: store + key, T1, T2: store, T3: copy + drop + store>(arg0: &mut Listing, arg1: T3, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : T0 {
        assert_version_and_upgrade(arg0);
        let v0 = inventory_internal_mut<T0, T2, T3>(arg0, arg1, arg3, arg2);
        let v1 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::redeem_pseudorandom_nft<T0>(v0, arg6);
        pay_and_emit_sold_event<T1, T0>(arg0, &v1, arg5, arg4);
        v1
    }

    public(friend) fun buy_random_nft<T0: store + key, T1, T2: store, T3: copy + drop + store>(arg0: &mut Listing, arg1: T3, arg2: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::RedeemCommitment, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: address, arg7: 0x2::balance::Balance<T1>, arg8: &mut 0x2::tx_context::TxContext) : T0 {
        assert_version_and_upgrade(arg0);
        let v0 = inventory_internal_mut<T0, T2, T3>(arg0, arg1, arg5, arg4);
        let v1 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::redeem_random_nft<T0>(v0, arg2, arg3, arg8);
        pay_and_emit_sold_event<T1, T0>(arg0, &v1, arg7, arg6);
        v1
    }

    public entry fun collect_proceeds<T0>(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_listing_admin_or_member(arg0, arg1);
        assert!(0x1::option::is_none<0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>>(&arg0.marketplace_id), 8);
        let v0 = arg0.receiver;
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::proceeds::collect_without_fees<T0>(borrow_proceeds_mut(arg0), v0, arg1);
    }

    public fun contains_custom_fee(arg0: &Listing) : bool {
        !0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::is_empty(&arg0.custom_fee)
    }

    public fun contains_inventory<T0>(arg0: &Listing, arg1: 0x2::object::ID) : bool {
        0x2::object_bag::contains_with_type<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0>>(&arg0.inventories, arg1)
    }

    public fun contains_venue(arg0: &Listing, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(&arg0.venues, arg1)
    }

    public fun create_venue<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: T0, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version_and_upgrade(arg0);
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::new<T0, T1>(arg1, arg2, arg3, arg4);
        add_venue(arg0, v0, arg4);
        0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(&v0)
    }

    public fun create_warehouse<T0: store + key>(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version_and_upgrade(arg0);
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::from_warehouse<T0>(0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::new<T0>(arg1), arg1);
        add_inventory<T0>(arg0, v0, arg1);
        0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0>>(&v0)
    }

    public fun custom_fee(arg0: &Listing) : &0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::ObjectBox {
        &arg0.custom_fee
    }

    public(friend) fun emit_sold_event<T0, T1: key>(arg0: &T1, arg1: u64, arg2: address) {
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

    public entry fun fund_rebate<T0: store + key, T1>(arg0: &mut Listing, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64) {
        let v0 = 0x2::coin::balance_mut<T1>(arg1);
        fund_rebate_with_balance<T0, T1>(arg0, v0, arg2);
    }

    public fun fund_rebate_with_balance<T0: store + key, T1>(arg0: &mut Listing, arg1: &mut 0x2::balance::Balance<T1>, arg2: u64) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::fund_rebate<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun has_rebate<T0: store + key, T1>(arg0: &Listing) : bool {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::has_rebate<T0, T1>(&arg0.id)
    }

    public entry fun init_listing(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Listing>(new(arg0, arg1, arg2));
    }

    public entry fun init_venue<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: T0, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        create_venue<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun init_warehouse<T0: store + key>(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        create_warehouse<T0>(arg0, arg1);
    }

    public fun insert_warehouse<T0: store + key>(arg0: &mut Listing, arg1: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version_and_upgrade(arg0);
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::from_warehouse<T0>(arg1, arg2);
        add_inventory<T0>(arg0, v0, arg2);
        0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0>>(&v0)
    }

    public fun inventory_admin_mut<T0>(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0> {
        assert_version_and_upgrade(arg0);
        assert_listing_admin_or_member(arg0, arg2);
        borrow_inventory_mut<T0>(arg0, arg1)
    }

    public(friend) fun inventory_internal_mut<T0, T1: store, T2: copy + drop + store>(arg0: &mut Listing, arg1: T2, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory::Inventory<T0> {
        assert_version_and_upgrade(arg0);
        venue_internal_mut<T1, T2>(arg0, arg1, arg2);
        borrow_inventory_mut<T0>(arg0, arg3)
    }

    public fun is_admin_or_member(arg0: &Listing, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1) == arg0.admin;
        let v1 = v0;
        let v2 = if (v0 == false) {
            let v3 = MembersDfKey{dummy_field: false};
            0x2::dynamic_field::exists_<MembersDfKey>(&arg0.id, v3)
        } else {
            false
        };
        if (v2) {
            let v4 = MembersDfKey{dummy_field: false};
            let v5 = 0x2::tx_context::sender(arg1);
            v1 = 0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<MembersDfKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v4), &v5);
        };
        v1
    }

    public(friend) fun market_internal_mut<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: 0x2::object::ID) : &mut T0 {
        assert_version_and_upgrade(arg0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::borrow_market_mut<T0, T1>(arg1, venue_internal_mut<T0, T1>(arg0, arg1, arg2))
    }

    entry fun migrate(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg1);
        assert!(arg0.version < 3, 999);
        arg0.version = 3;
    }

    public(friend) fun pay<T0>(arg0: &mut Listing, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        assert_version_and_upgrade(arg0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::proceeds::add<T0>(borrow_proceeds_mut(arg0), arg1, arg2);
    }

    public(friend) fun pay_and_emit_sold_event<T0, T1: key>(arg0: &mut Listing, arg1: &T1, arg2: 0x2::balance::Balance<T0>, arg3: address) {
        assert_version_and_upgrade(arg0);
        emit_sold_event<T0, T1>(arg1, 0x2::balance::value<T0>(&arg2), arg3);
        pay<T0>(arg0, arg2, 1);
    }

    public fun receiver(arg0: &Listing) : address {
        arg0.receiver
    }

    public entry fun remove_member(arg0: &mut Listing, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_listing_admin(arg0, arg2);
        let v0 = MembersDfKey{dummy_field: false};
        0x2::vec_set::remove<address>(0x2::dynamic_field::borrow_mut<MembersDfKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v0), &arg1);
    }

    public(friend) fun remove_venue<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: 0x2::object::ID) : 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue {
        assert_version_and_upgrade(arg0);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(&mut arg0.venues, arg2);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_market<T0, T1>(arg1, &v0);
        v0
    }

    public entry fun request_to_join_marketplace(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace, arg1: &mut Listing, arg2: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::assert_version(arg0);
        assert_version_and_upgrade(arg1);
        assert_listing_admin_or_member(arg1, arg2);
        assert!(0x1::option::is_none<0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::TypedID<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>>(&arg1.marketplace_id), 6);
        let v0 = RequestToJoin{
            id             : 0x2::object::new(arg2),
            marketplace_id : 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::typed_id::new<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace>(arg0),
        };
        let v1 = RequestToJoinDfKey{dummy_field: false};
        0x2::dynamic_object_field::add<RequestToJoinDfKey, RequestToJoin>(&mut arg1.id, v1, v0);
    }

    public entry fun sale_off(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_listing_admin_or_member(arg0, arg2);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::set_live(borrow_venue_mut(arg0, arg1), false);
    }

    public entry fun sale_off_delegated(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace, arg1: &mut Listing, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg1);
        assert_listing_marketplace_match(arg0, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::assert_version(arg0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::assert_listing_admin_or_member(arg0, arg3);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::set_live(borrow_venue_mut(arg1, arg2), false);
    }

    public entry fun sale_on(arg0: &mut Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert_listing_admin_or_member(arg0, arg2);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::set_live(borrow_venue_mut(arg0, arg1), true);
    }

    public entry fun sale_on_delegated(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace, arg1: &mut Listing, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg1);
        assert_listing_marketplace_match(arg0, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::assert_version(arg0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::assert_listing_admin_or_member(arg0, arg3);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::set_live(borrow_venue_mut(arg1, arg2), true);
    }

    public(friend) fun send_rebate<T0: store + key, T1>(arg0: &mut Listing, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::send_rebate<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public entry fun send_rebate_funds_to_address<T0: store + key, T1>(arg0: &mut Listing, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg3);
        let v1 = &mut v0;
        withdraw_rebate_funds<T0, T1>(arg0, v1, arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, arg2);
    }

    public entry fun send_rebate_funds_to_sender<T0: store + key, T1>(arg0: &mut Listing, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        send_rebate_funds_to_address<T0, T1>(arg0, arg1, v0, arg2);
    }

    public entry fun set_rebate<T0: store + key, T1>(arg0: &mut Listing, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg2);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::set_rebate<T0, T1>(&mut arg0.id, arg1);
    }

    public(friend) fun venue_internal_mut<T0: store, T1: copy + drop + store>(arg0: &mut Listing, arg1: T1, arg2: 0x2::object::ID) : &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue {
        assert_version_and_upgrade(arg0);
        let v0 = borrow_venue_mut(arg0, arg2);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_market<T0, T1>(arg1, v0);
        v0
    }

    public entry fun withdraw_rebate_funds<T0: store + key, T1>(arg0: &mut Listing, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance_mut<T1>(arg1);
        withdraw_rebate_funds_to_balance<T0, T1>(arg0, v0, arg2, arg3);
    }

    public fun withdraw_rebate_funds_to_balance<T0: store + key, T1>(arg0: &mut Listing, arg1: &mut 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_listing_admin(arg0, arg3);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate::withdraw_rebate_funds<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

