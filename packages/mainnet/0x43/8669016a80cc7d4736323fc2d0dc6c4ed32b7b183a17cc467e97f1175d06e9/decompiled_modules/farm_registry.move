module 0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::farm_registry {
    struct NftFarmRegistry has store, key {
        id: 0x2::object::UID,
        registry: 0x2::table_vec::TableVec<0x2::object::ID>,
    }

    struct SuperRegistryCap has key {
        id: 0x2::object::UID,
    }

    struct RegistryCap has key {
        id: 0x2::object::UID,
    }

    public fun add_farm<T0>(arg0: &RegistryCap, arg1: &mut NftFarmRegistry, arg2: &0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::nft_farm::GatedFarm<T0>) {
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg1.registry, 0x2::object::id<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::nft_farm::GatedFarm<T0>>(arg2));
    }

    public fun burn_registry_cap(arg0: RegistryCap) {
        let RegistryCap { id: v0 } = arg0;
        0x2::object::delete(v0);
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
        let v1 = SuperRegistryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<NftFarmRegistry>(v0);
        let v2 = RegistryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RegistryCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<SuperRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun issue_registry_cap(arg0: &SuperRegistryCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<RegistryCap>(v0, arg1);
    }

    public fun remove_farm<T0>(arg0: &RegistryCap, arg1: &mut NftFarmRegistry, arg2: &0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::nft_farm::GatedFarm<T0>) {
        let v0 = find_in_table_vec(&arg1.registry, 0x2::object::id<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::nft_farm::GatedFarm<T0>>(arg2));
        0x2::table_vec::swap_remove<0x2::object::ID>(&mut arg1.registry, 0x1::option::extract<u64>(&mut v0));
    }

    // decompiled from Move bytecode v6
}

