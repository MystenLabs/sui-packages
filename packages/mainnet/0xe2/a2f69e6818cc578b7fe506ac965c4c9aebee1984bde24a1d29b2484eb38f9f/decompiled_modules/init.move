module 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::config::new<INIT>(&arg0, arg1);
        0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

