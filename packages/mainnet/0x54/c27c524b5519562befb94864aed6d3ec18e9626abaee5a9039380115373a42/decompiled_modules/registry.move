module 0x54c27c524b5519562befb94864aed6d3ec18e9626abaee5a9039380115373a42::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        allowed_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public(friend) fun assert_witness(arg0: &Registry, arg1: 0x1::type_name::TypeName) {
        assert!(arg0.version <= 0x54c27c524b5519562befb94864aed6d3ec18e9626abaee5a9039380115373a42::constants::current_version(), 0);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_witnesses, &arg1), 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id                : 0x2::object::new(arg0),
            version           : 0x54c27c524b5519562befb94864aed6d3ec18e9626abaee5a9039380115373a42::constants::current_version(),
            allowed_witnesses : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun insert_witness(arg0: &mut Registry, arg1: 0x1::type_name::TypeName, arg2: &AdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, arg1);
    }

    public fun remove_witness(arg0: &mut Registry, arg1: 0x1::type_name::TypeName, arg2: &AdminCap) {
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_witnesses, &arg1);
    }

    public fun update_version(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

