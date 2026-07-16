module 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::create_registry<INIT>(&arg0, arg1);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::borrow_mut_id(&mut v0), arg1);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

