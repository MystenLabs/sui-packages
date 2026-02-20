module 0xe6a6db859f37164239ee615845d33eb2ed5bcda176c911de7db9898ed0413c35::admin_guard_pkg {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ManagedCounter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun create_shared_counter(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagedCounter{
            id    : 0x2::object::new(arg2),
            value : arg1,
        };
        0x2::transfer::share_object<ManagedCounter>(v0);
    }

    public fun increment(arg0: &AdminCap, arg1: &mut ManagedCounter, arg2: u64) {
        arg1.value = arg1.value + arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun value(arg0: &AdminCap, arg1: &ManagedCounter) : u64 {
        arg1.value
    }

    // decompiled from Move bytecode v6
}

