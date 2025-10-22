module 0xe2f6b1731b2a1244c9e98bf35b9a1908e0af3d5be38a180710a1233d12a5cee::vendorpass {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        vendors: 0x2::table::Table<address, bool>,
    }

    struct VendorAdded has copy, drop {
        vendor: address,
    }

    struct VendorRemoved has copy, drop {
        vendor: address,
    }

    public entry fun add_vendor(arg0: &AdminCap, arg1: &mut Registry, arg2: address) {
        if (!0x2::table::contains<address, bool>(&arg1.vendors, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.vendors, arg2, true);
            let v0 = VendorAdded{vendor: arg2};
            0x2::event::emit<VendorAdded>(v0);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            vendors : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Registry>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_vendor(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.vendors, arg1)
    }

    public entry fun remove_vendor(arg0: &AdminCap, arg1: &mut Registry, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.vendors, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.vendors, arg2);
            let v0 = VendorRemoved{vendor: arg2};
            0x2::event::emit<VendorRemoved>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

