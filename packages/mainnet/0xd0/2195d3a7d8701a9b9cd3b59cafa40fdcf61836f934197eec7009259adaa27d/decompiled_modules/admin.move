module 0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0x5fe2415c93cfd6251e579dfbd4f609795a0c917f33c40e82aaba5aec698d8769);
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::custodian::new(arg0);
    }

    public entry fun set_admin(arg0: &0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::assert_current_version(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::assert_current_version(arg0);
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::operator::new_operator(arg2, arg3);
    }

    public entry fun withdraw_treasury_balance(arg0: &0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::Version, arg1: &AdminCap, arg2: &mut 0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::custodian::Custodian, arg3: &mut 0x2::tx_context::TxContext) {
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::version::assert_current_version(arg0);
        0xd02195d3a7d8701a9b9cd3b59cafa40fdcf61836f934197eec7009259adaa27d::custodian::withdraw_treasury_balance(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

