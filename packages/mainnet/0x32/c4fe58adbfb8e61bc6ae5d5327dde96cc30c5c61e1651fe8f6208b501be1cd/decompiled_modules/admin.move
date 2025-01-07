module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun claim_treasury_balance<T0>(arg0: &AdminCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::custodian::sub_treasury_balance<T0>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::custodian::treasury_balance<T0>(arg2)), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xbdf3f6f40a74409ff1a62e099931a32e31d88ba0314ff70d4e498870d439b75f);
    }

    entry fun set_admin(arg0: &AdminCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    entry fun set_operator(arg0: &AdminCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::operator::new_operator(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

