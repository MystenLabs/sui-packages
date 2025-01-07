module 0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::minter_role {
    struct MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x4061a458beb11577e0e7659b0aaecde5ad8088b346809479a203050ff460a36b::access_control::AdminCap<MINTER_ROLE>>(0x4061a458beb11577e0e7659b0aaecde5ad8088b346809479a203050ff460a36b::access_control::create_role<MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

