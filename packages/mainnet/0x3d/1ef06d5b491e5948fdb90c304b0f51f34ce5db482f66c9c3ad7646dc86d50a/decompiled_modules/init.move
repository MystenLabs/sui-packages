module 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::verifier::create(arg1);
        0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::verifier::borrow_mut_id(&mut v0), arg1);
        0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::verifier::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

