module 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun bump_registry_version(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(1 > arg0.version, 0);
        arg0.version = 1;
    }

    public fun burn_admincap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_valid_version(arg0: &Registry) : bool {
        arg0.version == 1
    }

    public fun new_admincap(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::package::from_package<AdminCap>(arg0), 1);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

