module 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xeebcec63aa8b2f2103d4d6c80bcb5ab7a5d262c94cf243ef151df8750d76ca08);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::new(arg0);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::configuration::new(arg0);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::new(arg0);
    }

    public entry fun set_admin(arg0: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg0);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::operator::new_operator(arg2, arg3);
    }

    public entry fun update_configuration(arg0: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg1: &AdminCap, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::configuration::Configuration, arg3: u64, arg4: u64) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg0);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::configuration::update(arg2, arg3, arg4);
    }

    public entry fun withdraw_treasury_balance(arg0: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg1: &AdminCap, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::Custodian, arg3: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg0);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::withdraw_treasury_balance(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

