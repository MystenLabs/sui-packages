module 0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::blast_presale_package {
    struct BLAST_PRESALE_PACKAGE has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_PRESALE_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::keep<BLAST_PRESALE_PACKAGE>(0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::new_publication<BLAST_PRESALE_PACKAGE, PackageWitness>(arg0, 7, arg1), arg1);
    }

    public(friend) fun package_witness() : PackageWitness {
        PackageWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

