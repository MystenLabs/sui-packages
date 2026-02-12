module 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun check_paused(arg0: &Registry) {
        assert!(!arg0.paused, 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors::paused());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Registry{
            id      : 0x2::object::new(arg0),
            admin   : v0,
            paused  : false,
            version : 1,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v1);
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun is_paused(arg0: &Registry) : bool {
        arg0.paused
    }

    public fun set_admin(arg0: &mut Registry, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.admin = arg2;
    }

    public fun set_paused(arg0: &mut Registry, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg2;
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

