module 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InitEvent has copy, drop {
        versioned: 0x2::object::ID,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 2, 13835058360224907266);
    }

    public fun current_version() : u64 {
        2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 2,
        };
        let v1 = InitEvent{versioned: 0x2::object::id<Versioned>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public(friend) fun set_version(arg0: &mut Versioned, arg1: u64) {
        arg0.version = arg1;
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::admin_cap::AdminCap) {
        abort 1
    }

    public fun upgrade_v2(arg0: &mut Versioned, arg1: &0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::admin_cap::AdminCap) {
        assert!(arg0.version < 2, 13835339916806127620);
        arg0.version = 2;
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

