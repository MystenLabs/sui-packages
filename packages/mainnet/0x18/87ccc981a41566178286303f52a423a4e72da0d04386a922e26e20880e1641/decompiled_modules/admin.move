module 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xeebcec63aa8b2f2103d4d6c80bcb5ab7a5d262c94cf243ef151df8750d76ca08);
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::new(arg0);
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &AdminCap, arg1: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg1);
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::operator::new_operator(arg2, arg3);
    }

    public entry fun withdraw_treasury_balance(arg0: &AdminCap, arg1: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg2: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg3: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg1);
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::withdraw_treasury_balance(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

