module 0xfbc91f75397ce25b3b1b01cab2bf494d2e3f9b9e89c97545d88bd616cbbfcc37::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InitEvent has copy, drop {
        versioned: 0x2::object::ID,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 9, 13835058368814907395);
    }

    public fun check_version_or_emergency_pause(arg0: &Versioned) {
        assert!(arg0.version <= 9 || arg0.version == 1844674407370955161, 13835058403174645763);
    }

    public fun current_version() : u64 {
        9
    }

    public fun emergency_pause_version() : u64 {
        1844674407370955161
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 9,
        };
        let v1 = InitEvent{versioned: 0x2::object::id<Versioned>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun is_emergency_paused(arg0: &Versioned) : bool {
        arg0.version == 1844674407370955161
    }

    public(friend) fun set_version(arg0: &mut Versioned, arg1: u64) {
        arg0.version = arg1;
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::admin_cap::AdminCap) {
        abort 1
    }

    public fun upgrade_v2(arg0: &mut Versioned, arg1: &0xfbc91f75397ce25b3b1b01cab2bf494d2e3f9b9e89c97545d88bd616cbbfcc37::admin_cap::AdminCap) {
        assert!(arg0.version < 9, 13835339981230702597);
        arg0.version = 9;
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

