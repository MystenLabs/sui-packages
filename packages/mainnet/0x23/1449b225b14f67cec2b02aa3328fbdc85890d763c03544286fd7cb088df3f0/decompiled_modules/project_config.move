module 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::project_config {
    struct WhitelistedCollections has store, key {
        id: 0x2::object::UID,
        admin_id: 0x2::object::ID,
        whitelisted: vector<WhitelistedCollection>,
    }

    struct WhitelistedCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        items: vector<address>,
        enabled: bool,
    }

    struct ProjectConfig has store, key {
        id: 0x2::object::UID,
        admin: 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::AdminConfig,
        collections: WhitelistedCollections,
        raffles: vector<0x2::object::ID>,
    }

    struct Participation has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        tickets: vector<u64>,
    }

    public entry fun add_collection(arg0: &mut ProjectConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1) = deep(arg0);
        assert!(0x2::tx_context::sender(arg2) == 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::get_owner(v0), 1);
        let v2 = WhitelistedCollection{
            id      : 0x2::object::new(arg2),
            name    : arg1,
            items   : 0x1::vector::empty<address>(),
            enabled : false,
        };
        let v3 = 0x1::vector::length<WhitelistedCollection>(&v1.whitelisted);
        0x1::vector::insert<WhitelistedCollection>(&mut v1.whitelisted, v2, v3);
        v3
    }

    public entry fun add_item_to_collection(arg0: &mut ProjectConfig, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = deep(arg0);
        assert!(0x2::tx_context::sender(arg3) == 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::get_owner(v0), 1);
        0x1::vector::push_back<address>(&mut 0x1::vector::borrow_mut<WhitelistedCollection>(&mut v1.whitelisted, arg1).items, arg2);
    }

    public entry fun add_items_to_collection(arg0: &mut ProjectConfig, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = deep(arg0);
        assert!(0x2::tx_context::sender(arg3) == 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::get_owner(v0), 1);
        0x1::vector::append<address>(&mut 0x1::vector::borrow_mut<WhitelistedCollection>(&mut v1.whitelisted, arg1).items, arg2);
    }

    public fun add_raffle(arg0: &mut ProjectConfig, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.raffles, arg1);
    }

    public fun contains_item(arg0: &ProjectConfig, arg1: u64, arg2: address) : bool {
        let (_, v1) = deep_immutable(arg0);
        let (v2, _) = 0x1::vector::index_of<address>(&0x1::vector::borrow<WhitelistedCollection>(&v1.whitelisted, arg1).items, &arg2);
        v2
    }

    public fun deep(arg0: &mut ProjectConfig) : (&mut 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::AdminConfig, &mut WhitelistedCollections) {
        (&mut arg0.admin, &mut arg0.collections)
    }

    public fun deep_immutable(arg0: &ProjectConfig) : (&0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::AdminConfig, &WhitelistedCollections) {
        (&arg0.admin, &arg0.collections)
    }

    public entry fun get_collections(arg0: &ProjectConfig, arg1: u64) : vector<address> {
        let (_, v1) = deep_immutable(arg0);
        0x1::vector::borrow<WhitelistedCollection>(&v1.whitelisted, arg1).items
    }

    public entry fun get_id(arg0: &ProjectConfig, arg1: u64) : 0x2::object::ID {
        let (_, v1) = deep_immutable(arg0);
        0x2::object::id<WhitelistedCollection>(0x1::vector::borrow<WhitelistedCollection>(&v1.whitelisted, arg1))
    }

    public entry fun get_item_count(arg0: &ProjectConfig, arg1: u64) : u64 {
        let (_, v1) = deep_immutable(arg0);
        0x1::vector::length<address>(&0x1::vector::borrow<WhitelistedCollection>(&v1.whitelisted, arg1).items)
    }

    public entry fun get_items(arg0: &ProjectConfig, arg1: u64) : vector<address> {
        let (_, v1) = deep_immutable(arg0);
        0x1::vector::borrow<WhitelistedCollection>(&v1.whitelisted, arg1).items
    }

    public entry fun get_name(arg0: &ProjectConfig, arg1: u64) : 0x1::string::String {
        let (_, v1) = deep_immutable(arg0);
        0x1::vector::borrow<WhitelistedCollection>(&v1.whitelisted, arg1).name
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::init_(arg0);
        let v1 = WhitelistedCollections{
            id          : 0x2::object::new(arg0),
            admin_id    : 0x2::object::id<0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::AdminConfig>(&v0),
            whitelisted : 0x1::vector::empty<WhitelistedCollection>(),
        };
        let v2 = ProjectConfig{
            id          : 0x2::object::new(arg0),
            admin       : v0,
            collections : v1,
            raffles     : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<ProjectConfig>(v2);
        0x2::object::id<ProjectConfig>(&v2)
    }

    public entry fun is_admin(arg0: &ProjectConfig) : bool {
        let (_, _) = deep_immutable(arg0);
        true
    }

    public entry fun is_enabled(arg0: &ProjectConfig, arg1: u64) : bool {
        let (_, v1) = deep_immutable(arg0);
        0x1::vector::borrow<WhitelistedCollection>(&v1.whitelisted, arg1).enabled
    }

    public entry fun remove_empty_collection(arg0: &mut ProjectConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = deep(arg0);
        assert!(0x2::tx_context::sender(arg2) == 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::get_owner(v0), 1);
        assert!(0x1::vector::length<address>(&0x1::vector::borrow_mut<WhitelistedCollection>(&mut v1.whitelisted, arg1).items) == 0, 3);
        let WhitelistedCollection {
            id      : v2,
            name    : _,
            items   : _,
            enabled : _,
        } = 0x1::vector::remove<WhitelistedCollection>(&mut v1.whitelisted, arg1);
        0x2::object::delete(v2);
    }

    public entry fun remove_item_from_collection(arg0: &mut ProjectConfig, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = deep(arg0);
        assert!(0x2::tx_context::sender(arg3) == 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::get_owner(v0), 1);
        let v2 = 0x1::vector::borrow_mut<WhitelistedCollection>(&mut v1.whitelisted, arg1);
        let (v3, v4) = 0x1::vector::index_of<address>(&v2.items, &arg2);
        assert!(v3, 2);
        0x1::vector::remove<address>(&mut v2.items, v4);
    }

    public entry fun set_enabled(arg0: &mut ProjectConfig, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = deep(arg0);
        assert!(0x2::tx_context::sender(arg3) == 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::get_owner(v0), 1);
        0x1::vector::borrow_mut<WhitelistedCollection>(&mut v1.whitelisted, arg1).enabled = arg2;
    }

    // decompiled from Move bytecode v6
}

