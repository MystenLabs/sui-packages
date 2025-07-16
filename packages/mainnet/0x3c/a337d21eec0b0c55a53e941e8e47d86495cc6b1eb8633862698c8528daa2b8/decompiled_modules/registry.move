module 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        allowed_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    fun type_name<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public(friend) fun assert_witness<T0>(arg0: &Registry) {
        assert!(arg0.version <= 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::constants::current_version(), 0);
        let v0 = type_name<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_witnesses, &v0), 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id                : 0x2::object::new(arg0),
            version           : 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::constants::current_version(),
            allowed_witnesses : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun insert_witness<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, type_name<T0>());
    }

    public fun remove_witness<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        let v0 = type_name<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, &v0);
    }

    public fun update_version(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

