module 0x5cc02a74db92c643861b663a9bbf40ed6e79e7e536c0f30c23d3f30949efd3bb::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5cc02a74db92c643861b663a9bbf40ed6e79e7e536c0f30c23d3f30949efd3bb::registry::create_registry<INIT>(&arg0, arg1);
        0x5cc02a74db92c643861b663a9bbf40ed6e79e7e536c0f30c23d3f30949efd3bb::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x5cc02a74db92c643861b663a9bbf40ed6e79e7e536c0f30c23d3f30949efd3bb::registry::borrow_mut_id(&mut v0), arg1);
        0x5cc02a74db92c643861b663a9bbf40ed6e79e7e536c0f30c23d3f30949efd3bb::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

