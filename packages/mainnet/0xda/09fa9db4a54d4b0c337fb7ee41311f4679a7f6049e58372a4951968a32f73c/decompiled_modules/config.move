module 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        publisher: 0x2::package::Publisher,
        classes: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    public(friend) fun bind<T0>(arg0: &mut Config, arg1: 0x2::object::ID) {
        assert!(arg0.version == 1, 101);
        assert!(!arg0.paused, 102);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.classes, v0), 103);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.classes, v0, arg1);
    }

    public fun class_count(arg0: &Config) : u64 {
        0x2::table::length<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.classes)
    }

    public fun class_of<T0>(arg0: &Config) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.classes, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.classes, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun current() : u64 {
        1
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id        : 0x2::object::new(arg1),
            version   : 1,
            paused    : false,
            publisher : 0x2::package::claim<CONFIG>(arg0, arg1),
            classes   : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 104);
        arg1.version = 1;
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public(friend) fun publisher(arg0: &Config) : &0x2::package::Publisher {
        &arg0.publisher
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::config_paused(0x2::object::id<Config>(arg1), arg2);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

