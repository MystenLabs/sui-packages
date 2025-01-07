module 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun claim_treasury_balance<T0>(arg0: &AdminCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::Custodian<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::sub_treasury_balance<T0>(arg2, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::treasury_balance<T0>(arg2)), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xbdf3f6f40a74409ff1a62e099931a32e31d88ba0314ff70d4e498870d439b75f);
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &AdminCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::operator::new_operator(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

