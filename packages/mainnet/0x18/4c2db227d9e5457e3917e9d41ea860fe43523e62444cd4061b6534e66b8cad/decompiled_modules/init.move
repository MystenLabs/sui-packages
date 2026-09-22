module 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::create(arg1);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid_mut(&mut v0), arg1);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

