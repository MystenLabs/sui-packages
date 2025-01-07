module 0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xeebcec63aa8b2f2103d4d6c80bcb5ab7a5d262c94cf243ef151df8750d76ca08);
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::custodian::new(arg0);
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::configuration::new(arg0);
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::state::new(arg0);
    }

    public entry fun set_admin(arg0: &0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::version::assert_current_version(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::version::assert_current_version(arg0);
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::operator::new_operator(arg2, arg3);
    }

    public entry fun update_configuration(arg0: &0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::version::Version, arg1: &AdminCap, arg2: &mut 0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::configuration::Configuration, arg3: u64, arg4: u64) {
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::version::assert_current_version(arg0);
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::configuration::update(arg2, arg3, arg4);
    }

    public entry fun withdraw_treasury_balance(arg0: &0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::version::Version, arg1: &AdminCap, arg2: &mut 0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::custodian::Custodian, arg3: &mut 0x2::tx_context::TxContext) {
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::version::assert_current_version(arg0);
        0xd84e2676e42f2b5932d61c29bc2972972709aec7477370f20231d4c1fbdaf0a1::custodian::withdraw_treasury_balance(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

