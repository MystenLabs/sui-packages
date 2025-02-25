module 0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::dao {
    struct DAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::acl::new<DAO>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DAO>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::config::DaoConfig>(0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::config::new(3333, 15, 400, arg1));
    }

    // decompiled from Move bytecode v6
}

