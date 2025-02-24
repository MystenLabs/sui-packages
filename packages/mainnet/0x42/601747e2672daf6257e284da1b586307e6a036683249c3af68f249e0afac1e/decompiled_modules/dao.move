module 0x42601747e2672daf6257e284da1b586307e6a036683249c3af68f249e0afac1e::dao {
    struct DAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        0x42601747e2672daf6257e284da1b586307e6a036683249c3af68f249e0afac1e::acl::new<DAO>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DAO>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x42601747e2672daf6257e284da1b586307e6a036683249c3af68f249e0afac1e::config::DaoConfig>(0x42601747e2672daf6257e284da1b586307e6a036683249c3af68f249e0afac1e::config::new(3333, 15, 400, arg1));
    }

    // decompiled from Move bytecode v6
}

