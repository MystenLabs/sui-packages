module 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::core {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Blacklist has store, key {
        id: 0x2::object::UID,
        addresses: 0x2::table::Table<address, bool>,
    }

    struct CORE has drop {
        dummy_field: bool,
    }

    public fun admin_add_to_blacklist(arg0: &AdminCap, arg1: address, arg2: &mut Blacklist) {
        0x2::table::add<address, bool>(&mut arg2.addresses, arg1, true);
    }

    public fun admin_remove_from_blacklist(arg0: &AdminCap, arg1: address, arg2: &mut Blacklist) {
        0x2::table::remove<address, bool>(&mut arg2.addresses, arg1);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Blacklist{
            id        : 0x2::object::new(arg1),
            addresses : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CORE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Blacklist>(v1);
    }

    public fun is_blacklisted(arg0: &Blacklist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.addresses, arg1)
    }

    // decompiled from Move bytecode v6
}

