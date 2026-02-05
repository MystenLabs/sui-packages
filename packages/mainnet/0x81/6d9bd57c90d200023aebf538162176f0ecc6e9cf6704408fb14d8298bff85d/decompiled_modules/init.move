module 0x83e0022e96e0914516fd83fcb19d37efa0ed5aae2a81e9b15723a538fd209128::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x83e0022e96e0914516fd83fcb19d37efa0ed5aae2a81e9b15723a538fd209128::config::new<INIT>(&arg0, arg1);
        0x83e0022e96e0914516fd83fcb19d37efa0ed5aae2a81e9b15723a538fd209128::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x83e0022e96e0914516fd83fcb19d37efa0ed5aae2a81e9b15723a538fd209128::config::borrow_mut_id(&mut v0), arg1);
        0x83e0022e96e0914516fd83fcb19d37efa0ed5aae2a81e9b15723a538fd209128::vault::create_vault_and_share<INIT>(&arg0, 0x83e0022e96e0914516fd83fcb19d37efa0ed5aae2a81e9b15723a538fd209128::config::borrow_mut_id(&mut v0));
        0x2::transfer::public_share_object<0x83e0022e96e0914516fd83fcb19d37efa0ed5aae2a81e9b15723a538fd209128::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

