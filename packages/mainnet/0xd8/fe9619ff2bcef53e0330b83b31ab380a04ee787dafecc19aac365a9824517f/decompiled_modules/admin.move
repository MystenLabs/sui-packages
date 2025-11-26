module 0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
        treasury_id: 0x2::object::ID,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<address, bool>,
    }

    public entry fun add_whitelist_address(arg0: &mut Whitelist, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_exist_address(arg0, arg1), 6001);
        0x2::table::add<address, bool>(&mut arg0.list, arg1, true);
    }

    public entry fun del_whitelist_address(arg0: &mut Whitelist, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_exist_address(arg0, arg1), 6002);
        0x2::table::remove<address, bool>(&mut arg0.list, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id   : 0x2::object::new(arg0),
            list : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::public_share_object<Whitelist>(v0);
    }

    fun is_exist_address(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.list, arg1)
    }

    public(friend) fun new_admin_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id          : 0x2::object::new(arg1),
            treasury_id : arg0,
        }
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

