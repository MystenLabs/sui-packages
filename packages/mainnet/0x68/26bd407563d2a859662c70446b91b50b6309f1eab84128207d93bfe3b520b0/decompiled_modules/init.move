module 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::create_config<INIT>(&arg0, arg1);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::borrow_mut_id(&mut v0), arg1);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

