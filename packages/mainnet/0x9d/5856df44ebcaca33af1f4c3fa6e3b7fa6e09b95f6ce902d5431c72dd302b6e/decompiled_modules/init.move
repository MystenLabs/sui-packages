module 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::create(arg1);
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::borrow_uid_mut(&mut v0), arg1);
        0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

