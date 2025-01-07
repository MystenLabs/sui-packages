module 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package {
    struct MigrateEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct PackageAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun check_version(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public(friend) fun emit_migrate_event() {
        let v0 = MigrateEvent{
            old_version : 1 - 1,
            new_version : 1,
        };
        0x2::event::emit<MigrateEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PackageAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

