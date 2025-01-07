module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character_registry {
    struct NameRegistry has store, key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    public fun length(arg0: &NameRegistry) : u64 {
        0x2::table::length<0x1::string::String, 0x2::object::ID>(&arg0.registry)
    }

    public(friend) fun add_name(arg0: &mut NameRegistry, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert_name_available(arg0, arg1);
        assert_name_valid(arg1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.registry, arg1, 0x2::object::id_from_address(0x2::tx_context::sender(arg2)));
    }

    public fun assert_name_available(arg0: &NameRegistry, arg1: 0x1::string::String) {
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.registry, arg1), 3);
    }

    public fun assert_name_valid(arg0: 0x1::string::String) {
        assert!(0x1::string::length(&arg0) > 3 && 0x1::string::length(&arg0) < 20, 2);
        assert!(!0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::string::contains_whitespace(arg0), 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NameRegistry{
            id       : 0x2::object::new(arg0),
            registry : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<NameRegistry>(v0);
    }

    public(friend) fun remove_name(arg0: &mut NameRegistry, arg1: 0x1::string::String) {
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.registry, arg1);
    }

    // decompiled from Move bytecode v6
}

