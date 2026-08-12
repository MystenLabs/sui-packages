module 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManageCap has key {
        id: 0x2::object::UID,
        whitelisted_addresses: vector<address>,
    }

    public fun add_whitelisted_manager(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        abort 1000
    }

    public fun destroy_legacy_admin_cap(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: AdminCap) {
        let AdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AdminCap>(v0);
        let v1 = ManageCap{
            id                    : 0x2::object::new(arg0),
            whitelisted_addresses : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<ManageCap>(v1);
    }

    public fun is_whitelisted_manager(arg0: &ManageCap, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public fun remove_whitelisted_manager(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        abort 1000
    }

    // decompiled from Move bytecode v7
}

