module 0x39d11938aed623b39d8ebc83d699ee641e838f0476bafa6ae582ea63cf198ac7::bond_pool_registry {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        bond_pools: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    public fun create_pool<T0>(arg0: &mut Registry, arg1: &0x39d11938aed623b39d8ebc83d699ee641e838f0476bafa6ae582ea63cf198ac7::ownership::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x39d11938aed623b39d8ebc83d699ee641e838f0476bafa6ae582ea63cf198ac7::bond_pool::BondPool<T0> {
        assert!(arg0.version == 1, 1);
        let v0 = 0x39d11938aed623b39d8ebc83d699ee641e838f0476bafa6ae582ea63cf198ac7::bond_pool::create_pool<T0>(arg1, arg2);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.bond_pools, 0x1::type_name::get<T0>(), 0x2::object::id<0x39d11938aed623b39d8ebc83d699ee641e838f0476bafa6ae582ea63cf198ac7::bond_pool::BondPool<T0>>(&v0));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id         : 0x2::object::new(arg0),
            version    : 1,
            bond_pools : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    // decompiled from Move bytecode v6
}

