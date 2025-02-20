module 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        version: 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::version::Version,
        amms: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        banks: 0x2::table::Table<0x1::type_name::TypeName, BankType>,
    }

    struct BankType has store {
        bank_id: 0x2::object::ID,
        bank_type: 0x1::type_name::TypeName,
    }

    public(friend) fun add_amm<T0: key>(arg0: &mut Registry, arg1: &T0) {
        0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.amms, v0), 1);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.amms, v0, 0x2::object::id<T0>(arg1));
    }

    public(friend) fun add_bank<T0: key, T1>(arg0: &mut Registry, arg1: &T0) {
        0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, BankType>(&arg0.banks, v0), 2);
        let v1 = BankType{
            bank_id   : 0x2::object::id<T0>(arg1),
            bank_type : 0x1::type_name::get<T0>(),
        };
        0x2::table::add<0x1::type_name::TypeName, BankType>(&mut arg0.banks, v0, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            version : 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::version::new(1),
            amms    : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            banks   : 0x2::table::new<0x1::type_name::TypeName, BankType>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    entry fun migrate(arg0: &mut Registry, arg1: &0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::global_admin::GlobalAdmin) {
        0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::version::migrate_(&mut arg0.version, 1);
    }

    // decompiled from Move bytecode v6
}

