module 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::create(arg1);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid_mut(&mut v0), arg1);
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

