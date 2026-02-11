module 0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::new<INIT>(&arg0, arg1);
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::borrow_mut_id(&mut v0), arg1);
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::authority::create_package_assistant_cap_and_keep<INIT>(&arg0, 0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::borrow_mut_id(&mut v0), arg1);
        0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

