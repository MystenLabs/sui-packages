module 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::create_registry<INIT>(&arg0, arg1);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::borrow_mut_id(&mut v0), arg1);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

