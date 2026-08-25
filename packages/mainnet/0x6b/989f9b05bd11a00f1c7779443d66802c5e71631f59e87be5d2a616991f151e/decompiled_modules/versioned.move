module 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InitEvent has copy, drop {
        versioned: 0x2::object::ID,
    }

    struct UpgradeEvent has copy, drop {
        versioned: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 10, 13906834706919391234);
    }

    public fun current_version() : u64 {
        10
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 10,
        };
        let v1 = InitEvent{versioned: 0x2::object::id<Versioned>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public(friend) fun set_version(arg0: &mut Versioned, arg1: u64) {
        arg0.version = arg1;
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::admin_cap::AdminCap) {
        assert!(arg0.version < 10, 13906834784228933636);
        arg0.version = 10;
        let v0 = UpgradeEvent{
            versioned   : 0x2::object::id<Versioned>(arg0),
            old_version : arg0.version,
            new_version : 10,
        };
        0x2::event::emit<UpgradeEvent>(v0);
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

