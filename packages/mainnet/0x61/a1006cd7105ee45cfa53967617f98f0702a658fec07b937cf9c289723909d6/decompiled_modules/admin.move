module 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xeebcec63aa8b2f2103d4d6c80bcb5ab7a5d262c94cf243ef151df8750d76ca08);
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::custodian::new(arg0);
    }

    public entry fun set_admin(arg0: &0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::assert_current_version(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::assert_current_version(arg0);
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::operator::new_operator(arg2, arg3);
    }

    public entry fun withdraw_treasury_balance(arg0: &0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::Version, arg1: &AdminCap, arg2: &mut 0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::custodian::Custodian, arg3: &mut 0x2::tx_context::TxContext) {
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::version::assert_current_version(arg0);
        0x61a1006cd7105ee45cfa53967617f98f0702a658fec07b937cf9c289723909d6::custodian::withdraw_treasury_balance(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

