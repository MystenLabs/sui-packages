module 0x24af5dc5b716df90694f81a9f0a0ad99ee72820cbae08bc225191bf71deb6d2e::registry {
    struct NftFarmRegistry has store, key {
        id: 0x2::object::UID,
        registry: 0x2::table_vec::TableVec<0x2::object::ID>,
    }

    struct RegistryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_farm(arg0: &RegistryCap, arg1: &mut NftFarmRegistry, arg2: 0x2::object::ID) {
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg1.registry, arg2);
    }

    fun find_in_table_vec(arg0: &0x2::table_vec::TableVec<0x2::object::ID>, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<0x2::object::ID>(arg0)) {
            if (0x2::table_vec::borrow<0x2::object::ID>(arg0, v0) == &arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NftFarmRegistry{
            id       : 0x2::object::new(arg0),
            registry : 0x2::table_vec::empty<0x2::object::ID>(arg0),
        };
        let v1 = RegistryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<NftFarmRegistry>(v0);
        0x2::transfer::public_transfer<RegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun remove_farm(arg0: &RegistryCap, arg1: &mut NftFarmRegistry, arg2: 0x2::object::ID) {
        let v0 = find_in_table_vec(&arg1.registry, arg2);
        0x2::table_vec::swap_remove<0x2::object::ID>(&mut arg1.registry, 0x1::option::extract<u64>(&mut v0));
    }

    // decompiled from Move bytecode v6
}

