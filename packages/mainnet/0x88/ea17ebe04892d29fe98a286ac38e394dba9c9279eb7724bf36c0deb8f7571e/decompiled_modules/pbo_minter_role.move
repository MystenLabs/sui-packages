module 0x88ea17ebe04892d29fe98a286ac38e394dba9c9279eb7724bf36c0deb8f7571e::pbo_minter_role {
    struct PBO_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBO_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::AdminCap<PBO_MINTER_ROLE>>(0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::create_role<PBO_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

