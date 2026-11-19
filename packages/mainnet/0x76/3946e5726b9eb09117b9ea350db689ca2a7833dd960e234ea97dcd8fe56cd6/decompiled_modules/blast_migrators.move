module 0x763946e5726b9eb09117b9ea350db689ca2a7833dd960e234ea97dcd8fe56cd6::blast_migrators {
    struct BLAST_MIGRATORS has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::keep<BLAST_MIGRATORS>(0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::new_publication<BLAST_MIGRATORS, PackageWitness>(arg0, 0, arg1), arg1);
    }

    // decompiled from Move bytecode v7
}

