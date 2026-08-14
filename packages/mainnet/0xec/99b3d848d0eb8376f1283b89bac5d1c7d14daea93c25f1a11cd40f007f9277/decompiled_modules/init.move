module 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::create_registry<INIT>(&arg0, arg1);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::borrow_mut_id(&mut v0), arg1);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

