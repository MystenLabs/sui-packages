module 0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::new<INIT>(&arg0, arg1);
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

