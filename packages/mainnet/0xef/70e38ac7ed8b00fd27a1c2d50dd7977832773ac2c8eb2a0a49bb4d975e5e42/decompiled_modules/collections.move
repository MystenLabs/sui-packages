module 0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::collections {
    struct WhitelistedCollections has store, key {
        id: 0x2::object::UID,
        admin_id: 0x2::object::ID,
        whitelisted: 0x2::object_table::ObjectTable<address, WhitelistedCollection>,
    }

    struct WhitelistedCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        items: vector<address>,
        enabled: bool,
    }

    public fun add(arg0: &mut WhitelistedCollections, arg1: 0x1::string::String, arg2: vector<address>, arg3: &0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig, arg4: &mut 0x2::tx_context::TxContext) : address {
        assert!(0x2::tx_context::sender(arg4) == 0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::get_owner(arg3), 1);
        let v0 = WhitelistedCollection{
            id      : 0x2::object::new(arg4),
            name    : arg1,
            items   : arg2,
            enabled : false,
        };
        let v1 = 0x2::object::id_address<WhitelistedCollection>(&v0);
        0x2::object_table::add<address, WhitelistedCollection>(&mut arg0.whitelisted, v1, v0);
        v1
    }

    public fun add_item(arg0: &mut WhitelistedCollections, arg1: address, arg2: address, arg3: &0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::get_owner(arg3), 1);
        0x1::vector::push_back<address>(&mut 0x2::object_table::borrow_mut<address, WhitelistedCollection>(&mut arg0.whitelisted, arg1).items, arg2);
    }

    public fun add_items(arg0: &mut WhitelistedCollections, arg1: address, arg2: vector<address>, arg3: &0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::get_owner(arg3), 1);
        0x1::vector::append<address>(&mut 0x2::object_table::borrow_mut<address, WhitelistedCollection>(&mut arg0.whitelisted, arg1).items, arg2);
    }

    public fun contains_item(arg0: &WhitelistedCollections, arg1: address, arg2: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&0x2::object_table::borrow<address, WhitelistedCollection>(&arg0.whitelisted, arg1).items, &arg2);
        v0
    }

    public fun get_id(arg0: &WhitelistedCollections, arg1: address) : 0x2::object::ID {
        0x2::object::id<WhitelistedCollection>(0x2::object_table::borrow<address, WhitelistedCollection>(&arg0.whitelisted, arg1))
    }

    public fun get_item_count(arg0: &WhitelistedCollections, arg1: address) : u64 {
        0x1::vector::length<address>(&0x2::object_table::borrow<address, WhitelistedCollection>(&arg0.whitelisted, arg1).items)
    }

    public fun get_items(arg0: &WhitelistedCollections, arg1: address) : vector<address> {
        0x2::object_table::borrow<address, WhitelistedCollection>(&arg0.whitelisted, arg1).items
    }

    public fun get_name(arg0: &WhitelistedCollections, arg1: address) : 0x1::string::String {
        0x2::object_table::borrow<address, WhitelistedCollection>(&arg0.whitelisted, arg1).name
    }

    public(friend) fun init_(arg0: &0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig, arg1: &mut 0x2::tx_context::TxContext) : WhitelistedCollections {
        WhitelistedCollections{
            id          : 0x2::object::new(arg1),
            admin_id    : 0x2::object::id<0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig>(arg0),
            whitelisted : 0x2::object_table::new<address, WhitelistedCollection>(arg1),
        }
    }

    public fun is_admin(arg0: &WhitelistedCollections, arg1: &0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig) : bool {
        arg0.admin_id == 0x2::object::id<0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig>(arg1)
    }

    public fun is_enabled(arg0: &WhitelistedCollections, arg1: address) : bool {
        0x2::object_table::borrow<address, WhitelistedCollection>(&arg0.whitelisted, arg1).enabled
    }

    public(friend) fun propagate(arg0: WhitelistedCollections) {
        0x2::transfer::share_object<WhitelistedCollections>(arg0);
    }

    public fun remove_empty(arg0: &mut WhitelistedCollections, arg1: address, arg2: &0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::get_owner(arg2), 1);
        assert!(0x1::vector::length<address>(&0x2::object_table::borrow_mut<address, WhitelistedCollection>(&mut arg0.whitelisted, arg1).items) == 0, 3);
        let WhitelistedCollection {
            id      : v0,
            name    : _,
            items   : _,
            enabled : _,
        } = 0x2::object_table::remove<address, WhitelistedCollection>(&mut arg0.whitelisted, arg1);
        0x2::object::delete(v0);
    }

    public fun remove_item(arg0: &mut WhitelistedCollections, arg1: address, arg2: address, arg3: &0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::get_owner(arg3), 1);
        let v0 = 0x2::object_table::borrow_mut<address, WhitelistedCollection>(&mut arg0.whitelisted, arg1);
        let (v1, v2) = 0x1::vector::index_of<address>(&v0.items, &arg2);
        assert!(v1, 2);
        0x1::vector::remove<address>(&mut v0.items, v2);
    }

    public fun set_enabled(arg0: &mut WhitelistedCollections, arg1: address, arg2: bool, arg3: &0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::AdminConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0xef70e38ac7ed8b00fd27a1c2d50dd7977832773ac2c8eb2a0a49bb4d975e5e42::admin::get_owner(arg3), 1);
        0x2::object_table::borrow_mut<address, WhitelistedCollection>(&mut arg0.whitelisted, arg1).enabled = arg2;
    }

    // decompiled from Move bytecode v6
}

