module 0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        pools: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun add_pool(arg0: &mut Registry, arg1: 0x2::object::ID) {
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.pools, &arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.pools, arg1);
        };
    }

    public fun get_pools(arg0: &Registry) : vector<0x2::object::ID> {
        0x2::vec_set::into_keys<0x2::object::ID>(arg0.pools)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun remove_pool(arg0: &mut Registry, arg1: 0x2::object::ID) {
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.pools, &arg1)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.pools, &arg1);
        };
    }

    // decompiled from Move bytecode v6
}

