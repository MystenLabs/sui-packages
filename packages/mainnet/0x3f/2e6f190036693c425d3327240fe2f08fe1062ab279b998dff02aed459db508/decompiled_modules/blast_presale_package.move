module 0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::blast_presale_package {
    struct BLAST_PRESALE_PACKAGE has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_PRESALE_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::keep<BLAST_PRESALE_PACKAGE>(0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::new_publication<BLAST_PRESALE_PACKAGE, PackageWitness>(arg0, 7, arg1), arg1);
    }

    public(friend) fun package_witness() : PackageWitness {
        PackageWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

