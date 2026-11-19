module 0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::blast_presale_package {
    struct BLAST_PRESALE_PACKAGE has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_PRESALE_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::keep<BLAST_PRESALE_PACKAGE>(0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::new_publication<BLAST_PRESALE_PACKAGE, PackageWitness>(arg0, 7, arg1), arg1);
    }

    public(friend) fun package_witness() : PackageWitness {
        PackageWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

