module 0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::manage {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut 0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Setting) {
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::migrate(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_operator_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

