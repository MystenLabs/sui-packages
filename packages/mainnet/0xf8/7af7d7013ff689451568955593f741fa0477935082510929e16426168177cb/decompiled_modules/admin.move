module 0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0x6a1f20c51495a6dbadf04f26ea76679f9e00abad8a5fa600677ebcd4b09daaa);
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::custodian::new(arg0);
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::configuration::new(arg0);
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::state::new(arg0);
    }

    public entry fun set_admin(arg0: &0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::version::assert_current_version(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::version::assert_current_version(arg0);
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::operator::new_operator(arg2, arg3);
    }

    public entry fun update_configuration(arg0: &0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::version::Version, arg1: &AdminCap, arg2: &mut 0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::configuration::Configuration, arg3: u64, arg4: u64, arg5: u64) {
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::version::assert_current_version(arg0);
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::configuration::update(arg2, arg3, arg4, arg5);
    }

    public entry fun withdraw_treasury_balance(arg0: &0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::version::Version, arg1: &AdminCap, arg2: &mut 0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::custodian::Custodian, arg3: &mut 0x2::tx_context::TxContext) {
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::version::assert_current_version(arg0);
        0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::custodian::withdraw_treasury_balance(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

