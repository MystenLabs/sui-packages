module 0xa29c7f20b93f713c2549c8c4deec435e48c1ea618120627e1220bdd71c4623eb::psh_minter_role {
    struct PSH_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSH_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::AdminCap<PSH_MINTER_ROLE>>(0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::create_role<PSH_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

