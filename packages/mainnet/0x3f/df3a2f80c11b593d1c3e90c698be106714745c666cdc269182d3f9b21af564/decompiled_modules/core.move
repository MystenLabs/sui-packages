module 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    struct MoviePassRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        admin_addresses: 0x2::vec_set::VecSet<address>,
    }

    struct AdminAdded has copy, drop {
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
    }

    public fun add_admin(arg0: &0x2::package::Publisher, arg1: &mut MoviePassRegistry, arg2: address) {
        assert!(0x2::package::from_module<CORE>(arg0), 2);
        assert!(0x2::vec_set::size<address>(&arg1.admin_addresses) < 1000, 0);
        0x2::vec_set::insert<address>(&mut arg1.admin_addresses, arg2);
        let v0 = AdminAdded{admin: arg2};
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun admin_addresses(arg0: &MoviePassRegistry) : 0x2::vec_set::VecSet<address> {
        arg0.admin_addresses
    }

    public(friend) fun check_admin(arg0: &MoviePassRegistry, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.admin_addresses, &arg1), 4);
    }

    public(friend) fun check_valid_version(arg0: &MoviePassRegistry) {
        assert!(arg0.version == 1, 1);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CORE>(arg0, arg1);
        let v0 = MoviePassRegistry{
            id              : 0x2::object::new(arg1),
            version         : 1,
            admin_addresses : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::transfer::share_object<MoviePassRegistry>(v0);
    }

    public(friend) fun package_version() : u64 {
        1
    }

    public fun remove_admin(arg0: &0x2::package::Publisher, arg1: &mut MoviePassRegistry, arg2: address) {
        assert!(0x2::package::from_module<CORE>(arg0), 2);
        0x2::vec_set::remove<address>(&mut arg1.admin_addresses, &arg2);
        assert!(0x2::vec_set::size<address>(&arg1.admin_addresses) > 0, 3);
        let v0 = AdminRemoved{admin: arg2};
        0x2::event::emit<AdminRemoved>(v0);
    }

    public fun version(arg0: &MoviePassRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

