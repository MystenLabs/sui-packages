module 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item {
    struct ShopRegistry has key {
        id: 0x2::object::UID,
        item_ids: vector<0x2::object::ID>,
        total_created: u64,
    }

    struct ShopItem has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        item_type: u8,
        price_mist: u64,
        stock: u64,
        available: bool,
        available_sizes: 0x1::string::String,
        available_colors: 0x1::string::String,
        image_static: 0x1::string::String,
        image_animated: 0x1::string::String,
        image_back: 0x1::string::String,
        color_bg: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
        created_by: address,
    }

    struct ShopItemCreated has copy, drop {
        item_id: 0x2::object::ID,
        name: 0x1::string::String,
        item_type: u8,
        price_mist: u64,
        initial_stock: u64,
        by: address,
        timestamp: u64,
    }

    struct ShopItemUpdated has copy, drop {
        item_id: 0x2::object::ID,
        by: address,
        timestamp: u64,
    }

    struct StockReplenished has copy, drop {
        item_id: 0x2::object::ID,
        added: u64,
        new_total: u64,
        by: address,
        timestamp: u64,
    }

    struct StockDepleted has copy, drop {
        item_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ItemPaused has copy, drop {
        item_id: 0x2::object::ID,
        by: address,
        timestamp: u64,
    }

    struct ItemUnpaused has copy, drop {
        item_id: 0x2::object::ID,
        by: address,
        timestamp: u64,
    }

    struct StockDecremented has copy, drop {
        item_id: 0x2::object::ID,
        remaining: u64,
        timestamp: u64,
    }

    struct ShopItemBurned has copy, drop {
        item_id: 0x2::object::ID,
        name: 0x1::string::String,
        by: address,
        timestamp: u64,
    }

    public(friend) fun burn_item(arg0: &mut ShopRegistry, arg1: ShopItem, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(!arg1.available, 7);
        let ShopItem {
            id               : v0,
            name             : v1,
            item_type        : _,
            price_mist       : _,
            stock            : _,
            available        : _,
            available_sizes  : _,
            available_colors : _,
            image_static     : _,
            image_animated   : _,
            image_back       : _,
            color_bg         : _,
            created_at       : _,
            updated_at       : _,
            created_by       : _,
        } = arg1;
        let v15 = v0;
        let v16 = 0x2::object::uid_to_inner(&v15);
        let (v17, v18) = 0x1::vector::index_of<0x2::object::ID>(&arg0.item_ids, &v16);
        if (v17) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.item_ids, v18);
        };
        let v19 = ShopItemBurned{
            item_id   : v16,
            name      : v1,
            by        : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ShopItemBurned>(v19);
        0x2::object::delete(v15);
    }

    public(friend) fun create_item(arg0: &mut ShopRegistry, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else if (arg2 == 3) {
            true
        } else {
            arg2 == 4
        };
        assert!(v0, 6);
        assert!(arg3 > 0, 5);
        assert!(arg4 > 0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        let v2 = 0x2::object::new(arg12);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = ShopItem{
            id               : v2,
            name             : arg1,
            item_type        : arg2,
            price_mist       : arg3,
            stock            : arg4,
            available        : true,
            available_sizes  : arg5,
            available_colors : arg6,
            image_static     : arg7,
            image_animated   : arg8,
            image_back       : arg9,
            color_bg         : arg10,
            created_at       : v1,
            updated_at       : v1,
            created_by       : 0x2::tx_context::sender(arg12),
        };
        let v5 = ShopItemCreated{
            item_id       : v3,
            name          : arg1,
            item_type     : arg2,
            price_mist    : arg3,
            initial_stock : arg4,
            by            : 0x2::tx_context::sender(arg12),
            timestamp     : v1,
        };
        0x2::event::emit<ShopItemCreated>(v5);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.item_ids, v3);
        arg0.total_created = arg0.total_created + 1;
        0x2::transfer::share_object<ShopItem>(v4);
    }

    public(friend) fun decrement_stock(arg0: &mut ShopItem, arg1: &0x2::clock::Clock) {
        assert!(arg0.available, 2);
        assert!(arg0.stock > 0, 3);
        arg0.stock = arg0.stock - 1;
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.stock == 0) {
            arg0.available = false;
            let v1 = StockDepleted{
                item_id   : 0x2::object::uid_to_inner(&arg0.id),
                timestamp : v0,
            };
            0x2::event::emit<StockDepleted>(v1);
        };
        let v2 = StockDecremented{
            item_id   : 0x2::object::uid_to_inner(&arg0.id),
            remaining : arg0.stock,
            timestamp : v0,
        };
        0x2::event::emit<StockDecremented>(v2);
        arg0.updated_at = v0;
    }

    public fun get_all_item_ids(arg0: &ShopRegistry) : vector<0x2::object::ID> {
        arg0.item_ids
    }

    public fun get_item_id(arg0: &ShopItem) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_item_info(arg0: &ShopItem) : (0x1::string::String, u8, u64, u64, bool, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.name, arg0.item_type, arg0.price_mist, arg0.stock, arg0.available, arg0.available_sizes, arg0.available_colors, arg0.image_static, arg0.image_animated, arg0.image_back, arg0.color_bg)
    }

    public fun get_item_type(arg0: &ShopItem) : u8 {
        arg0.item_type
    }

    public fun get_name(arg0: &ShopItem) : 0x1::string::String {
        arg0.name
    }

    public fun get_price_mist(arg0: &ShopItem) : u64 {
        arg0.price_mist
    }

    public fun get_stock(arg0: &ShopItem) : u64 {
        arg0.stock
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShopRegistry{
            id            : 0x2::object::new(arg0),
            item_ids      : 0x1::vector::empty<0x2::object::ID>(),
            total_created : 0,
        };
        0x2::transfer::share_object<ShopRegistry>(v0);
    }

    public fun is_available(arg0: &ShopItem) : bool {
        arg0.available
    }

    public(friend) fun pause_item(arg0: &mut ShopItem, arg1: address, arg2: &0x2::clock::Clock) {
        arg0.available = false;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ItemPaused{
            item_id   : 0x2::object::uid_to_inner(&arg0.id),
            by        : arg1,
            timestamp : arg0.updated_at,
        };
        0x2::event::emit<ItemPaused>(v0);
    }

    public(friend) fun replenish_stock(arg0: &mut ShopItem, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg1 > 0, 4);
        arg0.stock = arg0.stock + arg1;
        if (!arg0.available) {
            arg0.available = true;
        };
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = StockReplenished{
            item_id   : 0x2::object::uid_to_inner(&arg0.id),
            added     : arg1,
            new_total : arg0.stock,
            by        : arg2,
            timestamp : arg0.updated_at,
        };
        0x2::event::emit<StockReplenished>(v0);
    }

    public fun total_created(arg0: &ShopRegistry) : u64 {
        arg0.total_created
    }

    public fun type_hoodie() : u8 {
        1
    }

    public fun type_mousepad() : u8 {
        3
    }

    public fun type_mug() : u8 {
        2
    }

    public fun type_other() : u8 {
        4
    }

    public fun type_shirt() : u8 {
        0
    }

    public(friend) fun unpause_item(arg0: &mut ShopItem, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(arg0.stock > 0, 3);
        arg0.available = true;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ItemUnpaused{
            item_id   : 0x2::object::uid_to_inner(&arg0.id),
            by        : arg1,
            timestamp : arg0.updated_at,
        };
        0x2::event::emit<ItemUnpaused>(v0);
    }

    public(friend) fun update_item_display(arg0: &mut ShopItem, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: address, arg9: &0x2::clock::Clock) {
        arg0.name = arg1;
        arg0.available_sizes = arg2;
        arg0.available_colors = arg3;
        arg0.image_static = arg4;
        arg0.image_animated = arg5;
        arg0.image_back = arg6;
        arg0.color_bg = arg7;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg9);
        let v0 = ShopItemUpdated{
            item_id   : 0x2::object::uid_to_inner(&arg0.id),
            by        : arg8,
            timestamp : arg0.updated_at,
        };
        0x2::event::emit<ShopItemUpdated>(v0);
    }

    public(friend) fun update_item_price(arg0: &mut ShopItem, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg1 > 0, 5);
        arg0.price_mist = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ShopItemUpdated{
            item_id   : 0x2::object::uid_to_inner(&arg0.id),
            by        : arg2,
            timestamp : arg0.updated_at,
        };
        0x2::event::emit<ShopItemUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

