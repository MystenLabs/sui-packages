module 0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xeebcec63aa8b2f2103d4d6c80bcb5ab7a5d262c94cf243ef151df8750d76ca08);
        0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::custodian::new(arg0);
    }

    public entry fun set_admin(arg0: &0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::version::assert_current_version(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun set_operator(arg0: &0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::version::Version, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::version::assert_current_version(arg0);
        0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::operator::new_operator(arg2, arg3);
    }

    public entry fun withdraw_treasury_balance(arg0: &0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::version::Version, arg1: &AdminCap, arg2: &mut 0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::custodian::Custodian, arg3: &mut 0x2::tx_context::TxContext) {
        0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::version::assert_current_version(arg0);
        0x30da2761ef217aa94865c200553d05860e7ca7ed6f0b3ad793869dde0f0c937c::custodian::withdraw_treasury_balance(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

