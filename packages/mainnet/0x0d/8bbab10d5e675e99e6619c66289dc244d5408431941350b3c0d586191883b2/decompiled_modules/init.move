module 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    public fun verify_extension<T0>(arg0: &mut 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg1: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::AuthorityCap<0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::PACKAGE, T0>) {
        let v0 = 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::state::create_extension_key();
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::verify_extension<T0, 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::state::ExtensionKey>(arg0, arg1, &v0);
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

