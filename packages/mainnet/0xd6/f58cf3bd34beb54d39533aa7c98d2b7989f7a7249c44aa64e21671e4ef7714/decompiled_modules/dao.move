module 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::dao {
    struct DAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::acl::new<DAO>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DAO>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig>(0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::new(3333, 15, 400, arg1));
    }

    // decompiled from Move bytecode v6
}

