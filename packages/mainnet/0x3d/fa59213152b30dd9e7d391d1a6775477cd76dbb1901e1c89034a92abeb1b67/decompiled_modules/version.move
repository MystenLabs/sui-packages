module 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
        cap: 0x1::option::Option<0x2::object::ID>,
    }

    struct VersionSet has copy, drop {
        from: u64,
        to: u64,
    }

    struct CapBound has copy, drop {
        cap: 0x2::object::ID,
    }

    public(friend) fun assert_current(arg0: &Version) {
        assert!(arg0.value == 3, 57);
    }

    public fun bind(arg0: &mut Version, arg1: &0x2::package::UpgradeCap) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.cap), 60);
        let v0 = if (0x2::package::version(arg1) == 1) {
            let v1 = 0x2::package::upgrade_package(arg1);
            0x2::object::id_to_address(&v1) == original_package()
        } else {
            false
        };
        assert!(v0, 59);
        let v2 = 0x2::object::id<0x2::package::UpgradeCap>(arg1);
        arg0.cap = 0x1::option::some<0x2::object::ID>(v2);
        let v3 = CapBound{cap: v2};
        0x2::event::emit<CapBound>(v3);
    }

    public fun bound_cap(arg0: &Version) : 0x1::option::Option<0x2::object::ID> {
        arg0.cap
    }

    public fun current() : u64 {
        3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 3,
            cap   : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    fun original_package() : address {
        let v0 = 0x1::type_name::with_original_ids<Version>();
        let v1 = 0x1::type_name::address_string(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    public fun set(arg0: &mut Version, arg1: &0x2::package::UpgradeCap) {
        assert!(arg0.cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg1)), 59);
        let v0 = 0x2::package::version(arg1);
        assert!(v0 > arg0.value, 58);
        arg0.value = v0;
        let v1 = VersionSet{
            from : arg0.value,
            to   : v0,
        };
        0x2::event::emit<VersionSet>(v1);
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

