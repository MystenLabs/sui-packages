module 0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun {
    struct BLAST_FUN has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::keep<BLAST_FUN>(0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::new_publication<BLAST_FUN, PackageWitness>(arg0, 7, arg1), arg1);
    }

    public(friend) fun package_witness() : PackageWitness {
        PackageWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

