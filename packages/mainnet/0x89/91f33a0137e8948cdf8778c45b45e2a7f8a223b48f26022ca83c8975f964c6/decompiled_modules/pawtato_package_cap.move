module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap {
    struct PawtatoPackageCap has store, key {
        id: 0x2::object::UID,
        authorized_package: 0x1::string::String,
        permissions: vector<0x1::string::String>,
    }

    public entry fun create_and_transfer_pawtato_package_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NewAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_pawtato_package_cap(arg0, arg1);
        0x2::transfer::public_transfer<PawtatoPackageCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_pawtato_package_cap(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NewAdminCap, arg1: &mut 0x2::tx_context::TxContext) : PawtatoPackageCap {
        PawtatoPackageCap{
            id                 : 0x2::object::new(arg1),
            authorized_package : 0x1::string::utf8(b""),
            permissions        : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    // decompiled from Move bytecode v6
}

