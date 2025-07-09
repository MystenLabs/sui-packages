module 0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

