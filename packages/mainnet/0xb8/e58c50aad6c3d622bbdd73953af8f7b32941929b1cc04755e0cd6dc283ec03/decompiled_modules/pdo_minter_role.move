module 0xb8e58c50aad6c3d622bbdd73953af8f7b32941929b1cc04755e0cd6dc283ec03::pdo_minter_role {
    struct PDO_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDO_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::AdminCap<PDO_MINTER_ROLE>>(0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::create_role<PDO_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

