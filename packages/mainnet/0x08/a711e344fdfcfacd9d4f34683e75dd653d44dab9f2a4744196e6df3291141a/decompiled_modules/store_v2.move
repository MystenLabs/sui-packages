module 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::store_v2 {
    struct Market has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MarketConfig has store {
        commission: u16,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AccessoryListing<phantom T0: drop> has store {
        name: 0x1::string::String,
        type: 0x1::string::String,
        price: u64,
        quantity: 0x1::option::Option<u64>,
    }

    struct GatedAccessoryListing<phantom T0: drop> has store {
        listing: AccessoryListing<T0>,
        accepted_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        used_objects: 0x2::table::Table<0x2::object::ID, bool>,
    }

    public fun add_gated_listing<T0: drop>(arg0: &0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::Wardrobe, arg1: &mut Market, arg2: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg8: &mut 0x2::tx_context::TxContext) {
        0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::assert_type_is_authorized<T0>(arg0);
        0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::assert_store_is_authorized<T0, MarketConfig>(&arg1.id);
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(&arg7) > 0, 8);
        let v0 = AccessoryListing<T0>{
            name     : arg3,
            type     : arg4,
            price    : arg5,
            quantity : arg6,
        };
        let v1 = GatedAccessoryListing<T0>{
            listing        : v0,
            accepted_types : arg7,
            used_objects   : 0x2::table::new<0x2::object::ID, bool>(arg8),
        };
        0x2::dynamic_field::add<0x1::string::String, GatedAccessoryListing<T0>>(&mut arg1.id, arg3, v1);
    }

    public fun add_listing<T0: drop>(arg0: &0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::Wardrobe, arg1: &mut Market, arg2: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::option::Option<u64>) {
        0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::assert_type_is_authorized<T0>(arg0);
        0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::assert_store_is_authorized<T0, MarketConfig>(&arg1.id);
        let v0 = AccessoryListing<T0>{
            name     : arg3,
            type     : arg4,
            price    : arg5,
            quantity : arg6,
        };
        0x2::dynamic_field::add<0x1::string::String, AccessoryListing<T0>>(&mut arg1.id, arg3, v0);
    }

    public fun admin_set_commission<T0: drop>(arg0: &mut Market, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg2: u16) {
        assert!(0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::commission::is_valid_commission(arg2), 7);
        internal_config_mut<T0>(arg0).commission = arg2;
    }

    public fun admin_withdraw(arg0: &mut Market, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg2)
    }

    public fun authorize_accessory_type<T0: drop>(arg0: &0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::Wardrobe, arg1: &mut Market, arg2: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg3: u16) {
        let v0 = MarketConfig{
            commission : arg3,
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::store_install<T0, MarketConfig>(arg0, &mut arg1.id, arg2, v0);
    }

    public fun creator_withdraw<T0: drop>(arg0: &mut Market, arg1: &0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::CreatorCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = internal_config_mut<T0>(arg0);
        0x2::coin::take<0x2::sui::SUI>(&mut v0.balance, 0x2::balance::value<0x2::sui::SUI>(&v0.balance), arg2)
    }

    public fun deauthorize_accessory_type<T0: drop>(arg0: &mut Market, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap) {
        let MarketConfig {
            commission : _,
            balance    : v1,
        } = 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::store_uninstall<T0, MarketConfig>(&mut arg0.id, arg1);
        let v2 = v1;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v2) == 0, 1);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Market{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Market>(v0);
    }

    fun internal_assert_listing_exists<T0: store>(arg0: &mut Market, arg1: 0x1::string::String) {
        assert!(0x2::dynamic_field::exists_with_type<0x1::string::String, T0>(&mut arg0.id, arg1), 2);
    }

    fun internal_config_mut<T0: drop>(arg0: &mut Market) : &mut MarketConfig {
        0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::store_config_mut<T0, MarketConfig>(&mut arg0.id)
    }

    fun internal_handle_sale<T0: drop>(arg0: &mut Market, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_config_mut<T0>(arg0);
        0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::commission::split_commission(&mut arg1, v0.commission, arg2));
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    fun internal_purchase<T0: drop>(arg0: &mut Market, arg1: &mut AccessoryListing<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::Accessory<T0>, 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::LockedPromise) {
        assert!(arg1.price == 0x2::coin::value<0x2::sui::SUI>(&arg2), 4);
        if (0x1::option::is_some<u64>(&arg1.quantity)) {
            let v0 = *0x1::option::borrow<u64>(&arg1.quantity);
            assert!(v0 > 0, 3);
            0x1::option::swap<u64>(&mut arg1.quantity, v0 - 1);
        };
        internal_handle_sale<T0>(arg0, arg2, arg3);
        0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::mint<T0>(&mut arg0.id, arg1.name, arg1.type, arg3)
    }

    public fun purchase<T0: drop>(arg0: &mut Market, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::Accessory<T0>, 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::LockedPromise) {
        internal_assert_listing_exists<AccessoryListing<T0>>(arg0, arg1);
        0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::assert_store_is_authorized<T0, MarketConfig>(&arg0.id);
        let v0 = 0x2::dynamic_field::remove<0x1::string::String, AccessoryListing<T0>>(&mut arg0.id, arg1);
        let v1 = &mut v0;
        let (v2, v3) = internal_purchase<T0>(arg0, v1, arg2, arg3);
        0x2::dynamic_field::add<0x1::string::String, AccessoryListing<T0>>(&mut arg0.id, arg1, v0);
        (v2, v3)
    }

    public fun purchase_gated<T0: drop, T1: key>(arg0: &mut Market, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &T1, arg4: &mut 0x2::tx_context::TxContext) : (0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::Accessory<T0>, 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::LockedPromise) {
        internal_assert_listing_exists<GatedAccessoryListing<T0>>(arg0, arg1);
        0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2::assert_store_is_authorized<T0, MarketConfig>(&arg0.id);
        let v0 = 0x2::dynamic_field::remove<0x1::string::String, GatedAccessoryListing<T0>>(&mut arg0.id, arg1);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v0.accepted_types, &v1), 5);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&v0.used_objects, 0x2::object::id<T1>(arg3)), 6);
        let v2 = &mut v0.listing;
        let (v3, v4) = internal_purchase<T0>(arg0, v2, arg2, arg4);
        0x2::table::add<0x2::object::ID, bool>(&mut v0.used_objects, 0x2::object::id<T1>(arg3), true);
        0x2::dynamic_field::add<0x1::string::String, GatedAccessoryListing<T0>>(&mut arg0.id, arg1, v0);
        (v3, v4)
    }

    public fun remove_gated_listing<T0: drop>(arg0: &mut Market, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg2: 0x1::string::String) {
        internal_assert_listing_exists<GatedAccessoryListing<T0>>(arg0, arg2);
        let GatedAccessoryListing {
            listing        : v0,
            accepted_types : _,
            used_objects   : v2,
        } = 0x2::dynamic_field::remove<0x1::string::String, GatedAccessoryListing<T0>>(&mut arg0.id, arg2);
        let AccessoryListing {
            name     : _,
            type     : _,
            price    : _,
            quantity : _,
        } = v0;
        0x2::table::drop<0x2::object::ID, bool>(v2);
    }

    public fun remove_listing<T0: drop>(arg0: &mut Market, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg2: 0x1::string::String) {
        internal_assert_listing_exists<AccessoryListing<T0>>(arg0, arg2);
        let AccessoryListing {
            name     : _,
            type     : _,
            price    : _,
            quantity : _,
        } = 0x2::dynamic_field::remove<0x1::string::String, AccessoryListing<T0>>(&mut arg0.id, arg2);
    }

    // decompiled from Move bytecode v6
}

