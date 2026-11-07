module 0x46f43834ce4ea917d3a3dcecc5418170cc516739ebe91425533374ef94bbd540::blast_presale_package {
    struct BLAST_PRESALE_PACKAGE has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_PRESALE_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::keep<BLAST_PRESALE_PACKAGE>(0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::new_publication<BLAST_PRESALE_PACKAGE, PackageWitness>(arg0, 7, arg1), arg1);
    }

    public(friend) fun package_witness() : PackageWitness {
        PackageWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

