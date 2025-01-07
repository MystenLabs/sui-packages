module 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pfps: 0x2::table::Table<u16, 0x2::object::ID>,
        is_initialized: bool,
        is_frozen: bool,
    }

    public(friend) fun add(arg0: u16, arg1: 0x2::object::ID, arg2: &mut Registry) {
        0x2::table::add<u16, 0x2::object::ID>(&mut arg2.pfps, arg0, arg1);
        if ((0x2::table::length<u16, 0x2::object::ID>(&arg2.pfps) as u16) == 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::collection::size()) {
            arg2.is_initialized = true;
        };
    }

    public fun admin_freeze_registry(arg0: &0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::AdminCap, arg1: Registry, arg2: &0x2::tx_context::TxContext) {
        0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::verify_admin_cap(arg0, arg2);
        assert!(arg1.is_frozen == false, 3);
        assert!(arg1.is_initialized == true, 2);
        arg1.is_frozen = true;
        0x2::transfer::freeze_object<Registry>(arg1);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<REGISTRY>(arg0, arg1);
        let v1 = Registry{
            id             : 0x2::object::new(arg1),
            pfps           : 0x2::table::new<u16, 0x2::object::ID>(arg1),
            is_initialized : false,
            is_frozen      : false,
        };
        let v2 = 0x2::display::new<Registry>(&v0, arg1);
        0x2::display::add<Registry>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Prime Machin Registry"));
        0x2::display::add<Registry>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The official registry of the Prime Machin collection by Studio Mirai."));
        0x2::display::add<Registry>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://prime.nozomi.world/images/registry.webp."));
        0x2::display::add<Registry>(&mut v2, 0x1::string::utf8(b"is_initialized"), 0x1::string::utf8(b"{is_initialized}"));
        0x2::display::add<Registry>(&mut v2, 0x1::string::utf8(b"is_frozen"), 0x1::string::utf8(b"{is_frozen}"));
        0x2::transfer::transfer<Registry>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Registry>>(v2, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
    }

    public(friend) fun is_frozen(arg0: &Registry) : bool {
        arg0.is_frozen
    }

    public(friend) fun is_initialized(arg0: &Registry) : bool {
        arg0.is_initialized
    }

    public fun pfp_id_from_number(arg0: u16, arg1: &Registry) : 0x2::object::ID {
        assert!(arg0 >= 1 && arg0 <= 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::collection::size(), 1);
        assert!(arg1.is_frozen == true, 4);
        *0x2::table::borrow<u16, 0x2::object::ID>(&arg1.pfps, arg0)
    }

    // decompiled from Move bytecode v6
}

