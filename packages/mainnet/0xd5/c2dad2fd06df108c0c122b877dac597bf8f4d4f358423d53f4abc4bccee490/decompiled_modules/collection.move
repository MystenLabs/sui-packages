module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection {
    struct Collection has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        cumulative_items_count: u64,
        items_count: u64,
        pending_burn_items_ids: vector<0x2::object::ID>,
        pending_burn_count: u64,
        burnable_items_ids: vector<0x2::object::ID>,
        burnable_count: u64,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    struct CollectionEdited has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    public(friend) fun add_burnable_item(arg0: &mut Collection, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.burnable_items_ids, arg1);
        arg0.burnable_count = arg0.burnable_count + 1;
    }

    public(friend) fun add_pending_burn_item(arg0: &mut Collection, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pending_burn_items_ids, arg1);
        arg0.pending_burn_count = arg0.pending_burn_count + 1;
    }

    public fun admin_create_collection(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg4), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 1);
        let v0 = Collection{
            id                     : 0x2::object::new(arg4),
            owner                  : arg3,
            name                   : arg1,
            description            : arg2,
            cumulative_items_count : 0,
            items_count            : 0,
            pending_burn_items_ids : 0x1::vector::empty<0x2::object::ID>(),
            pending_burn_count     : 0,
            burnable_items_ids     : 0x1::vector::empty<0x2::object::ID>(),
            burnable_count         : 0,
        };
        let v1 = CollectionCreated{
            collection_id : 0x2::object::id<Collection>(&v0),
            owner         : arg3,
            name          : arg1,
        };
        0x2::event::emit<CollectionCreated>(v1);
        0x2::transfer::share_object<Collection>(v0);
    }

    public(friend) fun borrow_collection_id(arg0: &Collection) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_collection_id_mut(arg0: &mut Collection) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun borrow_pending_burn_items_ids(arg0: &Collection) : &vector<0x2::object::ID> {
        &arg0.pending_burn_items_ids
    }

    public fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Collection{
            id                     : 0x2::object::new(arg2),
            owner                  : v0,
            name                   : arg0,
            description            : arg1,
            cumulative_items_count : 0,
            items_count            : 0,
            pending_burn_items_ids : 0x1::vector::empty<0x2::object::ID>(),
            pending_burn_count     : 0,
            burnable_items_ids     : 0x1::vector::empty<0x2::object::ID>(),
            burnable_count         : 0,
        };
        let v2 = CollectionCreated{
            collection_id : 0x2::object::id<Collection>(&v1),
            owner         : v0,
            name          : arg0,
        };
        0x2::event::emit<CollectionCreated>(v2);
        0x2::transfer::share_object<Collection>(v1);
    }

    public(friend) fun decrement_items_count(arg0: &mut Collection, arg1: u64) {
        arg0.items_count = arg0.items_count - arg1;
    }

    public fun edit_collection(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        arg0.name = arg1;
        arg0.description = arg2;
        let v0 = CollectionEdited{
            collection_id : 0x2::object::id<Collection>(arg0),
            name          : arg0.name,
            description   : arg0.description,
        };
        0x2::event::emit<CollectionEdited>(v0);
    }

    public fun get_burnable_count(arg0: &Collection) : u64 {
        arg0.burnable_count
    }

    public(friend) fun get_burnable_count_value(arg0: &Collection) : u64 {
        arg0.burnable_count
    }

    public fun get_burnable_item_ids(arg0: &Collection) : vector<0x2::object::ID> {
        arg0.burnable_items_ids
    }

    public(friend) fun get_burnable_items_ids(arg0: &Collection) : &vector<0x2::object::ID> {
        &arg0.burnable_items_ids
    }

    public fun get_collection_cumulative_items_count(arg0: &Collection) : u64 {
        arg0.cumulative_items_count
    }

    public fun get_collection_info(arg0: &Collection) : (0x2::object::ID, address, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64) {
        (0x2::object::id<Collection>(arg0), arg0.owner, arg0.name, arg0.description, arg0.cumulative_items_count, arg0.items_count, arg0.pending_burn_count, arg0.burnable_count)
    }

    public fun get_collection_items_count(arg0: &Collection) : u64 {
        arg0.items_count
    }

    public fun get_collection_owner(arg0: &Collection) : address {
        arg0.owner
    }

    public(friend) fun get_owner(arg0: &Collection) : address {
        arg0.owner
    }

    public fun get_pending_burn_item_count(arg0: &Collection) : u64 {
        arg0.pending_burn_count
    }

    public fun get_pending_burn_item_ids(arg0: &Collection) : vector<0x2::object::ID> {
        arg0.pending_burn_items_ids
    }

    public(friend) fun increment_cumulative_items_count(arg0: &mut Collection) : u64 {
        arg0.cumulative_items_count = arg0.cumulative_items_count + 1;
        arg0.cumulative_items_count
    }

    public(friend) fun increment_items_count(arg0: &mut Collection) {
        arg0.items_count = arg0.items_count + 1;
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun pop_burnable_item(arg0: &mut Collection) : 0x2::object::ID {
        0x1::vector::pop_back<0x2::object::ID>(&mut arg0.burnable_items_ids)
    }

    public(friend) fun remove_pending_burn_item(arg0: &mut Collection, arg1: 0x2::object::ID) : bool {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.pending_burn_items_ids, &arg1);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.pending_burn_items_ids, v1);
            arg0.pending_burn_count = arg0.pending_burn_count - 1;
        };
        v0
    }

    public(friend) fun reset_burnable_count(arg0: &mut Collection) {
        arg0.burnable_count = 0;
    }

    // decompiled from Move bytecode v6
}

