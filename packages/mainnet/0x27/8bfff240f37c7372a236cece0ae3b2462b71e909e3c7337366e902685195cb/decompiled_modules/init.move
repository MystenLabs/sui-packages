module 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::create_registry<INIT>(&arg0, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::borrow_mut_id(&mut v0), arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

