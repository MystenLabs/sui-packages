module 0x1f1f5a9b95278d1d5d121226db95c416a23c557a2ee5cd33256c80fb02ef1ae7::white_list {
    struct WhiteList has store {
        id: 0x2::object::UID,
        addresses: 0x2::table::Table<address, u64>,
        protection_limit_used: u64,
        protection_hard_cap: u64,
    }

    public fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : WhiteList {
        WhiteList{
            id                    : 0x2::object::new(arg1),
            addresses             : 0x2::table::new<address, u64>(arg1),
            protection_limit_used : 0,
            protection_hard_cap   : arg0,
        }
    }

    public fun add_white_listed_address(arg0: &mut WhiteList, arg1: address, arg2: u64) {
        assert!(!0x2::table::contains<address, u64>(&arg0.addresses, arg1), 2);
        0x2::table::add<address, u64>(&mut arg0.addresses, arg1, arg2);
    }

    public fun add_white_listed_addresses(arg0: &mut WhiteList, arg1: vector<address>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, u64>(&arg0.addresses, v1)) {
                0x2::table::add<address, u64>(&mut arg0.addresses, v1, arg2);
            };
            v0 = v0 + 1;
        };
    }

    public fun increase_protection_limit_used(arg0: &mut WhiteList, arg1: u64) {
        assert!(arg0.protection_hard_cap - arg0.protection_limit_used >= arg1, 3);
        arg0.protection_limit_used = arg0.protection_limit_used + arg1;
    }

    public fun protection_hard_cap(arg0: &WhiteList) : u64 {
        arg0.protection_hard_cap
    }

    public fun protection_limit_used(arg0: &WhiteList) : u64 {
        arg0.protection_limit_used
    }

    public fun remainer_protection_limit(arg0: &WhiteList) : u64 {
        arg0.protection_hard_cap - arg0.protection_limit_used
    }

    public fun remove_white_listed_address(arg0: &mut WhiteList, arg1: address) {
        assert!(0x2::table::contains<address, u64>(&arg0.addresses, arg1), 1);
        0x2::table::remove<address, u64>(&mut arg0.addresses, arg1);
    }

    public fun remove_white_listed_addresses(arg0: &mut WhiteList, arg1: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, u64>(&arg0.addresses, v1)) {
                0x2::table::remove<address, u64>(&mut arg0.addresses, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun update_protection_hard_cap(arg0: &mut WhiteList, arg1: u64) {
        arg0.protection_hard_cap = arg1;
    }

    public fun update_white_listed_address(arg0: &mut WhiteList, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, u64>(&arg0.addresses, arg1), 1);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.addresses, arg1) = arg2;
    }

    public fun white_listed_address_protection_limit(arg0: &WhiteList, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.addresses, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.addresses, arg1)
        }
    }

    // decompiled from Move bytecode v6
}

