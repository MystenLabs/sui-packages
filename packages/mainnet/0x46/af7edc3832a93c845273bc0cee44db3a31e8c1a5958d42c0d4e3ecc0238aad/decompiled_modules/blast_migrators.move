module 0x46af7edc3832a93c845273bc0cee44db3a31e8c1a5958d42c0d4e3ecc0238aad::blast_migrators {
    struct BLAST_MIGRATORS has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::keep<BLAST_MIGRATORS>(0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::new_publication<BLAST_MIGRATORS, PackageWitness>(arg0, 0, arg1), arg1);
    }

    // decompiled from Move bytecode v7
}

