module 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::new<INIT>(&arg0, arg1);
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::borrow_mut_id(&mut v0), arg1);
        0x583ee4e55e276589d30a062a606c91d9d692a68907b2f876d2ff0242140119a7::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

