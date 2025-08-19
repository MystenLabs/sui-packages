module 0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::player {
    struct Player has key {
        id: 0x2::object::UID,
        referrer: 0x1::option::Option<address>,
    }

    struct PlayerRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        has_registered: 0x2::table::Table<address, bool>,
    }

    struct NameRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        name_to_address: 0x2::table::Table<0x1::ascii::String, address>,
    }

    public fun create(arg0: &mut PlayerRegistry, arg1: 0x1::option::Option<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        if (0x1::option::is_some<address>(&arg1)) {
            let v0 = 0x1::option::destroy_some<address>(arg1);
            assert!(v0 != 0x2::tx_context::sender(arg2), 3);
            assert!(0x2::table::contains<address, bool>(&arg0.has_registered, v0), 4);
        } else {
            0x1::option::destroy_none<address>(arg1);
        };
        0x2::table::add<address, bool>(&mut arg0.has_registered, 0x2::tx_context::sender(arg2), true);
        let v1 = Player{
            id       : 0x2::object::new(arg2),
            referrer : arg1,
        };
        0x2::transfer::transfer<Player>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun create_by_name(arg0: &NameRegistry, arg1: &mut PlayerRegistry, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        create(arg1, 0x1::option::some<address>(*0x2::table::borrow<0x1::ascii::String, address>(&arg0.name_to_address, arg2)), arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerRegistry{
            id             : 0x2::object::new(arg0),
            version        : 1,
            has_registered : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<PlayerRegistry>(v0);
        let v1 = NameRegistry{
            id              : 0x2::object::new(arg0),
            version         : 1,
            name_to_address : 0x2::table::new<0x1::ascii::String, address>(arg0),
        };
        0x2::transfer::share_object<NameRegistry>(v1);
    }

    public fun referrer(arg0: &Player) : &0x1::option::Option<address> {
        &arg0.referrer
    }

    public fun register_name(arg0: &mut NameRegistry, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        0x2::table::add<0x1::ascii::String, address>(&mut arg0.name_to_address, arg1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

