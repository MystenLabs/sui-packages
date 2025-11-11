module 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    public fun verify_extension<T0>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::PACKAGE, T0>) {
        let v0 = 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::state::create_extension_key();
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::verify_extension<T0, 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::state::ExtensionKey>(arg0, arg1, &v0);
    }

    // decompiled from Move bytecode v6
}

