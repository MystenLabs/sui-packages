module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_product {
    struct ProductKey has copy, drop, store {
        product_id: 0x2::object::ID,
    }

    struct Product has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        max_supply: 0x1::option::Option<u64>,
        current_supply: u64,
        is_bundle: bool,
        is_active: bool,
        created_at: u64,
    }

    struct PriceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProductPriceInfo has store {
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct BundleKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BundleInfo has store {
        included_product_ids: vector<0x2::object::ID>,
        included_quantities: vector<u64>,
    }

    struct ProductCreated has copy, drop {
        product_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
        name: 0x1::string::String,
        is_bundle: bool,
    }

    struct ProductUpdated has copy, drop {
        product_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct ProductActiveToggled has copy, drop {
        product_id: 0x2::object::ID,
        is_active: bool,
    }

    struct ProductPriceSet has copy, drop {
        product_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
    }

    struct ProductPriceRemoved has copy, drop {
        product_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
    }

    struct BundleItemsUpdated has copy, drop {
        product_id: 0x2::object::ID,
        included_product_ids: vector<0x2::object::ID>,
        included_quantities: vector<u64>,
    }

    struct ProductMaxSupplyUpdated has copy, drop {
        product_id: 0x2::object::ID,
        max_supply: 0x1::option::Option<u64>,
    }

    public(friend) fun borrow_product(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg1: 0x2::object::ID) : &Product {
        assert!(product_exists(arg0, arg1), 6);
        let v0 = ProductKey{product_id: arg1};
        0x2::dynamic_field::borrow<ProductKey, Product>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_uid(arg0), v0)
    }

    public(friend) fun borrow_product_mut(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg1: 0x2::object::ID) : &mut Product {
        assert!(product_exists(arg0, arg1), 6);
        let v0 = ProductKey{product_id: arg1};
        0x2::dynamic_field::borrow_mut<ProductKey, Product>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_uid_mut(arg0), v0)
    }

    public fun create_product(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = if (v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_game_company(arg1)) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::is_game_active(arg1), 2);
        let v2 = 0x2::object::new(arg7);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_id(arg1);
        let v5 = Product{
            id             : v2,
            game_id        : v4,
            name           : arg2,
            description    : arg3,
            max_supply     : arg5,
            current_supply : 0,
            is_bundle      : arg4,
            is_active      : true,
            created_at     : 0x2::clock::timestamp_ms(arg6),
        };
        let v6 = ProductPriceInfo{prices: 0x2::vec_map::empty<0x1::type_name::TypeName, u64>()};
        let v7 = PriceKey{dummy_field: false};
        0x2::dynamic_field::add<PriceKey, ProductPriceInfo>(&mut v5.id, v7, v6);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::increment_game_products(arg1);
        let v8 = ProductCreated{
            product_id : v3,
            game_id    : v4,
            name       : v5.name,
            is_bundle  : arg4,
        };
        0x2::event::emit<ProductCreated>(v8);
        let v9 = ProductKey{product_id: v3};
        0x2::dynamic_field::add<ProductKey, Product>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_uid_mut(arg1), v9, v5);
        v3
    }

    public fun get_bundle_product_ids(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        let v0 = borrow_product(arg0, arg1);
        let v1 = BundleKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<BundleKey>(&v0.id, v1)) {
            let v3 = BundleKey{dummy_field: false};
            0x2::dynamic_field::borrow<BundleKey, BundleInfo>(&v0.id, v3).included_product_ids
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_bundle_quantities(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg1: 0x2::object::ID) : vector<u64> {
        let v0 = borrow_product(arg0, arg1);
        let v1 = BundleKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<BundleKey>(&v0.id, v1)) {
            let v3 = BundleKey{dummy_field: false};
            0x2::dynamic_field::borrow<BundleKey, BundleInfo>(&v0.id, v3).included_quantities
        } else {
            0x1::vector::empty<u64>()
        }
    }

    public fun get_product_current_supply(arg0: &Product) : u64 {
        arg0.current_supply
    }

    public fun get_product_description(arg0: &Product) : 0x1::string::String {
        arg0.description
    }

    public fun get_product_max_supply(arg0: &Product) : 0x1::option::Option<u64> {
        arg0.max_supply
    }

    public fun get_product_name(arg0: &Product) : 0x1::string::String {
        arg0.name
    }

    public fun get_product_price<T0>(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg1: 0x2::object::ID) : u64 {
        let v0 = PriceKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PriceKey, ProductPriceInfo>(&borrow_product(arg0, arg1).id, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v1.prices, &v2), 7);
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v1.prices, &v2)
    }

    public fun has_product_price<T0>(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg1: 0x2::object::ID) : bool {
        let v0 = PriceKey{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&0x2::dynamic_field::borrow<PriceKey, ProductPriceInfo>(&borrow_product(arg0, arg1).id, v0).prices, &v1)
    }

    public(friend) fun increment_product_supply(arg0: &mut Product) {
        if (0x1::option::is_some<u64>(&arg0.max_supply)) {
            assert!(arg0.current_supply < *0x1::option::borrow<u64>(&arg0.max_supply), 5);
        };
        arg0.current_supply = arg0.current_supply + 1;
    }

    public fun is_bundle_product(arg0: &Product) : bool {
        arg0.is_bundle
    }

    public fun is_product_active(arg0: &Product) : bool {
        arg0.is_active
    }

    public fun product_exists(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg1: 0x2::object::ID) : bool {
        let v0 = ProductKey{product_id: arg1};
        0x2::dynamic_field::exists_<ProductKey>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_uid(arg0), v0)
    }

    public(friend) fun product_game_id(arg0: &Product) : 0x2::object::ID {
        arg0.game_id
    }

    public fun remove_product_price<T0>(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_game_company(arg1)) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        let v2 = PriceKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<PriceKey, ProductPriceInfo>(&mut borrow_product_mut(arg1, arg2).id, v2);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v3.prices, &v4)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v3.prices, &v4);
            let v7 = ProductPriceRemoved{
                product_id : arg2,
                coin_type  : 0x1::type_name::into_string(v4),
            };
            0x2::event::emit<ProductPriceRemoved>(v7);
        };
    }

    public fun set_bundle_items(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg2: 0x2::object::ID, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_game_company(arg1)) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        let v2 = borrow_product_mut(arg1, arg2);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == 0x1::vector::length<u64>(&arg4), 9);
        let v3 = BundleInfo{
            included_product_ids : arg3,
            included_quantities  : arg4,
        };
        let v4 = BundleKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<BundleKey>(&v2.id, v4)) {
            let v5 = BundleKey{dummy_field: false};
            let BundleInfo {
                included_product_ids : _,
                included_quantities  : _,
            } = 0x2::dynamic_field::remove<BundleKey, BundleInfo>(&mut v2.id, v5);
        };
        let v8 = BundleKey{dummy_field: false};
        0x2::dynamic_field::add<BundleKey, BundleInfo>(&mut v2.id, v8, v3);
        let v9 = BundleItemsUpdated{
            product_id           : arg2,
            included_product_ids : get_bundle_product_ids(arg1, arg2),
            included_quantities  : get_bundle_quantities(arg1, arg2),
        };
        0x2::event::emit<BundleItemsUpdated>(v9);
    }

    public fun set_product_price<T0>(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = if (v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_game_company(arg1)) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        let v2 = PriceKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<PriceKey, ProductPriceInfo>(&mut borrow_product_mut(arg1, arg2).id, v2);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v3.prices, &v4)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v3.prices, &v4) = arg3;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v3.prices, v4, arg3);
        };
        let v5 = ProductPriceSet{
            product_id : arg2,
            coin_type  : 0x1::type_name::into_string(v4),
            price      : arg3,
        };
        0x2::event::emit<ProductPriceSet>(v5);
    }

    public fun toggle_product_active(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_game_company(arg1)) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        let v2 = borrow_product_mut(arg1, arg2);
        v2.is_active = !v2.is_active;
        let v3 = ProductActiveToggled{
            product_id : arg2,
            is_active  : v2.is_active,
        };
        0x2::event::emit<ProductActiveToggled>(v3);
    }

    public fun update_max_supply(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg2: 0x2::object::ID, arg3: 0x1::option::Option<u64>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = if (v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_game_company(arg1)) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        let v2 = borrow_product_mut(arg1, arg2);
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) >= v2.current_supply, 10);
        };
        v2.max_supply = arg3;
        let v3 = ProductMaxSupplyUpdated{
            product_id : arg2,
            max_supply : arg3,
        };
        0x2::event::emit<ProductMaxSupplyUpdated>(v3);
    }

    public fun update_product_metadata(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::Game, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::store_game::game_game_company(arg1)) {
            true
        } else if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role())) {
            true
        } else {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role())
        };
        assert!(v1, 1);
        let v2 = borrow_product_mut(arg1, arg2);
        v2.name = arg3;
        v2.description = arg4;
        let v3 = ProductUpdated{
            product_id : arg2,
            name       : v2.name,
        };
        0x2::event::emit<ProductUpdated>(v3);
    }

    // decompiled from Move bytecode v7
}

