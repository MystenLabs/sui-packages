module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap {
    struct PawtatoPackageCap has store, key {
        id: 0x2::object::UID,
        authorized_package: 0x1::string::String,
        permissions: vector<0x1::string::String>,
    }

    public entry fun create_and_transfer_pawtato_package_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NewAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun create_pawtato_package_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NewAdminCap, arg1: &mut 0x2::tx_context::TxContext) : PawtatoPackageCap {
        abort 0
    }

    // decompiled from Move bytecode v6
}

