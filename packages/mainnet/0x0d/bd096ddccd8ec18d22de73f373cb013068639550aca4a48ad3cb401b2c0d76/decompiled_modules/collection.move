module 0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::collection {
    struct CollectionCreatedEvent has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        total_supply: u64,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        current_minted: u64,
        total_supply: u64,
        allocated_supply: u64,
        is_active: bool,
    }

    public fun new(arg0: &0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id               : 0x2::object::new(arg4),
            name             : arg1,
            description      : arg2,
            creator          : 0x2::tx_context::sender(arg4),
            current_minted   : 0,
            total_supply     : arg3,
            allocated_supply : 0,
            is_active        : true,
        };
        let v1 = CollectionCreatedEvent{
            collection_id : 0x2::object::id<Collection>(&v0),
            name          : v0.name,
            description   : v0.description,
            creator       : v0.creator,
            total_supply  : v0.total_supply,
        };
        0x2::event::emit<CollectionCreatedEvent>(v1);
        0x2::transfer::share_object<Collection>(v0);
    }

    public(friend) fun allocate_supply(arg0: &mut Collection, arg1: u64) {
        assert!(arg0.allocated_supply <= arg0.total_supply - arg1, 0);
        arg0.allocated_supply = arg0.allocated_supply + arg1;
    }

    public fun allocated_supply(arg0: &Collection) : u64 {
        arg0.allocated_supply
    }

    public fun available_supply(arg0: &Collection) : u64 {
        arg0.total_supply - arg0.allocated_supply
    }

    public fun creator(arg0: &Collection) : address {
        arg0.creator
    }

    public fun current_minted(arg0: &Collection) : u64 {
        arg0.current_minted
    }

    public(friend) fun deallocate_supply(arg0: &mut Collection, arg1: u64) {
        assert!(arg0.allocated_supply >= arg1, 1);
        arg0.allocated_supply = arg0.allocated_supply - arg1;
    }

    public fun description(arg0: &Collection) : &0x1::string::String {
        &arg0.description
    }

    public(friend) fun increment_supply(arg0: &mut Collection) : u64 {
        assert!(arg0.current_minted < arg0.total_supply, 0);
        arg0.current_minted = arg0.current_minted + 1;
        arg0.current_minted
    }

    public fun is_active(arg0: &Collection) : bool {
        arg0.is_active
    }

    public fun name(arg0: &Collection) : 0x1::string::String {
        arg0.name
    }

    public fun remaining_supply(arg0: &Collection) : u64 {
        arg0.total_supply - arg0.current_minted
    }

    public entry fun set_collection_active(arg0: &mut Collection, arg1: &0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::admin::AdminCap, arg2: bool) {
        arg0.is_active = arg2;
    }

    public fun total_supply(arg0: &Collection) : u64 {
        arg0.total_supply
    }

    public entry fun update_metadata(arg0: &mut Collection, arg1: &0xdbd096ddccd8ec18d22de73f373cb013068639550aca4a48ad3cb401b2c0d76::admin::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg0.name = arg2;
        arg0.description = arg3;
    }

    // decompiled from Move bytecode v6
}

