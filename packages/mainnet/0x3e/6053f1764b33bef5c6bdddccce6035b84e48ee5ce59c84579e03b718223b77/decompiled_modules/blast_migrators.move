module 0x3e6053f1764b33bef5c6bdddccce6035b84e48ee5ce59c84579e03b718223b77::blast_migrators {
    struct BLAST_MIGRATORS has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::keep<BLAST_MIGRATORS>(0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::new_publication<BLAST_MIGRATORS, PackageWitness>(arg0, 0, arg1), arg1);
    }

    // decompiled from Move bytecode v7
}

