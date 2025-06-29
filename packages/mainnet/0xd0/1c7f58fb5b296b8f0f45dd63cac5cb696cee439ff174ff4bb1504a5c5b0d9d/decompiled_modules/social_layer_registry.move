module 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry {
    struct Registry has store, key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct SOCIAL_LAYER_REGISTRY has drop {
        dummy_field: bool,
    }

    public(friend) fun add_record(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.registry, arg1), 1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.registry, arg1, arg2);
    }

    public fun create_registry(arg0: &SOCIAL_LAYER_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) : Registry {
        assert!(0x2::types::is_one_time_witness<SOCIAL_LAYER_REGISTRY>(arg0), 3);
        Registry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
        }
    }

    public fun get_record(arg0: &Registry, arg1: 0x1::string::String) : &0x2::object::ID {
        0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.registry, arg1)
    }

    public fun has_record(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.registry, arg1)
    }

    fun init(arg0: SOCIAL_LAYER_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Registry>(create_registry(&arg0, arg1));
    }

    public(friend) fun remove_record(arg0: &mut Registry, arg1: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.registry, arg1), 2);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.registry, arg1);
    }

    // decompiled from Move bytecode v6
}

