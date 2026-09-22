module 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core {
    struct BLAST_BOOSTS_CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_BOOSTS_CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::new<BLAST_BOOSTS_CORE>(arg0, 16, 604800000, arg1);
    }

    public fun package_admin_role() : u64 {
        16
    }

    public fun risk_admin_role() : u64 {
        2
    }

    public fun shutdown_admin_role() : u64 {
        8
    }

    public fun vault_issuer_role() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

